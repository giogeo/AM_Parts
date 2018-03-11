using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class Suppliers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string Filtr_Sup_Name = txt_name.Text.ToString();

            if (!string.IsNullOrEmpty(Filtr_Sup_Name))
            {
                //მომწოდებლების გაფილტვრა დასახელების მიხედვით.
                
                DS_Suppliers.FilterParameters.Clear();
                ControlParameter cpText = new ControlParameter();
                cpText.ControlID = "txt_name";
                cpText.Name = "waybill_number";
                cpText.PropertyName = "Text";
                DS_Suppliers.FilterParameters.Add(cpText);
                DS_Suppliers.FilterExpression = "name LIKE '%{0}%' OR taxcode = '{0}'";

            }

        }
    }
}