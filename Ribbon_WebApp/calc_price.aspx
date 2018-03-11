<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="calc_price.aspx.cs" Inherits="Ribbon_WebApp.calc_price" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <th style="width:150px">ასაღები ფასი</th>   <th style="width:150px">მოგების %</th>   <th style="width:150px">გასაყიდი ფასი</th>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>   
                <td>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>   
                <td>
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
            </tr>
        </table>  
        <asp:Button ID="btn_calc" runat="server" Text="გამოთვლა" OnClick="btn_calc_Click" />  
    </div>
    </form>
</body>
</html>
