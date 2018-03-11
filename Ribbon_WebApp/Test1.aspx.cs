using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class Test1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            



            if (!IsPostBack)
            {
                show_updateGRV();
                srch();
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            }
        }

        protected void show_updateGRV()
        {
            SqlDataAdapter da = new SqlDataAdapter(@"select * from expenses", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GRD_MultyUpdate.DataSource = dt;
            GRD_MultyUpdate.DataBind();
        
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Response.Write("<script type='text/javascript'>alert('Hellow World')</script>");
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            }
            else
            {
                Response.Write("<script type='text/javascript'>alert('Page Refreshed')</script>");
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ViewState["CheckRefresh"] = Session["CheckRefresh"];
        }

        protected void del_box_Click(object sender, ImageClickEventArgs e)
        {
          //  ImageButton imgbtn = (ImageButton)sender;
         //   GridViewRow gvr = (GridViewRow)imgbtn.NamingContainer;


            ImageButton imgbtn = (ImageButton)sender;
            ListViewDataItem clickedItem = (ListViewDataItem)imgbtn.NamingContainer;            

            string delID = ((Label)clickedItem.FindControl("lblTenderId")).Text;

            Response.Redirect(delID + ".aspx");

        }

        protected void ListViewControl(object sender, ListViewItemEventArgs e)
        {


            ListViewDataItem currentItem = (ListViewDataItem)ListView01.Items;
            Label list_lbl_supply = (Label)currentItem.FindControl("lbl_supply");

            SqlDataAdapter da = new SqlDataAdapter(@"select tender_id, tr_type, SUM(price*quantity*tr_type) AS tot 
                                                    INTO #t1
                                                    from tenders_items 
                                                    group by tender_id, tr_type

                                                    select tenders.*, #t1.* from tenders, #t1
                                                    where tenders.id = #t1.tender_id AND tr_type = -1
                                                    ORDER BY tender_date DESC", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string strTotal = dt.Rows[i][7].ToString();

                list_lbl_supply.Text = strTotal.ToString();            
            }

            
        }


        protected void ListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Label someLabel = (Label)e.Item.FindControl("lbltender_num");
                someLabel.Text = "Hurray!";
            }
        }

        
        
        [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
        public static string[] GetCompletionList(string prefixText, int count, string contextKey)
        {
            //ADO.Net
            SqlConnection cn = new SqlConnection();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            String strCn = ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString;
            cn.ConnectionString = strCn;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            cmd.CommandType = CommandType.Text;
            //Compare String From Textbox(prefixText) AND String From 
            //Column in DataBase(CompanyName)
            //If String from DataBase is equal to String from TextBox(prefixText) 
            //then add it to return ItemList
            //-----I defined a parameter instead of passing value directly to 
            //prevent SQL injection--------//
            cmd.CommandText = "SELECT * FROM goods WHERE name LIKE @myParameter OR product_code LIKE @myParameter ";
            cmd.Parameters.AddWithValue("@myParameter", "%" + prefixText + "%");

            try
            {
                cn.Open();
                cmd.ExecuteNonQuery();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
            }
            catch
            {
            }
            finally
            {
                cn.Close();
            }
            dt = ds.Tables[0];

            //Then return List of string(txtItems) as result
            List<string> txtItems = new List<string>();
            String prod_name;
            String prod_code;

           

           

            foreach (DataRow row in dt.Rows)
            {

                prod_name = row["name"].ToString();
                prod_code = row["product_code"].ToString();
                txtItems.Add(prod_name);
                txtItems.Add(prod_code);

                
            }
            return txtItems.ToArray();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                

                var WaybillPriceOut = (Label)e.Row.FindControl("Label4");
                var WaybillPriceIn = (Label)e.Row.FindControl("Label3");
                if (Convert.ToDecimal(WaybillPriceOut.Text) < 0)
                {
                    WaybillPriceOut.ForeColor = System.Drawing.Color.Red;
                    e.Row.BackColor = System.Drawing.Color.NavajoWhite;
                }
                if (Convert.ToDecimal(WaybillPriceIn.Text) > 0)
                {
                    WaybillPriceIn.ForeColor = System.Drawing.Color.GreenYellow;
                    e.Row.BackColor = System.Drawing.Color.Goldenrod;
                }

                if (Convert.ToDecimal(WaybillPriceIn.Text) == 0 && Convert.ToDecimal(WaybillPriceOut.Text) == 0)
                {
                    e.Row.Visible = false;
                }
            }
        }

        public string OrderBy;
        void srch()
        {


            SqlDataAdapter da = new SqlDataAdapter(@"select * 
                                    into #tmp1
                                    from 
                                    (select id, waybill_number, waybill_date, cost, paid, contractor_id from tenders_waybills) T1
                                    inner join
                                    (select id as Cid, name, is_supplier from suppliers) T2
                                    ON(T2.Cid = T1.contractor_id)
                                    where cost is not null AND is_supplier = '1';

                                    select waybill_number, waybill_date, paid*is_supplier as shemos,  REPLACE(cost, cost, '0') as gasav, name into #tmp01 from #tmp1;


select * 
                                    into #tmp2
                                    from 
                                    (select id, waybill_number, waybill_date, cost, paid, contractor_id from tenders_waybills) T1
                                    inner join
                                    (select id as Cid, name, is_supplier from suppliers) T2
                                    ON(T2.Cid = T1.contractor_id)
                                    where cost is not null AND is_supplier = '-1';

                                    select waybill_number, waybill_date, REPLACE(cost, cost, '0') as shemos, paid*is_supplier as gasav, name into #tmp02 from #tmp2;

		select * from #tmp01
		UNION ALL
		select * from #tmp02 "+ OrderBy +" ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();



        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY waybill_number ASC";
            srch();
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY waybill_number DESC";
            srch();
        }

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY waybill_date DESC";
            srch();
        }

        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY waybill_date ASC";
            srch();
        }

        protected void ImageButton5_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY shemos DESC";
            srch();
        }

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY shemos ASC";
            srch();
        }

        protected void ImageButton7_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY gasav ASC";
            srch();
        }

        protected void ImageButton8_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY gasav DESC";
            srch();
        }

        protected void ImageButton9_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY name DESC";
            srch();
        }

        protected void ImageButton10_Click(object sender, ImageClickEventArgs e)
        {
            OrderBy = "ORDER BY name ASC";
            srch();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow gvr in GRD_MultyUpdate.Rows)
            {
                double _new; 
                double _cost;
                int _id;
                TextBox Update_id = (TextBox)gvr.FindControl("txt_updID");
                TextBox Update_cost = (TextBox)gvr.FindControl("txt_updPrice");
                _id = Convert.ToInt32(Update_id.Text);
                _cost = Convert.ToDouble(Update_cost.Text);
                _new = _id + _cost;
                // Hope you understand what to do next?
                // txtMarksScored.Text

                con.Open();
                SqlCommand cmd = new SqlCommand(@" UPDATE expenses  SET cost = '" + _new + "' WHERE id = '" + _id + "' ", con);
                cmd.ExecuteNonQuery();
                con.Close();

                //  Response.Write("<SCRIPT language='JavaScript'>  alert('"+_cost+"') </SCRIPT>");
            }
        }

        protected void btn_GetOnlyNums_Click(object sender, EventArgs e)
        {
            var getnums = txt_OnlyNums.Text;
            var result_nums = string.Join("", getnums.ToCharArray().Where(Char.IsDigit));

            Response.Write("<script type='text/javascript'>alert('"+ result_nums.ToString() +"')</script>");
        }
    }
}