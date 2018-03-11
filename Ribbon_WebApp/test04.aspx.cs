using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ribbon_WebApp
{
    public partial class test04 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //webstream();
            //json();
        }

        void webstream()
        {
            //preparing url with all four parameter            
            string uri = "http://tecapp.tecalliance.net/api/TEC/ru/tecdoctocat/RU/PA/manufacturer/136/modelseries";
            //making web request to url
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            //getting response from api
            WebResponse response = request.GetResponse();

            Stream strm = response.GetResponseStream();

            StreamReader reader = new System.IO.StreamReader(strm);
            //reading result 
            string translatedText = reader.ReadToEnd();

            //remove elements before 
            
            string output = translatedText.Split('[').Last();
            string output2 = translatedText.Substring(translatedText.IndexOf('['));
            string output22 = output2.Substring(0, output2.LastIndexOf("]") + 1);

            Response.Write("Converted Texts Are: " + output + "<br>" + output2 + "<br>" + output22);
            response.Close();
        }

        protected void btn_srchOEM_Click(object sender, EventArgs e)
        {
            //preparing url with all four parameter
            string uri = "http://api.tecdoc.ru/oemcars/" + txt_search.Text + "";

            //making web request to url
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            //getting response from api
            WebResponse response = request.GetResponse();
            Stream strm = response.GetResponseStream();
            StreamReader reader = new System.IO.StreamReader(strm);

            //reading result 
            string resultsText = reader.ReadToEnd();

            //remove elements before            
            string output2 = resultsText.Substring(resultsText.IndexOf('['));

            //remove elements after
            string output22 = output2.Substring(0, output2.LastIndexOf("]") + 1);

            //Random json string, No fix number of columns or rows and no fix column name.   
            string myDynamicJSON = output22;

            //Using dynamic keyword with JsonConvert.DeserializeObject, here you need to import Newtonsoft.Json  
            dynamic myObject = JsonConvert.DeserializeObject(myDynamicJSON);

            //Using DataTable with JsonConvert.DeserializeObject, here you need to import using System.Data;  
            DataTable myObjectDT = JsonConvert.DeserializeObject<DataTable>(myDynamicJSON);

            //Binding gridview from dynamic object   
            GridView1.DataSource = myObjectDT;
            GridView1.DataBind();
        }

        protected void btn_srchART_Click(object sender, EventArgs e)
        {
            //preparing url with all four parameter
            string uri = "http://api.tecdoc.ru/getCrossesTitle/" + txt_search.Text + "";

            //making web request to url
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            //getting response from api
            WebResponse response = request.GetResponse();
            Stream strm = response.GetResponseStream();
            StreamReader reader = new System.IO.StreamReader(strm);

            //reading result 
            string resultsText = reader.ReadToEnd();

            //remove elements before            
            string output2 = resultsText.Substring(resultsText.IndexOf('['));

            //remove elements after
            string output22 = output2.Substring(0, output2.LastIndexOf("]") + 1);

            //Random json string, No fix number of columns or rows and no fix column name.   
            string myDynamicJSON = output22;

            //Using dynamic keyword with JsonConvert.DeserializeObject, here you need to import Newtonsoft.Json  
            dynamic myObject = JsonConvert.DeserializeObject(myDynamicJSON); 

            //Using DataTable with JsonConvert.DeserializeObject, here you need to import using System.Data;  
            DataTable myObjectDT = JsonConvert.DeserializeObject<DataTable>(myDynamicJSON);

            //Binding gridview from dynamic object   
            GridView1.DataSource = myObjectDT;
            GridView1.DataBind();
        }
    }
}