<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test04.aspx.cs" Inherits="Ribbon_WebApp.test04" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txt_search" runat="server" />
        <asp:Button ID="btn_srchOEM" runat="server" Text="SearchOEM" OnClick="btn_srchOEM_Click" />
        <asp:Button ID="btn_srchART" runat="server" Text="GetCrosses" OnClick="btn_srchART_Click" />
        <br /><br />
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>
    </form>
</body>
</html>
