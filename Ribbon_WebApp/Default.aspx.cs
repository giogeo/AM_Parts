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
using System.Text;
using ClassLibrary1;
using System.Web.Services;
using System.Data.Odbc;
using Google.API.Translate;

namespace Ribbon_WebApp
{
    public partial class Default : System.Web.UI.Page
    {
        string ConTecdoc = "Dsn=TECDOC_CD_2_2016;database=TECDOC_CD_2_2016;server=localhost;uid=tecdoc; providerName='System.Data.Odbc'";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        private void qq()
        {
            SqlDataSource3.SelectCommand = @"select * from
                                                    (
                                                    select * from
                                                    (select contractor_id, sum(tender_price) AS t_price from tenders where id in (select tender_id from tenders_waybills where expense_type is null AND user_id = '"+ AuthUsers.strSessionValue.ToString() + @"')
                                                    group by contractor_id) T1
                                                    INNER JOIN
                                                    (select id, name from suppliers) T2
                                                    ON(T1.contractor_id = T2.id)
                                                    ) T001

                                                    INNER JOIN
                                                    (
                                                    select contractor_id as ctr_id, sum(jami) AS Sul
                                                    from 
                                                    (select * from tenders_waybills where tender_id is not null and expense_type = '-1') T1
                                                    INNER JOIN
                                                    (select waybill_id, sum(quantity * price) AS jami from tenders_items
                                                    group by waybill_id) T2
                                                    ON(T2.waybill_id = T1.id)
                                                    where user_id = '" + AuthUsers.strSessionValue.ToString() + @"'
                                                    group by contractor_id
                                                    ) T002
                                                    ON(T002.ctr_id = T001.contractor_id)";
        }


        protected void countANDsum_query()
        {
            qq();
            SqlDataAdapter _daSumCount = new SqlDataAdapter(@"SELECT *
                                                            into #t111
                                                            FROM
                                                            (SELECT id AS tit_id, waybill_id, goods_id, (quantity*price) as Tot FROM tenders_items ) T1

                                                            INNER JOIN
                                                            (SELECT id AS wb_id, tender_id, user_id, contractor_id, cost from tenders_waybills) T2
                                                            ON (T1.waybill_id = T2.wb_id)
                                                            where  cost is not null AND tender_id is not null AND user_id = "+ AuthUsers.strSessionValue.ToString() +" ;  select sum(Tot) as sul, contractor_id into #t222  from #t111  group by contractor_id;     SELECT  (select COUNT(id) from tenders where id in(select tender_id from tenders_waybills where user_id = "+ AuthUsers.strSessionValue.ToString() + " and expense_type IS NULL)) AS count_tenders,  (select COUNT(id) from tenders_waybills where user_id = "+ AuthUsers.strSessionValue.ToString() + " and expense_type IS NOT NULL AND expense_way IS NOT NULL) AS count_waybills,     (select sum(tender_price) from tenders where id in(select tender_id from tenders_waybills where user_id = "+ AuthUsers.strSessionValue.ToString() + " and expense_type IS NULL)) AS sum_tenders,   (select sum(sul) from #t222) as sum_supply", con);
            DataTable _dtSumCount = new DataTable();
            _daSumCount.Fill(_dtSumCount);

            if (_dtSumCount.Rows.Count > 0)
            {
                ListView5.DataSourceID = "SqlDataSource3";
                
            }
            else ListView5.DataSourceID = "";

            for (int i = 0; i < _dtSumCount.Rows.Count; i++)
            {
                double remain = 0;
                string cuntTenders = _dtSumCount.Rows[0][0].ToString();
                string countWaybills = _dtSumCount.Rows[0][1].ToString();
                string sumTenders = String.Format("{0:0.00}", _dtSumCount.Rows[0][2]);
                string sumSupply = String.Format("{0:0.00}", _dtSumCount.Rows[0][3]);
                if (string.IsNullOrEmpty(sumTenders))
                {
                    sumTenders = "0";
                }
                if (string.IsNullOrEmpty(sumSupply))
                {
                    sumSupply = "0";
                }
                double rval1 = Convert.ToDouble(sumTenders);
                double rval2 = Convert.ToDouble(sumSupply);
                remain = rval1 - rval2;
                string nashti = String.Format("{0:0.00}", remain);

                Lnkbtn_SumOfTenders.Text = sumTenders + " ლარის";
                Lnkbtn_SumOfSupply.Text = sumSupply + " ლარის";
                Lnkbtn_CountTenders.Text = cuntTenders + " ტენდერი";
                Lnkbtn_RemOfSupply.Text = nashti.ToString() + " ლარის";

            }
        }     

        protected void Page_Load(object sender, EventArgs e)
        {
            //  build_supps();
            if (AuthUsers.strSessionValue != null)
            {
                countANDsum_query();                
            }
                
            sort_TenderList();
            ImageButton btn_AddNewGood = (ImageButton)this.Master.FindControl("ImgBtn_AddNewGood");
            btn_AddNewGood.Click += Btn_AddNewGood_Click;
            

            if (!IsPostBack)
            {                
                if (Request.QueryString.Count == 0)
                {
                    MainPanel.Visible = true;                    
                }
            }

            string txt1 = unit.Text;
            if (!string.IsNullOrEmpty(txt1))
            {
                string name = Class1.To_Unicode(txt1);
                unit.Text = name;
            }

            string act = Request["action"];            
            string tid = Request["TenderID"];
            string jobid = Request["job"];
            string job = Request["do"];
            string wbid = Request["Id"];
            string editid = Request["E_ID"];
            string deleteid = Request["D_ID"];
            string TendersItems = Request["T_Items"];

            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(jobid) && act == "goods" && jobid == "addnewgood")
            {
                Div_Insert.Visible = true;
            }
            else
            {
                Div_Insert.Visible = false;
            }

            if (!string.IsNullOrEmpty(act) && act == "goods")
            {
                Div_Products.Visible = true;                
            }
            else
            {
                Div_Products.Visible = false;
            }

            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(jobid) && act == "rem")
            {
                txt_tid.Text = jobid;

                SqlDataTendersItemsLeft.SelectCommand = @"select * 
                                                            into #tmp01
                                                            from
                                                            (select id as wbId, tender_id, ISNULL(expense_type, 1) AS expense_type from tenders_waybills where tender_id is not null) T1
                                                            INNER JOIN
                                                            (select quantity, waybill_id, goods_id from tenders_items) T2
                                                            ON (T2.waybill_id = T1.wbId)

                                                            INNER JOIN
                                                            (select Id as gId, name from goods) T3
                                                            on (t3.gId = T2.goods_id)
                                                            where tender_id = '"+ txt_tid.Text + "'; select * from (select goods_id, sum(expense_type * quantity) as remained from #tmp01 group by goods_id) T4 INNER JOIN (select Id, name from goods) T5 ON(T5.Id = T4.goods_id);";
            }
            else Procurements_ItemsLeft.Visible = false;

            if (!string.IsNullOrEmpty(act) && !string.IsNullOrEmpty(jobid) && act == "T_Items")
            {
                txt_tid.Text = jobid;
                ControlParameter CPText2 = new ControlParameter();
                CPText2.ControlID = "txt_tid";
                CPText2.Name = "tender_id";
                CPText2.PropertyName = "Text";

                SqlDataTendersItems.FilterParameters.Add(CPText2);
                SqlDataTendersItems.FilterExpression = "tender_id = '{0}'";
                Procurements_Items.Visible = true;
            }
            else Procurements_Items.Visible = false;

            if (!string.IsNullOrEmpty(act) && act == "tenders")
            {
                procurement_list.Visible = true;
                show_tenders();
            }
            else procurement_list.Visible = false;

            if (!string.IsNullOrEmpty(tid))
            {
                txt_wbid.Text = tid;
                ControlParameter cpText = new ControlParameter();
                cpText.ControlID = "txt_wbid";
                cpText.Name = "tender_id";
                cpText.PropertyName = "Text";

                SqlDataTendersWaybillsList.FilterParameters.Add(cpText);
                SqlDataTendersWaybillsList.FilterExpression = "tender_id = '{0}'";
                Procurements_Waybills.Visible = true;
            }
            else Procurements_Waybills.Visible = false;
        }

        private void Btn_AddNewGood_Click(object sender, ImageClickEventArgs e)
        {
            edt_mod_popupextender.Show();
            btn_update_save.Visible = false;
            btn_add_new_good.Visible = true;
        }

        //Show tenders In Listview
        private void show_tenders()
        {
            string sortby = Request["sort"];
            if (!string.IsNullOrEmpty(sortby) && sortby == "dateup")
            {
                sortby = "ORDER BY tender_date DESC";
                myCheck1.Checked = true;
            }
            if (!string.IsNullOrEmpty(sortby) && sortby == "priceup")
            {
                sortby = "ORDER BY tender_price DESC";
                myCheck2.Checked = true;
            }

            if (!string.IsNullOrEmpty(sortby) && sortby == "suppliers")
            {
                sortby = "ORDER BY contractor_id, tender_date DESC";
                myCheck3.Checked = true;
            }

            SqlDataAdapter sda = new SqlDataAdapter(@"select 
														tenders_waybills.tender_id, tenders_waybills.user_id,
                                                        tenders.id AS t_id, tenders.tender_num, tenders.contractor_id,
                                                        tenders.tender_date, tenders.tender_ends, tenders.tender_price, 
                                                        tenders.tender_category, 
                                                        suppliers.id AS SupId, name AS Sup_name 
                                                      from 
                                                        tenders, suppliers, tenders_waybills
                                                      where 
                                                        tenders.contractor_id = suppliers.id AND
														tenders_waybills.tender_id = tenders.id AND tenders_waybills.user_id = "+ AuthUsers.strSessionValue.ToString() + " AND tenders_waybills.expense_type IS NULL " + sortby + " ", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);
            if (sdt.Rows.Count > 0)
            {
                ListView01.DataSource = sdt;
                ListView01.DataBind();
            }
            else if (sdt.Rows.Count <= 0)
            {
                SqlDataAdapter da = new SqlDataAdapter(@"select * from
                                                        (select id as t_id, tender_num, contractor_id, tender_date, tender_ends, tender_price, REPLACE(tender_price, tender_price, '') AS cost, tender_category  from tenders) T1
                                                        INNER JOIN
                                                        (SELECT id as Sup_id, name as Sup_name  FROM suppliers) T2
                                                        ON (T2.Sup_id = T1.contractor_id)
														INNER JOIN
														(select tender_id, user_id, expense_type from tenders_waybills) T3
														ON(T3.tender_id = T1.t_id AND T3.user_id = " + AuthUsers.strSessionValue.ToString() + " AND T3.expense_type IS NULL) " + sortby + " ", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ListView01.DataSource = dt;
                ListView01.DataBind();

                //Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა!') </SCRIPT>");
            }
        }
        
        // Add Goods To Database
        protected void add_to_db(object sender, EventArgs e)
        {
            con.Open();

            string str = "INSERT INTO goods (name,unit_name,product_code,price) VALUES (N'" + name.Text + "',N'" + unit.Text + "','" + code.Text + "','" + price.Text + "')";
            SqlCommand strCmd = new SqlCommand(str, con);
            strCmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("default.aspx");
        }

        public string tnd_id;
        protected void ListView01_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            string sortby = Request["sort"];
            string act = Request["action"];
            CheckBox chk1 = (CheckBox)Master.FindControl("CheckBox4");
            if (string.IsNullOrEmpty(act) && act != "tenders")
            {
                chk1.Visible = false;
            }

            if (e.Item is ListViewDataItem)
            {
                var btndel = e.Item.FindControl("del_box") as ImageButton;
                if (!string.IsNullOrEmpty(act) && act == "tenders" && chk1.Checked == true)
                {
                    btndel.Visible = true;
                    order_row.Visible = false;                    
                }

                else 
                {
                    btndel.Visible = false;
                    order_row.Visible = true;
                }                
            }

            
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {

                // Lbl_Sold_To.Font.Bold = true;
                // Lbl_remained.Text = Lbl_tenders_id.Text;
                // Display the e-mail address in italics.
                HtmlAnchor A_Sold_to = (HtmlAnchor)e.Item.FindControl("a_sold_to");
                Label Lbl_Sold_To = (Label)e.Item.FindControl("l_sold_to");
                Label Lbl_remained = (Label)e.Item.FindControl("l_remained");
                Label Lbl_tenders_id = (Label)e.Item.FindControl("l_tender_id");
                Label Lbl_tenders_price = (Label)e.Item.FindControl("l_tender_price");

                if (string.IsNullOrEmpty(Lbl_Sold_To.Text))
                {
                    Lbl_Sold_To.Text = "0.00";                    
                }


                SqlDataAdapter sda = new SqlDataAdapter(@"select * 
                                                            into #tmp1
                                                          from 
                                                            tenders_waybills
                                                          where 
                                                            tender_id IS NOT NULL AND expense_type = '-1' AND tender_id = '"+ Lbl_tenders_id.Text + "'; select tender_id, SUM(expense_type * cost) AS total from #tmp1 group by tender_id; ", con);
                DataTable dt1 = new DataTable();
                sda.Fill(dt1);

                for (int i = 0; i < dt1.Rows.Count; i++)
                {
                    tnd_id = dt1.Rows[i]["tender_id"].ToString();
                    string supplied = dt1.Rows[i]["total"].ToString();

                    Lbl_Sold_To.Text = Convert.ToDouble(supplied).ToString("0.00");
                    // Lbl_remained.Text = 
                }

                double a, b;

                double.TryParse(Lbl_tenders_price.Text, out a);
                double.TryParse(Lbl_Sold_To.Text, out b);

                if(b == 0)
                {
                    A_Sold_to.HRef = "#";
                }
                else
                {
                    A_Sold_to.Attributes.Add("href", "?TenderID=" + Lbl_tenders_id.Text + "");
                }

                Lbl_remained.Text = (a + b).ToString("0.00");

            }
        }

        protected void Show_Command(object sender, ImageClickEventArgs e)
        {
            string waybill_id = Request["Id"];
            if (!string.IsNullOrEmpty(waybill_id))
            {
                string rr = Convert.ToString(waybill_id);

                SqlDataAdapter sda = new SqlDataAdapter("select tenders_items.*, goods.Id, goods.name from tenders_items, goods where goods.Id = tenders_items.goods_id AND waybill_id = '" + rr + "'", con);
                DataTable sdt = new DataTable();
                sda.Fill(sdt);

                int ins_tdID = Convert.ToInt32(sdt.Rows[0]["tender_id"].ToString());
                int ins_wbID = Convert.ToInt32(sdt.Rows[0]["waybill_id"].ToString());
                int ins_goodID = Convert.ToInt32(sdt.Rows[0]["goods_id"].ToString());
                int ins_trTYPE = Convert.ToInt32(sdt.Rows[0]["tr_type"].ToString());
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("?action=tenders#procurements");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("?action=tenders#procurements");
        }

        protected void del_box_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton imgbtn = (ImageButton)sender;
            ListViewDataItem clickedItem = (ListViewDataItem)imgbtn.NamingContainer;
            string delID = ((Label)clickedItem.FindControl("lblTenderId")).Text;

            con.Open();
            string strdel1 = "DELETE from tenders WHERE id = '" + delID + "' ";
            string strdel2 = @"DELETE tenders_items
                                FROM   tenders_items T_Itms
                                INNER JOIN tenders_waybills T_Wbs
                                ON T_Wbs.id = T_Itms.waybill_id
                                where tender_id = '" + delID + "' ";
            string strdel3 = "DELETE from tenders_waybills WHERE tender_id = '" + delID + "' ";
            SqlCommand strCmd1 = new SqlCommand(strdel1, con);
            SqlCommand strCmd2 = new SqlCommand(strdel2, con);
            SqlCommand strCmd3 = new SqlCommand(strdel3, con);
            int DTenders = strCmd1.ExecuteNonQuery();
            int DTendersItems = strCmd2.ExecuteNonQuery();
            int DTendersWaybills = strCmd3.ExecuteNonQuery();

            if (DTenders != 0 && DTendersItems != 0 && DTendersWaybills != 0)
            {
                Response.Write("<SCRIPT language='JavaScript'>  alert('წაშლა შესრულდა წარმატებით!') </SCRIPT>");
                Response.Redirect("?action=tenders#procurements");
                //Response.Redirect(delID + ".aspx");
                //Response.Redirect(Request.RawUrl);
                con.Close();
            }

            else
            {
                Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა, წაშლა ვერ შესრულდა !!!') </SCRIPT>");
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton LinkbtnID = (LinkButton)sender;
            ListViewDataItem clickedItem = (ListViewDataItem)LinkbtnID.NamingContainer;
            string WayBill_ID = ((Label)clickedItem.FindControl("lblWayId")).Text;
            string Tenders_ID = ((Label)clickedItem.FindControl("lblTenderId")).Text;

            if (Request.Browser.Cookies) // To check that the browser support cookies
            {
                HttpCookie cookie = new HttpCookie("Wb_Id");
                cookie.Value = WayBill_ID;
                cookie.Expires = DateTime.Now.AddSeconds(2);
                Response.Cookies.Add(cookie);

                HttpCookie cookie0 = new HttpCookie("Td_Id");
                cookie0.Value = Tenders_ID;
                cookie0.Expires = DateTime.Now.AddSeconds(2);
                Response.Cookies.Add(cookie0);

                Response.Redirect("waybills.aspx");
            }
        }

        protected void Lnkbtn_CountOfSupply_Click(object sender, EventArgs e)
        {
            Response.Redirect("waybills.aspx");
        }

        double totl = 0;

        protected void ListOfWaybills_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Label lblUP = e.Item.FindControl("lblTotl") as Label;

                totl += Convert.ToDouble(lblUP.Text);
            }
        }

        protected void ListOfWaybills_PreRender(object sender, EventArgs e)
        {
            Label lblTot = this.ListOfWaybills.FindControl("lblTotal") as Label;
            lblTot.Text = totl.ToString();
        }
        
        protected void sort_TenderList()
        {

            if (myCheck1.Checked == true)
            {
                Response.Redirect("default.aspx?action=tenders&sort=dateup");                
            }


            if (myCheck2.Checked == true)
            {
                Response.Redirect("default.aspx?action=tenders&sort=priceup");
            }

            if (myCheck3.Checked == true)
            {
                Response.Redirect("default.aspx?action=tenders&sort=suppliers");
            }

        }
        
        protected void ListOf_TendersItems_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Label lblUP2 = e.Item.FindControl("lblTotl2") as Label;

                totl += Convert.ToDouble(lblUP2.Text);
            }
        }

        protected void ListOf_TendersItems_PreRender(object sender, EventArgs e)
        {
            Label lblTot2 = this.ListOf_TendersItems.FindControl("lblTotal2") as Label;
            lblTot2.Text = totl.ToString();
        }

        protected void Advance_ImgBtn_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton ImgBtn_AdvEdit = (ImageButton)sender;
            GridViewRow GrdRow = (GridViewRow)ImgBtn_AdvEdit.NamingContainer;
            lbl_editgoodsId.Text = GrdRow.Cells[0].Text;
            SqlDataAdapter da = new SqlDataAdapter("select * from goods where Id = '" + lbl_editgoodsId.Text + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                txt_editgoodsID.Text = lbl_editgoodsId.Text;           
                txt_editgoodsCode.Text = dt.Rows[0]["product_code"].ToString();
                txt_editsuppliersCode.Text = dt.Rows[0]["suppliers_code"].ToString();                
                txt_editgoodsName.Text = dt.Rows[0]["name"].ToString();
                txt_editgoodsBarCode.Text = dt.Rows[0]["barcode"].ToString();
                txt_editgoodsOEM.Text = dt.Rows[0]["OEM"].ToString();
                txt_editgoodsCategory.Text = dt.Rows[0]["category"].ToString();
                txt_edit_Brand_Manufacturer.Text = dt.Rows[0]["manufacturer"].ToString();
                txt_editgoodsUnit.Text = dt.Rows[0]["unit_name"].ToString();
                txt_editgoodsPrice.Text = Convert.ToDouble(dt.Rows[0]["price"]).ToString();
                txt_editgoodsDescription.Text = dt.Rows[0]["description"].ToString();
               // txt_editgoodsCompatableWith.Text = dt.Rows[0]["comment"].ToString();
            }
            edt_mod_popupextender.Show();
            //d01.Visible = true;
        }

        protected void Replace_ImgBtn_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton ReplaceImgBtn = (ImageButton)sender;
            GridViewRow GrdViewRow = (GridViewRow)ReplaceImgBtn.NamingContainer;

            string strSrch = GrdViewRow.Cells[4].Text;
            string strRepl = RemoveElementsFrom.RmvSomeElements(strSrch);

            OdbcConnection connection = new OdbcConnection(ConTecdoc);
            connection.ConnectionTimeout = 600;
            connection.Open();

            OdbcDataAdapter da = new OdbcDataAdapter(@"SELECT *
                                                        FROM TOF_ART_LOOKUP ARL
                                                        INNER JOIN TOF_ARTICLES ART ON (ART.ART_ID = ARL.ARL_ART_ID)
                                                        LEFT OUTER JOIN TOF_SUPPLIERS SUP ON (SUP.SUP_ID = ART.ART_SUP_ID)
                                                        INNER JOIN TOF_DESIGNATIONS DES ON (DES.DES_ID = ART.ART_COMPLETE_DES_ID)
                                                        INNER JOIN TOF_DES_TEXTS TEX ON (DES.DES_TEX_ID = TEX.TEX_ID)
                                                        WHERE DES.DES_LNG_ID = 16 AND (ARL.ARL_KIND = '4' OR ARL.ARL_KIND = '3') AND ARL.ARL_SEARCH_NUMBER = '" + strRepl.ToUpper() + "'", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GRD_Replacement.DataSource = dt;
            GRD_Replacement.DataBind();
            if (dt.Rows.Count > 0)
            {
                ShowReplacement_popupextender.Show();
            }
            else
            {
                Response.Write("<SCRIPT language='JavaScript'>  alert('შემცვლელის მოძებნა ვერ მოხერხდა !!!') </SCRIPT>");
            }
        }

        protected void lbl_TEX_TEXT_Click(object sender, EventArgs e)
        {
            LinkButton Btn_Preview = (LinkButton)sender;
            GridViewRow GrdRow = (GridViewRow)Btn_Preview.NamingContainer;
            var ID_link = GrdRow.Cells[0].Text.ToString();

            OdbcConnection connection = new OdbcConnection(ConTecdoc);
            connection.ConnectionTimeout = 600;
            connection.Open();

            OdbcDataAdapter da = new OdbcDataAdapter(@"SELECT 
                                                        TOF_TYPES.TYP_ID,    
                                                        TOF_DES_TEXTS.TEX_TEXT AS TEX_TEXT,
                                                        TOF_TYPES.TYP_MOD_ID 
                                                        FROM TOF_TYPES  
                                                            INNER JOIN TOF_COUNTRY_DESIGNATIONS ON TOF_COUNTRY_DESIGNATIONS.CDS_ID = TOF_TYPES.TYP_MMT_CDS_ID 
                                                            INNER JOIN TOF_DES_TEXTS ON TOF_COUNTRY_DESIGNATIONS.CDS_TEX_ID = TOF_DES_TEXTS.TEX_ID 
                                                            INNER JOIN tof_LINK_LA_TYP ON tof_LINK_LA_TYP.LAT_TYP_ID = TOF_TYPES.TYP_ID
                                                            INNER JOIN tof_LINK_ART ON tof_LINK_ART.LA_ID = tof_LINK_LA_TYP.LAT_LA_ID AND tof_LINK_ART.LA_ART_ID = " + ID_link + " WHERE TOF_COUNTRY_DESIGNATIONS.CDS_LNG_ID = 16", connection);

            DataTable dt = new DataTable();
            da.Fill(dt);            

            GridView2.DataSource = dt;
            GridView2.DataBind();
            ShowUsedIn_popupextender.Show();
        }

        private void build_supps()
        {
            StringBuilder html = new StringBuilder();
            html.Append("<datalist id='browsers' runat='server'>");
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from suppliers ", con);
            System.Data.SqlClient.SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while(dr.Read())
            {
                string SupName = dr["name"].ToString();
                html.Append("<option value='"+SupName+"'>");
            
            }          
            
            html.Append("</datalist>");
            Response.Write(" " + html.ToString() + " ");
            con.Close();
        }

        protected void btn_add_sup_price_Click(object sender, EventArgs e)
        {
            string goods_Id = txt_id.Text;
            string goods_Price = txt_price.Text.ToString().Replace(",", ".");
            if (!string.IsNullOrEmpty(goods_Price))
            {
                Convert.ToDouble(goods_Price.ToString());
            }
            
            string suppliers_Name = suppliersName.Value;
            if (!string.IsNullOrEmpty(suppliers_Name) && !string.IsNullOrEmpty(goods_Price))
            {
                con.Open();
                string str = "INSERT INTO sellers_price (good_id,seller_price,seller_name) VALUES ('" + goods_Id + "','" + goods_Price + "',N'" + suppliers_Name + "')";
                SqlCommand strCmd = new SqlCommand(str, con);
                int countIns = strCmd.ExecuteNonQuery();
                con.Close();
                if (countIns > 0)
                {
                    Response.Write("<SCRIPT language='JavaScript'>  alert('მომწოდებლის ფასის დამატება განხორციელდა წარმატებით') </SCRIPT>");                    
                }
            }
            else
            {
                Response.Write("<SCRIPT language='JavaScript'>  alert('მომწოდებლის ფასის დამატება ვერ განხორციელდა, თქვენ არ გქონდათ მითითებული ფასი ან/და მომწოდებლის დასახელება') </SCRIPT>");
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='aquamarine';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='white';";
                e.Row.Cells[2].ToolTip = "მომწოდებლების ფასის სანახავად დააწექით ინფო ლოგოს";
                e.Row.Cells[5].ToolTip = "მომწოდებლების ფასის დამატება";
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string Info_Id = GridView1.SelectedRow.Cells[0].Text;

            SqlDataAdapter da = new SqlDataAdapter(@"select * from sellers_price where good_id = '" + Info_Id + "' ", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            Div2.Attributes.Add("style", "display:block;");
            Div3.Attributes.Add("style", "display:block;");
            ListView4.DataSource = dt;
            ListView4.DataBind();
        }

        protected void Img_advanced_srch_Click(object sender, ImageClickEventArgs e)
        {
           ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:show_adv_search();", true);
           SqlDataSource1.FilterParameters.Clear();


           if (!string.IsNullOrEmpty(txt_ItemName.Text) && !string.IsNullOrEmpty(txt_CompatableWith.Text) && string.IsNullOrEmpty(txt_ProductPrice.Text))
           {
               ControlParameter cpItemName = new ControlParameter();
               cpItemName.ControlID = "txt_ItemName";
               cpItemName.Name = "waybill_number";
               cpItemName.PropertyName = "Text";

               ControlParameter cpCompatableWith = new ControlParameter();
               cpCompatableWith.ControlID = "txt_CompatableWith";
               cpCompatableWith.Name = "waybill_number";
               cpCompatableWith.PropertyName = "Text";

               SqlDataSource1.FilterParameters.Add(cpItemName);
               SqlDataSource1.FilterParameters.Add(cpCompatableWith);
               SqlDataSource1.FilterExpression = " name LIKE  '%" + txt_ItemName.Text + "%' AND comment LIKE '%" + txt_CompatableWith.Text + "%' ";

           }

           if (!string.IsNullOrEmpty(txt_ItemName.Text) && !string.IsNullOrEmpty(txt_ProductPrice.Text) && string.IsNullOrEmpty(txt_CompatableWith.Text))
           {
               ControlParameter cpItemName = new ControlParameter();
               cpItemName.ControlID = "txt_ItemName";
               cpItemName.Name = "waybill_number";
               cpItemName.PropertyName = "Text";

               ControlParameter cpProductPrice = new ControlParameter();
               cpProductPrice.ControlID = "txt_ProductPrice";
               cpProductPrice.Name = "waybill_number";
               cpProductPrice.PropertyName = "Text";

               SqlDataSource1.FilterParameters.Add(cpItemName);
               SqlDataSource1.FilterParameters.Add(cpProductPrice);
               SqlDataSource1.FilterExpression = " name LIKE  '%" + txt_ItemName.Text + "%' AND price ='" + txt_ProductPrice.Text + "' ";

           }

           if (string.IsNullOrEmpty(txt_ItemName.Text) && !string.IsNullOrEmpty(txt_CompatableWith.Text) && !string.IsNullOrEmpty(txt_ProductPrice.Text))
           {
               ControlParameter cpCompatableWith = new ControlParameter();
               cpCompatableWith.ControlID = "txt_CompatableWith";
               cpCompatableWith.Name = "waybill_number";
               cpCompatableWith.PropertyName = "Text";

               ControlParameter cpProductPrice = new ControlParameter();
               cpProductPrice.ControlID = "txt_ProductPrice";
               cpProductPrice.Name = "waybill_number";
               cpProductPrice.PropertyName = "Text";

               SqlDataSource1.FilterParameters.Add(cpCompatableWith);
               SqlDataSource1.FilterParameters.Add(cpProductPrice);
               SqlDataSource1.FilterExpression = " comment LIKE '%" + txt_CompatableWith.Text + "%' AND price = '" + txt_ProductPrice.Text + "' ";
           }

           if (string.IsNullOrEmpty(txt_ItemName.Text) && string.IsNullOrEmpty(txt_CompatableWith.Text) && !string.IsNullOrEmpty(txt_ProductPrice.Text))
           {
               ControlParameter cpProductPrice = new ControlParameter();
               cpProductPrice.ControlID = "txt_ProductPrice";
               cpProductPrice.Name = "waybill_number";
               cpProductPrice.PropertyName = "Text";

               SqlDataSource1.FilterParameters.Add(cpProductPrice);
               SqlDataSource1.FilterExpression = " price = '" + txt_ProductPrice.Text + "' ";

               GridView1.PageSize = 100;
           }
        }

        protected void lnkSelect_Click(object sender, EventArgs e)
        {
            build_supps();
        }

        protected void Query_InTecdoc_Click(object sender, ImageClickEventArgs e)
        {
            string strSrch = txt_editgoodsCode.Text;
            string strRepl = RemoveElementsFrom.RmvSomeElements(strSrch);




            OdbcConnection connection = new OdbcConnection(ConTecdoc);
            connection.ConnectionTimeout = 600;
            connection.Open();

            OdbcDataAdapter da = new OdbcDataAdapter(@"SELECT TOF_ART_LOOKUP.ARL_SEARCH_NUMBER,
                                                        TOF_ART_LOOKUP.ARL_KIND,
                                                        TOF_ART_LOOKUP.ARL_ART_ID,
                                                        TOF_ART_LOOKUP.ARL_DISPLAY_NR, 
                                                        
                                                        TOF_ARTICLES.ART_SUP_ID,
                                                        TOF_SUPPLIERS.SUP_BRAND,
                                                        TOF_DES_TEXTS.TEX_TEXT AS ART_COMPLETE_DES_TEXT
                                                        FROM TOF_ART_LOOKUP
                                                        LEFT JOIN TOF_BRANDS ON TOF_BRANDS.BRA_ID = TOF_ART_LOOKUP.ARL_BRA_ID
                                                        INNER JOIN TOF_ARTICLES ON TOF_ARTICLES.ART_ID = TOF_ART_LOOKUP.ARL_ART_ID
                                                        INNER JOIN TOF_SUPPLIERS ON TOF_SUPPLIERS.SUP_ID = TOF_ARTICLES.ART_SUP_ID
                                                        INNER JOIN TOF_DESIGNATIONS ON TOF_DESIGNATIONS.DES_ID = TOF_ARTICLES.ART_COMPLETE_DES_ID
                                                        INNER JOIN TOF_DES_TEXTS ON TOF_DES_TEXTS.TEX_ID = TOF_DESIGNATIONS.DES_TEX_ID
                                                        WHERE TOF_DESIGNATIONS.DES_LNG_ID = 16 AND (TOF_ART_LOOKUP.ARL_KIND = '1') AND TOF_ART_LOOKUP.ARL_SEARCH_NUMBER = '" + strRepl.ToUpper() + "'", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string Brand_Name = dt.Rows[i]["SUP_BRAND"].ToString();
                string Category_Name = dt.Rows[i]["ART_COMPLETE_DES_TEXT"].ToString();
                txt_edit_Brand_Manufacturer.Text = Brand_Name.ToString();
                txt_editgoodsCategory.Text = Category_Name;
            }
            edt_mod_popupextender.Show();
        }

        protected void btn_update_save_Click1(object sender, EventArgs e)
        {
            string updID = txt_editgoodsID.Text;
            if (!string.IsNullOrEmpty(updID))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@" UPDATE goods  SET product_code = N'" + txt_editgoodsCode.Text + "',  suppliers_code = N'" + txt_editsuppliersCode.Text + "', name = N'" + txt_editgoodsName.Text + "', barcode = '" + txt_editgoodsBarCode.Text + "', OEM = N'" + txt_editgoodsOEM.Text + "', category = N'" + txt_editgoodsCategory.Text + "', manufacturer = N'" + txt_edit_Brand_Manufacturer.Text + "', unit_name = N'" + txt_editgoodsUnit.Text + "', price = N'" + txt_editgoodsPrice.Text + "', description = N'" + txt_editgoodsDescription.Text + "' WHERE id = '" + updID + "' ", con);
                cmd.ExecuteNonQuery();
                con.Close();
            }            
        }

        protected void lbl_SUP_BRAND_Click(object sender, EventArgs e)
        {
            LinkButton It_dtls = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)It_dtls.NamingContainer;

            var txt_ARL_ART_ID = gvr.Cells[0].Text.ToString();
            LinkButton txt_Brand = (LinkButton)gvr.FindControl("lbl_SUP_BRAND");
            LinkButton txt_Category = (LinkButton)gvr.FindControl("lbl_TEX_TEXT");
            lbl_Category.Text = txt_Category.Text;
            lbl_BrandName.Text = txt_Brand.Text;
            OdbcConnection connection = new OdbcConnection(ConTecdoc);
            connection.ConnectionTimeout = 600;
            connection.Open();

            OdbcDataAdapter da = new OdbcDataAdapter(@"SELECT 
                                                          TOF_ARTICLES.ART_ID,
                                                          TOF_ARTICLES.ART_ARTICLE_NR,
                                                          TOF_DES_TEXTS.TEX_TEXT,
                                                          TOF_ARTICLE_CRITERIA.ACR_VALUE
                                                        FROM
                                                          TOF_ARTICLES
                                                          LEFT OUTER JOIN TOF_ARTICLE_CRITERIA ON (TOF_ARTICLES.ART_ID = TOF_ARTICLE_CRITERIA.ACR_ART_ID)
                                                          INNER JOIN TOF_CRITERIA ON (TOF_ARTICLE_CRITERIA.ACR_CRI_ID = TOF_CRITERIA.CRI_ID)
                                                          INNER JOIN TOF_DESIGNATIONS ON (TOF_CRITERIA.CRI_DES_ID = TOF_DESIGNATIONS.DES_ID)
                                                          INNER JOIN TOF_DES_TEXTS ON (TOF_DESIGNATIONS.DES_TEX_ID = TOF_DES_TEXTS.TEX_ID)
                                                        WHERE
                                                          TOF_ARTICLES.ART_ID = "+ txt_ARL_ART_ID + " AND TOF_CRITERIA.CRI_TYPE IN ('A','B','D','N') AND TOF_DESIGNATIONS.DES_LNG_ID = 16", connection);

            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView3.DataSource = dt;
            GridView3.DataBind();            
            ShowItemDetales_popupextender.Show();
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {


            string Tenders_ID = Request["job"];

            SqlDataAdapter sda = new SqlDataAdapter(@"select * from tenders_waybills where cost is null and paid is null and tender_id = '"+ Tenders_ID +"'", con);
            DataTable dt1 = new DataTable();
            sda.Fill(dt1);

            string Waybills_ID = dt1.Rows[0]["id"].ToString();


            if (Request.Browser.Cookies) // To check that the browser support cookies
            {

                HttpCookie cookie0 = new HttpCookie("Wb_Id");
                cookie0.Value = Waybills_ID;
                cookie0.Expires = DateTime.Now.AddSeconds(2);
                Response.Cookies.Add(cookie0);

                // Response.Write("<SCRIPT language='JavaScript'>  alert('"+Waybills_ID+"') </SCRIPT>");
                Response.Redirect("waybills.aspx");
            }
        }

        protected void btn_add_new_good_Click(object sender, EventArgs e)
        {
            con.Open();

            string str = "INSERT INTO goods (product_code,suppliers_code,barcode,OEM,category,manufacturer,name,unit_name,price,comment) VALUES (N'" + txt_editgoodsCode.Text + "',N'" + txt_editsuppliersCode.Text + "',N'" + txt_editgoodsBarCode.Text + "',N'" + txt_editgoodsOEM.Text + "',N'" + txt_editgoodsCategory.Text + "',N'" + txt_edit_Brand_Manufacturer.Text + "',N'" + txt_editgoodsName.Text + "',N'" + txt_editgoodsUnit.Text + "',N'" + txt_editgoodsPrice.Text + "',N'" + txt_editgoodsDescription.Text + "')";
            SqlCommand strCmd = new SqlCommand(str, con);
            strCmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("default.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Write("<SCRIPT language='JavaScript'>  alert('" + AuthUsers.strSessionValue.ToString() + "') </SCRIPT>" );
        }
    }
}
