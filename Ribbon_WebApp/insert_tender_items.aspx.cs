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
    public partial class insert_tender_items : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            // compare_two_grid();
            show_wb_items();
        }

        protected void show_wb_items()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from goods where Id < '150'", con);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView4.DataSource = dt;
            GridView4.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow GR in GridView1.Rows)
            {
                if (GR.RowType == DataControlRowType.DataRow)
                {
                    // You can also find grid view inside controls here
                    TextBox goods_id = (TextBox)GR.FindControl("lbl_GoodId");
                    TextBox goods_unit = (TextBox)GR.FindControl("lbl_ItemUnit");
                    TextBox goods_qty = (TextBox)GR.FindControl("lbl_ItemQty");
                    TextBox goods_price = (TextBox)GR.FindControl("lbl_ItemPrice");


                    int g_id = Convert.ToInt32(goods_id.Text.ToString());
                    string g_unit = Convert.ToString(goods_unit.Text.ToString());
                    string g_qty = Convert.ToString(goods_qty.Text.ToString().Replace(",", "."));
                    string g_price = Convert.ToString(goods_price.Text.ToString().Replace(",", "."));


                    int LastInsertedId2 = 3261;
                    int transaction_type = 1;
                    con.Open();
                    string str3 = "insert into tenders_items (waybill_id, goods_id, unit_name, quantity, price, tr_type) Values ('" + LastInsertedId2 + "', '" + g_id + "', N'" + g_unit + "', '" + g_qty + "', '" + g_price + "', '" + transaction_type + "')";
                    SqlCommand strCmd3 = new SqlCommand(str3, con);
                    strCmd3.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        protected void compare_two_grid()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select *
                                                    from 
                                                    (select * from tenders_items where waybill_id = '3261' AND tr_type = '1') T1
                                                    inner join
                                                    (select Id as gid from goods) T2
                                                    on T1.goods_id = T2.gid

                                                    order by T2.gid;", con);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView2.DataSource = dt;
            GridView2.DataBind();

            SqlDataAdapter sda2 = new SqlDataAdapter(@"select * from tenders_items 
                                                    where waybill_id = '3261' AND tr_type = '1'
                                                    order by goods_id;", con);
            DataTable dt2 = new DataTable();
            sda2.Fill(dt2);
            GridView3.DataSource = dt2;
            GridView3.DataBind();
 
        }

        protected void GetSelectedRecords(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                   
                        string name = row.Cells[1].Text;
                        string country = (row.Cells[2].FindControl("lblCountry") as Label).Text;

                    Response.Write("<script type='text/javascript'>alert('"+country+"')</script>");
                }
            }
           
        }
    }
}