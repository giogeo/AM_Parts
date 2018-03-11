using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class Statements : System.Web.UI.Page
    {
        // string ConTecdoc = "Dsn=TECDOC_CD_2_2016;database=TECDOC_CD_2_2016;server=localhost;uid=tecdoc; providerName='System.Data.Odbc'";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        public string Start_Date;
        public string End_Date;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                srch();
            }

            ImageButton btn_overspends = (ImageButton)this.Master.FindControl("img_overspends");
            btn_overspends.Click += btn_overspends_Click;

            ImageButton btn_img_pays = (ImageButton)this.Master.FindControl("img_pays");
            btn_img_pays.Click += btn_img_pays_Click;

            
            if (!string.IsNullOrEmpty(date_from.Text))
            {
                // Start date
                DateTime startdate = Convert.ToDateTime(date_from.Text);
                string StartDateFormat = "yyyy.MM.dd";
                Start_Date = startdate.ToString(StartDateFormat);

            }

            if (!string.IsNullOrEmpty(date_to.Text))
            {
                // End date
                DateTime enddate = Convert.ToDateTime(date_to.Text);
                string EndDateFormat = "yyyy.MM.dd";
                End_Date = enddate.ToString(EndDateFormat);
            }
                

            if (string.IsNullOrEmpty(date_from.Text) && string.IsNullOrEmpty(date_to.Text))
            {
                datebetween = "between '1900/12/01' and GETDATE() ";

            }

            else if (!string.IsNullOrEmpty(date_from.Text) && !string.IsNullOrEmpty(date_to.Text))
            {
                datebetween = "between '" + Start_Date.ToString() + "' and '" + End_Date.ToString() + "' ";
                balance();
            }

            else if (!string.IsNullOrEmpty(date_from.Text) && string.IsNullOrEmpty(date_to.Text))
            {
                datebetween = "between '" + Start_Date.ToString() + "' and GETDATE() ";
                balance();
            }
        }

        void btn_img_pays_Click(object sender, ImageClickEventArgs e)
        {
            OverFlows.Visible = false;
            GridView1.Visible = true;
            head_for_statments.Visible = true;
        }

        void btn_overspends_Click(object sender, ImageClickEventArgs e)
        {
            balance();
            OverFlows.Visible = true;
            GridView1.Visible = false;
            head_for_statments.Visible = false;
        }

        double dPageTotal_in = 0;
        double dPageTotal_out = 0;
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotalins = (Label)e.Row.FindControl("lbl_Tot_of_Ins");
                Label lblTotalouts = (Label)e.Row.FindControl("lbl_Tot_of_Outs");

                lblTotalins.Text = dPageTotal_in.ToString();
                lblTotalouts.Text = dPageTotal_out.ToString();

                if (Convert.ToDecimal(lblTotalouts.Text) < 0)
                {
                    lblTotalouts.ForeColor = System.Drawing.Color.Red;
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label WaybillPriceOut = (Label)e.Row.FindControl("lbl_Pays_Out");
                Label WaybillPriceIn = (Label)e.Row.FindControl("lbl_Pays_In");
                Label WaybillExpenseWay = (Label)e.Row.FindControl("lbl_expense_way");

                dPageTotal_in += Convert.ToDouble(WaybillPriceIn.Text);
                dPageTotal_out += Convert.ToDouble(WaybillPriceOut.Text);



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

                //  if (Convert.ToDouble(WaybillExpenseWay.Text) == 0)
                //  {
                //      e.Row.Visible = false;
                //      for (int i = 0; i < GridView1.Rows.Count; i++)
                //       {
                //           HtmlTableCell WaybillExpenseType = (HtmlTableCell)GridView1.Rows[i].FindControl("ExpenseWay");
                //           WaybillExpenseType.Visible = false;
                //      }                    
                //  }
            }
        }

        public string OrderBy;
        void srch()
        {

            SqlDataAdapter da = new SqlDataAdapter(@"select * 
                                    into #tmp1
                                    from 
                                    (select id, waybill_number, waybill_date, expense_way, cost, paid, contractor_id from tenders_waybills) T1
                                    inner join
                                    (select id as Cid, name, is_supplier from suppliers) T2
                                    ON(T2.Cid = T1.contractor_id)
                                    where cost is not null AND is_supplier = '1';

                                    select waybill_number, waybill_date, expense_way, paid*is_supplier as shemos,  REPLACE(cost, cost, '0') as gasav, name into #tmp01 from #tmp1;


                                    select * 
                                    into #tmp2
                                    from 
                                    (select id, waybill_number, waybill_date, expense_way, cost, paid, contractor_id from tenders_waybills) T1
                                    inner join
                                    (select id as Cid, name, is_supplier from suppliers) T2
                                    ON(T2.Cid = T1.contractor_id)
                                    where cost is not null AND is_supplier = '-1';

                                    select waybill_number, waybill_date, expense_way, REPLACE(cost, cost, '0') as shemos, paid*is_supplier as gasav, name into #tmp02 from #tmp2;

		                            select * from #tmp01
		                            UNION ALL
		                            select * from #tmp02 where expense_way != 0 " + OrderBy + " ", con);
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


        public string datebetween;
        void balance()
        {    
            

                SqlDataAdapter da = new SqlDataAdapter(@"select product_code, sum(namravli) as nashti from
                                                    (select tenders_waybills.id AS wb_id, tenders_waybills.user_id, tenders_items.goods_id, tenders_items.quantity * tenders_waybills.expense_type as namravli 
                                                    from tenders_items, tenders_waybills
                                                    where tenders_waybills.user_id = '" + AuthUsers.strSessionValue.ToString() + "'  AND tenders_waybills.id = tenders_items.waybill_id AND tenders_waybills.expense_type is not null AND tenders_waybills.waybill_date " + datebetween.ToString() + ") T1  inner join  (select id, product_code from goods) T2 ON(T2.Id = T1.goods_id) group by product_code   order by nashti", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView2.DataSource = dt;
                GridView2.DataBind();
            
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // the underlying data item is a DataRowView object.
                DataRowView rowView = (DataRowView)e.Row.DataItem;

                // Retrieve the key value for the current row. Here it is an int.
                string myDataKey = rowView["product_code"].ToString();
                
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='aquamarine';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white';";

                SqlDataAdapter da = new SqlDataAdapter(@"select * from goods where product_code = '" + myDataKey.ToString() + "' ", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    e.Row.Cells[0].Text = dt.Rows[0]["name"].ToString();
                    e.Row.Cells[1].Text = dt.Rows[0]["comment"].ToString();
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write("<script type='text/javascript'>alert('"+Start_Date+" - "+End_Date+"')</script>");
        }
    }
}