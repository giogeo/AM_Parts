using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Collections.Generic;

namespace Ribbon_WebApp
{
    public class Customer
    {
        private string strItemID;
        private string strItemName;
        private string strItemUnit;
        private string strItemQty;
        private string strItemPrice;
        private string strItemCode;

        public string ItemID
        {
            get
            {
                return strItemID;
            }
            set
            {
                strItemID = value;
            }
        }

        public string ItemName
        {
            get
            {
                return strItemName;
            }
            set
            {
                strItemName = value;
            }
        }

        public string ItemUnit
        {
            get
            {
                return strItemUnit;
            }
            set
            {
                strItemUnit = value;
            }
        }

        public string ItemQty
        {
            get
            {
                return strItemQty;
            }
            set
            {
                strItemQty = value;
            }
        }

        public string ItemPrice
        {
            get
            {
                return strItemPrice;
            }
            set
            {
                strItemPrice = value;
            }
        }

        public string ItemCode
        {
            get
            {
                return strItemCode;
            }
            set
            {
                strItemCode = value;
            }
        }

    }

    public class RemoveElementsFrom
    {
        public static string RmvSomeElements(string str)
        {
            StringBuilder stringBuilder = new StringBuilder(str);
            stringBuilder.Replace("-", "");
            stringBuilder.Replace(":", "");
            stringBuilder.Replace(".", "");
            stringBuilder.Replace(",", "");
            stringBuilder.Replace("/", "");
            stringBuilder.Replace(" ", "");
            stringBuilder.Replace("(", "");
            stringBuilder.Replace(")", "");

            return str = stringBuilder.ToString();
        }
    }

    public class HiddenFieldValueStatus
    {
        public static string Waybill_CheckBox { get; set; }
        public static string Tender_CheckBox { get; set; }
    }

    public class _Requests
    {
        public static string check_action { get; set; }
        public static string check_barcode { get; set; }
    }

    public class AuthUsers
    {
        public static string strSessionValue;

        public static string strUserFullName;



        public string SessVal
        {
            get
            {
                return strSessionValue;
            }
            set
            {
                strSessionValue = value;
            }
        }

        public string SessVal2
        {
            get
            {
                return strUserFullName;
            }
            set
            {
                strUserFullName = value;
            }
        }
    }

}