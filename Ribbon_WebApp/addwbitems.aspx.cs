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
    public partial class addwbitems : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {            
        }

        protected void CheckDifferentItems()
        {
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT * 
                                                        INTO #tmp 
                                                        FROM (
                                                        select product_code from goods where product_code <> ''
                                                        union
                                                        select suppliers_code from goods where suppliers_code <> ''
                                                        )
                                                        as #tmp;

                                                        select * 
                                                        into #tmp000
                                                        from Grid
                                                        where products_code NOT IN (select product_code from #tmp);

                                                        select products_code 
                                                        from #tmp000
                                                        group by products_code", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView2.DataSource = dt;
            GridView2.DataBind();
            
        }

        protected void ShowWaybillsList()
        {
            SqlDataAdapter da = new SqlDataAdapter(@"select seller, waybills_number, sum(total_price) as wb_cost, waybills_date
                                                        from Grid
                                                        group by seller, waybills_number, waybills_date;", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void Image1_Click(object sender, ImageClickEventArgs e)
        {
            wb_step1.Visible = false;
            wb_step2.Visible = true;
            CheckDifferentItems();
        }

        protected void Image2_Click(object sender, ImageClickEventArgs e)
        {
            wb_step1.Visible = true;
            wb_step2.Visible = false;
            ShowWaybillsList();
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // e.Row.Cells[0].ToolTip = "მომწოდებლების ფასის სანახავად დააწექით ინფო ლოგოს";
                // Label myDataName = e.Row.FindControl("lbl_gds_name") as Label;
                // myDataName.Text = myDataKey.ToString();


                // the underlying data item is a DataRowView object.
                DataRowView rowView = (DataRowView)e.Row.DataItem;

                // Retrieve the key value for the current row. Here it is an int.
                string myDataKey = rowView["products_code"].ToString();                

                e.Row.Cells[0].ToolTip = ""+ myDataKey.ToString() +"";
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='aquamarine';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white';";

                SqlDataAdapter da = new SqlDataAdapter(@"select * from Grid where products_code = '"+ myDataKey.ToString() +"' ", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    e.Row.Cells[1].Text =  dt.Rows[0]["name"].ToString();
                    e.Row.Cells[2].Text = dt.Rows[0]["unit_name"].ToString();
                    e.Row.Cells[3].Text = dt.Rows[0]["unit_price"].ToString();
                }
            }            
        }

        protected void wb_chk_AllRows_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox ChkBoxHeader = (CheckBox)GridView1.HeaderRow.FindControl("wb_chk_AllRows");
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox ChkBoxRows = (CheckBox)row.FindControl("wb_chkRow");
                if (ChkBoxHeader.Checked == true)
                {
                    ChkBoxRows.Checked = true;
                    
                }
                else
                {
                    ChkBoxRows.Checked = false;
                    
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {

                CheckBox wb_chk_all = e.Row.Cells[0].FindControl("wb_chk_AllRows") as CheckBox;
                e.Row.Attributes["onclick"] = "Check_SelectAll(this)";
                e.Row.Attributes.Add("title", "ყველას მონიშვნა");
            }

            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbl_seller = e.Row.Cells[1].FindControl("lbl_wb_seller") as Label;
                Label lbl_sellerID = e.Row.Cells[2].FindControl("lbl_wb_sellerTaxCode") as Label;
                Label lbl_WaybillsNum =  e.Row.Cells[3].FindControl("lbl_wb_num") as Label;
                var getSeller = lbl_seller.Text;
                var result_nums = string.Join("", getSeller.ToCharArray().Where(Char.IsDigit));
                var result_name = getSeller.Replace(result_nums, "").Replace("(", "").Replace(")", "");
                var WB_Num = lbl_WaybillsNum.Text;

                lbl_sellerID.Text = result_nums.ToString();
                lbl_seller.Text = result_name.ToString();

                string strwbNum = string.Empty;
                SqlDataAdapter da = new SqlDataAdapter(@"select waybill_number from tenders_waybills where waybill_number = '"+ WB_Num + "' ", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                for(int i=0; i<dt.Rows.Count; i++)
                {
                    strwbNum = dt.Rows[i]["waybill_number"].ToString();
                }



                if (lbl_WaybillsNum.Text == ""+strwbNum+"")
                {
                    e.Row.Visible = false;
                    //e.Row.BackColor = System.Drawing.Color.AliceBlue;                    
                }
            }

        }

        protected void btn_next_Click(object sender, EventArgs e)
        {
            int gamr = -1;
            string strwbNum = string.Empty;
            string strwbTaxCode = string.Empty;
            string strwbSupName = string.Empty;
            string strwbCost = string.Empty;
            string strwbSupID = string.Empty;            
            string strwbIsSup = string.Empty;
            string strwbDate = string.Empty;
            foreach (GridViewRow gvrow in GridView1.Rows)
            {                

                CheckBox chk = (CheckBox)gvrow.FindControl("wb_chkRow");
                if (chk != null & chk.Checked)
                {                    
                    string wb_num = (gvrow.Cells[3].FindControl("lbl_wb_num") as Label).Text;
                    string wb_sellerTaxCode = (gvrow.Cells[3].FindControl("lbl_wb_sellerTaxCode") as Label).Text;
                    string wb_sellerName = (gvrow.Cells[3].FindControl("lbl_wb_seller") as Label).Text;
                    string wb_cost = (gvrow.Cells[3].FindControl("lbl_wb_cost") as Label).Text;
                    DateTime wb_date = Convert.ToDateTime((gvrow.Cells[3].FindControl("lbl_wb_date") as Label).Text);
                    strwbNum +=  wb_num ;
                    strwbTaxCode = wb_sellerTaxCode;
                    strwbSupName = wb_sellerName;
                    strwbCost = wb_cost;
                    //get date value                    
                    strwbDate = wb_date.ToString("yyyy.MM.dd");
                }
            }
            SqlDataAdapter da0 = new SqlDataAdapter(@"select id, is_supplier, name, taxcode  from suppliers where taxcode = '" + strwbTaxCode + "' ", con);
            DataTable dt0 = new DataTable();
            da0.Fill(dt0);
            for (int i=0; i< dt0.Rows.Count; i++)
            {
                strwbSupID = dt0.Rows[i]["id"].ToString();
                strwbIsSup = dt0.Rows[i]["is_supplier"].ToString();
            }
            
            if (dt0.Rows.Count == 0)
            {
                Response.Write("<script type='text/javascript'>alert('აღნიშნული მომწოდებელი ბაზაში არაა რეგისტრირებული, გთხოვთ დაარეგისტრირეთ მომხმარებელი')</script>");
            }

            else
            {
                SqlDataAdapter da = new SqlDataAdapter(@"select * from
                                                        (select products_code, name, unit_name, qty, unit_price, total_price  from Grid where waybills_number in('"+ strwbNum + "')) T1  INNER JOIN  (select Id AS goods_id, name AS goods_name, product_code AS goods_code, suppliers_code from goods) T2   ON (T1.products_code = T2.goods_code OR T1.products_code = T2.suppliers_code OR (T1.products_code = T2.suppliers_code AND T1.name = t2.goods_name));", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView3.DataSource = dt;
                GridView3.DataBind();
                GridView1.Visible = false;
                GridView3.Visible = true;
                wb_content.Visible = true;                
                
                lbl_slrName.Text = strwbSupName;
                lbl_slrId.Text = strwbSupID;
                lbl_isSupplier.Text = (Convert.ToInt32(strwbIsSup) * Convert.ToInt32(gamr)).ToString();
                lbl_wbCost.Text = strwbCost;
                lbl_wbDate.Text = strwbDate;
                lbl_wbNumber.Text = strwbNum;
                ShowPayTypes();
            }
        }

        protected void btn_InsDiffGoods_Click(object sender, EventArgs e)
        {
            int countIns = 0;
            foreach (GridViewRow gvrow in GridView2.Rows)
            {
                if (gvrow.RowType == DataControlRowType.DataRow)
                {                    
                    string pr_code = gvrow.Cells[0].Text;
                    string pr_name = gvrow.Cells[1].Text;
                    string pr_unit = gvrow.Cells[2].Text;
                    string pr_price = gvrow.Cells[3].Text;

                    con.Open();
                    string str2 = "insert into goods (product_code, name, unit_name, price ) Values (N'" + pr_code + "', N'" + pr_name + "', N'" + pr_unit + "', N'" + pr_price + "')";
                    SqlCommand cmd2 = new SqlCommand(str2, con);
                    countIns = cmd2.ExecuteNonQuery();
                    con.Close();
                    
                }               
            }
            if (countIns > 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:window.history.back(); ", true);
                Response.Write("<script type='text/javascript'>alert('პროდუქტი დამატებულია ბაზაში')</script>");
            }
            else
            {
                Response.Write("<script type='text/javascript'>alert('შეცდომა!!! დამატება ვერ მოხერხდა')</script>");
            }
        }

        protected void ShowPayTypes()
        {
            List<ListItem> items = new List<ListItem>();
            items.Add(new ListItem("ნაღდი (სალაროში)", "1"));
            items.Add(new ListItem("უნაღდო (ბანკში)", "2"));
            ddl_Pay_Method_Id.Items.AddRange(items.ToArray());
        }

        protected void btn_wbInsert_Click(object sender, EventArgs e)
        {            
            if (GridView3.Rows.Count > 0)
            {
                con.Open();
                string str = "INSERT INTO tenders_waybills (user_id,waybill_date,expense_type,expense_way,contractor_id,waybill_number,cost,paid) OUTPUT INSERTED.ID VALUES ('"+ AuthUsers.strSessionValue.ToString() +"', '" + lbl_wbDate.Text + "','" + lbl_isSupplier.Text + "','" + ddl_Pay_Method_Id.SelectedValue + "','" + lbl_slrId.Text + "', N'" + lbl_wbNumber.Text + "','" + lbl_wbCost.Text + "', '" + txt_wbPaid.Text + "')";
                SqlCommand strCmd = new SqlCommand(str, con);
                SqlDataReader dr = strCmd.ExecuteReader();

                dr.Read();
                if (!dr.HasRows)
                {
                    Response.Write("<script type='text/javascript'>alert('ბაზაში დამატება ვერ მოხერხდა')</script>");
                }

                //Inserted Id
                int LastInsertedId = dr.GetInt32(0);
                // Response.Write("<script type='text/javascript'>alert('" + LastInsertedId + "')</script>");
                dr.Close();
                con.Close();

                foreach (GridViewRow GR in GridView3.Rows)
                {
                    if (GR.RowType == DataControlRowType.DataRow)
                    {
                        // You can also find grid view inside controls here
                        string goods_id = GR.Cells[6].Text;
                        string goods_unit = GR.Cells[2].Text;
                        double goods_qty = Convert.ToDouble(GR.Cells[3].Text);
                        double goods_price = Convert.ToDouble(GR.Cells[4].Text);

                        int g_id = Convert.ToInt32(goods_id.ToString());
                        string g_unit = Convert.ToString(goods_unit.ToString());
                        string g_qty = Convert.ToString(goods_qty.ToString().Replace(",", "."));
                        string g_price = Convert.ToString(goods_price.ToString().Replace(",", "."));

                        con.Open();
                        string str3 = "insert into tenders_items (waybill_id, goods_id, unit_name, quantity, price) Values ('" + LastInsertedId + "', '" + g_id + "', N'" + g_unit + "', '" + g_qty + "', '" + g_price + "')";
                        SqlCommand strCmd3 = new SqlCommand(str3, con);
                        int count_ins = strCmd3.ExecuteNonQuery();

                    }
                    con.Close();
                }
                Response.Redirect("addwbitems.aspx");
            }
            else Response.Write("<script type='text/javascript'>alert('ზედნადების ბაზაში დამატება ვერ მოხერხდა, გთხოვთ შეამოწმეთ')</script>");
        }
    }
}