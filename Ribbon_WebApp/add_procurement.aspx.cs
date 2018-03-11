using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace Ribbon_WebApp
{
    public partial class add_procurement : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowSuppliersInDropdown();


            //dropdown_suppliers.Items.Insert(0, new ListItem("Select Month", "1"));
            //  dropdown_suppliers.DataSource = dt1;
            //  dropdown_suppliers.DataTextField = "name";
            //   dropdown_suppliers.DataValueField = "id";
            //   dropdown_suppliers.DataBind();


            //table = new DataTable();
            //table.Columns.Add("STU_ID", typeof(string));
            //table.Columns.Add("NAME", typeof(string));

            //GridView1.DataSource = table;
            //GridView1.DataBind();               
        }

        protected void ShowSuppliersInDropdown()
        {
            SqlDataAdapter sda = new SqlDataAdapter("select * from suppliers ", con);
            DataTable dt1 = new DataTable();
            sda.Fill(dt1);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                string id = dt1.Rows[i]["id"].ToString();
                string name = dt1.Rows[i]["name"].ToString();
                dropdown_suppliers.Items.Insert(0, new ListItem("" + name + "", "" + id + ""));
            }
        }

        public void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //      TextBox txt = e.Row.FindControl("txt_TenderName") as TextBox;
            //      txt.TextChanged += new EventHandler(TextBox1_TextChanged);  

            //   var nn = "gio";
            //  TextBox tb = (TextBox)e.Row.FindControl("txt_TenderQty");
            //   tb.Text = nn.ToString();
        }

        protected void Btn_addrow_clicked(object sender, EventArgs e)
        {
            dropdown_suppliers.Items.Clear();
            int lines = GridView1.Rows.Count;
            int rowsqty = Convert.ToInt32(nun_of_rows.Text.ToString());
            int NewRow = lines + rowsqty;

            List<Customer> items = new List<Customer>(NewRow);
            for (int i = 0; i < NewRow; i++)
            {
                Customer c = new Customer();
                items.Add(c);
            }
            GridView1.DataSource = items;
            GridView1.DataBind();

            ShowSuppliersInDropdown();

            //Label1.Text = lines.ToString() + "სტრიქონი";
        }

        protected void TxtId_TextChanged(object sender, EventArgs e)
        {
            GridViewRow currentRow = (GridViewRow)((TextBox)sender).Parent.Parent.Parent.Parent;
            TextBox Item_id = (TextBox)currentRow.FindControl("txt_TenderId");
            TextBox Item_name = (TextBox)currentRow.FindControl("txt_TenderName");
            TextBox Item_unit = (TextBox)currentRow.FindControl("txt_TenderUnit");
            TextBox Item_qty = (TextBox)currentRow.FindControl("txt_TenderQty");
            TextBox Item_price = (TextBox)currentRow.FindControl("txt_TenderPrice");
            TextBox Item_code = (TextBox)currentRow.FindControl("txt_TenderItemCode");

            string goods_code = Convert.ToString(Item_code.Text);

            if (!string.IsNullOrEmpty(goods_code) && goods_code.Length > 3)
            {
                SqlDataAdapter sda = new SqlDataAdapter("select * from goods where product_code LIKE '%" + goods_code + "' ", con);
                DataTable dt1 = new DataTable();
                sda.Fill(dt1);
                if (dt1.Rows.Count != 0)
                {
                    string sqlid = dt1.Rows[0][0].ToString();
                    string sqlname = dt1.Rows[0][5].ToString();
                    string sqlunit = dt1.Rows[0][6].ToString();
                    string sqlprice = dt1.Rows[0][8].ToString();

                    Item_name.Text = Convert.ToString(sqlname);
                    Item_unit.Text = Convert.ToString(sqlunit);
                    Item_id.Text = Convert.ToString(sqlid);
                    Item_price.Text = Convert.ToString(sqlprice.Replace(",", "."));
                }
                else
                {
                    Response.Write("<script type='text/javascript'>alert('აღნიშნული კოდით პროდუქტი არ მოიძებნა')</script>");
                }

            }
            else
            {
                Item_name.Text = "";
                Item_unit.Text = "";
                Item_id.Text = "";
            }
        }

        protected void Btn_Add_To_DB_clicked(object sender, ImageClickEventArgs e)
        {
            DateTime begintime = txt_tndr_date.SelectedDate;   // Use time from textbox
            string format1 = "yyyy.MM.dd";    // Use this format
            string tenderbegin = begintime.ToString(format1);


            DateTime endtime = txt_tndr_ends.SelectedDate;   // Use time from textbox
            string format2 = "yyyy.MM.dd";    // Use this format
            string tenderends = endtime.ToString(format2);


            string drop = dropdown_suppliers.SelectedItem.Value.ToString();

            string price_text = Convert.ToString(txt_tndr_price.Text.ToString().Replace(",", "."));



            con.Open();
            string str = "insert into tenders (tender_num, contractor_id, tender_date, tender_ends, tender_price, tender_category) Values ('" + txt_tndr_num.Text + "', '" + drop + "', '" + tenderbegin + "', '" + tenderends + "', '" + price_text + "', N'" + txt_tndr_cat.Text + "')";
            SqlCommand cmd = new SqlCommand(str, con);
            cmd.ExecuteNonQuery();

            SqlCommand strsql = new SqlCommand("SELECT SCOPE_IDENTITY () As NewID", con);
            SqlDataReader dr = strsql.ExecuteReader();
            dr.Read();
            if (!dr.HasRows)
            {
                Response.Write("<script type='text/javascript'>alert('ბაზაში დამატება ვერ მოხერხდა')</script>");
            }

            int tenderID = Convert.ToInt32(dr["NewID"]);
            // Response.Write("<script type='text/javascript'>alert('" + newRowID + "')</script>");


            dr.Close();
            con.Close();


            foreach (GridViewRow GR in GridView1.Rows)
            {
                if (GR.RowType == DataControlRowType.DataRow)
                {
                    // You can also find grid view inside controls here
                    TextBox goods_id = (TextBox)GR.FindControl("txt_TenderId");
                    TextBox goods_name = (TextBox)GR.FindControl("txt_TenderName");
                    TextBox goods_unit = (TextBox)GR.FindControl("txt_TenderUnit");
                    TextBox goods_qty = (TextBox)GR.FindControl("txt_TenderQty");
                    TextBox goods_price = (TextBox)GR.FindControl("txt_TenderPrice");
                    TextBox goods_code = (TextBox)GR.FindControl("txt_TenderItemCode");

                    int id = Convert.ToInt32(goods_id.Text.ToString());
                    string qty = Convert.ToString(goods_qty.Text.ToString().Replace(",", "."));
                    string price = Convert.ToString(goods_price.Text.ToString().Replace(",", "."));
                    int transaction_type = 1;
                    Convert.ToInt32(transaction_type.ToString());


                    con.Open();
                    string str2 = "insert into tenders_items (tender_id, goods_id, quantity, price, tr_type) Values ('" + tenderID + "', '" + id + "', '" + qty + "', '" + price + "', '" + transaction_type + "')";
                    SqlCommand cmd2 = new SqlCommand(str2, con);
                    cmd2.ExecuteNonQuery();
                    con.Close();
                }


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
                //String From DataBase(dbValues)
                prod_name = row["name"].ToString();
                prod_code = row["product_code"].ToString();
                // dbValues = dbValues.ToLower();
                txtItems.Add(prod_name);
                txtItems.Add(prod_code);
                txtItems.Add("-----------------");
            }

            return txtItems.ToArray();
        }
    }
}