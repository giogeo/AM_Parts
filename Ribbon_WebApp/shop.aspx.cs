using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class Mobile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            del_temp_grid();
            ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:getLocation(); ", true);
            

            if (Request.QueryString.ToString().Length > 0)
            {
                //Request.QueryString is exist
                Main.Visible = false;
            }

            else
            {
                //This code runs when it is postback request
                Main.Visible = true;
                
            }

            string act = Request["action"];
            string item_id = Request["item"];

            if (!string.IsNullOrEmpty(act) && act == "list")
            {
                ListView01.Visible = true;
            }

            if (!string.IsNullOrEmpty(act) && act == "goods")
            {
                Show_goods.Visible = true;
            }

            if (!string.IsNullOrEmpty(act) && act == "sell" && !string.IsNullOrEmpty(item_id))
            {
                Show_goods.Visible = true;
                myFilter.Text = item_id;
            }

            string tid = Request["TenderID"];
            if (!string.IsNullOrEmpty(tid))
            {
                ShowTendersWaybills();
                show_Twaybils.Visible = true;
            }

            string jobid = Request["job"];
            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(jobid) && act == "T_Items")            
            {
                
                Show_TndrItems.Visible = true;

                txt_tId.Text = jobid;

                ControlParameter cpText = new ControlParameter();
                cpText.ControlID = "txt_tId";
                cpText.Name = "tender_id";
                cpText.PropertyName = "Text";

                SqlDataSource5.FilterParameters.Add(cpText);
                SqlDataSource5.FilterExpression = "t_id = '{0}'";
            }

            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(jobid) && act == "rem")
            {
                ShowItemsLeft();
                Showitemsleft.Visible = true;
            }

            string wbid = Request["Id"];
            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(wbid) && act == "waybills")
            {
                ShowWaybillsItems();
                show_WbItems.Visible = true;
            }
        }       

        private void ShowTendersWaybills()
        {
            string tid = Request["TenderID"];
            txt_name.Text = tid;
            ControlParameter cpText = new ControlParameter();
            cpText.ControlID = "txt_name";
            cpText.Name = "tender_id";
            cpText.PropertyName = "Text";

            SqlDataSource3.FilterParameters.Add(cpText);
            SqlDataSource3.FilterExpression = "tender_id = '{0}'";
        }

        private void ShowWaybillsItems()
        {
            string wbid = Request["Id"];
            txt_wbID.Text = wbid;
        }

        

        private void ShowItemsLeft() 
        {
            string jobid = Request["job"];
            txt_Tit_rem.Text = jobid;
        }

        protected void ListView01_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                HtmlAnchor A_Sold_to = (HtmlAnchor)e.Item.FindControl("a_sold_to");
                Label Lbl_tenders_id = (Label)e.Item.FindControl("l_tender_id");
                Label Lbl_Sold_To = (Label)e.Item.FindControl("l_sold_to");
                Label Lbl_remained = (Label)e.Item.FindControl("l_remained");
                Label Lbl_tenders_price = (Label)e.Item.FindControl("l_tender_price");

                if (string.IsNullOrEmpty(Lbl_Sold_To.Text))
                {
                    Lbl_Sold_To.Text = "0.00";
                }

                SqlDataAdapter sda = new SqlDataAdapter(@"select * 
                                                            into #tmp1
                                                          from 
                                                            tenders_waybills
                                                          where 
                                                            tender_id IS NOT NULL AND expense_type = '-1' AND tender_id = '" + Lbl_tenders_id.Text + "'; select tender_id, SUM(expense_type * cost) AS total from #tmp1 group by tender_id; ", con);
                DataTable dt1 = new DataTable();
                sda.Fill(dt1);

                for (int i = 0; i < dt1.Rows.Count; i++)
                {
                    // tnd_id = dt1.Rows[i]["tender_id"].ToString();
                    string supplied = dt1.Rows[i]["total"].ToString();

                    Lbl_Sold_To.Text = Convert.ToDouble(supplied).ToString("0.00");
                    
                    // Lbl_remained.Text = 
                }

                double a, b;

                double.TryParse(Lbl_tenders_price.Text, out a);
                double.TryParse(Lbl_Sold_To.Text, out b);

                if (b == 0)
                {
                    A_Sold_to.HRef = "#";
                }
                else
                {
                    A_Sold_to.Attributes.Add("href", "?TenderID=" + Lbl_tenders_id.Text + "");
                }

                Lbl_remained.Text = (a + b).ToString("0.00");
            }
        }

        protected void del_temp_grid()
        {
            SqlDataAdapter _sda = new SqlDataAdapter("select * from TmpGrid", con);
            DataTable _sdt = new DataTable();
            _sda.Fill(_sdt);
            if(_sdt.Rows.Count > 0)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("TRUNCATE TABLE TmpGrid", con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }
}