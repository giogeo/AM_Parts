using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class sellitem : System.Web.UI.Page
    {
        public int count_ins0;        
        int count_ins;
        public int count_ins2;
        public string act;
        public string item_id;
        public string it_qty;
        public string request;
        public string confirm_value;

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            act = Request["action"];
            item_id = Request["item"];
            it_qty = Request["qty"];
            request = Request["req"];
            confirm_value = Request["confirm"];

            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                //this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked YES!')", true);
            }
            else
            {
                //this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked NO!')", true);
            }

            

            if (Request.QueryString.ToString().Length > 0)
            {
                //Request.QueryString is exist
                sell_table.Visible = true;
            }
            else
            {
                //This code runs when it is postback request
                sell_table.Visible = false;
            }

            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(item_id) && act == "del" )
            {
                del_item_from_sale();
            }

            if (!string.IsNullOrEmpty(request) && request == "add" && confirm_value == "yes")
            {
                insert_sell();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Script", "javascript:hide_table();", true);
                
                //Response.Redirect("shop.aspx");
            }

            if (!string.IsNullOrEmpty(request) && request == "add" && confirm_value == "no")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Script", "javascript:goBack();", true);                
            }

            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(item_id) && !string.IsNullOrEmpty(it_qty) && act == "sell")
            {
                check_session();
                btn_insert.Visible = true;
            }

            if (count_ins2 > 0)
            {
                del_temp_grid();
            }
        }
        private void insert_by_barcode()
        {
            SqlDataAdapter da = new SqlDataAdapter("select * from goods where barcode = '" + item_id.ToString() + "' ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            string it_id = dt.Rows[0]["id"].ToString();
            string it_name = dt.Rows[0]["name"].ToString();
            string it_price = dt.Rows[0]["price"].ToString();
            string it_totalPprice = (Convert.ToDouble(it_price) * Convert.ToDouble(it_qty)).ToString();
            DateTime dtnow = DateTime.Now;
            string formatDateNow = "yyyy.MM.dd HH:mm";
            string TenderFrom = dtnow.ToString(formatDateNow);
            if (dt.Rows.Count == 1)
            {
                con.Open();
                string str = "INSERT INTO TmpGrid (g_id, name, price, qty, totalprice, added) VALUES('" + it_id.ToString() + "', N'" + it_name.ToString() + "', '" + it_price.ToString() + "', '" + it_qty.ToString() + "', '" + it_totalPprice.ToString() + "', '" + TenderFrom.ToString() + "' )";
                SqlCommand strCmd = new SqlCommand(str, con);
                count_ins = strCmd.ExecuteNonQuery();

            }
            con.Close();
            if (count_ins > 0)
            {
                query_forSell_grid();
            }            
        }
        private void query_forSell_grid()
        {
            SqlDataAdapter da = new SqlDataAdapter(@"select * 
                                                        into #tmp01
                                                        from
                                                        (select g_id, sum(qty) AS qty, price from TmpGrid group by g_id, price) T1
                                                        INNER JOIN
                                                        (select Id, name from goods) T2
                                                        on T2.Id = T1.g_id;

                                                        select g_id, name, qty, price, qty*price AS totalprice  from #tmp01", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            Session["GridViewTable"] = dt;
        }
        protected void btn_sell_Click(object sender, ImageClickEventArgs e)
        {
            if (GridView1.Rows.Count == 0)
            {

            }

            else if (GridView1.Rows.Count > 0)
            {

            }
        }
        string time_diff;
        protected void check_session()
        {
            SqlDataAdapter _da = new SqlDataAdapter("SELECT DATEDIFF(MINUTE, (select top 1 added from TmpGrid ), GETDATE() ) AS DiffDate", con);
            DataTable _dt = new DataTable();
            _da.Fill(_dt);
            if (_dt.Rows.Count > 0)
            {
                time_diff = _dt.Rows[0]["DiffDate"].ToString();
                try
                {
                    if (!string.IsNullOrEmpty(time_diff))
                    {
                        if (Convert.ToInt32(time_diff) > 5)
                        {
                            Response.Write("<script type='text/javascript'>alert('სესია დასრულებულია, ვინაიდან გავიდა " + time_diff + " წუთი')</script>");
                        }
                        else
                        {
                            insert_by_barcode();
                        }
                    }
                    else
                    {
                        insert_by_barcode();
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("My Custom Error Message", ex);
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {

            }
        }
        private void insert_sell()
        {
            DataTable New_dt = (DataTable)Session["GridViewTable"];
            foreach (DataRow row in New_dt.Rows)
            {
                string goods_name = Convert.ToString(row["name"].ToString());
                int goods_id = Convert.ToInt32(row["g_id"].ToString());
                double goods_qty = Convert.ToDouble(row["qty"].ToString());
                double goods_price = Convert.ToDouble(row["price"].ToString());

                //Response.Write("<script type='text/javascript'>alert('"+ goods_name +" - "+ goods_price +"')</script>");

                con.Open();
                string str0 = "INSERT INTO TmpSales (Id, name, qty, price) VALUES('" + goods_id + "', N'" + goods_name + "', '" + goods_qty + "', '" + goods_price + "')";
                SqlCommand strCmd0 = new SqlCommand(str0, con);
                count_ins0 = strCmd0.ExecuteNonQuery();
                con.Close();
            }
        }
            

            
        
            
        
        protected void del_temp_grid()
        {
            con.Open();
            string strdel1 = "TRUNCATE TABLE TmpGrid";
            SqlCommand strCmd1 = new SqlCommand(strdel1, con);
            int Del_count = strCmd1.ExecuteNonQuery();
            if (Del_count != 0)
            {
                Response.Redirect("sellitem.aspx");
            }

            con.Close();
        }

        protected void del_item_from_sale()
        {
            con.Open();
            SqlCommand del_item = new SqlCommand("DELETE FROM TmpGrid WHERE g_id = "+ item_id.ToString() +" ", con);
            int cnt_del = del_item.ExecuteNonQuery();

            if(cnt_del > 0)
            {
                con.Close();
                query_forSell_grid();
            }
        }

        decimal SumofPrice = 0;
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                decimal txt_it_pr = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "totalprice"));
                SumofPrice += txt_it_pr;
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                ((TextBox)e.Row.FindControl("txt_FooterTotalPrice")).Text = SumofPrice.ToString();
            }
        }
    }
}