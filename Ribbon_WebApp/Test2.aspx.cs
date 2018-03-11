using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Google.API.Translate;

namespace Ribbon_WebApp
{
    public partial class Test2 : System.Web.UI.Page
    {
        string ConTecdoc = "Dsn=TecDoc2016;database=TECDOC_CD_2_2016;server=localhost;uid=tecdoc; providerName='System.Data.Odbc'";

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.Cookies["Wb_Id"] != null)
            {
                Response.Write(Request.Cookies["Wb_Id"].Value);
            }

           // S_Grid();
        }

        public void FirstLetterReplace()
        {
            string str = TextBox4.Text;
            string other_nums = string.Empty;

            if (TextBox4.Text != null)
            {
                for (int i = 1; i < str.Length; i++)
                {
                    if (Char.IsDigit(str[i]))
                        other_nums += str[i];

                    var f_num = str[0].ToString();
                    var first_num = Convert.ToString(f_num.Replace("8", "5"));
                    Label1.Text = first_num + other_nums;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            show_tenders();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // ShowGrid();
            S_Grid();
        }

        protected void ShowGrid()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from
                                                (select Id, name, comment from goods) T1
                                                INNER JOIN
                                                (select waybill_id, goods_id, quantity, price from tenders_items) T2

                                                ON (T1.Id = T2.goods_id)
                                                INNER JOIN 
                                                (select id, tender_id from tenders_waybills) T3
                                                ON(T3.id = T2.waybill_id)
                                                where tender_id = '1085' order by comment, goods_id", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);
            GridView1.DataSource = sdt;
            GridView1.DataBind();

        }

        private void show_tenders()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select * 
                                                        INTO #t1
                                                        from
                                                        (select waybill_id, SUM(quantity*price) AS Total, tr_type from tenders_items
                                                        group by waybill_id, tr_type) T1
                                                        INNER JOIN
                                                        (select id AS WbId, tender_id AS Tid, cost from tenders_waybills) T2
                                                        ON(T1.waybill_id = T2.WbId AND cost IS NOT NULL)
                                                        where T1.tr_type = '-1';

                                                        select * from
                                                        (select Tid, SUM(cost) AS jami from #t1 group by tId) TB1
                                                        INNER JOIN
                                                        (select tenders.id, tenders.tender_num, tenders.contractor_id, tenders.tender_date, tenders.tender_ends, tenders.tender_category, suppliers.id AS SupId, name from tenders, suppliers) TB2
                                                        ON(TB2.id = TB1.Tid AND TB2.contractor_id = TB2.SupId)", con);
            DataTable sdt = new DataTable();
            sda.Fill(sdt);
            if (sdt.Rows.Count > 0)
            {
                GridView1.DataSource = sdt;
                GridView1.DataBind();
            }
            else if (sdt.Rows.Count <= 0)
            {
                SqlDataAdapter da = new SqlDataAdapter(@"select * from
                                                        (select id as t_id, tender_num, contractor_id, tender_date, tender_ends, tender_price, REPLACE(tender_price, tender_price, '0') AS cost, tender_category  from tenders) T1
                                                        INNER JOIN
                                                        (SELECT id as Sup_id, name as Sup_name  FROM suppliers) T2
                                                        ON (T2.Sup_id = T1.contractor_id)", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();

                //Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა!') </SCRIPT>");
            }

        }

        private void S_Grid()
        {
            SqlDataAdapter nda = new SqlDataAdapter(@"select *
                                                    into #tmp1 
                                                    from
                                                    (select waybill_id, goods_id, quantity, tr_type  from tenders_items) T1
                                                    inner join
                                                    (select id as wb_id, cost from tenders_waybills) T2
                                                    ON(T2.wb_id = T1.waybill_id AND cost is not null)
                                                    inner join
                                                    (select id as Gid, product_code from goods) T3
                                                    ON(T3.Gid = T1.goods_id)
                                                    order by product_code;

                                                    select goods_id, (quantity*tr_type) as narcheni, product_code 
                                                    into #tmp2
                                                    from #tmp1
                                                    order by product_code;

                                                    select product_code, sum(narcheni) nashti
                                                    from #tmp2
                                                    group by product_code", con);
            DataTable ndt = new DataTable();
            nda.Fill(ndt);
            for (int i = 0; i < ndt.Rows.Count; i++)
            {
                string p_c = ndt.Rows[i]["product_code"].ToString();
                string p_b = ndt.Rows[i]["nashti"].ToString();

                string tmp_Table = @"

                                    CREATE TABLE #Employee 
                                    ( 
                                        product_code NVARCHAR(MAX) NULL, 
	                                    nashti NVARCHAR(MAX) NULL
                                    )
                                   
                                                                        
                                    INSERT INTO #Employee(product_code, nashti)  VALUES ('" + p_c + "', '" + p_b + "') ";

                con.Open();

                //Execute the command to make a temp table
                SqlCommand cmd = new SqlCommand(tmp_Table, con);
                cmd.ExecuteNonQuery();
                SqlDataAdapter nda01 = new SqlDataAdapter("select * from #Employee", con);
                DataTable ndt01 = new DataTable();
                nda01.Fill(ndt01);
                GridView1.DataSource = ndt01;
                GridView1.DataBind();
                con.Close();
            }
        }

        protected void Replace_ImgBtn_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton Btn_AdvEdit = (ImageButton)sender;
            GridViewRow GrdRow = (GridViewRow)Btn_AdvEdit.NamingContainer;

            var nId = GrdRow.Cells[0].Text;

            Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა! " + nId + "') </SCRIPT>");


        }


        protected void Button3_Click(object sender, EventArgs e)
        {
            StringBuilder html = new StringBuilder();

            html.Append("<datalist id='browsers' runat='server'>");
            html.Append("<option value='Internet Explorer'>");
            html.Append("<option value='Firefox'>");
            html.Append("<option value='Chrome'>");
            html.Append("</datalist>");
            // Label2.Text = html.ToString();

            Response.Write(" " + html.ToString() + " ");
        }

        protected void Button31_Click(object sender, EventArgs e)
        {
            string txx = sup_list.Value;
            Response.Write("<SCRIPT language='JavaScript'>  alert('" + txx + "') </SCRIPT>");
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {
            string strSrch = TextBox2.Text;
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
                                                        WHERE TOF_DESIGNATIONS.DES_LNG_ID = 16 AND (TOF_ART_LOOKUP.ARL_KIND = '1' ) AND TOF_ART_LOOKUP.ARL_ART_ID = 177531", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();

            // Response.Write("<SCRIPT language='JavaScript'>  alert('"+ TextBox2.Text +"') </SCRIPT>");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string strSrch = TextBox1.Text;
            string strRepl = RemoveElementsFrom.RmvSomeElements(strSrch);

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
                                                          TOF_ARTICLES.ART_ID = 4325174 AND 
                                                          TOF_CRITERIA.CRI_TYPE IN ('A','B','D','N') AND 
                                                          TOF_DESIGNATIONS.DES_LNG_ID = 16", connection);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();



        }

        protected void imj_Click(object sender, ImageClickEventArgs e)
        {
            string strSrch = txt_ProductCode.Value;
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
                txt_Brand_Manufacturer.Value = Brand_Name.ToString();
                txt_Category.Value = Category_Name;
            }

        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlDataAdapter nda01 = new SqlDataAdapter("select Id, name, product_code, suppliers_code, comment  from goods order by name, comment  DESC", con);
            DataTable ndt01 = new DataTable();
            nda01.Fill(ndt01);
            GridView2.DataSource = ndt01;
            GridView2.DataBind();
            con.Close();
        }


        protected void btn_upd_Click(object sender, EventArgs e)
        {
            Button updt_btn = (Button)sender;
            GridViewRow gvr = (GridViewRow)updt_btn.NamingContainer;
            string updateID = gvr.Cells[0].Text;
            TextBox updatePrCode = (TextBox)gvr.FindControl("txt_ItCode");
            TextBox updateSupCode = (TextBox)gvr.FindControl("txt_SupCode");

            // Response.Write("<SCRIPT language='JavaScript'>  alert('"+updatePrCode.Text+" - "+updateSupCode.Text+"') </SCRIPT>");

            con.Open();
            SqlCommand cmd = new SqlCommand(@"UPDATE goods  SET product_code = '" + updatePrCode.Text + "', suppliers_code = '" + updateSupCode.Text + "'  WHERE Id = '" + updateID + "' ", con);
            cmd.ExecuteNonQuery();
            con.Close();


        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            e.Cell.BackColor = System.Drawing.Color.Aqua;

            con.Open();
            SqlDataAdapter da = new SqlDataAdapter("select waybill_date from tenders_waybills", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DateTime Book_Date = Convert.ToDateTime(dt.Rows[i]["waybill_date"].ToString());

                
                int yyyy = Convert.ToInt32(Book_Date.Year);
                int dd = Convert.ToInt32(Book_Date.Day);
                int MM = Convert.ToInt32(Book_Date.Month);

                if (e.Day.Date == new DateTime(yyyy, MM, dd))
                {
                    e.Cell.BackColor = System.Drawing.Color.Red;
                    e.Cell.Font.Strikeout = true;
                }
                if (e.Day.IsToday)
                {
                   // e.Cell.BackColor = System.Drawing.Color.Pink;
                    e.Cell.Font.Italic = true;
                    e.Cell.Font.Size = FontUnit.XLarge;
                    
                }

            }

            con.Close();

        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            //Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა! "+MyDropDown.Ddl_Id.ToString()+"') </SCRIPT>");
        }
    }
}
