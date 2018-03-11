<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Statements.aspx.cs" Inherits="Ribbon_WebApp.Statements" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">
    <link href="themes/2/tooltip.css" rel="stylesheet" type="text/css" />
    <script src="themes/2/tooltip.js" type="text/javascript"></script>
    <style type="text/css">
       .tooltip {
           background-color: Yellow;
           position: absolute;
           border-style: solid;
           border-width: 1px;
       }
    </style> 

    <script type="text/javascript">
        function GetSelectedRow(lnk) {
            var row = lnk.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;
            var customerId = row.cells[0].innerHTML;
            var compatable = row.cells[1].innerHTML;
            tooltip.pop(null, "RowIndex: " + rowIndex + "<br /> დასახელება: " + customerId + "<br /> გამოიყენება:" + compatable, { overlay: false, position: 4 });
            return false;
        } setTimeout(open, 500);        
    </script>

    <script type="text/javascript">
        function GetWeatherTbilisi() {
            var MyDiv1 = document.getElementById('DIV1').innerHTML;
            tooltip.pop(null, "RowIndex: " + MyDiv1 + "<br />", { overlay: false, position: 4 });
            return false;
        } setTimeout(open, 500);
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <div>
        <table class="rsGrid">
            <thead class="rsGridHeaderRow">
                <asp:Panel ID="head_for_statments" runat="server">
                    <th class="gridRow" style="width: 55px"></th>
                    <th class="gridRow" style="text-align: left; width: 17%">
                        <table>
                            <tr>
                                <td><span>ზედნადების N</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton1_Click" PostBackUrl="#statements" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton2_Click" PostBackUrl="#statements" /></td>
                            </tr>
                        </table>
                    </th>
                    <th class="gridRow" style="text-align: left; width: 13%">
                        <table>
                            <tr>
                                <td><span>თარიღი</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton3_Click" PostBackUrl="#statements" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton4_Click" PostBackUrl="#statements" /></td>
                            </tr>
                        </table>
                    </th>
                    <th class="gridRow" style="text-align: left; width: 11%">
                        <table>
                            <tr>
                                <td><span>შემოსავლები</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton5_Click" PostBackUrl="#statements" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton6_Click" PostBackUrl="#statements" /></td>
                            </tr>
                        </table>
                    </th>
                    <th class="gridRow" style="text-align: left; width: 11%">
                        <table>
                            <tr>
                                <td><span>ხარჯები</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton7_Click" PostBackUrl="#statements" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton8_Click" PostBackUrl="#statements" /></td>
                            </tr>
                        </table>
                    </th>
                    <th class="gridRow">
                        <table>
                            <tr>
                                <td><span>კლიენტი</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton9" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton9_Click" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton10" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton10_Click" /></td>
                            </tr>
                        </table>
                    </th>
                </asp:Panel>

                <asp:Panel ID="head_for_overspends" runat="server" Visible="false">
                </asp:Panel>
            </thead>

            <tbody class="rsGridHeaderRow">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="true" OnRowDataBound="GridView1_RowDataBound" GridLines="None" Width="100.5%" CssClass="grid">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <td class="gridRow">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("waybill_number") %>'></asp:Label>
                                </td>
                                <td class="gridRow">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("waybill_date", "{0:dd.MM.yyyy}") %>'></asp:Label>
                                </td>
                                <td class="gridRow">
                                    <asp:Label ID="lbl_Pays_In" runat="server" Text='<%# Bind("shemos", "{0:0.00}") %>'></asp:Label>
                                </td>
                                <td class="gridRow">
                                    <asp:Label ID="lbl_Pays_Out" runat="server" Text='<%# Bind("gasav", "{0:0.00}") %>'></asp:Label>
                                </td>
                                <td class="gridRow">
                                    <asp:Label ID="lbl_expense_name" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                </td>
                            </ItemTemplate>
                            <FooterTemplate>
                                <tr class="rsGridSummaryRow">
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <asp:Label ID="lbl_Tot_of_Ins" runat="server"></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lbl_Tot_of_Outs" runat="server"></asp:Label></td>
                                    <td></td>
                                </tr>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </tbody>

            <tfoot>
            </tfoot>
        </table>

        <div id="Rs_Tab_Header" runat="server" class="rsTabRightPanel">
            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy.MM.dd" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="date_from" />
            <asp:TextBox ID="date_from" runat="server" onclick="this.placeholder=''" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'თარიღიდან':this.placeholder" placeholder="თარიღიდან" CssClass="rsButton" PaneWidth="120px" FirstDayOfWeek="Monday" Width="70px" AutoPostBack="True"></asp:TextBox>
            <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy.MM.dd" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="date_to" />
            <asp:TextBox ID="date_to" runat="server" onclick="this.placeholder=''" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'თარიღამდე':this.placeholder" placeholder="თარიღამდე" CssClass="rsButton" PaneWidth="120px" FirstDayOfWeek="Monday" Width="70px" AutoPostBack="True"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
        </div>

        <div id="OverFlows" runat="server" class="textbox">
            
            
            <asp:Label ID="Label4" runat="server" Style="display: none"></asp:Label>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView2_RowDataBound" GridLines="None" Width="95.5%">
                <Columns>
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label ID="txtItemName" runat="server" ></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField ItemStyle-CssClass="hide_column" HeaderStyle-CssClass="hide_column">

                        <HeaderStyle CssClass="hide_column"></HeaderStyle>

                        <ItemStyle CssClass="hide_column"></ItemStyle>
                    </asp:BoundField>

                    <asp:BoundField DataField="product_code" HeaderText="Product Code" />

                    <asp:TemplateField HeaderText="ნაშთი / -">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkSelect" runat="server" Text='<%# Convert.ToDouble(Eval("nashti"))  %>' CommandName="Select" OnClientClick="return GetSelectedRow(this)" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="rsGridHeaderRow" />
                <PagerSettings Mode="NumericFirstLast" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            </asp:GridView>
        </div>
    </div> 
</asp:Content>
