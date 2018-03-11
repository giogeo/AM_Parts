using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class page2 : System.Web.UI.Page
    {
        string ConTecdoc = "Description=TecDoc2016;Dsn=TecDoc2016;Database=TECDOC_CD_2_2016;Server=192.168.0.109;UID=tecdoc;PWD=tcd_error_0;";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
        }


        private void test1()
        {
            string txt1 = TextBox1.Text;
            string strRepl = RemoveElementsFrom.RmvSomeElements(txt1);

            OdbcConnection connection = new OdbcConnection(ConTecdoc);
            OdbcDataAdapter da2 = new OdbcDataAdapter(@"SELECT *
                                                        FROM TOF_ART_LOOKUP ARL
                                                        INNER JOIN TOF_ARTICLES ART ON (ART.ART_ID = ARL.ARL_ART_ID)
                                                        LEFT OUTER JOIN TOF_SUPPLIERS SUP ON (SUP.SUP_ID = ART.ART_SUP_ID)
                                                        INNER JOIN TOF_DESIGNATIONS DES ON (DES.DES_ID = ART.ART_COMPLETE_DES_ID)
                                                        INNER JOIN TOF_DES_TEXTS TEX ON (DES.DES_TEX_ID = TEX.TEX_ID)
                                                        WHERE DES.DES_LNG_ID = 16 AND (ARL.ARL_KIND = '4' OR ARL.ARL_KIND = '3') AND ARL.ARL_SEARCH_NUMBER = '" + strRepl.ToUpper() + "' ", connection);
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);

            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                var StringValue = dt2.Rows[i]["ART_ARTICLE_NR"].ToString();
                var StringText = dt2.Rows[i]["ARL_SEARCH_NUMBER"].ToString();
                var StringBrand = dt2.Rows[i]["SUP_BRAND"].ToString();
                var StringCategory = dt2.Rows[i]["TEX_TEXT"].ToString();

                con.Open();
                string str = @" INSERT INTO tmpTable (name, brand, category) VALUES ('" + StringValue + "', '" + StringBrand + "', N'" + StringCategory + "')";
                SqlCommand cmd = new SqlCommand(str, con);
                int insNum = cmd.ExecuteNonQuery();

                if (insNum == 0)
                {
                    Response.Write("<script type='text/javascript'>alert(' არ დამატებულა!')</script>");
                }

                SqlCommand command = new SqlCommand(@"select * 
                                                        from
                                                        (select Id, name as Gname, price, product_code, description from goods) T1
                                                        INNER JOIN
                                                        (select * from tmpTable) T2
                                                        ON(T2.name = T1.product_code OR T2.name = T1.Gname OR T2.name = T1.description)", con);
                SqlDataReader dr = command.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else if (dt.Rows.Count == 0)
                {
                    SqlCommand command1 = new SqlCommand(@"select brand, name, name AS Gname, category, REPLACE(brand, brand, N'შეკვეთით' ) price from tmpTable order by brand", con);
                    SqlDataReader dtr = command1.ExecuteReader();
                    DataTable dt_t = new DataTable();
                    dt_t.Load(dtr);

                    GridView1.DataSource = dt_t;
                    GridView1.DataBind();
                }


                //  string strdel = "DELETE from tmpTable ";
                //  SqlCommand strCmd1 = new SqlCommand(strdel, con);

                con.Close();


                // Response.Write("<script type='text/javascript'>alert('"+ArtNum+"-"+ArtBrand+"')</script>");               
            }
        }

        protected void test2()
        {
            SqlDataAdapter da2 = new SqlDataAdapter(@"select name, product_code  from goods where Id < '380' ", con);

            DataTable salesData = new DataTable();
            da2.Fill(salesData);

            using (SqlConnection sqlconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["borjomiConnectionString"].ConnectionString))
            {
                sqlconnection.Open();

                // create table if not exists 
                string createTableQuery = @"Create Table SalesHistory 
                (name nvarchar(1000),product_code nvarchar(1000))";
                SqlCommand createCommand = new SqlCommand(createTableQuery, sqlconnection);
                createCommand.ExecuteNonQuery();




                // Copy the DataTable to SQL Server Table using Table-Valued Parameter
                string sqlInsert = "INSERT INTO SalesHistory SELECT * FROM @SalesHistoryData";
                SqlCommand insertCommand = new SqlCommand(sqlInsert, sqlconnection);
                SqlParameter tvp = insertCommand.Parameters.AddWithValue("@SalesHistoryData", salesData);
                tvp.SqlDbType = SqlDbType.Structured;
                tvp.TypeName = "SalesHistoryTableType";
                insertCommand.ExecuteNonQuery();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(TextBox1.Text))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"select * from tmpTable", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                // If tmptable isn't Empty Do .....
                if (dt.Rows.Count > 0)
                {
                    con.Open();
                    using (SqlCommand command = new SqlCommand("DELETE FROM tmpTable", con))
                    {
                        int countDel = command.ExecuteNonQuery();
                        if (countDel > 0)
                        {
                            string txt1 = TextBox1.Text;
                            string strRepl = RemoveElementsFrom.RmvSomeElements(txt1);

                            OdbcConnection connection = new OdbcConnection(ConTecdoc);
                            OdbcDataAdapter da2 = new OdbcDataAdapter(@"SELECT *
                                                                        FROM TOF_ART_LOOKUP ARL
                                                                        INNER JOIN TOF_ARTICLES ART ON (ART.ART_ID = ARL.ARL_ART_ID)
                                                                        LEFT OUTER JOIN TOF_SUPPLIERS SUP ON (SUP.SUP_ID = ART.ART_SUP_ID)
                                                                        INNER JOIN TOF_DESIGNATIONS DES ON (DES.DES_ID = ART.ART_COMPLETE_DES_ID)
                                                                        INNER JOIN TOF_DES_TEXTS TEX ON (DES.DES_TEX_ID = TEX.TEX_ID)
                                                                        WHERE DES.DES_LNG_ID = 16 AND (ARL.ARL_KIND = '4' OR ARL.ARL_KIND = '3') AND ARL.ARL_SEARCH_NUMBER = '" + strRepl.ToUpper() + "' ", connection);
                            DataTable dt2 = new DataTable();
                            da2.Fill(dt2);



                            for (int i = 0; i < dt2.Rows.Count; i++)
                            {
                                var StringValue = dt2.Rows[i]["ART_ARTICLE_NR"].ToString();
                                var StringText = dt2.Rows[i]["ARL_SEARCH_NUMBER"].ToString();
                                var StringBrand = dt2.Rows[i]["SUP_BRAND"].ToString();
                                var StringCategory = dt2.Rows[i]["TEX_TEXT"].ToString();

                                string str = @" INSERT INTO tmpTable (name, brand, category) VALUES ('" + StringValue + "', '" + StringBrand + "', N'" + StringCategory + "')";
                                SqlCommand cmd = new SqlCommand(str, con);
                                int insNum = cmd.ExecuteNonQuery();

                                if (insNum == 0)
                                {
                                    Response.Write("<script type='text/javascript'>alert(' არ დამატებულა!')</script>");
                                }

                                SqlCommand cmd2 = new SqlCommand(@"select * 
                                                                        from
                                                                        (select Id, name as Gname, price, product_code, description from goods) T1
                                                                        INNER JOIN
                                                                        (select * from tmpTable) T2
                                                                        ON(T2.name = T1.product_code OR T2.name = T1.Gname OR T2.name = T1.description)", con);
                                SqlDataReader dr = cmd2.ExecuteReader();
                                DataTable dt3 = new DataTable();
                                dt3.Load(dr);
                                if (dt3.Rows.Count > 0)
                                {
                                    GridView1.DataSource = dt3;
                                    GridView1.DataBind();
                                }
                                else if (dt3.Rows.Count == 0)
                                {
                                    SqlCommand command1 = new SqlCommand(@"select brand, name, name AS Gname, category, REPLACE(brand, brand, N'შეკვეთით' ) price from tmpTable order by brand", con);
                                    SqlDataReader dtr = command1.ExecuteReader();
                                    DataTable dt_t = new DataTable();
                                    dt_t.Load(dtr);

                                    GridView1.DataSource = dt_t;
                                    GridView1.DataBind();
                                }

                                // Response.Write("<script type='text/javascript'>alert('" + countDel + "')</script>");
                            }
                        }
                        con.Close();
                    }
                }
                // If tmptable is Empty Do .....
                else if (dt.Rows.Count == 0)
                {
                    string txt1 = TextBox1.Text;
                    string strRepl = RemoveElementsFrom.RmvSomeElements(txt1);

                    OdbcConnection connection = new OdbcConnection(ConTecdoc);
                    OdbcDataAdapter da2 = new OdbcDataAdapter(@"SELECT *
                                                                        FROM TOF_ART_LOOKUP ARL
                                                                        INNER JOIN TOF_ARTICLES ART ON (ART.ART_ID = ARL.ARL_ART_ID)
                                                                        LEFT OUTER JOIN TOF_SUPPLIERS SUP ON (SUP.SUP_ID = ART.ART_SUP_ID)
                                                                        INNER JOIN TOF_DESIGNATIONS DES ON (DES.DES_ID = ART.ART_COMPLETE_DES_ID)
                                                                        INNER JOIN TOF_DES_TEXTS TEX ON (DES.DES_TEX_ID = TEX.TEX_ID)
                                                                        WHERE DES.DES_LNG_ID = 16 AND (ARL.ARL_KIND = '4' OR ARL.ARL_KIND = '3') AND ARL.ARL_SEARCH_NUMBER = '" + strRepl.ToUpper() + "' ", connection);
                    DataTable dt2 = new DataTable();
                    da2.Fill(dt2);



                    for (int i = 0; i < dt2.Rows.Count; i++)
                    {
                        var StringValue = dt2.Rows[i]["ART_ARTICLE_NR"].ToString();
                        var StringText = dt2.Rows[i]["ARL_SEARCH_NUMBER"].ToString();
                        var StringBrand = dt2.Rows[i]["SUP_BRAND"].ToString();
                        var StringCategory = dt2.Rows[i]["TEX_TEXT"].ToString();

                        con.Open();
                        string str = @" INSERT INTO tmpTable (name, brand, category) VALUES ('" + StringValue + "', '" + StringBrand + "', N'" + StringCategory + "')";
                        SqlCommand cmd = new SqlCommand(str, con);
                        int insNum = cmd.ExecuteNonQuery();

                        if (insNum == 0)
                        {
                            Response.Write("<script type='text/javascript'>alert(' არ დამატებულა!')</script>");
                        }

                        SqlCommand cmd2 = new SqlCommand(@"select * 
                                                                        from
                                                                        (select Id, name as Gname, price, product_code, description from goods) T1
                                                                        INNER JOIN
                                                                        (select * from tmpTable) T2
                                                                        ON(T2.name = T1.product_code OR T2.name = T1.Gname OR T2.name = T1.description)", con);
                        SqlDataReader dr = cmd2.ExecuteReader();
                        DataTable dt3 = new DataTable();
                        dt3.Load(dr);
                        if (dt3.Rows.Count > 0)
                        {
                            GridView1.DataSource = dt3;
                            GridView1.DataBind();
                        }
                        else if (dt3.Rows.Count == 0)
                        {
                            SqlCommand command1 = new SqlCommand(@"select brand, name, name AS Gname, category, REPLACE(brand, brand, N'შეკვეთით' ) price from tmpTable order by brand", con);
                            SqlDataReader dtr = command1.ExecuteReader();
                            DataTable dt_t = new DataTable();
                            dt_t.Load(dtr);

                            GridView1.DataSource = dt_t;
                            GridView1.DataBind();
                        }

                        // Response.Write("<script type='text/javascript'>alert('" + countDel + "')</script>");
                        con.Close();
                    }
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string txt1 = TextBox1.Text;
            string strRepl = RemoveElementsFrom.RmvSomeElements(txt1);
            if (!string.IsNullOrEmpty(strRepl))
            {


                OdbcConnection conn_tec = new OdbcConnection(ConTecdoc);
                OdbcDataAdapter da_arls = new OdbcDataAdapter(@"SELECT *
                                                                        FROM TOF_ART_LOOKUP ARL
                                                                        INNER JOIN TOF_ARTICLES ART ON (ART.ART_ID = ARL.ARL_ART_ID)
                                                                        LEFT OUTER JOIN TOF_SUPPLIERS SUP ON (SUP.SUP_ID = ART.ART_SUP_ID)
                                                                        INNER JOIN TOF_DESIGNATIONS DES ON (DES.DES_ID = ART.ART_COMPLETE_DES_ID)
                                                                        INNER JOIN TOF_DES_TEXTS TEX ON (DES.DES_TEX_ID = TEX.TEX_ID)
                                                                        WHERE DES.DES_LNG_ID = 16 AND (ARL.ARL_KIND = '4' OR ARL.ARL_KIND = '3') AND ARL.ARL_SEARCH_NUMBER = '" + strRepl.ToUpper() + "' ", conn_tec);
                DataTable dt_arls = new DataTable();
                da_arls.Fill(dt_arls);
                GridView2.DataSource = dt_arls;
                GridView2.DataBind();
                if(dt_arls.Rows.Count < 1)
                {
                    img_btn_Kia.Visible = true;
                }
                else
                {
                    img_btn_Kia.Visible = false;
                }
            }

        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gvSearchFooter = e.Row.FindControl("GridView3") as GridView;
                // Retrieve the underlying data item. In this example
                // the underlying data item is a DataRowView object.
                DataRowView rowSearchView = (DataRowView)e.Row.DataItem;

                // Retrieve the key value for the current row. Here it is an int.
                string SearchArtNum = rowSearchView["ART_ARTICLE_NR"].ToString();

                SqlDataAdapter sda = new SqlDataAdapter(@"SELECT * 
                                                        FROM goods
                                                          WHERE product_code LIKE '" + SearchArtNum + "' ", con);
                DataTable dt1 = new DataTable();
                sda.Fill(dt1);
                gvSearchFooter.DataSource = dt1;
                gvSearchFooter.DataBind();
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton ReplaceImgBtn = (ImageButton)sender;
            GridViewRow GrdViewRow = (GridViewRow)ReplaceImgBtn.NamingContainer;

            string strArtBrand = GrdViewRow.Cells[3].Text;
            string strArtNum = RemoveElementsFrom.RmvSomeElements(GrdViewRow.Cells[4].Text);

            //Response.Write("<SCRIPT language='JavaScript'>  alert('"+ strArtNum.ToString()+"') </SCRIPT>");
            Response.Redirect("http://old.tegetamotors.ge/ka/products/act/partsGetResultsByCode2/?make=&makeName=&model=&modelName=&typ=&typName=&pcat=" + strArtNum+"&pcatName=&brand="+strArtBrand+"");

           // Response.Write("<a href='tegetamotors.ge/ka/products/act/partsGetResultsByCode2/?make=&makeName=&model=&modelName=&typ=&typName=&pcat=" + strArtNum + "&pcatName=&brand=" + strArtBrand + "'></a>");
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton ReplaceImgBtn2 = (ImageButton)sender;
            GridViewRow GrdViewRow2 = (GridViewRow)ReplaceImgBtn2.NamingContainer;

            string strArtBrand2 = GrdViewRow2.Cells[3].Text;
            string strArtNum2 = RemoveElementsFrom.RmvSomeElements(GrdViewRow2.Cells[4].Text);

            //Response.Write("<SCRIPT language='JavaScript'>  alert('"+ strArtNum.ToString()+"') </SCRIPT>");
            Response.Redirect("http://vedro.pro/search/?pcode=" + strArtNum2 + " ");
        }

        protected void img_btn_Kia_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("http://vedro.pro/search/?pcode=" + TextBox1.Text + " ");
        }
    }
}