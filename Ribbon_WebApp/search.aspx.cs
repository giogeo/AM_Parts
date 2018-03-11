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
    public partial class search : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                SqlDataAdapter da = new SqlDataAdapter(@"select distinct comment AS Name from goods where comment<>'' ", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
                con.Close();
            }
        }
        protected void GetSelectedRecords(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[6] { new DataColumn("Name"), new DataColumn("ProductCode"), new DataColumn("OEM"), new DataColumn("Manufacturer"), new DataColumn("Price"), new DataColumn("Comment") });
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                    if (chkRow.Checked)
                    {
                        string CarBrands = row.Cells[1].Text;


                        SqlDataAdapter da = new SqlDataAdapter(@"select * from goods where comment in(N'" + CarBrands +"') ", con);
                        DataTable tmp_dt = new DataTable();
                        da.Fill(tmp_dt);                        
                        //con.Close();

                        for (int i = 0; i < tmp_dt.Rows.Count; i++)
                        {
                            string products_name = tmp_dt.Rows[i]["name"].ToString();
                            string products_code = tmp_dt.Rows[i]["product_code"].ToString();
                            string products_oem = tmp_dt.Rows[i]["OEM"].ToString();
                            string products_manufacturer = tmp_dt.Rows[i]["manufacturer"].ToString();
                            string products_price = tmp_dt.Rows[i]["price"].ToString();
                            string products_comment = tmp_dt.Rows[i]["comment"].ToString();
                            dt.Rows.Add(products_name, products_code, products_oem, products_manufacturer, products_price, products_comment);
                        }

                        




                        //string country = (row.Cells[2].FindControl("lblCountry") as Label).Text;
                        Response.Write("<script type='text/javascript'>alert('"+ CarBrands + " - !!!')</script>");
                        dt.Rows.Add(CarBrands);
                    }
                }
            }
            ListResults.DataSource = dt;
            ListResults.DataBind();
        }
    }
}