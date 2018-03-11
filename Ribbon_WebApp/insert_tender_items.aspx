<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="insert_tender_items.aspx.cs" Inherits="Ribbon_WebApp.insert_tender_items" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .modalDialog {
            position: fixed;
            font-family: Arial, Helvetica, sans-serif;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background: rgba(0,0,0,0.8);
            z-index: 99999;
            opacity: 0;
            -webkit-transition: opacity 400ms ease-in;
            -moz-transition: opacity 400ms ease-in;
            transition: opacity 400ms ease-in;
            pointer-events: none;
        }

            .modalDialog:target {
                opacity: 1;
                pointer-events: auto;
            }

            .modalDialog > div {
                width: 400px;
                position: relative;
                margin: 10% auto;
                padding: 5px 20px 13px 20px;
                border-radius: 10px;
                background: #fff;
                background: -moz-linear-gradient(#fff, #999);
                background: -webkit-linear-gradient(#fff, #999);
                background: -o-linear-gradient(#fff, #999);
            }

        .close {
            background: #606061;
            color: #FFFFFF;
            line-height: 25px;
            position: absolute;
            right: -12px;
            text-align: center;
            top: -10px;
            width: 24px;
            text-decoration: none;
            font-weight: bold;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
            -moz-box-shadow: 1px 1px 3px #000;
            -webkit-box-shadow: 1px 1px 3px #000;
            box-shadow: 1px 1px 3px #000;
        }

            .close:hover {
                background: #00d9ff;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" ForeColor="#333333" GridLines="None" CssClass="rsGridHeaderRow" AutoGenerateColumns="False">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>

                    <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_GoodId" runat="server" Text='<%# Bind("goods_id") %>' Width="90px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                        </ItemTemplate>
                        <ControlStyle Width="90px" />
                        <FooterStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                        <ItemStyle HorizontalAlign="Left" Width="90px" />
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_ItemUnit" runat="server" Text='<%# Bind("unit_name") %>' Width="98px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                        </ItemTemplate>
                        <ControlStyle Width="98px" />
                        <FooterStyle Width="98px" />
                        <HeaderStyle Width="98px" />
                        <ItemStyle HorizontalAlign="Left" Width="98px" />
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_ItemQty" runat="server" Text='<%# Bind("quantity") %>' Width="58px"></asp:TextBox>
                        </ItemTemplate>
                        <ControlStyle Width="58px" />
                        <FooterStyle Width="58px" />
                        <HeaderStyle Width="58px" />
                        <ItemStyle HorizontalAlign="Left" Width="58px" />
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_ItemPrice" runat="server" Text='<%# Bind("price") %>' Width="58px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                        </ItemTemplate>
                        <ControlStyle Width="58px" />
                        <FooterStyle Width="58px" />
                        <HeaderStyle Width="58px" />
                        <ItemStyle HorizontalAlign="Left" Width="58px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <table>
                <tr>
                    <td style="vertical-align: top">
                        <asp:GridView ID="GridView2" runat="server"></asp:GridView>
                    </td>
                    <td style="vertical-align: top">
                        <asp:GridView ID="GridView3" runat="server"></asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div>
            <asp:Button ID="Button1" runat="server" Text="Insert" OnClick="Button1_Click" />
            <br /> <br />
            
        </div>
        <br /><br />
        <div>
            <asp:GridView ID="GridView4" runat="server" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="name" HeaderText="Name" ItemStyle-Width="350" />
                    <asp:TemplateField HeaderText="Country" ItemStyle-Width="150">
                        <ItemTemplate>
                            <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("price") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:LinkButton ID="btnGetSelected" runat="server" href="#openModal" OnClick="GetSelectedRecords" >ADD</asp:LinkButton>
            <hr />
            <u>Selected Rows</u>
            <br />
            <div id="openModal" class="modalDialog">
                <div>
                    <a href="#close" title="Close" class="close">X</a>
                    <h2>Modal Box</h2>
                    <p>
                        <asp:GridView ID="gvSelected" runat="server" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White" AutoGenerateColumns="false">
                        </asp:GridView>
                    </p>
                </div>
            </div>
            
        </div>

    </form>
</body>
</html>
