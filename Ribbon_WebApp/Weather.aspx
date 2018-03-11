<%@ Page Language="C#" %>
<%@ OutputCache Location="None" VaryByParam="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void ImgBtn_Preview_WbIn_Click(object sender, ImageClickEventArgs e)
    {
        Response.Write("error");
    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Local Weather Conditions</title>
</head>
<body>
<form id="form1" runat="server">
<div style="font-family: Arial, 'Microsoft Sans Serif';font-size: 10pt;">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" Visible="true" ReadOnly="True" SortExpression="id" />

            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />

            <asp:TemplateField HeaderText="price" SortExpression="price" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:Label ID="wbdate1" runat="server"><%# Eval("price") %></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="200px" />
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Preview" HeaderStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <asp:ImageButton ID="ImgBtn_Preview_WbIn" runat="server" ImageUrl="~/Ribbon/images/icon_eye.png" ToolTip="ზედნადების ნახვა" OnClick="ImgBtn_Preview_WbIn_Click" />
                            </td>
                            <td>

                            </td>
                        </tr>
                    </table>
                </ItemTemplate>

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
</form>
</body>
</html>