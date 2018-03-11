<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cars.aspx.cs" Inherits="Ribbon_WebApp.Cars" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $("[src*=plus]").live("click", function () {
            $(this).closest("tr").after("<tr><td colspan = '2' >" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "images/minus.png");
        });
        $("[src*=minus]").live("click", function () {
            $(this).attr("src", "images/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>
    <style type="text/css">
        .hide_column {
            display: none;
        }
        .Grid {
            table-layout: fixed;
            border-collapse: collapse;
            display: block;
            position: relative;
        }
        .Grid td {
            border: none;
            color: black;
            font-size: 10pt;
            line-height: 200%;
        }
        .Grid th {

            border: none;            
            color: White;
            font-size: 10pt;
            line-height: 200%;
        }
        .ChildGrid th {
            background-color: #6C6C6C !important;
            font-size: 10pt;
            line-height: 200%;
        }

        #grdOrders tr:nth-child(even) {
            background-color: antiquewhite;
        }

        #grdOrders {
            height: auto;
            overflow: scroll;
            max-height: 450px;
        }    
     
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 350px; border: groove; border: Outset;">
            <asp:TextBox ID="TextBox1" runat="server" Style="box-shadow: none; outline: none; border: 0px; width:320px" onclick="document.getElementById('Br_List').style.visibility='visible'"></asp:TextBox>
            <img class="common_sprite selected" src="https://cdn4.iconfinder.com/data/icons/mayssam/512/up-128.png" width="15" onclick="document.getElementById('Br_List').style.visibility='hidden';" />
        </div>
        <div id="Br_List" style="width: 350px; border: groove; visibility: hidden">
            <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="Grid"
                DataKeyNames="MFA_ID" OnRowDataBound="OnRowDataBound">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <img alt="" style="cursor: pointer" src="images/plus.png" />
                            <asp:Panel ID="pnlOrders" runat="server" Style="display: none;">
                                <div id="grdOrders">
                                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="ChildGrid">
                                        <Columns>
                                            <asp:HyperLinkField
                                                ItemStyle-Width="75px"
                                                HeaderStyle-CssClass="head"
                                                DataNavigateUrlFields="TYP_ID"
                                                DataNavigateUrlFormatString="?ID={0}"
                                                DataTextField="MOD_CDS_TEXT"
                                                HeaderText="Model"/>                                            
                                            <asp:BoundField ItemStyle-Width="75px" DataField="MOD_PCON_START" HeaderText="Date From" HeaderStyle-CssClass="head1" />
                                            <asp:BoundField ItemStyle-Width="75px" DataField="MOD_PCON_END" HeaderText="Date To" HeaderStyle-CssClass="head2" />
                                            <asp:BoundField ItemStyle-Width="50px" DataField="TYP_CCM" HeaderText="Engine CM/3" HeaderStyle-CssClass="head3" /> 
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField ItemStyle-Width="150px" DataField="MFA_BRAND" HeaderText="Car Maker" />
                </Columns>
            </asp:GridView>
        </div>

        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:BoundField ItemStyle-Width="200px" DataField="ARL_DISPLAY_NR" HeaderText="Art. N" >
                        <ItemStyle CssClass="" />
                    </asp:BoundField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Panel ID="Panel1" runat="server" CssClass="ChildGrid">
                                <div>
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:BoundField ItemStyle-Width="250px" DataField="ART_ARTICLE_NR" HeaderText="Art. N">
                                                <ItemStyle CssClass="hide_column" />
                                            </asp:BoundField>
                                            <asp:BoundField ItemStyle-Width="90px" DataField="SUP_BRAND" HeaderText="Art. N" />
                                            <asp:BoundField ItemStyle-Width="250px" DataField="TEX_TEXT" HeaderText="Art. N" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
                                   
        </div>
    </form>
</body>
</html>
