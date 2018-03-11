using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

namespace Ribbon_WebApp
{
    public partial class waybills : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        public class MyDdlItem
        {
            public string Id { get; set; }
            public string Name { get; set; }

            public static List<MyDdlItem> GetAll()
            {



                List<MyDdlItem> list = new List<MyDdlItem>();
                list.Add(new MyDdlItem { Id = "1", Name = "Option 1" });
                list.Add(new MyDdlItem { Id = "2", Name = "Option 2" });
                list.Add(new MyDdlItem { Id = "3", Name = "Option 3" });
                list.Add(new MyDdlItem { Id = "4", Name = "Option 4" });
                return list;


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
                ddl_Contractor_Id.Items.AddRange(items.ToArray());
                ddl_Contractor_Id2.Items.AddRange(items.ToArray());
            }
        }

        protected void ShowPayTypes()
        {
            List<ListItem> items = new List<ListItem>();
            items.Add(new ListItem("ნაღდი (სალაროში)", "1"));
            items.Add(new ListItem("უნაღდო (ბანკში)", "2"));
            ddl_Pay_Method_Id.Items.AddRange(items.ToArray());
            ddl_Pay_Method_Id2.Items.AddRange(items.ToArray());
        }

        protected void ShowTendersList()
        {
            SqlDataAdapter da1 = new SqlDataAdapter("select * from tenders ", con);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                string id = dt1.Rows[i]["id"].ToString();
                string TenderNum = dt1.Rows[i]["tender_num"].ToString();
                List<ListItem> items = new List<ListItem>();
                items.Add(new ListItem("" + TenderNum + "", "" + id + ""));
                tender_Id_Edit_ddl.Items.AddRange(items.ToArray());
            }
        }

        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 

                ShowSuppliersInDropdown();
                ShowPayTypes();
                ShowTendersList();
                if (Request.Cookies["waybills"] != null && Request.Cookies["waybills"].Value == "income")
                {
                    GridView1.Visible = false;
                    GridView2.Visible = true;
                    // tbl_PaidOrNot.Visible = true;
                }
                else
                {
                    GridView1.Visible = true;
                    GridView2.Visible = false;
                }
            }

            SeeWaybill();
            //  FilterExpression="waybill_number LIKE '%{0}%' OR name LIKE '%{0}%' AND waybill_date > '{1}' AND waybill_date < '{2}' "
            //  SqlDataSource1.FilterExpression = "waybill_number LIKE '%{0}%' OR name LIKE '%{0}%' AND waybill_date > '"+ date_from.Text +"' AND waybill_date < '"+ date_to.Text +"' ";
            string filtr_name = txt_name.Text.ToString();
            string filtr_DateFrom = date_from.Text.ToString();
            string filtr_DateTo = date_to.Text.ToString();
            if (!string.IsNullOrEmpty(filtr_name))
            {
                //გაცემული ზედნადებების გაფილტვრა ნომრის ან დასახელების მიხედვით.
                SqlDataSource1.FilterParameters.Clear();
                ControlParameter cpText = new ControlParameter();
                cpText.ControlID = "txt_name";
                cpText.Name = "waybill_number";
                cpText.PropertyName = "Text";
                SqlDataSource1.FilterParameters.Add(cpText);
                SqlDataSource1.FilterExpression = "waybill_number LIKE '%{0}%' OR name LIKE '%{0}%'";

                //მიღებული ზედნადებების გაფილტვრა ნომრის ან დასახელების მიხედვით.
                Source1.FilterParameters.Clear();
                ControlParameter cpwbin = new ControlParameter();
                cpwbin.ControlID = "txt_name";
                cpwbin.Name = "waybill_number";
                cpwbin.PropertyName = "Text";
                Source1.FilterParameters.Add(cpwbin);
                Source1.FilterExpression = "waybill_number LIKE '%{0}%' OR name LIKE '%{0}%'";

            }

            if (string.IsNullOrEmpty(filtr_name))
            {
                //გაცემული ზედნადებების გაფილტვრა თარიღის მიხედვით.
                SqlDataSource1.FilterParameters.Clear();
                ControlParameter cpDateFrom = new ControlParameter();
                cpDateFrom.ControlID = "date_from";
                cpDateFrom.Name = "waybill_date";
                cpDateFrom.PropertyName = "Text";
                cpDateFrom.Type = TypeCode.DateTime;

                ControlParameter cpDateTo = new ControlParameter();
                cpDateTo.ControlID = "date_to";
                cpDateTo.Name = "waybill_date";
                cpDateTo.PropertyName = "Text";
                cpDateTo.Type = TypeCode.DateTime;

                SqlDataSource1.FilterParameters.Add(cpDateFrom);
                SqlDataSource1.FilterParameters.Add(cpDateTo);
                SqlDataSource1.FilterExpression = SqlDataSource1.FilterExpression = " waybill_date >= '" + date_from.Text + "' AND waybill_date <= '" + date_to.Text + "' ";

                //მიღებული ზედნადებების გაფილტვრა თარიღის მიხედვით.
                Source1.FilterParameters.Clear();
                ControlParameter cpWbInDateFrom = new ControlParameter();
                cpWbInDateFrom.ControlID = "date_from";
                cpWbInDateFrom.Name = "waybill_date";
                cpWbInDateFrom.PropertyName = "Text";
                cpWbInDateFrom.Type = TypeCode.DateTime;

                ControlParameter cpWbInDateTo = new ControlParameter();
                cpWbInDateTo.ControlID = "date_to";
                cpWbInDateTo.Name = "waybill_date";
                cpWbInDateTo.PropertyName = "Text";
                cpWbInDateTo.Type = TypeCode.DateTime;

                Source1.FilterParameters.Add(cpWbInDateFrom);
                Source1.FilterParameters.Add(cpWbInDateTo);
                Source1.FilterExpression = Source1.FilterExpression = " waybill_date >= '" + date_from.Text + "' AND waybill_date <= '" + date_to.Text + "' ";
            }
            if (!string.IsNullOrEmpty(filtr_name) && !string.IsNullOrEmpty(filtr_DateFrom) && !string.IsNullOrEmpty(filtr_DateTo))
            {
                //გაცემული ზედნადებების გაფილტვრა დასახელების ან ნომრის და თარიღის მიხედვით
                SqlDataSource1.FilterParameters.Clear();
                ControlParameter cpText = new ControlParameter();
                cpText.ControlID = "txt_name";
                cpText.Name = "waybill_number";
                cpText.PropertyName = "Text";

                ControlParameter cpDateFrom = new ControlParameter();
                cpDateFrom.ControlID = "date_from";
                cpDateFrom.Name = "waybill_date";
                cpDateFrom.PropertyName = "Text";
                cpDateFrom.Type = TypeCode.DateTime;

                ControlParameter cpDateTo = new ControlParameter();
                cpDateTo.ControlID = "date_to";
                cpDateTo.Name = "waybill_date";
                cpDateTo.PropertyName = "Text";
                cpDateTo.Type = TypeCode.DateTime;

                SqlDataSource1.FilterParameters.Add(cpText);
                SqlDataSource1.FilterParameters.Add(cpDateFrom);
                SqlDataSource1.FilterParameters.Add(cpDateTo);
                SqlDataSource1.FilterExpression = "waybill_number LIKE '%{0}%' OR name LIKE '%{0}%' AND waybill_date >= '" + date_from.Text + "' AND waybill_date <= '" + date_to.Text + "' ";


                //მიღებული ზედნადებების გაფილტვრა დასახელების ან ნომრის და თარიღის მიხედვით
                Source1.FilterParameters.Clear();
                ControlParameter cpWbInText = new ControlParameter();
                cpWbInText.ControlID = "txt_name";
                cpWbInText.Name = "waybill_number";
                cpWbInText.PropertyName = "Text";

                ControlParameter cpWbInDateFrom = new ControlParameter();
                cpWbInDateFrom.ControlID = "date_from";
                cpWbInDateFrom.Name = "waybill_date";
                cpWbInDateFrom.PropertyName = "Text";
                cpWbInDateFrom.Type = TypeCode.DateTime;

                ControlParameter cpWbInDateTo = new ControlParameter();
                cpWbInDateTo.ControlID = "date_to";
                cpWbInDateTo.Name = "waybill_date";
                cpWbInDateTo.PropertyName = "Text";
                cpWbInDateTo.Type = TypeCode.DateTime;

                Source1.FilterParameters.Add(cpWbInText);
                Source1.FilterParameters.Add(cpWbInDateFrom);
                Source1.FilterParameters.Add(cpWbInDateTo);
                Source1.FilterExpression = "waybill_number LIKE '%{0}%' OR name LIKE '%{0}%' AND waybill_date >= '" + date_from.Text + "' AND waybill_date <= '" + date_to.Text + "' ";
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {

            ViewState["CheckRefresh"] = Session["CheckRefresh"];

        }

        private void Grid3Bind()
        {
            if (!string.IsNullOrEmpty(lbl_tender_id.Text) && !string.IsNullOrEmpty(lbl_wb_id.Text))
            {
                SqlDataAdapter sda = new SqlDataAdapter("select tenders_items.*, tenders_waybills.id, tenders_waybills.tender_id, goods.Id, goods.name, goods.comment from tenders_items, goods, tenders_waybills where goods.Id = tenders_items.goods_id AND waybill_id = '" + lbl_wb_id.Text + "' and tenders_waybills.tender_id = '" + lbl_tender_id.Text + "' and tenders_waybills.id = tenders_items.waybill_id order by tenders_items.id", con);
                DataTable sdt = new DataTable();
                sda.Fill(sdt);
                GridView3.DataSource = sdt;
                GridView3.DataBind();
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());

            }
            else if (string.IsNullOrEmpty(lbl_tender_id.Text) && !string.IsNullOrEmpty(lbl_wb_id.Text))
            {
                //Response.Write("<script type='text/javascript'>alert('ტენდერის ID არ მოიძებნა')</script>");
                SqlDataAdapter sda = new SqlDataAdapter(@"select tenders_items.*, tenders_waybills.id, goods.Id, goods.name, goods.comment from tenders_items, goods, tenders_waybills where goods.Id = tenders_items.goods_id AND waybill_id = '" + lbl_wb_id.Text + "' and tenders_waybills.id = tenders_items.waybill_id order by tenders_items.id", con);
                DataTable sdt = new DataTable();
                sda.Fill(sdt);
                GridView3.DataSource = sdt;
                GridView3.DataBind();
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            }
        }

        protected void ImgBtn_PreviewGrid_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imgbtn = (ImageButton)sender;
            GridViewRow gvr = (GridViewRow)imgbtn.NamingContainer;
            lbl_wb_id.Text = gvr.Cells[0].Text;
            // Convert.ToInt32(lbl_wb_id.Text.ToString());
            lbl_tender_id.Text = gvr.Cells[1].Text;
            //Convert.ToInt32(lbl_tender_id.Text.ToString());
            lbl_wb_number.Text = "ზედნადების N: " + gvr.Cells[2].Text;
            lbl_tr_type.Text = "-1";



            // ControlParameter cpText = new ControlParameter();
            // cpText.ControlID = "lbl_ID";
            // cpText.Name = "waybill_id";
            // cpText.PropertyName = "Text";

            // TendersWaybillsItems.FilterParameters.Add(cpText);
            // TendersWaybillsItems.FilterExpression = "waybill_id = '{0}'";
            home.Style.Add("visibility", "visible");
            GridView1.Visible = false;
            Rs_Tab_Header.Visible = false;
            GridView3.Visible = true;
            Grid3Bind();
        }

        protected void SeeWaybill()
        {
            if (Request.Cookies["Wb_Id"] != null)
            {
                lbl_wb_id.Text = Request.Cookies["Wb_Id"].Value;
                // lbl_tender_id.Text = Request.Cookies["Td_Id"].Value;

                home.Style.Add("visibility", "visible");
                GridView1.Visible = false;
                Rs_Tab_Header.Visible = false;
                GridView3.Visible = true;
                Grid3Bind();
            }
        }

        protected void btn_update_Click(object sender, EventArgs e)
        {
            double Item_UpdatePrice, Item_UpdateQty;
            int Item_UpdateId;
            Item_UpdatePrice = Convert.ToDouble(txt_upd_wbItemPrice.Text.Replace(",", "."));
            Item_UpdateQty = Convert.ToDouble(txt_upd_wbItemQty.Text.Replace(",", "."));
            Item_UpdateId = Convert.ToInt32(lbl_ID.Text);
            con.Open();
            SqlCommand cmd = new SqlCommand(@"  BEGIN TRANSACTION;
                                                UPDATE tenders_items  SET tenders_items.quantity = '" + Item_UpdateQty + "', tenders_items.price = '" + Item_UpdatePrice + "' FROM tenders_items T1, tenders_waybills T2   WHERE T1.waybill_id = T2.id  and T1.id = '" + Item_UpdateId + "'   UPDATE tenders_waybills  SET tenders_waybills.cost = '" + Item_UpdatePrice * Item_UpdateQty + "'   FROM tenders_items T1, tenders_waybills T2     WHERE T1.waybill_id = T2.id  and T1.id = '" + Item_UpdateId + "' COMMIT  ", con);
            cmd.ExecuteNonQuery();
            int count_update = cmd.ExecuteNonQuery();
            if (count_update != 0)
            {
                //btn_update.OnClientClick = "JavaScript: window.history.back(1); return false;";                  
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:doneOK(); ", true);
            }
            con.Close();
        }

        protected void txt_WB_name_TextChanged(object sender, EventArgs e)
        {
            TextBox grdtenderid = (TextBox)GridView3.FooterRow.FindControl("txt_tenderid");
            TextBox grdwaybillid = (TextBox)GridView3.FooterRow.FindControl("txt_waybillid");
            /// TextBox grdtrtype = (TextBox)GridView3.FooterRow.FindControl("txt_trtype");
            TextBox grdFooterId = (TextBox)GridView3.FooterRow.FindControl("txt_goodsid");
            TextBox grdFooterName = (TextBox)GridView3.FooterRow.FindControl("txt_goodsname");
            TextBox grdFooterCode = (TextBox)GridView3.FooterRow.FindControl("txt_goodscode");
            TextBox grdFooterprice = (TextBox)GridView3.FooterRow.FindControl("txt_goodsprice");

            grdwaybillid.Text = lbl_wb_id.Text;
            grdtenderid.Text = lbl_tender_id.Text;



            if (!string.IsNullOrEmpty(grdFooterCode.Text))
            {
                SqlDataAdapter sda = new SqlDataAdapter("select * from goods where product_code LIKE '%" + grdFooterCode.Text + "%' ", con);
                DataTable dt1 = new DataTable();
                sda.Fill(dt1);
                if (dt1.Rows.Count != 0)
                {
                    string sqlid = dt1.Rows[0][0].ToString();
                    string sqlname = dt1.Rows[0][5].ToString();
                    string sqlunit = dt1.Rows[0][6].ToString();
                    string sqlprice = dt1.Rows[0][9].ToString();

                    grdFooterId.Text = sqlid;
                    grdFooterName.Text = sqlname;
                    grdFooterprice.Text = sqlprice;

                    // SqlDataAdapter sda1 = new SqlDataAdapter("select tenders_items.id, tenders_items.waybill_id, tenders_items.goods_id, tenders_items.unit_name, tenders_items.quantity, tenders_items.price, tenders_items.tr_type, tenders_waybills.id, tenders_waybills.tender_id, goods.Id, goods.name from tenders_items, goods, tenders_waybills where goods.Id = tenders_items.goods_id AND waybill_id = '" + grdwaybillid.Text + "'  and tenders_waybills.tender_id = '" + grdtenderid.Text + "' and tenders_waybills.id = tenders_items.waybill_id", con);
                    // DataTable dt11 = new DataTable();
                    // sda1.Fill(dt11);
                    // if (dt11.Rows.Count != 0)
                    // {
                       // string trans_metod = dt11.Rows[0]["tr_type"].ToString();
                       // grdtrtype.Text = trans_metod;
                    // }
                }
                else
                {
                    Response.Write("<script type='text/javascript'>alert('აღნიშნული კოდით პროდუქტი არ მოიძებნა')</script>");
                }
            }
        }

        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "InsertToWaybill")
            {

                TextBox grdwaybillid = (TextBox)GridView3.FooterRow.FindControl("txt_waybillid");
                TextBox grdtrtype = (TextBox)GridView3.FooterRow.FindControl("txt_trtype");
                TextBox grdFooterId = (TextBox)GridView3.FooterRow.FindControl("txt_goodsid");
                TextBox grdFooterCode = (TextBox)GridView3.FooterRow.FindControl("txt_goodscode");
                TextBox grdFooterName = (TextBox)GridView3.FooterRow.FindControl("txt_goodsname");
                TextBox grdFooterQty = (TextBox)GridView3.FooterRow.FindControl("txt_goodsqty");
                DropDownList grdFooterunit = (DropDownList)GridView3.FooterRow.FindControl("txt_goodsunit_selectedValueId");
                TextBox grdFooterprice = (TextBox)GridView3.FooterRow.FindControl("txt_goodsprice");


                if (!string.IsNullOrEmpty(grdwaybillid.Text) && !string.IsNullOrEmpty(grdFooterId.Text) && !string.IsNullOrEmpty(grdFooterCode.Text) && !string.IsNullOrEmpty(grdFooterName.Text) && !string.IsNullOrEmpty(grdFooterQty.Text) && !string.IsNullOrEmpty(grdFooterprice.Text))
                {
                    double item_Price, item_Qty;
                    // int item_tr_tupe = Convert.ToInt32(lbl_tr_type.Text);

                    int waybill_ID = Convert.ToInt32(grdwaybillid.Text);
                    int goods_ID = Convert.ToInt32(grdFooterId.Text);
                    string item_Name = grdFooterName.Text;
                    item_Price = Convert.ToDouble(grdFooterprice.Text.Replace(",", "."));
                    string item_Unit = Convert.ToString(grdFooterunit.SelectedItem.Text);
                    item_Qty = Convert.ToDouble(grdFooterQty.Text.Replace(",", "."));
                    // Convert.ToInt32(item_tr_tupe.ToString());

                    if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
                    {
                        con.Open();
                        string str = "INSERT INTO tenders_items (waybill_id,goods_id,unit_name,quantity,price) VALUES (N'" + waybill_ID + "','" + goods_ID + "',N'" + item_Unit + "','" + item_Qty + "','" + item_Price + "')";
                        SqlCommand strCmd = new SqlCommand(str, con);
                        int ins = strCmd.ExecuteNonQuery();
                        if (ins != 0)
                        {
                            con.Close();
                            Grid3Bind();
                            Response.Write("<SCRIPT language='JavaScript'>  alert('ბაზაში დამატება შესრულდა წარმატებით!') </SCRIPT>");
                            //Response.Redirect(Request.RawUrl);
                        }
                    }
                    else if (Session["CheckRefresh"].ToString() != ViewState["CheckRefresh"].ToString())
                    {
                        Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა! სესია დასრულებულია, ამიტომ დამატება ვერ მოხერხდა!') </SCRIPT>");
                    }
                    else
                    {
                        Response.Redirect("waybills.aspx");
                    }
                }
                else
                {
                    Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა! დამატება ვერ მოხერხდა, შეავსეთ ყველა ველი!') </SCRIPT>");
                }
            }
        }

        protected void InsToWaybill(object sender, EventArgs e)
        {
            CheckBox check_footer = (CheckBox)GridView3.HeaderRow.FindControl("chkb_showfooter");
            if (check_footer.Checked == true)
            {
                GridView3.ShowFooter = true;
                GridView3.FooterRow.Visible = true;
            }

            else
            {
                GridView3.ShowFooter = false;
                GridView3.FooterRow.Visible = false;
            }
        }

        protected void ImgBtn_DelFromWaybill_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imgbtn = (ImageButton)sender;
            GridViewRow gvr = (GridViewRow)imgbtn.NamingContainer;
            var delId = gvr.Cells[0].Text;

            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                con.Open();
                string str = "DELETE from tenders_items WHERE id = '" + delId + "' ";
                SqlCommand strCmd = new SqlCommand(str, con);
                int ins = strCmd.ExecuteNonQuery();

                if (ins != 0)
                {
                    Response.Write("<SCRIPT language='JavaScript'>  alert('წაშლა შესრულდა წარმატებით!') </SCRIPT>");
                    Grid3Bind();
                    //Response.Redirect(Request.RawUrl);
                    con.Close();
                }
                else
                {
                    Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა, ოპერაცია წარუმატებელია!') </SCRIPT>");
                }
            }

            else
            {
                Response.Redirect("waybills.aspx");
            }
        }

        protected void go_home(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }

        public string kl_id;
        public string exp_w;
        public string wb_from_DB;
        public double wb_cost;
        public double wb_paid;
        public string wb_comment;
        protected void ImgBtn_Edit_Waybill_Click(object sender, ImageClickEventArgs e)
        {

            ImageButton ImgBtn_Edit = (ImageButton)sender;
            GridViewRow Gvr = (GridViewRow)ImgBtn_Edit.NamingContainer;
            var editID = Gvr.Cells[0].Text;
            var tndrID = Gvr.Cells[1].Text;
            var wb_numb = Gvr.Cells[2].Text;


            SqlDataAdapter da = new SqlDataAdapter("select id, tender_id, contractor_id, expense_way, waybill_date, cost, paid, comment from tenders_waybills where id = '" + editID + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                kl_id = dt.Rows[0]["contractor_id"].ToString();
                exp_w = dt.Rows[0]["expense_way"].ToString();
                wb_from_DB = dt.Rows[0]["waybill_date"].ToString();
                wb_cost = Convert.ToDouble(dt.Rows[0]["cost"].ToString());
                wb_paid = Convert.ToDouble(dt.Rows[0]["paid"].ToString());
                wb_comment = Convert.ToString(dt.Rows[0]["comment"].ToString());
            }

            waybill_Id_Edit_lbl.Text = editID.ToString();
            if (!string.IsNullOrEmpty(tndrID.ToString()))
            {
                tender_Id_Edit_ddl.SelectedValue = tndrID.ToString();
            }
            else
            {
                tender_Id_Edit_ddl.SelectedValue = "";
            }

            ddl_Contractor_Id.SelectedValue = kl_id.ToString(); // Add klient value to EditForm ddl
            ddl_Pay_Method_Id.SelectedValue = exp_w.ToString();  // Add pay method value to EditForm ddl
            DateTime wb_date = Convert.ToDateTime(wb_from_DB.ToString());
            waybill_date_Edit_txt.Text = wb_date.ToString("dd/MM/yyyy"); // Convert date and Add  value to EditForm calendar's textbox
            Waybill_Num_Edit_txt.Text = wb_numb.ToString();  // Add waybill number value to EditForm
            Waybill_Cost_Edit_txt.Text = wb_cost.ToString(); // Add waybill cost value to EditForm
            Waybill_Paid_Edit_txt.Text = wb_paid.ToString(); // Add waybill paid value to EditForm
            Waybill_Comment_Edit_txt.Text = wb_comment.ToString(); // Add waybill Comment value to EditForm

            ModalPopupExtender2.Show();
        }


        public string update_id;
        public string upd_tender_id;
        public string upd_waybill_date;
        public string upd_paytype;
        public string upd_client_id;
        public string upd_waybill_number;
        public string upd_cost;
        public string upd_paid;
        public string upd_comment;
        protected void Waybill_Edit_Update_Btn_Click(object sender, EventArgs e)
        {
            update_id = waybill_Id_Edit_lbl.Text;
            upd_tender_id = tender_Id_Edit_ddl.SelectedValue;

            DateTime newUpdate_date = Convert.ToDateTime(waybill_date_Edit_txt.Text);
            upd_waybill_date = newUpdate_date.ToString("yyyy.MM.dd");

            upd_paytype = ddl_Pay_Method_Id.SelectedValue;
            upd_client_id = ddl_Contractor_Id.SelectedValue;
            upd_waybill_number = Waybill_Num_Edit_txt.Text;
            upd_cost = Waybill_Cost_Edit_txt.Text;
            upd_paid = Waybill_Paid_Edit_txt.Text;
            upd_comment = Waybill_Comment_Edit_txt.Text;

            con.Open();
            SqlCommand cmd = new SqlCommand(@" UPDATE tenders_waybills  SET tender_id = '" + upd_tender_id + "',  waybill_date = '" + upd_waybill_date + "', expense_way = '" + upd_paytype + "', contractor_id = '" + upd_client_id + "', waybill_number = N'" + upd_waybill_number + "', cost = '" + upd_cost + "', paid = '" + upd_paid + "' WHERE id = '" + update_id + "' ", con);
            cmd.ExecuteNonQuery();
            con.Close();
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

        protected void ImgBtn_Preview_WbIn_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imgbtn = (ImageButton)sender;
            GridViewRow gvr = (GridViewRow)imgbtn.NamingContainer;
            lbl_wb_id.Text = gvr.Cells[0].Text;
            lbl_tr_type.Text = "1";

            lbl_wb_number.Text = "ზედნადების N: " + gvr.Cells[1].Text;
            home.Style.Add("visibility", "hidden");
            ImgBtnHome.Visible = true;
            GridView1.Visible = false;
            GridView2.Visible = false;
            Rs_Tab_Header.Visible = false;
            GridView3.Visible = true;
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from 
                                                    (select id ,waybill_id, goods_id, quantity, price from tenders_items) T1
                                                    INNER JOIN
                                                    (select Id AS Gid, name, comment from goods ) T2
                                                    ON (T1.goods_id = T2.Gid)
                                                    where waybill_id = '" + lbl_wb_id.Text + "' ", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);
            GridView3.DataSource = sdt;
            GridView3.DataBind();
            Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
        }

        protected void AddcookiesAndGotoWBS()
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

        protected void ImgBtnHome_Click(object sender, ImageClickEventArgs e)
        {
            AddcookiesAndGotoWBS();
        }

        protected void ImgBtn_Edit_WbIn_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton ImgBtn_Edit = (ImageButton)sender;
            GridViewRow Gvr = (GridViewRow)ImgBtn_Edit.NamingContainer;
            var editID = Gvr.Cells[0].Text;
            var wb_numb = Gvr.Cells[1].Text;


            SqlDataAdapter da = new SqlDataAdapter("select id, contractor_id, expense_way, waybill_date, cost, paid, comment from tenders_waybills where id = '" + editID + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                kl_id = dt.Rows[0]["contractor_id"].ToString();
                exp_w = dt.Rows[0]["expense_way"].ToString();
                wb_from_DB = dt.Rows[0]["waybill_date"].ToString();
                wb_cost = Convert.ToDouble(dt.Rows[0]["cost"].ToString());
                wb_paid = Convert.ToDouble(dt.Rows[0]["paid"].ToString());
                wb_comment = Convert.ToString(dt.Rows[0]["comment"].ToString());
            }

            waybill_In_Id_Edit_lbl.Text = editID.ToString();

            ddl_Contractor_Id2.SelectedValue = kl_id.ToString(); // Add klient value to EditForm ddl
            ddl_Pay_Method_Id2.SelectedValue = exp_w.ToString();  // Add pay method value to EditForm ddl
            DateTime wb_date = Convert.ToDateTime(wb_from_DB.ToString());
            waybill_In_date_Edit_txt.Text = wb_date.ToString("dd/MM/yyyy"); // Convert date and Add  value to EditForm calendar's textbox
            Waybill_In_Num_Edit_txt.Text = wb_numb.ToString();  // Add waybill number value to EditForm
            Waybill_In_Cost_Edit_txt.Text = wb_cost.ToString(); // Add waybill cost value to EditForm
            Waybill_In_Paid_Edit_txt.Text = wb_paid.ToString(); // Add waybill paid value to EditForm
            Waybill_In_Comment_Edit_txt.Text = wb_comment.ToString();

            ModalPopupExtender3.Show();
        }

        protected void Waybill_In_Edit_Update_Btn_Click(object sender, EventArgs e)
        {
            update_id = waybill_In_Id_Edit_lbl.Text;

            DateTime newUpdate_INdate = Convert.ToDateTime(waybill_In_date_Edit_txt.Text);
            upd_waybill_date = newUpdate_INdate.ToString("yyyy.MM.dd");

            upd_paytype = ddl_Pay_Method_Id2.SelectedValue;
            upd_client_id = ddl_Contractor_Id2.SelectedValue;
            upd_waybill_number = Waybill_In_Num_Edit_txt.Text;
            upd_cost = Waybill_In_Cost_Edit_txt.Text;
            upd_paid = Waybill_In_Paid_Edit_txt.Text;
            upd_comment = Waybill_In_Comment_Edit_txt.Text;

            con.Open();
            SqlCommand cmd = new SqlCommand(@" UPDATE tenders_waybills  SET waybill_date = '" + upd_waybill_date + "', expense_way = '" + upd_paytype + "', contractor_id = '" + upd_client_id + "', waybill_number = N'" + upd_waybill_number + "', cost = '" + upd_cost + "', paid = '" + upd_paid + "', comment = N'" + upd_comment + "' WHERE id = '" + update_id + "' ", con);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void ImgBtn_DelFrom_WbIn_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton ImgBtn_DelFromWB = (ImageButton)sender;
            GridViewRow Gvr = (GridViewRow)ImgBtn_DelFromWB.NamingContainer;
            var DelFromID = Gvr.Cells[0].Text;

            con.Open();
            string str = "DELETE from tenders_items WHERE waybill_id = '" + DelFromID + "' ";
            string str2 = "DELETE from tenders_waybills WHERE id = '" + DelFromID + "' ";
            SqlCommand strCmd = new SqlCommand(str, con);
            SqlCommand strCmd2 = new SqlCommand(str2, con);
            int del1 = strCmd.ExecuteNonQuery();
            int del2 = strCmd2.ExecuteNonQuery();

            if (del1 != 0 && del2 != 0)
            {
                Response.Write("<SCRIPT language='JavaScript'>  alert('წაიშალა " + del2 + " ზედნადები (" + del1 + " დასახელების პროდუქციით)') </SCRIPT>");

                //Response.Redirect(Request.RawUrl);
                con.Close();

                AddcookiesAndGotoWBS();
            }
            else
            {
                Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა, ოპერაცია წარუმატებელია!') </SCRIPT>");
            }
        }

        double dWaybillsTotal = 0;
        protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='aquamarine';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white';";
                e.Row.ToolTip = "Click last column for selecting this row.";
                string totof_waybills = e.Row.Cells[5].Text;
                dWaybillsTotal += Convert.ToDouble(totof_waybills);

                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    if (e.Row.Cells[i].Text == "&nbsp;")
                    {
                        e.Row.Cells[i].Text = "";
                    }
                }

            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotaofwaybills = (Label)e.Row.FindControl("lblSum_Waybills");
                lblTotaofwaybills.Text = "სულ: " + dWaybillsTotal.ToString();
            }
        }

        double dWaybillsTotalIn = 0;
        double dWaybillsTotalInPaid = 0;
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='aquamarine';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white';";
                e.Row.ToolTip = "Click last column for selecting this row.";
                string totof_waybillsIn = e.Row.Cells[4].Text;
                string totof_waybillsInPaid = e.Row.Cells[5].Text;
                dWaybillsTotalIn += Convert.ToDouble(totof_waybillsIn);
                dWaybillsTotalInPaid += Convert.ToDouble(totof_waybillsInPaid);
            }
                

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotaofwaybillsIn = (Label)e.Row.FindControl("lblSum_WaybillsIn");
                Label lblTotaofwaybillsInPaid = (Label)e.Row.FindControl("lblSum_WaybillsIn_Paid");
                lblTotaofwaybillsIn.Text = "სულ: " + dWaybillsTotalIn.ToString();
                lblTotaofwaybillsInPaid.Text = "Paid: " + dWaybillsTotalInPaid.ToString();
            }

        }

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='aquamarine';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white';";
            }

        }

        protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
        {

            var grid = (GridView)sender;
            foreach (GridViewRow row in grid.Rows)
            {

                var div = (HtmlGenericControl)row.FindControl("Correct_Div");
                var undo_div = (HtmlGenericControl)row.FindControl("Undo_Div");

                var btn_edit_wb_its = (ImageButton)row.FindControl("ImgBtn_CorrectWBItem");
                var txt_wb_its_name = (TextBox)row.FindControl("lbl_WB_name");
                var txt_wb_its_qty = (TextBox)row.FindControl("lbl_Item_qty");
                var txt_wb_its_price = (TextBox)row.FindControl("lbl_WB_price");
                // Compare this row with the currently selected row using the SelectedRow property
                // SelectedRow might be null, the logic would work anyway
                div.Visible = row == grid.SelectedRow;
                undo_div.Visible = row == grid.SelectedRow;
                btn_edit_wb_its.Visible = row == grid.SelectedRow;
                txt_wb_its_name.Enabled = row == grid.SelectedRow;
                txt_wb_its_qty.Enabled = row == grid.SelectedRow;
                if (txt_wb_its_qty.ReadOnly == true)
                {
                    txt_wb_its_qty.ReadOnly = false;
                }
                txt_wb_its_price.Enabled = row == grid.SelectedRow;
                if (txt_wb_its_price.ReadOnly == true)
                {
                    txt_wb_its_price.ReadOnly = false;
                }

            }

        }

        protected void ImgBtn_CorrectWBItem_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btn_update_wb_item = (ImageButton)sender;
            GridViewRow wb_item = (GridViewRow)btn_update_wb_item.NamingContainer;
            lbl_update_id.Text = wb_item.Cells[0].Text;
            var div = (HtmlGenericControl)wb_item.FindControl("Correct_Div");
            var txt_wb_upd_qty = (TextBox)wb_item.Cells[2].FindControl("lbl_Item_qty");
            var txt_wb_upd_price = (TextBox)wb_item.Cells[3].FindControl("lbl_WB_price");
            int upd_id = Convert.ToInt32(lbl_update_id.Text);
            double upd_qty = Convert.ToDouble(txt_wb_upd_qty.Text);
            double upd_price = Convert.ToDouble(txt_wb_upd_price.Text);

            con.Open();
            SqlCommand cmd = new SqlCommand(@" UPDATE tenders_items  SET quantity = '" + upd_qty + "',  price = '" + upd_price + "' WHERE id = '" + upd_id + "' ", con);
            int cunt_upd_wb_itms = cmd.ExecuteNonQuery();
            if (cunt_upd_wb_itms != 0)
            {
                div.Visible = false;
                txt_wb_upd_qty.ReadOnly = true;
                txt_wb_upd_price.ReadOnly = true;

            }
            con.Close();

            // Response.Write("<script type='text/javascript'>alert('" + upd_qty + " - " + upd_price + "')</script>");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btn_update_wb_item = (ImageButton)sender;
            GridViewRow wb_item = (GridViewRow)btn_update_wb_item.NamingContainer;

            var Corr_div = (HtmlGenericControl)wb_item.FindControl("Correct_Div");
            var Undo_div = (HtmlGenericControl)wb_item.FindControl("Undo_div");
            var txt_wb_upd_qty = (TextBox)wb_item.Cells[2].FindControl("lbl_Item_qty");
            var txt_wb_upd_price = (TextBox)wb_item.Cells[3].FindControl("lbl_WB_price");

            Corr_div.Visible = false;
            Undo_div.Visible = false;
            txt_wb_upd_qty.ReadOnly = true;
            txt_wb_upd_price.ReadOnly = true;
        }

    }
}