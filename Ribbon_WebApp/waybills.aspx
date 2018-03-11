<%@ Page Title="ზედნადებები" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="waybills.aspx.cs" Inherits="Ribbon_WebApp.waybills" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="SlimeeLibrary" Namespace="SlimeeLibrary" TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">
    
    <style>
        .GVFixedHeader {
            background-color: blue;
            position: relative;
            top: expression(this.offsetParent.scrollTop);
        }

        .footer_top {
            position: fixed;
            top: 180px;
        }

        .squaredThree {
            display: inline-block;
            width: 19px;
            height: 19px;
            margin: -1px 4px 0 0;
            vertical-align: middle;
            position: relative;
            cursor: pointer;
        }
        /* end .squaredThree */
    </style>
    <script type="text/javascript">
       function doneOK() {
           
           window.history.go(-2);           
       }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <div class="top_line">
        <div style="background: #488ad2; color: #b6ff00 !important; min-height: 60px;">
            <div id="Rs_Tab_Header" runat="server" class="rsTabRightPanel">
                <asp:TextBox ID="txt_name" runat="server" onclick="this.placeholder='';" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'ზედ.N/მომწოდებელი':this.placeholder;" placeholder="ზედ.N/მომწოდებელი" CssClass="rsButton" AutoPostBack="true" Width="110px"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="date_from" />
                <asp:TextBox ID="date_from" runat="server" onclick="this.placeholder=''" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'თარიღიდან':this.placeholder" placeholder="თარიღიდან" CssClass="rsButton" PaneWidth="120px" FirstDayOfWeek="Monday" Width="70px" AutoPostBack="True"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="date_to" />
                <asp:TextBox ID="date_to" runat="server" onclick="this.placeholder=''" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'თარიღამდე':this.placeholder" placeholder="თარიღამდე" CssClass="rsButton" PaneWidth="120px" FirstDayOfWeek="Monday" Width="70px" AutoPostBack="True"></asp:TextBox>
            </div>
            <div class="rsTabLeftPanel">
                <h3 style="color: black;">
                    <a id="home" runat="server" href="waybills.aspx" style="visibility: hidden;">
                        <img src="images/icons/1448768265_Cabin_1.ico" alt="" title="" width="24" />
                    </a>
                    <asp:ImageButton ID="ImgBtnHome" runat="server" ImageUrl="~/images/icons/1448768265_Cabin_1.ico" Width="24" OnClick="ImgBtnHome_Click" Visible="False" />
                    <asp:Label ID="lbl_update_id" runat="server" CssClass="hide_column"></asp:Label>
                    <asp:Label ID="lbl_update_qty" runat="server" CssClass="hide_column"></asp:Label>
                    <asp:Label ID="lbl_update_price" runat="server" CssClass="hide_column"></asp:Label>
                    <asp:Label ID="lbl_wb_number" runat="server"></asp:Label>                    
                    <asp:Label ID="lbl_wb_id" runat="server" CssClass="hide_column"></asp:Label>
                    <asp:Label ID="lbl_tender_id" runat="server" CssClass="hide_column"></asp:Label>
                    <asp:Label ID="lbl_wb_in_id" runat="server" CssClass="hide_column"></asp:Label>
                    <asp:Label ID="lbl_tr_type" runat="server" CssClass="hide_column"></asp:Label>
                </h3>
            </div>
        </div>
        
        <table id="tbl_PaidOrNot" runat="server" class="rsGrid" visible="true">
            <tr>                    
                <td style="width: 50px"></td>
                <td style="width: 95px"></td>
                <td style="width: 95px"></td>

                <td style="width: 275px">
                    <div id="" style="max-width:275px; border-style: outset">
                        <table>
                            <tbody>
                                <tr style="float: left">
                                    <td style="margin-left: 2px; width: 275px">
                                        <input type="text" style="box-shadow: none; outline: none; border: 0px" onclick="document.getElementById('suppliers_list').style.display = 'block';" />
                                    </td>

                                    <td style="margin-left: 2px;">
                                        <img class="common_sprite selected" src="https://cdn4.iconfinder.com/data/icons/mayssam/512/up-128.png" width="24" height="24" onclick="document.getElementById('suppliers_list').style.display='none';" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <div id="suppliers_list" class="rsGridContainer" style="display: none">
                                <div class="rsGridDataRow">
                                    <label style="float:left" ">
                                        <input type="checkbox" value=""  class="squaredThree" /><span>დისტრიბუცია</span><label></label></label>
                                </div>
                                <div class="rsGridDataRow">
                                    <label style="float:left">
                                        <input type="checkbox" value="" class="squaredThree" /><span>ქვე-ზედნადები</span><label></label></label>
                                </div>
                                <div class="rsGridDataRow">
                                    <label style="float:left">
                                        <input type="checkbox" value="" class="squaredThree" /><span>ქვე-ზედნადები</span><label></label></label>
                                </div>
                                <div class="rsGridDataRow">
                                    <label style="float: left">
                                        <input type="button" value="გასუფთავება" class="rsButton" style="width: 100%" /><br />
                                        <br />
                                        <input type="button" value="არჩევა" class="rsButton" style="width: 38%" />
                                        <input type="button" value="გაუქმება" class="rsButton" style="width: 42%" />
                                    </label>                                    
                                </div>
                        </div>
                    </div>
                </td>

                <td style="width: 150px"></td>
                <td style="width: 70px"></td>
                <td style="width: 70px"></td>
            </tr>
        </table>

        <div style="background: rgb(248, 248, 248) !important; min-height: 740px;">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" ShowFooter="true" DataKeyNames="id" DataSourceID="Source1" OnRowDataBound="GridView2_RowDataBound" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="27" Width="100.5%" CssClass="grid">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" Visible="true" ReadOnly="True" SortExpression="id" />

                    <asp:BoundField DataField="waybill_number" HeaderText="ზედნადების ნომერი" SortExpression="waybill_number" />

                    <asp:TemplateField HeaderText="თარიღი" SortExpression="waybill_date" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="wbdate1" runat="server"><%# Eval("waybill_date", "{0:d}") %></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>

                    <asp:BoundField DataField="name" HeaderText="კონტრაქტორი" SortExpression="name" HeaderStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle Width="300px" />
                    </asp:BoundField>                    

                    <asp:BoundField DataField="cost" HeaderText="ღირებულება" SortExpression="cost" HeaderStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle Width="170px" />
                    </asp:BoundField>

                    <asp:BoundField DataField="paid" HeaderText="გადახდილია" SortExpression="paid" HeaderStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle Width="170px" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="Preview" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:ImageButton ID="ImgBtn_Preview_WbIn" runat="server" ImageUrl="~/Ribbon/images/icon_eye.png" ToolTip="ზედნადების ნახვა" OnClick="ImgBtn_Preview_WbIn_Click" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ImgBtn_Edit_WbIn" runat="server" ImageUrl="~/Ribbon/images/icon_edit.png" ToolTip="ზედნადების რედაქტირება" Width="16px" OnClick="ImgBtn_Edit_WbIn_Click" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ImgBtn_DelFrom_WbIn" runat="server" ImageUrl="~/images/icons/delete_selected.ico" ToolTip="ზედნადების წაშლა" Width="16px" OnClick="ImgBtn_DelFrom_WbIn_Click" OnClientClick="javascript:if (confirm('ნამდვილად გნებავთ წაშლა?')) return true; else return false;" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <FooterTemplate>
                            <tr class="">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:Label ID="lblSum_WaybillsIn" runat="server"></asp:Label></td>
                                </td>
                                <td>
                                    <asp:Label ID="lblSum_WaybillsIn_Paid" runat="server"></asp:Label></td>
                                <td></td>
                            </tr>
                        </FooterTemplate>

                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="Source1" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                SelectCommand="select * 
                                from 
                                (select * from tenders_waybills )  T1
                                INNER JOIN
                                (select id as Cid, name, is_supplier from suppliers)  T2
                                ON (T2.Cid = T1.contractor_id)
                                where tender_id is null and expense_type = '1' and ([user_id] = @user) ">
                <SelectParameters>
                    <asp:SessionParameter Name="user" SessionField="user" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="btn_edit_waybills_in" runat="server" Style="display: none;" />
            <asp:Panel ID="Panel_Edit_Wabills_In" runat="server" CssClass="modalPopup" Height="500px">
                <table id="tbl_Edit_Wabills_In" runat="server" style="max-height: 500px; overflow: auto; width: 98%;">
                    <tr style="">
                        <th style="width: 25%;">ID</th>
                        <td style="width: 2%;">:</td>
                        <td class="auto-style1">
                            <asp:Label ID="waybill_In_Id_Edit_lbl" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">WayBill Date</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="waybill_In_date_Edit_txt" />
                            <asp:TextBox ID="waybill_In_date_Edit_txt" runat="server" onclick="this.placeholder=''" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'ზედნადების თარიღი':this.placeholder" placeholder="ზედნადების თარიღი" CssClass="rsGridSelect" PaneWidth="120px" FirstDayOfWeek="Monday" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Expense Way</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:DropDownList ID="ddl_Pay_Method_Id2" runat="server" CssClass="rsGridSelect" Width="100%">
                                <asp:ListItem Selected="True" Value="0">გადახდის მეთოდი</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Contractor ID</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:DropDownList ID="ddl_Contractor_Id2" runat="server" CssClass="rsGridSelect" Width="100%" />
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">WayBill Number</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_In_Num_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Total Cost</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_In_Cost_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Total Paid</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_In_Paid_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Comment</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_In_Comment_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%" Height="100px" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3">
                            <asp:Button ID="Waybill_In_Edit_Update_Btn" runat="server" Text="UPDATE" CssClass="rsButton" OnClick="Waybill_In_Edit_Update_Btn_Click" />
                            &nbsp;
                  <asp:Button ID="Waybill_In_Edit_btn_cancel" runat="server" Text="Cancel" CssClass="rsButton" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender3" runat="server" TargetControlID="btn_edit_waybills_in" PopupControlID="Panel_Edit_Wabills_In" CancelControlID="Waybill_In_Edit_btn_cancel" BackgroundCssClass="ModalBackground">
            </ajaxToolkit:ModalPopupExtender>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowFooter="true" DataKeyNames="id" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="27" Width="100.5%" CssClass="grid" OnRowDataBound="GridView1_RowDataBound1">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" Visible="true" ReadOnly="True" SortExpression="id" />

                    <asp:BoundField DataField="tender_id" HeaderText="tender_id" Visible="true" ReadOnly="True" SortExpression="tender_id" />

                    <asp:BoundField DataField="waybill_number" HeaderText="ზედნადების ნომერი" SortExpression="waybill_number" />

                    <asp:TemplateField HeaderText="თარიღი" SortExpression="waybill_date" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="wbdate" runat="server"><%# Eval("waybill_date", "{0:d}") %></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:TemplateField>

                    <asp:BoundField DataField="name" HeaderText="შემსყიდველი" SortExpression="name" HeaderStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle Width="300px" />
                    </asp:BoundField>

                    <asp:BoundField DataField="cost" HeaderText="ღირებულება" SortExpression="cost" HeaderStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle Width="170px" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="Preview" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <table class="">
                                <tr>
                                    <td>
                                        <asp:ImageButton ID="ImgBtn_PreviewGrid" runat="server" ImageUrl="~/Ribbon/images/icon_eye.png" ToolTip="ზედნადების ნახვა" OnClick="ImgBtn_PreviewGrid_Click" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="ImgBtn_Edit_Waybill" runat="server" ImageUrl="~/Ribbon/images/icon_edit.png" ToolTip="ზედნადების რედაქტირება" OnClick="ImgBtn_Edit_Waybill_Click" Width="16px" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <FooterTemplate>
                            <tr class="">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:Label ID="lblSum_Waybills" runat="server"></asp:Label></td>
                                <td></td>
                            </tr>
                        </FooterTemplate>
                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </asp:TemplateField>

                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                SelectCommand="select * 
                                from 
                                (select * from tenders_waybills) T1
                                INNER JOIN
                                (select id, name, taxcode, address, phone, email, is_supplier from suppliers) T2
                                ON(T2.id = T1.contractor_id)
                                where is_supplier = '1' AND expense_way is not null AND ([user_id] = @user)">
                <SelectParameters>
                    <asp:SessionParameter Name="user" SessionField="user" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="btn_edit_waybills" runat="server" Style="display: none;" />
            <asp:Panel ID="Panel_Edit_Wabills" runat="server" CssClass="modalPopup" Height="500px">
                <table id="tbl_Edit_Wabills" runat="server" style="max-height: 500px; overflow: auto; width: 98%;">
                    <tr style="">
                        <th style="width: 25%;">ID</th>
                        <td style="width: 2%;">:</td>
                        <td class="auto-style1">
                            <asp:Label ID="waybill_Id_Edit_lbl" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Tender ID</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:DropDownList ID="tender_Id_Edit_ddl" runat="server" CssClass="rsGridSelect" Width="100%">
                                <asp:ListItem Selected="True" Value="">ტენდერის N°.</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">WayBill Date</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="waybill_date_Edit_txt" />
                            <asp:TextBox ID="waybill_date_Edit_txt" runat="server" onclick="this.placeholder=''" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'ზედნადების თარიღი':this.placeholder" placeholder="ზედნადების თარიღი" CssClass="rsGridSelect" PaneWidth="120px" FirstDayOfWeek="Monday" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Expense Way</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:DropDownList ID="ddl_Pay_Method_Id" runat="server" CssClass="rsGridSelect" Width="100%">
                                <asp:ListItem Selected="True" Value="0">გადახდის მეთოდი</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Contractor ID</th>
                        <td style="width: 2%;">:</td>
                        <td>

                            <asp:DropDownList ID="ddl_Contractor_Id" runat="server" CssClass="rsGridSelect" Width="100%" />
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">WayBill Number</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_Num_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Total Cost</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_Cost_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Total Paid</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_Paid_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">Comment</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="Waybill_Comment_Edit_txt" runat="server" CssClass="rsGridSelect" Width="100%" Height="100px" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3">
                            <asp:Button ID="Waybill_Edit_Update_Btn" runat="server" Text="UPDATE" OnClick="Waybill_Edit_Update_Btn_Click" CssClass="rsButton" />
                            &nbsp;
                  <asp:Button ID="btn_cancel" runat="server" Text="Cancel" CssClass="rsButton" OnClientClick="JavaScript: window.history.back(1); return false;" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="btn_edit_waybills" PopupControlID="Panel_Edit_Wabills" CancelControlID="btn_cancel" BackgroundCssClass="ModalBackground">
            </ajaxToolkit:ModalPopupExtender>

            <asp:GridView ID="GridView3" runat="server" Visible="False" ForeColor="#333333" GridLines="None" CssClass="grid" Width="100.5%" AutoGenerateColumns="False" OnRowCommand="GridView3_RowCommand" OnRowDataBound="GridView3_RowDataBound" OnSelectedIndexChanged="GridView3_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" SortExpression="id">
                        <ItemStyle Width="10px" />
                    </asp:BoundField>

                    <asp:BoundField DataField="tender_id" HeaderText="TID" SortExpression="tender_id" Visible="false">
                        <ItemStyle Width="10px" />
                    </asp:BoundField>

                    <asp:BoundField DataField="tr_type" HeaderText="type" SortExpression="tr_type" Visible="false">
                        <ItemStyle Width="10px" />
                    </asp:BoundField>

                    <asp:TemplateField HeaderText="name" SortExpression="name" FooterStyle-CssClass="footer_top">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_WB_name" runat="server" ReadOnly="true" Enabled="false" Text='<%# Bind("name") %>' ToolTip='<%# Bind("comment") %>'></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txt_waybillid" runat="server" CssClass="hide_column"></asp:TextBox>
                            <asp:TextBox ID="txt_tenderid" runat="server" CssClass="hide_column"></asp:TextBox>
                            <asp:TextBox ID="txt_trtype" runat="server" CssClass="hide_column"></asp:TextBox>
                            <asp:TextBox ID="txt_goodsid" runat="server" CssClass="hide_column"></asp:TextBox>
                            <asp:TextBox ID="txt_goodscode" runat="server" AutoPostBack="True" OnTextChanged="txt_WB_name_TextChanged" Width="15%"></asp:TextBox>
                            <asp:TextBox ID="txt_goodsname" runat="server" Width="77%"></asp:TextBox>
                            &nbsp;
                    <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txt_goodscode"
                        UseContextKey="true"
                        CompletionInterval="500"
                        ServiceMethod="GetCompletionList"
                        MinimumPrefixLength="4"
                        CompletionListCssClass="autoCompleteList"
                        CompletionListItemCssClass="autoCompleteListItem"
                        CompletionListHighlightedItemCssClass="autoCompleteSelectedListItem">
                    </ajaxToolkit:AutoCompleteExtender>
                            <asp:TextBox ID="txt_goodsqty" runat="server" Width="9%"></asp:TextBox>
                            <asp:DropDownList ID="txt_goodsunit_selectedValueId" runat="server" class="rsGridSelect" Style="width: 12%">
                                <asp:ListItem Value="">აირჩიეთ</asp:ListItem>
                                <asp:ListItem Value="1">ცალი</asp:ListItem>
                                <asp:ListItem Value="3">გრამი</asp:ListItem>
                                <asp:ListItem Value="4">ლიტრი</asp:ListItem>
                                <asp:ListItem Value="5">ტონა</asp:ListItem>
                                <asp:ListItem Value="7">სანტიმეტრი</asp:ListItem>
                                <asp:ListItem Value="8">მეტრი</asp:ListItem>
                                <asp:ListItem Value="9">კილომეტრი</asp:ListItem>
                                <asp:ListItem Value="10">კვ.სმ</asp:ListItem>
                                <asp:ListItem Value="11">კვ.მ</asp:ListItem>
                                <asp:ListItem Value="12">მ³</asp:ListItem>
                                <asp:ListItem Value="13">მილილიტრი</asp:ListItem>
                                <asp:ListItem Value="2">კგ</asp:ListItem>
                                <asp:ListItem Value="99">სხვა</asp:ListItem>
                                <asp:ListItem Value="14">შეკვრა</asp:ListItem>
                                <asp:ListItem Value="15">შეცვლა/მომსახურება</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txt_goodsprice" runat="server" Width="22%"></asp:TextBox>
                        </FooterTemplate>
                        <FooterStyle CssClass="footer_top"></FooterStyle>
                        <ItemStyle Width="350px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="რაოდ." SortExpression="quantity">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_Item_qty" runat="server" Enabled="false" Text='<%# Bind("quantity") %>'></asp:TextBox>
                        </ItemTemplate>

                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle Width="70px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="ფასი" SortExpression="price">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_WB_price" runat="server" Enabled="false" Text='<%# Bind("price") %>'></asp:TextBox>
                        </ItemTemplate>

                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle Width="70px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="წაშლა" ItemStyle-Width="15px">
                        <ItemTemplate>
                            <div class="rsButton">
                                <asp:ImageButton ID="ImgBtn_DelFromWaybill" runat="server" ImageUrl="~/images/icons/Del_Box_Red.ico" Width="24px" OnClick="ImgBtn_DelFromWaybill_Click" OnClientClick="javascript:if (confirm('ნამდვილად გნებავთ წაშლა?')) return true; else return false;" ImageAlign="Middle" ToolTip="წაშლა" />
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:ImageButton ID="ImgBtn_InsToWB" CssClass="footer_top" runat="server" ImageUrl="~/Ribbon/images/add_new.png" Width="24px" OnClientClick="javascript:if (confirm('ნამდვილად გნებავთ დამატება?')) return true; else return false;" CommandName="InsertToWaybill" />
                        </FooterTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:ButtonField CommandName="Select" ControlStyle-CssClass="btn_Edit" ControlStyle-Height="20" ItemStyle-Width="20" />

                    <asp:TemplateField>
                        <HeaderTemplate>
                            <img src="images/icons/netvibes.ico" title="ზედნადებში ჩასამატებლად გააკეთეთ მონიშვნა" alt="insert" height="15" />
                            <asp:CheckBox ID="chkb_showfooter" runat="server" OnCheckedChanged="InsToWaybill" AutoPostBack="true" ToolTip="ზედნადებში ჩამატება" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div id="Correct_Div" runat="server" class="rsButton" visible="false">
                                <asp:ImageButton ID="ImgBtn_CorrectWBItem" runat="server" Visible="false" OnClick="ImgBtn_CorrectWBItem_Click" ImageUrl="~/images/icons/right_correct.ico" Height="24px" ImageAlign="Middle" />
                            </div>
                            <div id="Undo_Div" runat="server" class="rsButton" visible="false">
                                <asp:ImageButton ID="ImageButton1" runat="server" OnClick="ImageButton1_Click" ImageUrl="~/images/icons/Undo_Box.ico" Height="24px" ImageAlign="Middle" />
                            </div>
                        </ItemTemplate>
                        <ItemStyle Width="15px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Button ID="btn_ShowPop" runat="server" Style="display: none;" />
            <asp:Panel ID="Edit_Panel" runat="server" CssClass="modalPopup" Height="500px">
                <table id="Div1" runat="server" style="max-height: 500px; overflow: auto; width: 98%;">
                    <tr style="">
                        <th style="width: 25%;">ID</th>
                        <td style="width: 2%;">:</td>
                        <td class="auto-style1">
                            <asp:Label ID="lbl_ID" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">დასახელება</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="txt_upd_wbItemName" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">რაოდენობა</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="txt_upd_wbItemQty" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 25%;">ერთ. ფასი</th>
                        <td style="width: 2%;">:</td>
                        <td>
                            <asp:TextBox ID="txt_upd_wbItemPrice" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3">
                            <asp:Button ID="btn_update" runat="server" Text="UPDATE" OnClick="btn_update_Click" CssClass="rsButton" />
                            &nbsp;
                  <asp:Button ID="btn_exit" runat="server" Text="Cancel" CssClass="rsButton" OnClientClick="JavaScript: window.history.back(1); return false;" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn_ShowPop" PopupControlID="Edit_Panel" CancelControlID="btn_exit" BackgroundCssClass="ModalBackground">
            </ajaxToolkit:ModalPopupExtender>
        </div>
    </div>
</asp:Content>
