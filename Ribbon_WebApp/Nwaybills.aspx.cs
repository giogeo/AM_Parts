using System;
using System.IO;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.Data.OleDb;
using Excel = Microsoft.Office.Interop.Excel;
using System.Web.UI.HtmlControls;

namespace Ribbon_WebApp
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                AjaxControlToolkit.ModalPopupExtender m_panel = this.Master.FindControl("MPopup_Login") as AjaxControlToolkit.ModalPopupExtender;
                m_panel.Show();
            }

            if (!IsPostBack)
            {
                empty_dt();
                MyTendersInDrList();
                ContractorsInDrList();
                Generate_WB_Num();
                //Grd1p_load();
            }
            ddl_val = TenderId_inputId.SelectedValue;
            check_box_status();
        }

        protected void TestVoid()
        {
            SqlDataAdapter sda = new SqlDataAdapter("select * from tenders ", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);
        }

        void empty_dt()
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[8] { new DataColumn("GridNum"), new DataColumn("GoodId"), new DataColumn("ItemCode"), new DataColumn("ItemName"), new DataColumn("ItemUnit"), new DataColumn("ItemQty"), new DataColumn("ItemPrice"), new DataColumn("ItemTotalPrice") });

            string Grd_Nm = String.Empty ;
            string G_Id = String.Empty;
            string name = String.Empty;
            string Item_Code = String.Empty;
            string Unit_Name = String.Empty;
            string Item_Price = String.Empty;
            string Item_Qty = String.Empty;
            string sum = String.Empty;

            dt.Rows.Add(Grd_Nm, G_Id, Item_Code, name, Unit_Name, Item_Qty, Item_Price, sum);

            GridView2.DataSource = null;
            if (GridView2.DataSource == null)
            {
                GridView2.DataSource = new string[] { };
            }
            GridView2.DataBind();
            
        }

        protected void MyTendersInDrList()
        {
            SqlDataAdapter sda = new SqlDataAdapter("select * from tenders ", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);
            for (int i = 0; i < sdt.Rows.Count; i++)
            {
                string TenderN = sdt.Rows[i]["tender_num"].ToString();
                string TenderId = sdt.Rows[i]["id"].ToString();
                TenderId_inputId.Items.Insert(0, new ListItem("" + TenderN + "", "" + TenderId + ""));
            }
        }

        protected void ContractorsInDrList()
        {
            SqlDataAdapter da = new SqlDataAdapter("select * from suppliers ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string ContractorName = dt.Rows[i]["name"].ToString();
                string ContractorId = dt.Rows[i]["id"].ToString();
                Contractor_inputId.Items.Insert(0, new ListItem("" + ContractorName + "", "" + ContractorId + ""));
                BuyerId_inputId.Items.Insert(0, new ListItem("" + ContractorName + "", "" + ContractorId + ""));
            }
        }

        protected void Generate_WB_Num()
        {
            string tmp_wbn = string.Empty;
            string tmp_wbn_converted = string.Empty;

            tmp_wbn = DateTime.Now.ToString();
            tmp_wbn_converted = RemoveElementsFrom.RmvSomeElements(tmp_wbn);
            WaybillNumber_inputID.Value = tmp_wbn_converted.Replace("PM", "").Replace("AM", ""); // waybill number            
        }

        protected void AddTenderdata_ToDB()
        {
            // Tender SPA Number
            string TenderNum = TenderNumber_inputID.Value;
            // Tender date from
            DateTime startDate = TenderDateFrom.SelectedDate;
            string formatDateFrom = "yyyy.MM.dd";
            string TenderFrom = startDate.ToString(formatDateFrom);
            // Tender date to
            DateTime endDate = TenderDateTo.SelectedDate;
            string formatDateTo = "yyyy.MM.dd";
            string TenderTo = endDate.ToString(formatDateTo);
            // Tender Category
            string TenderCategory = TenderCategory_inputId.Value;
            // Tender ContractorId
            string TenderSupplierId = Contractor_inputId.SelectedItem.Value;
            // Waybill Number
            string var1 = Convert.ToString(DateTime.Now.ToString().Replace(":", ""));
            string var2 = Convert.ToString(var1.ToString().Replace("/", ""));
            string waybillDateNow = Convert.ToString(var2.ToString().Replace(" ", ""));

            if (string.IsNullOrEmpty(TenderNum) || string.IsNullOrEmpty(TenderCategory) || string.IsNullOrEmpty(TenderSupplierId))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "class", "Chk_Textboxes();", true);
                Response.Write("<script type='text/javascript'>alert('გთხოვთ შეავსეთ ყველა ცარიელი უჯრა')</script>");
            }
            else
            {
                // Tender TotalPrice
                if (GridView2.Rows.Count > 0)
                {
                    string Sumtotalprice = ((TextBox)GridView2.FooterRow.FindControl("txt_SumOfWaybill") as TextBox).Text;
                    Convert.ToDouble(Sumtotalprice.ToString());

                    con.Open();
                    string str = "INSERT INTO tenders (tender_num,contractor_id,tender_date,tender_ends,tender_price,tender_category) OUTPUT INSERTED.ID VALUES (N'" + TenderNum + "','" + TenderSupplierId + "','" + TenderFrom + "','" + TenderTo + "','" + Sumtotalprice + "',N'" + TenderCategory + "')";
                    SqlCommand strCmd = new SqlCommand(str, con);
                    //Inserted Tenders' Id
                    Int32 newId = (Int32)strCmd.ExecuteScalar();

                   
                    if (newId == 0 || string.IsNullOrEmpty(newId.ToString()))
                    {
                        Response.Write("<script type='text/javascript'>alert('ტენდერის ბაზაში დამატება ვერ მოხერხდა')</script>");
                    }
                    con.Close();

                    //Positive Transaction Type
                    int transaction_type = 1;
                    Convert.ToInt32(transaction_type.ToString());           

                    con.Open();
                    string str2 = "insert into tenders_waybills (user_id, tender_id, waybill_date, contractor_id, waybill_number) OUTPUT INSERTED.ID Values ('" + AuthUsers.strSessionValue.ToString() + "', '" + newId + "', '" + TenderFrom + "', '" + TenderSupplierId + "', '" + waybillDateNow + "')";
                    SqlCommand strCmd2 = new SqlCommand(str2, con);
                    //Inserted Waybills' Id
                    Int32 newId2 = (Int32)strCmd2.ExecuteScalar();


                    if (newId2 == 0 || string.IsNullOrEmpty(newId2.ToString()))
                    {
                        Response.Write("<script type='text/javascript'>alert('ზედნადების ბაზაში დამატება ვერ მოხერხდა, გთხოვთ შეავსოთ ყველა საჭირო მონაცემები')</script>");
                    }                    
                    con.Close();

                    foreach (GridViewRow GR in GridView2.Rows)
                    {
                        if (GR.RowType == DataControlRowType.DataRow)
                        {
                            // You can also find grid view inside controls here
                            HiddenField goods_id = (HiddenField)GR.FindControl("HiddenField_GoodId");
                            Label goods_unit = (Label)GR.FindControl("lbl_ItemUnit");
                            Label goods_qty = (Label)GR.FindControl("lbl_ItemQty");
                            Label goods_price = (Label)GR.FindControl("lbl_ItemPrice");
                            
                            int g_id = Convert.ToInt32(goods_id.Value.ToString());
                            string g_unit = Convert.ToString(goods_unit.Text.ToString());
                            string g_qty = Convert.ToString(goods_qty.Text.ToString().Replace(",", "."));
                            string g_price = Convert.ToString(goods_price.Text.ToString().Replace(",", "."));
                            
                            con.Open();
                            string str3 = "insert into tenders_items (waybill_id, goods_id, unit_name, quantity, price) Values ('" + newId2 + "', '" + g_id + "', N'" + g_unit + "', '" + g_qty + "', '" + g_price + "')";
                            SqlCommand strCmd3 = new SqlCommand(str3, con);
                            strCmd3.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
                else Response.Write("<script type='text/javascript'>alert('ბაზაში დამატება ვერ მოხერხდა, გთხოვთ შეავსოთ ფასების ცხრილი')</script>");
            }
        }

        protected void AddWaybilldata_ForTender()
        {
            string WaybillNum = WaybillNumber_inputID.Value;   // waybill number
            DateTime wbstartdate = WaybillDate_inputID.SelectedDate;
            string formatWBdate = "yyyy.MM.dd";
            string WaybillDate = wbstartdate.ToString(formatWBdate); // waybill date
            string WaybillType = WaybillType_inputID.SelectedItem.Value; // transaction type
            string Pay_MethodType = Pay_Method_InputId.SelectedItem.Value;  // Cash - OR Bank Transfer
            string TenderId = TenderId_inputId.SelectedItem.Value;  // tender Id
            string WaybillBuyerId = BuyerId_inputId.SelectedItem.Value; // client Id
            string txtpay_value = txt_paid.Text;
            string Paid_Value = Convert.ToString(txtpay_value.ToString().Replace(",", ".")); // Amount of paid Money
            if (string.IsNullOrEmpty(WaybillNum))
            {
                Response.Write("<script type='text/javascript'>alert('გთხოვთ მიუთითეთ ზედნადების ნომერი')</script>");
                Chk_waybill.Checked = false;
            }
            else if (string.IsNullOrEmpty(WaybillType))
            {
                Response.Write("<script type='text/javascript'>alert('გთხოვთ აირჩიეთ ოპერაციის ტიპი')</script>");
            }
            else if (string.IsNullOrEmpty(TenderId))
            {
                Response.Write("<script type='text/javascript'>alert('გთხოვთ აირჩიეთ ტენდერი')</script>");
            }
            else if (string.IsNullOrEmpty(WaybillBuyerId))
            {
                Response.Write("<script type='text/javascript'>alert('გთხოვთ აირჩიეთ კლიენტი')</script>");
            }
            else
            {
                // Tender's WayBill TotalPrice
                if (GridView2.Rows.Count > 0)
                {
                    string Sumtotalprice = ((TextBox)GridView2.FooterRow.FindControl("txt_SumOfWaybill") as TextBox).Text;
                    Convert.ToDouble(Sumtotalprice.ToString());

                    con.Open();
                    string str = "INSERT INTO tenders_waybills (user_id,tender_id,waybill_date,expense_type,expense_way,contractor_id,waybill_number,cost,paid) OUTPUT INSERTED.ID VALUES ('" + AuthUsers.strSessionValue.ToString() + "','" + TenderId + "','" + WaybillDate + "','" + WaybillType + "','" + Pay_MethodType + "','" + WaybillBuyerId + "',N'" + WaybillNum + "','" + Sumtotalprice + "', '" + Paid_Value + "')";
                    SqlCommand strCmd = new SqlCommand(str, con);
                    //Inserted TenderId
                    Int32 newId2 = (Int32)strCmd.ExecuteScalar();
                    if (string.IsNullOrEmpty(newId2.ToString()))
                    {
                        Response.Write("<script type='text/javascript'>alert('ტენდერის ბაზაში დამატება ვერ მოხერხდა')</script>");
                    }
                    con.Close();

                    
                    //SqlDataReader dr = strCmd.ExecuteReader();
                    //Inserted TenderId
                    //int LastInsertedId = dr.GetInt32(0);
                    //dr.Read();
                    //if (!dr.HasRows)
                    //{
                    //    Response.Write("<script type='text/javascript'>alert('ტენდერის ბაზაში დამატება ვერ მოხერხდა')</script>");
                    //}
                    // Response.Write("<script type='text/javascript'>alert('" + LastInsertedId + "')</script>");
                    //dr.Close();


                    foreach (GridViewRow GR in GridView2.Rows)
                    {
                        if (GR.RowType == DataControlRowType.DataRow)
                        {
                            // You can also find grid view inside controls here
                            HiddenField goods_id = (HiddenField)GR.FindControl("HiddenField_GoodId");
                            Label goods_unit = (Label)GR.FindControl("lbl_ItemUnit");
                            Label goods_qty = (Label)GR.FindControl("lbl_ItemQty");
                            Label goods_price = (Label)GR.FindControl("lbl_ItemPrice");


                            int g_id = Convert.ToInt32(goods_id.Value.ToString());
                            string g_unit = Convert.ToString(goods_unit.Text.ToString());
                            string g_qty = Convert.ToString(goods_qty.Text.ToString().Replace(",", "."));
                            string g_price = Convert.ToString(goods_price.Text.ToString().Replace(",", "."));


                            con.Open();
                            string str3 = "insert into tenders_items (waybill_id, goods_id, unit_name, quantity, price) Values ('" + newId2 + "', '" + g_id + "', N'" + g_unit + "', '" + g_qty + "', '" + g_price + "')";
                            SqlCommand strCmd3 = new SqlCommand(str3, con);
                            strCmd3.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                    Response.Redirect("nwaybills.aspx");
                }
                else Response.Write("<script type='text/javascript'>alert('ბაზაში დამატება ვერ მოხერხდა, ვინაიდან ფასების ცხრილი ცარიელია')</script>");
            }
        }

        protected void AddWaybilldata_ForShop()
        {
            string WaybillNum = WaybillNumber_inputID.Value;   // waybill number
            DateTime wbstartdate = WaybillDate_inputID.SelectedDate;
            string formatWBdate = "yyyy.MM.dd";
            string WaybillDate = wbstartdate.ToString(formatWBdate); // waybill date
            string WaybillType = WaybillType_inputID.SelectedItem.Value; // transaction type
            string Pay_MethodType = Pay_Method_InputId.SelectedItem.Value;  // Cash - OR Bank Transfer
            string WaybillBuyerId = BuyerId_inputId.SelectedItem.Value; // client Id
            string txtpay_value = txt_paid.Text;
            string Paid_Value = Convert.ToString(txtpay_value.ToString().Replace(",", ".")); // Amount of paid Money
            if (string.IsNullOrEmpty(WaybillNum))
            {
                Response.Write("<script type='text/javascript'>alert('გთხოვთ მიუთითეთ ზედნადების ნომერი')</script>");
            }
            else if (string.IsNullOrEmpty(WaybillType))
            {
                Response.Write("<script type='text/javascript'>alert('გთხოვთ აირჩიეთ ოპერაციის ტიპი')</script>");
            }
            else if (string.IsNullOrEmpty(WaybillBuyerId))
            {
                Response.Write("<script type='text/javascript'>alert('გთხოვთ აირჩიეთ კლიენტი')</script>");
            }
            else
            {
                // WayBill TotalPrice
                if (GridView2.Rows.Count > 0)
                {
                    string Sumtotalprice = ((TextBox)GridView2.FooterRow.FindControl("txt_SumOfWaybill") as TextBox).Text;
                    Convert.ToDouble(Sumtotalprice.ToString());

                    con.Open();
                    string str = "INSERT INTO tenders_waybills (user_id,waybill_date,expense_type,expense_way,contractor_id,waybill_number,cost,paid) OUTPUT INSERTED.ID VALUES ('" + AuthUsers.strSessionValue.ToString() + "','" + WaybillDate + "','" + WaybillType + "','" + Pay_MethodType + "','" + WaybillBuyerId + "', N'" + WaybillNum + "','" + Sumtotalprice + "', '" + Paid_Value + "')";
                    SqlCommand strCmd = new SqlCommand(str, con);

                    //Inserted TenderId
                    Int32 newId = (Int32)strCmd.ExecuteScalar();

                    
                    if (string.IsNullOrEmpty(newId.ToString()))
                    {
                        Response.Write("<script type='text/javascript'>alert('ტენდერის ბაზაში დამატება ვერ მოხერხდა')</script>");
                    }                  
                    con.Close();


                    foreach (GridViewRow GR in GridView2.Rows)
                    {
                        if (GR.RowType == DataControlRowType.DataRow)
                        {
                            // You can also find grid view inside controls here
                            HiddenField goods_id = (HiddenField)GR.FindControl("HiddenField_GoodId");
                            Label goods_unit = (Label)GR.FindControl("lbl_ItemUnit");
                            Label goods_qty = (Label)GR.FindControl("lbl_ItemQty");
                            Label goods_price = (Label)GR.FindControl("lbl_ItemPrice");


                            int g_id = Convert.ToInt32(goods_id.Value.ToString());
                            string g_unit = Convert.ToString(goods_unit.Text.ToString());
                            string g_qty = Convert.ToString(goods_qty.Text.ToString().Replace(",", "."));
                            string g_price = Convert.ToString(goods_price.Text.ToString().Replace(",", "."));


                            con.Open();
                            string str3 = "insert into tenders_items (waybill_id, goods_id, unit_name, quantity, price) Values ('" + newId + "', '" + g_id + "', N'" + g_unit + "', '" + g_qty + "', '" + g_price + "')";
                            SqlCommand strCmd3 = new SqlCommand(str3, con);
                            int count_ins = strCmd3.ExecuteNonQuery();

                        }
                        con.Close();
                    }
                    Response.Redirect("nwaybills.aspx");
                }
                else Response.Write("<script type='text/javascript'>alert('ბაზაში დამატება ვერ მოხერხდა, გთხოვთ შეავსოთ ფასების ცხრილი')</script>");
            }
        }

        protected void SetInitialRow()
        {
            TextBox get_GoodsId = GridView2.HeaderRow.Cells[1].FindControl("good_Id_txt") as TextBox;
            TextBox get_GoodsCode = GridView2.HeaderRow.Cells[1].FindControl("good_bar_code_input") as TextBox;
            TextBox get_GoodsName = GridView2.HeaderRow.Cells[1].FindControl("good_name_input") as TextBox;
            HtmlInputText get_GoodsUnit = GridView2.HeaderRow.Cells[1].FindControl("good_unit_selectedValueId") as HtmlInputText;
            TextBox get_GoodsQTY = GridView2.HeaderRow.Cells[1].FindControl("good_quantity_input") as TextBox; 
            TextBox get_GoodsMaxPrice = GridView2.HeaderRow.Cells[1].FindControl("good_unitPrice_input") as TextBox;
            TextBox get_GoodsTotalPrice = GridView2.HeaderRow.Cells[1].FindControl("good_totalPrice_input") as TextBox;
            
            if (string.IsNullOrEmpty(get_GoodsId.Text))
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა "+ "პროდუქციის ID" + " ცარიელია!!!!')</script>");
            }
            else if (string.IsNullOrEmpty(get_GoodsCode.Text))
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა "+ "პროდუქციის კოდი"+"  ცარიელია!!!')</script>");
            }

            else if (string.IsNullOrEmpty(get_GoodsName.Text))
            // good_unit_selectedValueId.Items[good_unit_selectedValueId.SelectedIndex].Text
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "პროდუქციის სახელწოდება" + "  ცარიელია!!!')</script>");
            }

            else if (string.IsNullOrEmpty(get_GoodsUnit.Value))            
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "ზომის ერთეული" + "  ცარიელია!!!')</script>");
            }

            else if (string.IsNullOrEmpty(get_GoodsQTY.Text))
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "რაოდენობა" + "  ცარიელია!!!')</script>");
            }

            else if (string.IsNullOrEmpty(get_GoodsMaxPrice.Text))            
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "ერთეულის ფასი" + "  ცარიელია!!!')</script>");
            }

            else
            {

                DataTable dt = new DataTable();
                DataRow dr = null;

                dt.Columns.Add(new DataColumn("GridNum", typeof(string)));
                dt.Columns.Add(new DataColumn("GoodId", typeof(string)));
                dt.Columns.Add(new DataColumn("ItemCode", typeof(string)));
                dt.Columns.Add(new DataColumn("ItemName", typeof(string)));
                dt.Columns.Add(new DataColumn("ItemUnit", typeof(string)));
                dt.Columns.Add(new DataColumn("ItemQty", typeof(string)));
                dt.Columns.Add(new DataColumn("ItemPrice", typeof(string)));
                dt.Columns.Add(new DataColumn("ItemTotalPrice", typeof(string)));
                dr = dt.NewRow();

                dr["GridNum"] = 1;
                dr["GoodId"] = get_GoodsId.Text.ToString();
                dr["ItemCode"] = get_GoodsCode.Text.ToString();
                dr["ItemName"] = get_GoodsName.Text.ToString();
                dr["ItemUnit"] = get_GoodsUnit.Value.ToString();
                dr["ItemQty"] = get_GoodsQTY.Text.ToString();
                dr["ItemPrice"] = get_GoodsMaxPrice.Text.ToString();
                dr["ItemTotalPrice"] = get_GoodsTotalPrice.Text.ToString();
                dt.Rows.Add(dr);

                //Store the DataTable in ViewState
                Session["OldTable"] = dt;

                GridView2.DataSource = dt;
                GridView2.DataBind();               
               
            }
        }

        protected void NewRowToGrid()
        {
            TextBox get_GoodsId = GridView2.HeaderRow.Cells[1].FindControl("good_Id_txt") as TextBox;
            TextBox get_GoodsCode = GridView2.HeaderRow.Cells[1].FindControl("good_bar_code_input") as TextBox;
            TextBox get_GoodsName = GridView2.HeaderRow.Cells[1].FindControl("good_name_input") as TextBox;
            HtmlInputText get_GoodsUnit = GridView2.HeaderRow.Cells[1].FindControl("good_unit_selectedValueId") as HtmlInputText;
            TextBox get_GoodsQTY = GridView2.HeaderRow.Cells[1].FindControl("good_quantity_input") as TextBox;
            TextBox get_GoodsMaxPrice = GridView2.HeaderRow.Cells[1].FindControl("good_unitPrice_input") as TextBox;
            TextBox get_GoodsTotalPrice = GridView2.HeaderRow.Cells[1].FindControl("good_totalPrice_input") as TextBox;

            if (string.IsNullOrEmpty(get_GoodsId.Text))
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "პროდუქციის ID" + " ცარიელია!!!!')</script>");
            }
            else if (string.IsNullOrEmpty(get_GoodsCode.Text))
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "პროდუქციის კოდი" + "  ცარიელია!!!')</script>");
            }

            else if (string.IsNullOrEmpty(get_GoodsName.Text))
            // good_unit_selectedValueId.Items[good_unit_selectedValueId.SelectedIndex].Text
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "პროდუქციის სახელწოდება" + "  ცარიელია!!!')</script>");
            }

            else if (string.IsNullOrEmpty(get_GoodsUnit.Value))
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "ზომის ერთეული" + "  ცარიელია!!!')</script>");
            }

            else if (string.IsNullOrEmpty(get_GoodsMaxPrice.Text))
            {
                Response.Write("<script type='text/javascript'>alert('უჯრა " + "ერთეულის ფასი" + "  ცარიელია!!!')</script>");
            }

            else
            {
                DataTable New_dt = (DataTable)Session["OldTable"];
                DataRow dr;
                if (New_dt.Rows.Count > 0)
                {
                    int rCount = Convert.ToInt32(New_dt.Rows.Count);
                    dr = New_dt.NewRow();
                    dr[0] = rCount + 1;
                    dr[1] = get_GoodsId.Text;
                    dr[2] = get_GoodsCode.Text;
                    dr[3] = get_GoodsName.Text;
                    dr[4] = get_GoodsUnit.Value;
                    dr[5] = get_GoodsQTY.Text;
                    dr[6] = get_GoodsMaxPrice.Text;
                    dr[7] = get_GoodsTotalPrice.Text;

                    New_dt.Rows.Add(dr);

                    GridView2.DataSource = New_dt;
                    GridView2.DataBind();
                }
            }
        }

        protected void AddGoodToFooterRow()
        {

            TextBox get_GoodsIdTxT = GridView2.HeaderRow.Cells[1].FindControl("good_Id_txt") as TextBox;
            TextBox get_GoodsCode = GridView2.HeaderRow.Cells[1].FindControl("good_bar_code_input") as TextBox;
            TextBox get_GoodsName = GridView2.HeaderRow.Cells[1].FindControl("good_name_input") as TextBox;
            TextBox get_GoodsMaxPrice = GridView2.HeaderRow.Cells[1].FindControl("good_unitPrice_input") as TextBox;
            HtmlInputText get_GoodsUnit = GridView2.HeaderRow.Cells[1].FindControl("good_unit_selectedValueId") as HtmlInputText;

            SqlDataAdapter da = new SqlDataAdapter(@"select * 
                                                        from
                                                     (select Id, name, product_code, unit_name
                                                        from goods
                                                        where product_code = '" + get_GoodsCode.Text + "' OR suppliers_code = N'" + get_GoodsCode.Text + "' OR name = N'" + get_GoodsCode.Text + "') T1 INNER JOIN (SELECT MAX(price) AS MaxPrice, goods_id FROM tenders_items GROUP BY goods_id) T2 ON T2.goods_id = T1.Id ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    get_GoodsIdTxT.Text = dt.Rows[0]["Id"].ToString();
                    get_GoodsCode.Text = dt.Rows[0]["product_code"].ToString();
                    get_GoodsName.Text = dt.Rows[0]["name"].ToString();
                    get_GoodsMaxPrice.Text = dt.Rows[0]["MaxPrice"].ToString();
                    get_GoodsUnit.Value  = dt.Rows[0]["unit_name"].ToString();
                }
            }
            else
            {
                
                get_GoodsCode.Text = "";
                get_GoodsName.Text = "";
                get_GoodsMaxPrice.Text = "";
                get_GoodsUnit.Value = "";
            }
        }
            
        protected void AddRow_Command_Click(object sender, EventArgs e)
        {
            if (GridView2.Rows.Count == 0)
            {
                SetInitialRow();                
            }

            else if (GridView2.Rows.Count > 0)
            {
                NewRowToGrid();                
            }
        }

        protected void check_box_status()
        {

            if (Confirm_Chk_waybill_Value.Value == "true")
            {
                HiddenFieldValueStatus.Waybill_CheckBox = "true";
            }
            else
            {
                HiddenFieldValueStatus.Waybill_CheckBox = "false";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // 
            if (Chk_tender.Checked == true)
            {
                AddTenderdata_ToDB();
            }
            else if (Chk_waybill.Checked && chk_ShowTender.Checked)
            {
                AddWaybilldata_ForTender();
            }
            else if (chk_ShowTender.Checked == false && Chk_waybill.Checked)
            {
                AddWaybilldata_ForShop();
                if (string.IsNullOrEmpty(WaybillNumber_inputID.Value) || string.IsNullOrEmpty(WaybillType_inputID.SelectedValue))
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "class", "Chk_Textboxes();", true);
                }
            }
            else Response.Write("<script type='text/javascript'>alert('გთხოვთ აირჩიეთ რისი დამატება გსურთ')</script>");
        }

        public static string ddl_val;
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

            cmd.Parameters.AddWithValue("@myParameter", "%" + prefixText + "%");
            if (HiddenFieldValueStatus.Waybill_CheckBox == "true")
            {
                cmd.CommandText = @"select * from
                              (select id as wb_id, tender_id  from tenders_waybills where expense_type IS NULL) T1
                              INNER JOIN
                              (select waybill_id, goods_id, price from tenders_items) T2
                              ON T2.waybill_id = t1.wb_id
                              inner join
                              (select Id, name, unit_name, product_code, suppliers_code, comment from goods) T3
                              ON T3.Id = T2.goods_id WHERE tender_id = '" + ddl_val + "' AND  (name LIKE @myParameter OR product_code LIKE @myParameter OR suppliers_code LIKE @myParameter OR comment LIKE @myParameter) ";

            }
            else
            {
                cmd.CommandText = @"select *
                                    from
                                    (select Id, name, product_code,unit_name, suppliers_code, comment
                                    from goods
                                    where name LIKE @myParameter OR product_code LIKE @myParameter OR suppliers_code LIKE @myParameter OR comment LIKE @myParameter) T1

                                    INNER JOIN
                                    (SELECT MAX(price) AS MaxBalance, goods_id FROM tenders_items GROUP BY goods_id) T2
                                    ON T2.goods_id = T1.Id";
            }


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
            String prod_comment;


            foreach (DataRow row in dt.Rows)
            {

                prod_name = row["name"].ToString();
                prod_code = row["product_code"].ToString();
                prod_comment = row["comment"].ToString();

                txtItems.Add(prod_name);
                txtItems.Add(prod_code);
                txtItems.Add(prod_comment);


            }

            return txtItems.ToArray();
        }

        protected void good_name_inputId_TextChanged(object sender, EventArgs e)
        {

            AddGoodToFooterRow();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect(ddl_val + ".aspx");

        }

        public int exp;
        protected void btntoExcel_Click(object sender, EventArgs e)
        {
            MyNewTest();

            foreach (GridViewRow GR in GridView2.Rows)
            {
                if (GR.RowType == DataControlRowType.DataRow)
                {
                    // You can also find grid view inside controls here

                    TextBox goods_name = (TextBox)GR.FindControl("lbl_ItemName");
                    TextBox goods_code = (TextBox)GR.FindControl("lbl_ItemCode");
                    TextBox goods_qty = (TextBox)GR.FindControl("lbl_ItemQty");
                    TextBox goods_price = (TextBox)GR.FindControl("lbl_ItemPrice");



                    string g_name = Convert.ToString(goods_name.Text.ToString());
                    string g_code = Convert.ToString(goods_code.Text.ToString());
                    string g_qty = Convert.ToString(goods_qty.Text.ToString().Replace(",", "."));
                    string g_price = Convert.ToString(goods_price.Text.ToString().Replace(",", "."));



                    using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\\Expoted_Files\\gridview.xls;Extended Properties='Excel 12.0;HDR=Yes'"))
                    {
                        conn.Open();
                        OleDbCommand cmd = new OleDbCommand("INSERT INTO [Sheet1$] ([name], [code], [qty], [price]) values ('" + g_name + "', '" + g_code + "', '" + g_qty + "', '" + g_price + "')", conn);
                        exp = cmd.ExecuteNonQuery();

                    }
                }
            }
            if (exp > 0)
            {
                Response.Write("<script type='text/javascript'>alert('Excel-ის ფაილის ექსპორტი განხორციელდა წარმატებით C: დისკზე, დირექტორიაში Expoted_Files')</script>");
            }
        }

        void To_Excel()
        {
            StringBuilder builder = new StringBuilder();
            string strFileName = "GridviewExcel_" + DateTime.Now.ToShortDateString() + ".csv";
            builder.Append("Name ,Education,Location" + Environment.NewLine);
            foreach (GridViewRow row in GridView2.Rows)
            {
                string name = row.Cells[0].Text;
                string education = row.Cells[1].Text;
                string location = row.Cells[2].Text;
                builder.Append(name + "," + education + "," + location + Environment.NewLine);
            }
            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + strFileName);
            Response.Write(builder.ToString());
            Response.End();
        }

        void MyTest()
        {
            string path = @"C:\\Expoted_Files\\";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            File.Delete(path + "GridView.xls"); // DELETE THE FILE BEFORE CREATING A NEW ONE.
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StreamWriter writer = File.AppendText(path + "GridView.xls");
                    writer.WriteLine("[name] ,[Education], [Location]" + Environment.NewLine);
                    // GridView2.RenderControl(hw);
                    writer.WriteLine(sw.ToString());
                    writer.Close();
                }
            }
        }

        void MyNewTest()
        {
            string path = @"C:\Expoted_Files\";
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            if (File.Exists(path + "gridview.xls"))
            {
                File.Delete(path + "gridview.xls"); // DELETE THE FILE BEFORE CREATING A NEW ONE.
            }

            // ADD A WORKBOOK USING THE EXCEL APPLICATION.
            Excel.Application xlAppToExport = new Excel.Application();
            xlAppToExport.Workbooks.Add("");

            // ADD A WORKSHEET.
            Excel.Worksheet xlWorkSheetToExport = default(Excel.Worksheet);
            xlWorkSheetToExport = (Excel.Worksheet)xlAppToExport.Sheets["Sheet1"];

            // ROW ID FROM WHERE THE DATA STARTS SHOWING.
            int iRowCnt = 4;

            // SHOW THE HEADER.
            //  xlWorkSheetToExport.Cells[1, 1] = "Employee Details";

            Excel.Range range = xlWorkSheetToExport.Cells[1, 1] as Excel.Range;
            range.EntireRow.Font.Name = "Calibri";
            range.EntireRow.Font.Bold = true;
            range.EntireRow.Font.Size = 20;

            //     xlWorkSheetToExport.Range["A1:D1"].MergeCells = true;       // MERGE CELLS OF THE HEADER.

            // SHOW COLUMNS ON THE TOP.
            xlWorkSheetToExport.Cells[iRowCnt - 3, 1] = "name";
            xlWorkSheetToExport.Cells[iRowCnt - 3, 2] = "code";
            xlWorkSheetToExport.Cells[iRowCnt - 3, 3] = "qty";
            xlWorkSheetToExport.Cells[iRowCnt - 3, 4] = "price";


            // FINALLY, FORMAT THE EXCEL SHEET USING EXCEL'S AUTOFORMAT FUNCTION.
            Excel.Range range1 = xlAppToExport.ActiveCell.Worksheet.Cells[4, 1] as Excel.Range;


            // SAVE THE FILE IN A FOLDER.
            xlWorkSheetToExport.SaveAs(path + "gridview.xls");

            // CLEAR.
            xlAppToExport.Workbooks.Close();
            xlAppToExport.Quit();
            xlAppToExport = null;
            xlWorkSheetToExport = null;

        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void GetSelectedRecords(object sender, EventArgs e)
        {
            if (GridView2.Rows.Count == 0)
            {
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[8] { new DataColumn("GridNum"), new DataColumn("GoodId"), new DataColumn("ItemCode"), new DataColumn("ItemName"), new DataColumn("ItemUnit"), new DataColumn("ItemQty"), new DataColumn("ItemPrice"), new DataColumn("ItemTotalPrice") });

                int count = 0;

                foreach (GridViewRow row in Grd1.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                        if (chkRow.Checked)
                        {
                            count++;
                            string Grd_Nm = count.ToString();

                            string G_Id = row.Cells[1].Text;
                            string name = (row.Cells[3].FindControl("lbl_ItemName") as Label).Text;
                            string Item_Code = (row.Cells[2].FindControl("txt_ItemCode") as Label).Text;
                            string Unit_Name = (row.Cells[4].FindControl("lbl_UnitName") as Label).Text;
                            string Item_Price = (row.Cells[6].FindControl("txt_ItemPrice") as TextBox).Text;
                            string Item_Qty = (row.Cells[6].FindControl("txt_ItemQty") as TextBox).Text;
                            double sum = Convert.ToDouble(Item_Price) * Convert.ToDouble(Item_Qty);

                            // double sum = Convert.ToDouble(price) * qty;
                            dt.Rows.Add(Grd_Nm, G_Id, Item_Code, name, Unit_Name, Item_Qty, Item_Price, sum);
                            //Response.Write("<script type='text/javascript'>alert('" + Item_Code + " - " + Unit_Name + "')</script>");
                            //Store the DataTable in ViewState
                            Session["OldTable"] = dt;
                        }
                    }
                }
                GridView2.DataSource = dt;
                GridView2.DataBind();
            }

            else if (GridView2.Rows.Count > 0)
            {
                foreach (GridViewRow row in Grd1.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                        if (chkRow.Checked)
                        {
                            DataTable N_DT = (DataTable)Session["OldTable"];
                            DataRow n_dr;
                            if (N_DT.Rows.Count > 0)
                            {
                                int TotNRowsNum = Convert.ToInt32(N_DT.Rows.Count.ToString());
                                int totnum = TotNRowsNum + 1;
                                string G_Id = row.Cells[1].Text;
                                string name = (row.Cells[3].FindControl("lbl_ItemName") as Label).Text;
                                string Item_Code = (row.Cells[2].FindControl("txt_ItemCode") as Label).Text;
                                string Unit_Name = (row.Cells[4].FindControl("lbl_UnitName") as Label).Text;
                                string Item_Price = (row.Cells[6].FindControl("txt_ItemPrice") as TextBox).Text;
                                string Item_Qty = (row.Cells[6].FindControl("txt_ItemQty") as TextBox).Text;
                                double sum = Convert.ToDouble(Item_Price) * Convert.ToDouble(Item_Qty);


                                // Response.Write("<script type='text/javascript'>alert('"+ Grd_Nm + " gridN "+ totnum.ToString() + "')</script>");

                                n_dr = N_DT.NewRow();
                                n_dr[0] = totnum;
                                n_dr[1] = G_Id;
                                n_dr[2] = Item_Code;
                                n_dr[3] = name;
                                n_dr[4] = Unit_Name;
                                n_dr[5] = Item_Qty;
                                n_dr[6] = Item_Price;
                                n_dr[7] = sum;
                                N_DT.Rows.Add(n_dr);
                            }

                            GridView2.DataSource = N_DT;
                            GridView2.DataBind();
                            //Store the DataTable in ViewState
                            Session["OldTable"] = N_DT;
                        }
                    }
                }
            }
        }

        protected void chk_AllRows_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox ChkBoxHeader = (CheckBox)Grd1.HeaderRow.FindControl("chk_AllRows");
            foreach (GridViewRow row in Grd1.Rows)
            {
                CheckBox ChkBoxRows = (CheckBox)row.FindControl("chkRow");
                if (ChkBoxHeader.Checked == true)
                {
                    ChkBoxRows.Checked = true;
                    ModalPopup_Grid.Show();
                }
                else
                {
                    ChkBoxRows.Checked = false;
                    ModalPopup_Grid.Show();
                }
            }
        }

        public string query;
        void Grd1p_load()
        {
            if (string.IsNullOrEmpty(filtr_name.Text) && string.IsNullOrEmpty(filtr_code.Text) && string.IsNullOrEmpty(filter_brand.Text))
            {
                query = string.Empty;
            }

            else if (!string.IsNullOrEmpty(filtr_name.Text) && string.IsNullOrEmpty(filtr_code.Text) && string.IsNullOrEmpty(filter_brand.Text))
            {
                query = "where name like N'%" + filtr_name.Text + "%'";
            }

            else if (string.IsNullOrEmpty(filtr_name.Text) && !string.IsNullOrEmpty(filtr_code.Text) && string.IsNullOrEmpty(filter_brand.Text))
            {
                query = "where product_code like N'%" + filtr_code.Text + "%'";
            }

            else if (string.IsNullOrEmpty(filtr_name.Text) && string.IsNullOrEmpty(filtr_code.Text) && !string.IsNullOrEmpty(filter_brand.Text))
            {
                query = "where comment like N'%" + filter_brand.Text + "%'";
            }

            else if (!string.IsNullOrEmpty(filtr_name.Text) && string.IsNullOrEmpty(filtr_code.Text) && !string.IsNullOrEmpty(filter_brand.Text))
            {
                query = "where name like N'%" + filtr_name.Text + "%' AND comment like N'%" + filter_brand.Text + "%'";
            }

            else if (!string.IsNullOrEmpty(filtr_name.Text) && !string.IsNullOrEmpty(filtr_code.Text) && string.IsNullOrEmpty(filter_brand.Text))
            {
                query = "where name like N'%" + filtr_name.Text + "%' AND product_code like N'%" + filtr_code.Text + "%' ";
            }

            SqlDataAdapter da = new SqlDataAdapter(@"select * from goods " + query + " ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            Grd1.DataSource = dt;
            Grd1.DataBind();
        }

        protected void filtr_name_TextChanged(object sender, EventArgs e)
        {
            Grd1p_load();
            ModalPopup_Grid.Show();
        }

        protected void filtr_code_TextChanged(object sender, EventArgs e)
        {
            Grd1p_load();
            ModalPopup_Grid.Show();
        }

        protected void filter_brand_TextChanged(object sender, EventArgs e)
        {
            Grd1p_load();
            ModalPopup_Grid.Show();
        }

        protected void SaveWaybill_Click(object sender, ImageClickEventArgs e)
        {
            foreach (GridViewRow GR in GridView2.Rows)
            {
                if (GR.RowType == DataControlRowType.DataRow)
                {
                    // You can also find grid view inside controls here
                    HiddenField goods_id = (HiddenField)GR.FindControl("HiddenField_GoodId");
                    Label goods_unit = (Label)GR.FindControl("lbl_ItemUnit");
                    Label goods_qty = (Label)GR.FindControl("lbl_ItemQty");
                    Label goods_price = (Label)GR.FindControl("lbl_ItemPrice");

                    int g_id = Convert.ToInt32(goods_id.Value.TrimStart());
                    string g_unit = Convert.ToString(goods_unit.Text.ToString());
                    string g_qty = Convert.ToString(goods_qty.Text.ToString().Replace(",", "."));
                    string g_price = Convert.ToString(goods_price.Text.ToString().Replace(",", "."));

                    Response.Write("<script type='text/javascript'>alert('"+ g_id + "')</script>");
                }                
            }
        }

        double WaybillsTotalAmount = 0;
        //decimal SumofItems = 0;
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
            {
                Label txt_goodsfullamount = (Label)e.Row.FindControl("lbl_ItemTotalPrice");

                WaybillsTotalAmount += Convert.ToDouble(txt_goodsfullamount.Text);

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                TextBox txt_TotalPriceInFooter = (TextBox)e.Row.FindControl("txt_SumOfWaybill");

                txt_TotalPriceInFooter.Text = WaybillsTotalAmount.ToString();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Grd1.DataSource = null;
            Grd1.DataBind();
        }
    }
}