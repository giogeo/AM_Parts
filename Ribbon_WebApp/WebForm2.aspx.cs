using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;

namespace Ribbon_WebApp
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        string ConTecdoc = "Description=TecDoc2016;Dsn=TecDoc2016;Database=TECDOC_CD_2_2016;Server=192.168.0.109;UID=tecdoc;PWD=tcd_error_0;";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            json_tree();
            //show_subtree();
        }

        void xml_stream()
        {

            var tt = "https://parts.mysupp.ru/1c.php?format=xml&action=base&code=" + txt_search.Text + "";

            DataSet dsresult = new DataSet();
            XmlDocument x = new XmlDocument();
            x.Load(tt);
            XmlElement exelement = x.DocumentElement;


            XmlNodeReader nodereader = new XmlNodeReader(exelement);
            dsresult.ReadXml(nodereader, XmlReadMode.Auto);
            GridView2.DataSource = dsresult;
            GridView2.DataBind();
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            //xml_stream();
            COMP2ByOEM();
        }

        void COMP2ByOEM()
        {            
            string uri = String.Empty;
            //preparing url with all four parameter   
            if (by_oem.Checked)
            {
                uri = "http://api.tecdoc.ru/oemcars/" + txt_search.Text + "";
            }

            else if (by_cross.Checked)
            {
                uri = "http://api.tecdoc.ru/getCrosses/" + txt_search.Text + "";
            }
            
            //making web request to url
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            //getting response from api
            WebResponse response = request.GetResponse();
            Stream strm = response.GetResponseStream();
            StreamReader reader = new System.IO.StreamReader(strm);
            //reading result 
            string RequestedText = reader.ReadToEnd();

            string output2 = RequestedText.Substring(RequestedText.IndexOf('['));
            string output22 = output2.Substring(0, output2.LastIndexOf("]") + 1);

            //Random json string, No fix number of columns or rows and no fix column name.   
            string myDynamicJSON = output22;

            //Using DataTable with JsonConvert.DeserializeObject, here you need to import using System.Data;  
            DataTable myObjectDT = JsonConvert.DeserializeObject<DataTable>(myDynamicJSON);

            //Binding gridview from dynamic object   
            GridView2.DataSource = myObjectDT;
            GridView2.DataBind();  
        }

        void json_tree()
        {
            //preparing url with all four parameter            
            string uri = "https://parts.mysupp.ru/1c.php?format=json&action=tree";

            //making web request to url
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);

            //getting response from api
            WebResponse response = request.GetResponse();
            Stream strm = response.GetResponseStream();
            StreamReader reader = new System.IO.StreamReader(strm);

            //reading result 
            string RequestedText = reader.ReadToEnd();
            string output2 = RequestedText.Substring(RequestedText.IndexOf('['));
            string output22 = output2.Substring(0, output2.LastIndexOf("]") + 1);

            //Random json string, No fix number of columns or rows and no fix column name.   
            string myDynamicJSON = output22;

            //Using DataTable with JsonConvert.DeserializeObject, here you need to import using System.Data;  
            DataTable myObjectDT = JsonConvert.DeserializeObject<DataTable>(myDynamicJSON);

            //Binding gridview from dynamic object   

            gvTree.DataSource = myObjectDT;
            gvTree.DataBind();
            Session["OldTable"] = myObjectDT;
        }

        private void show_subtree()
        {
            foreach (GridViewRow gvOfTree in gvTree.Rows)
            {
                if (gvOfTree.RowType == DataControlRowType.DataRow)
                {
                    GridView gvInsideTree = (GridView)gvOfTree.FindControl("gvSubTree");
                    string vv = gvOfTree.Cells[0].Text;
                    string parantID = vv.ToString();

                    DataTable dt = (DataTable)Session["OldTable"];
                    DataView dataView = dt.DefaultView;

                    if (!string.IsNullOrEmpty(parantID))
                    {
                        dataView.RowFilter = "STR_ID_PARENT = '" + parantID + "'";
                    }
                    gvInsideTree.DataSource = dataView;
                    gvInsideTree.DataBind();
                }
            }
        }

        protected void gvTree_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {               
                if (e.Row.Cells[1].Text == "10001")
                {
                    e.Row.Cells[1].Visible = true;
                }
                else
                {
                    e.Row.Visible = false;
                }                
            }
        }       

        protected void gvTree_RowCommand(object sender, GridViewCommandEventArgs e)
        {          
            if (e.CommandName == "Select")
            {
            }
        }

        protected void gvTree_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Find Current row's Index
            GridViewRow row = gvTree.Rows[gvTree.SelectedIndex];
                           
            //Find Specific/Selected Row's Value
            string parantID = gvTree.SelectedRow.Cells[0].Text;
            gvTree.SelectedRow.Cells[2].Enabled = false;
            if(gvTree.SelectedRow.Cells[2].Enabled == false)
            {
                gvTree.SelectedRow.Cells[2].CssClass = "to_minus";
                gvTree.SelectedRow.Cells[2].Style.Add("background-color", "rgba(0, 0, 0, 0.025)");
            }

            //Find Listview inside Gridview
            ListView listitems = row.FindControl("lst_sub_tree") as ListView;
            
            //Get Datatable from saved Session
            DataTable dt = (DataTable)Session["OldTable"];

            //in case if you get multiple rows
            DataRow[] drs = dt.Select("STR_ID_PARENT='" + parantID + "'");

            

            // Create new Datatable with DataColumn(s) As much as we need
            DataTable N_dt = new DataTable();
            N_dt.Columns.AddRange(new DataColumn[4] { new DataColumn("STR_ID"), new DataColumn("STR_ID_PARENT"), new DataColumn("STR_DES_TEXT"), new DataColumn("DESCENDANTS") });

            string sid = String.Empty;
            string sip = String.Empty;
            string sdt = String.Empty;
            string desc = String.Empty;
            foreach (DataRow dr in drs)
            {
                sid = dr["STR_ID"].ToString();
                sip = dr["STR_ID_PARENT"].ToString();
                sdt = dr["STR_DES_TEXT"].ToString();
                desc = dr["DESCENDANTS"].ToString();                
                N_dt.Rows.Add(sid, sip, sdt, desc);
            }            
            listitems.DataSource = N_dt;
            listitems.DataBind();
        }
    }
}