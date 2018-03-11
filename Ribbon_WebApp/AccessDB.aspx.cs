using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;

namespace Ribbon_WebApp
{
    public partial class AccessDB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                AccessDatabase();
            }
        }

        private void AccessDatabase()
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["accessDB"].ToString();
            con.Open();
            OleDbCommand cmd = new OleDbCommand();
            cmd.CommandText = "select * from companies where taxID LIKE '%" + TextBox1.Text + "%' OR companyName LIKE '%" + TextBox1.Text + "%' OR activityTypeID LIKE '%" + TextBox1.Text + "%' ";
            cmd.Connection = con;
            OleDbDataReader dr = cmd.ExecuteReader();
            GridView1.DataSource = dr;
            GridView1.DataBind();
            con.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow GR in GridView1.Rows)
            {
                if (GR.RowType == DataControlRowType.DataRow)
                {
                    // You can also find grid view inside controls here
                    Label MobileNum = (Label)GR.FindControl("mobile");

                    string str = MobileNum.Text;
                    string other_nums = string.Empty;

                    if (MobileNum.Text != null)
                    {
                        for (int i = 1; i < str.Length; i++)
                        {
                            if (Char.IsDigit(str[i]))
                                other_nums += str[i];

                            var f_num = str[0].ToString();
                            var first_num = Convert.ToString(f_num.Replace("8", "5"));
                            MobileNum.Text = first_num + other_nums;
                        }
                    }

                }
            }
        }
    }
}