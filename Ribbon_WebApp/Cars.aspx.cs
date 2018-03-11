using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{

    public partial class Cars : System.Web.UI.Page
    {
        string ConTecdoc = "Description=TecDoc2016;Dsn=TecDoc2016;Database=TECDOC_CD_2_2016;Server=localhost;UID=tecdoc;PWD=tcd_error_0;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //Control Initialization
                //Databinding
                ListCarBrands();
            }
            
            if (Request.QueryString.Count != 0)
            {
                CAR_TYPE_ID = Request["ID"];
                if(!string.IsNullOrEmpty(CAR_TYPE_ID))
                {
                    // Response.Write("<SCRIPT language='JavaScript'>  alert('შეცდომა! - "+ CAR_TYPE_ID +"') </SCRIPT");
                    ListModelsParts();
                    
                }
            }
        }

        private void ListCarBrands()
        {
            OdbcConnection connection = new OdbcConnection(ConTecdoc);
            connection.ConnectionTimeout = 600;
            connection.Open();

            OdbcDataAdapter da = new OdbcDataAdapter(@"
            SELECT *        
            FROM TOF_MANUFACTURERS
            WHERE MFA_ID IN (538,647,539,551,553,561,10138)
            ", connection);

            DataTable dt = new DataTable();
            da.Fill(dt);
            gvCustomers.DataSource = dt;
            gvCustomers.DataBind();
            connection.Close();

        }

        public string CAR_TYPE_ID;
        private void ListModelsParts()
        {
            OdbcConnection conn2 = new OdbcConnection(ConTecdoc);
            conn2.ConnectionTimeout = 600;
            conn2.Open();

            OdbcDataAdapter da = new OdbcDataAdapter(@"SELECT	LA_ART_ID, TOF_ART_LOOKUP.ARL_ART_ID, TOF_ART_LOOKUP.ARL_BRA_ID, TOF_ART_LOOKUP.ARL_DISPLAY_NR
                                                       FROM TOF_LINK_GA_STR INNER JOIN TOF_LINK_LA_TYP ON (TOF_LINK_LA_TYP.LAT_TYP_ID = " + CAR_TYPE_ID + " ) AND TOF_LINK_LA_TYP.LAT_GA_ID = TOF_LINK_GA_STR.LGS_GA_ID INNER JOIN TOF_LINK_ART ON (TOF_LINK_ART.LA_ID = TOF_LINK_LA_TYP.LAT_LA_ID) INNER JOIN TOF_ART_LOOKUP ON (LA_ART_ID = TOF_ART_LOOKUP.ARL_ART_ID) first(10)", conn2);

            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string MFA_ID = gvCustomers.DataKeys[e.Row.RowIndex].Value.ToString();
                GridView gvOrders = e.Row.FindControl("gvOrders") as GridView;

                OdbcConnection connection2 = new OdbcConnection(ConTecdoc);
                connection2.ConnectionTimeout = 600;
                connection2.Open();

                OdbcDataAdapter da = new OdbcDataAdapter(@"
                SELECT	MOD_ID, TOF_TYPES.TYP_ID, TOF_TYPES.TYP_MOD_ID, TOF_TYPES.TYP_CCM, TEX_TEXT AS MOD_CDS_TEXT,	MOD_PCON_START,	MOD_PCON_END
                FROM   TOF_MODELS
                INNER JOIN TOF_COUNTRY_DESIGNATIONS ON CDS_ID = MOD_CDS_ID
                INNER JOIN TOF_DES_TEXTS ON TEX_ID = CDS_TEX_ID
                INNER JOIN TOF_TYPES ON TOF_TYPES.TYP_MOD_ID = MOD_ID
                WHERE	MOD_MFA_ID = " + MFA_ID.ToString() + "  AND	CDS_LNG_ID = 16 ORDER BY MOD_CDS_TEXT, MOD_PCON_START DESC ", connection2);

                DataTable dt = new DataTable();
                da.Fill(dt);
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
                // gvOrders.DataSource = GetData(string.Format("select top 3 * from Orders where CustomerId='{0}'", customerId));
                // gvOrders.DataBind();                
            }
        }



        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gvParts = e.Row.FindControl("GridView2") as GridView;
                // Retrieve the underlying data item. In this example
                // the underlying data item is a DataRowView object.
                DataRowView rowView = (DataRowView)e.Row.DataItem;


                // Retrieve the key value for the current row. Here it is an int.
                string myDataKey = rowView["ARL_DISPLAY_NR"].ToString();

                string Art_Num = RemoveElementsFrom.RmvSomeElements(myDataKey);
                // ... do more work ...
                OdbcConnection connection = new OdbcConnection(ConTecdoc);
                connection.ConnectionTimeout = 600;
                connection.Open();

                OdbcDataAdapter da = new OdbcDataAdapter(@"SELECT *
                                                        FROM 
                                                           TOF_ART_LOOKUP ARL
                                                        INNER JOIN 
                                                           TOF_ARTICLES ART ON (ART.ART_ID = ARL.ARL_ART_ID)
                                                        LEFT OUTER JOIN 
                                                           TOF_SUPPLIERS SUP ON (SUP.SUP_ID = ART.ART_SUP_ID)
                                                        INNER JOIN 
                                                           TOF_DESIGNATIONS DES ON (DES.DES_ID = ART.ART_COMPLETE_DES_ID)
                                                        INNER JOIN 
                                                           TOF_DES_TEXTS TEX ON (DES.DES_TEX_ID = TEX.TEX_ID)
                                                        WHERE 
                                                           DES.DES_LNG_ID = 16 AND (ARL.ARL_KIND = '3') AND 
                                                           ARL.ARL_SEARCH_NUMBER = '" + Art_Num +"' FIRST(1)", connection);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvParts.DataSource = dt;
                gvParts.DataBind();
            }
        } 
    }
}