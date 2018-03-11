<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="replacement.aspx.cs" Inherits="Ribbon_WebApp.page2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server" Visible="false" >
    
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" Visible="false" />
    
    <asp:ImageButton ID="img_btn_Kia" runat="server" ImageUrl="https://cdn2.iconfinder.com/data/icons/fortune500badges/Cars/hyundai.png" OnClick="img_btn_Kia_Click" Visible="false" ToolTip="მოვძბნოთ HYUNDAI/KIA-ში" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server" >
    <style type="text/css">


        .hide_column {
            display: none;
        }

        .Grid {
            table-layout: fixed;
            border-collapse: collapse;
            display: block;
        }

        .art_num {
            text-align:right;
        }

            .Grid td {
                border: none;
                color: black;
                font-size: 10pt;
                line-height: 200%;
                width: 200px;
            }

            .Grid th {
                border: none;
                color: #f7b109;
                font-size: 10pt;
                line-height: 200%;
                text-align:left;
                max-width: 300px;
            }

            .ChildGrid th {
            background-color: #6C6C6C !important;
            font-size: 10pt;
            line-height: 200%;
        }

        .Grid tfoot {
            background-color: #00ff00  !important;
            font-size: 10pt;
            line-height: 200%;
            width: 100%;
        }

        #grdOrders tr:nth-child(even) {
            background-color: antiquewhite;
        }

        #grdOrders {
            height: auto;
            overflow: scroll;
            max-height: 250px;
        }
    </style>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Visible="false" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <table class="rsGrid" style="max-width: 95%">
                        <td>
                            <asp:Label ID="lbl_SUP_BRAND" runat="server" Text='<%# String.Concat( Eval("brand"), " ",  Eval("name") )%>'></asp:Label></td>
                        <td>
                            <asp:Label ID="lbl_ART_ARTICLE_NR" runat="server" Text='<%# Bind("Gname")  %>'></asp:Label></td>
                        <td>
                            <asp:Label ID="lbl_TEX_TEXT" runat="server" Text='<%# Bind("price") %>'></asp:Label></td>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("category") %>'></asp:Label></td>
                    </table>
                </ItemTemplate>
                <ControlStyle Width="" />
                <FooterStyle Width="" />
                <HeaderStyle Width="" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:GridView>
    <div style="position:fixed; top: 20%; left: 0;">
        <asp:TextBox ID="TextBox1" runat="server" Width="175"></asp:TextBox>
        <asp:Button ID="Button2" runat="server" Text="მარაგში ?" OnClick="Button2_Click" />
    </div>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView2_RowDataBound" CellPadding="4" ForeColor="#333333" GridLines="None" style="margin-left: auto; margin-right: auto; margin-top: -25px;" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:TemplateField ItemStyle-HorizontalAlign="Left" >
                <ItemTemplate>
                    <table class="Grid" style="max-width: 95%">
                        <thead>
                            <tr>
                                <th>
                                    <asp:Label ID="ARL_TEX_TEXT" runat="server" Text='<%# Eval("TEX_TEXT") %>'></asp:Label></th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td>
                                    <asp:Panel ID="qwe" runat="server">
                                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="ChildGrid" Width="100%">
                                            <Columns>
                                                <asp:BoundField ItemStyle-Width="50px" ItemStyle-ForeColor="Red" DataField="price" HeaderText="მაღაზიის ფასი" HeaderStyle-Width="400px" />
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label4" runat="server" Text="ლარი"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </tfoot>
                        
                    </table>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" />
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SUP_BRAND") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ItemStyle-CssClass="art_num">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("ART_ARTICLE_NR") %>'></asp:Label>
                </ItemTemplate>

<ItemStyle CssClass="art_num"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="SUP_BRAND" ReadOnly="True" ItemStyle-CssClass="hide_column">
                <HeaderStyle CssClass="hide_column"></HeaderStyle>

                <ItemStyle CssClass="hide_column"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="ART_ARTICLE_NR" ReadOnly="True" ItemStyle-CssClass="hide_column">
                <HeaderStyle CssClass="hide_column"></HeaderStyle>

                <ItemStyle CssClass="hide_column"></ItemStyle>
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" Width="24" OnClick="ImageButton1_Click" ImageUrl="~/images/plus.png" ToolTip="მოვძბნოთ თეგეტაში" />
                    <asp:ImageButton ID="ImageButton2" runat="server" Width="24" OnClick="ImageButton2_Click" ImageUrl="https://cdn2.iconfinder.com/data/icons/fortune500badges/Cars/hyundai.png" ToolTip="მოვძბნოთ HYUNDAI/KIA-ში" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:GridView>
    

</asp:Content>
