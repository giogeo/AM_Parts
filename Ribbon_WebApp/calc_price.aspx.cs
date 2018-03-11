using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class calc_price : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_calc_Click(object sender, EventArgs e)
        {
            double asagebi_fasi, mogebis_proc, procentiani_fasi, gasakidi_fasi;

            asagebi_fasi = Convert.ToDouble(TextBox1.Text);
            mogebis_proc = Convert.ToDouble(TextBox2.Text);

            procentiani_fasi = asagebi_fasi/100 * (mogebis_proc + 100);
            gasakidi_fasi = procentiani_fasi / 0.8;

            TextBox3.Text = gasakidi_fasi.ToString();
        }
    }
}