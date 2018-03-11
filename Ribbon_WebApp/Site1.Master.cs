using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Ribbon_WebApp
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        private void AccessDatabase()
        {
            OleDbConnection con = new OleDbConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["accessDB"].ToString();
            con.Open();
            OleDbDataAdapter sda = new OleDbDataAdapter("select * from companies where taxID LIKE '%" + taxID.Text + "%' OR companyName LIKE '%" + taxID.Text + "%'", con);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string company_name = dt.Rows[0][1].ToString();
                string city = dt.Rows[0][4].ToString();
                string address = dt.Rows[0][5].ToString();
                string comp_head = dt.Rows[0][12].ToString();
                string mobile1 = dt.Rows[0][13].ToString();
                string mobile2 = dt.Rows[0][14].ToString();
                string land_line = dt.Rows[0][15].ToString();
                string email = dt.Rows[0][16].ToString();

                companyName.Text = company_name;
                regAddress.Text = city + ", " + address;
                companyHead.Text = comp_head;
                mobile.Text = mobile1 + ", " + mobile2;
                lendline.Text = land_line;
            }
            con.Close();
        }

        private void ShowTendersInDropdown()
        {
            SqlDataAdapter sda = new SqlDataAdapter("select * from tenders ", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);
            for (int i = 0; i < sdt.Rows.Count; i++)
            {
                string tndr_NUM = sdt.Rows[i]["tender_num"].ToString();
                string tndr_ID = sdt.Rows[i]["id"].ToString();

            }
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
                List<ListItem> items = new List<ListItem>();
                items.Add(new ListItem("" + name + "", "" + id + ""));
                ExpenseContractorId.Items.AddRange(items.ToArray());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (Session["user"] != null)
            {
                AuthUsers.strSessionValue = "" + Session["user"].ToString() + "";
                login_pnl.Visible = false;
                log_status.Visible = true;

                if (AuthUsers.strSessionValue != null)
                {
                    ImgBtn_log_status.ToolTip = AuthUsers.strUserFullName.ToString();
                    Pnl_Login.Attributes.Add("style", "display: none;");
                }
            }
            else
            {                
                MPopup_Login.Show();
                AuthUsers.strSessionValue = null;
            }

            

            if (!Page.IsPostBack)
            {                
                ShowSuppliersInDropdown();
                // ntfy_tab();                
            }

            if (taxID.Text.Length > 8)
            {
                AccessDatabase();
                MPopup_AddNewSupplier.Show();
            }
        }

        void ntfy_tab()
        {

            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT tender_id, paid, waybill_date AS StartDate  , GETDATE() AS CurrentDateTime
                                                    INTO #tmp1
                                                    FROM tenders_waybills;

                                                    SELECT tender_id, paid, StartDate, CurrentDateTime, DATEDIFF(d, StartDate, CurrentDateTime) as Difference
                                                    INTO #tmp2
                                                    FROM #tmp1
                                                    WHERE tender_id IS NULL and paid IS NOT NULL and paid = 0;


                                                    select *
                                                    from
                                                    (select count(Difference) as Green from #tmp2 where Difference < 20) T1
                                                    INNER JOIN
                                                    (select count(Difference) as Yellow from #tmp2 where Difference > 20 AND Difference < 30) T2
                                                    ON(T2.Yellow != 0)
                                                    INNER JOIN
                                                    (select count(Difference) as Red from #tmp2 where Difference >= 30) T3
                                                    ON(T3.Red !=0);", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);

                int _ntfy_red = Convert.ToInt32( sdt.Rows[0]["Red"]);
                int _ntfy_green = Convert.ToInt32(sdt.Rows[0]["Green"]) -1;
                int _ntfy_yellow = Convert.ToInt32(sdt.Rows[0]["Yellow"]);

                notif_txt.InnerText = "<!>";
                txt_ntfy_red.InnerText = _ntfy_red.ToString();
                txt_ntfy_green.InnerText = _ntfy_green.ToString();
                txt_ntfy_yellow.InnerText = _ntfy_yellow.ToString();



                if (_ntfy_green != 0)
                { 
                    notif_tab.Visible = true;
                }


            

            DateTime d1 = DateTime.Now;
            DateTime d2 = new DateTime(2016, 08, 31);

            TimeSpan t = d1 - d2;
            
            string NumOfDays = Convert.ToInt32(t.TotalDays).ToString();
           // notif_txt.InnerText = NumOfDays.ToString();
            
        }

        protected void go_home(object sender, EventArgs e)
        {
            Response.Redirect("default.aspx");
        }

        protected void list_tndr(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("?action=tenders#procurements");
        }

        protected void img_btn_prnt_pre_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("gio.aspx?id=2");
        }

        protected void waybill_list(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("default.aspx?action=waybills#procurements");
        }

        protected void btn_calc_Click(object sender, ImageClickEventArgs e)
        {
            System.Diagnostics.Process.Start("calc.exe");
        }

        protected void Link_Suppliers_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("suppliers.aspx");
        }

        protected void btn_AddSupplier_Click(object sender, ImageClickEventArgs e)
        {

            string str = "insert into suppliers (is_supplier, name, taxcode, address, phone, fax, email) Values ('" + clientType.SelectedValue + "', N'" + companyName.Text + "', '" + taxID.Text + "', N'" + regAddress.Text + "', '" + mobile.Text + "', '" + lendline.Text + "', '" + email.Text + "')";
            SqlCommand cmd = new SqlCommand(str, con);
            con.Open();
            int count_ins = cmd.ExecuteNonQuery();
            con.Close();
            if (count_ins > 0)
            {

                Response.Redirect("suppliers.aspx");
            }
            else
            {
                Response.Write("<script type='text/javascript'>alert('შეცდომა, დამატება ვერ მოხერხდა !!!')</script>");
            }
        }

        protected void ImgBtn_GoodsList_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("?action=goods#itemlist");
        }

        // protected void ImgBtn_AddNewGood_Click(object sender, ImageClickEventArgs e)
        // {
        //     Response.Redirect("?action=goods&job=addnewgood#itemlist");
        // }

        protected void Waybills_in_Click(object sender, EventArgs e)
        {
            if (Request.Browser.Cookies) // To check that the browser support cookies
            {
                HttpCookie cookie = new HttpCookie("waybills");
                cookie.Value = "income";
                cookie.Expires = DateTime.Now.AddSeconds(2);
                Response.Cookies.Add(cookie);
                Response.Redirect("waybills.aspx");
            }
        }

        void CheckBox4_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox4.Checked == false)
            {
                CheckBox4.Checked = true;
            }
        }

        protected void btn_add_expences_Click(object sender, EventArgs e)
        {
            string exp_name = ExpenseName.Value;
            string exp_contr_id = ExpenseContractorId.SelectedValue;
            DateTime ex_dt = Convert.ToDateTime(ExpenseDate.Text);
            string exp_date = ex_dt.ToString("yyyy.MM.dd");
            string exp_price = ExpensePrice.Value;
            string exp_type = ExpenseType.SelectedValue;
            string exp_way = ExpenseWay.SelectedValue;
            string exp_comment = ExpenseComment.Text;

            string str = "insert into expenses (name, cost, contractor_id, expense_type, expense_way, expense_date, comment) Values (N'" + exp_name + "', '"+ exp_price +"', '" + exp_contr_id + "', '" + exp_type + "', '" + exp_way + "', '" + exp_date + "', N'" + exp_comment + "')";
            SqlCommand cmd = new SqlCommand(str, con);
            con.Open();
            int count_ins = cmd.ExecuteNonQuery();
            con.Close();
            if (count_ins > 0) 
            {               
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Script", "javascript:InsDone();", true);
            }
        }

        protected void btn_add_InJournal_Click(object sender, EventArgs e)
        {
            using (TextWriter tw = new StreamWriter(@"C:\TestSession\bin\session.csv", true, Encoding.UTF8))
            {
                // write a line of text to the file
                tw.WriteLine(DateTime.Now.ToShortDateString() + ", " + txt_InJournal_Name.Text + ", " + txt_InJournal_Price.Text + ", " + txt_InJournal_Text.Text);
            }
            txt_InJournal_Name.Text = String.Empty;
            txt_InJournal_Price.Text = String.Empty;
            txt_InJournal_Text.Text = String.Empty;
            MPopup_add_InJournal.Show();
        }

        public string txt_hashed_pass;
        public string db_hashed_pass;
        protected void btn_login_Click(object sender, EventArgs e)
        {
            string byte_user_pass = userpass.Text;
            SqlDataAdapter sda = new SqlDataAdapter("select * from my_users where user_name = '" + username.Text + "' AND user_pass = '" + userpass.Text + "' ", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);

            if (sdt.Rows.Count == 1)
            {
                // txt_user_area.InnerText = AuthUsers.strSessionValue.ToString();
                // Session["user"] = ""+ sdt.Rows[0]["id"].ToString() + "";
                string user_FirstName = sdt.Rows[0]["first_name"].ToString();
                string user_LastName = sdt.Rows[0]["last_name"].ToString();
                AuthUsers.strUserFullName = user_FirstName +" "+ user_LastName;

                // SHA256 MD5 is disposable by inheritance.  
                using (var sha256 = MD5.Create())
                {
                    var str_byte = byte_user_pass.ToString();

                    // Send a sample text to hash.  
                    var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(str_byte));
                    var hashed_db_Bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(sdt.Rows[0]["user_pass"].ToString()));
                    // Get the hashed string.  
                    var hash = BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
                    var hashdb = BitConverter.ToString(hashed_db_Bytes).Replace("-", "").ToLower();
                    // Print the string.   

                    txt_hashed_pass = hash;
                    db_hashed_pass = hashdb;
                }

                if(txt_hashed_pass == db_hashed_pass)
                {
                    Session["user"] = "" + sdt.Rows[0]["id"].ToString() + "";
                    Response.Redirect("#loged");
                }                
            }
            else
            {
                MPopup_error.Show();
                // Response.Write("<script type='text/javascript'>alert('შეცდომა!!!, პაროლი ან მომხმარებელი არასწორია')</script>");
            }

            username.Text = "";
            userpass.Text = "";            
        }       

        protected void lnkbtn_exit_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("#logoff");
        }
    }
}