<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Suppliers.aspx.cs" Inherits="Ribbon_WebApp.Suppliers" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="SlimeeLibrary" Namespace="SlimeeLibrary" TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">

    <style type="text/css">
        .rsTabLeftPanel {
            float: left;
            width: auto;
            text-align: right;
            margin: 15px 10px;
            display: inline;
        }

        .rsTabRightPanel {
            float: left;
            width: 400px;
            text-align: left;
            margin: 15px 10px;
            display: inline;
        }

        .top_line {
            border-bottom-color: rgb(0, 0, 0);
            border-bottom-style: none;
            border-bottom-width: 0px;
            border-image-outset: 0px;
            border-image-repeat: stretch;
            border-image-slice: 100%;
            border-image-source: none;
            border-image-width: 1;
            border-left-color: rgb(248, 248, 248);
            border-left-style: solid;
            border-left-width: 3px;
            border-right-color: rgb(248, 248, 248);
            border-right-style: solid;
            border-right-width: 3px;
            border-top-color: rgb(0, 0, 0);
            border-top-style: none;
            border-top-width: 0px;
            display: block;
            font-family: 'BPG Arial';
            font-size: 12px;
            height: 802px;
            margin: auto;
            overflow-x: hidden;
            overflow-y: auto;
            padding-bottom: 0px;
            padding-left: 0px;
            padding-right: 0px;
            padding-top: 0px;
            position: inherit;
            width: 80%;
        }
    </style>

<link href="scripts/rs_style.css" rel="Stylesheet" type="text/css" /> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <div class="top_line">
        <div style="background: #488ad2; color: #b6ff00 !important; min-height: 60px;">

            <div class="rsTabRightPanel">
                <asp:TextBox ID="txt_name" runat="server" onfocus="this.placeholder = ''" onblur="this.placeholder = 'enter your text'" CssClass="rsButton" AutoPostBack="true" Width="80px"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="date_from" />
                <asp:TextBox ID="date_from" runat="server" onclick="this.value=''" onblur="this.placeholder ='თარიღიდან'" CssClass="inpt_date" PaneWidth="120px" FirstDayOfWeek="Monday" Width="70px" AutoPostBack="True"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" StartDate="2015-01-01" FirstDayOfWeek="Monday" TargetControlID="date_to" />
                <asp:TextBox ID="date_to" runat="server" onclick="this.value=''" onblur="this.placeholder ='თარიღამდე'" CssClass="inpt_date" PaneWidth="120px" FirstDayOfWeek="Monday" Width="70px" AutoPostBack="True"></asp:TextBox>
            </div>

            <div class="rsTabLeftPanel">
                <asp:Button ID="btn_AddNewSupplier" runat="server" Text="+ ახალი კლიენტი" CssClass="rsButton" />
            </div>

        </div>

            <div style="background: rgb(248, 248, 248) !important;  min-height: 740px;">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="DS_Suppliers" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="27" Width="100.5%" CssClass="rsGrid">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="id" Visible="False" ReadOnly="True" SortExpression="id" />
                        <asp:TemplateField HeaderText="სახელწოდება" SortExpression="name" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblDOB" runat="server"><%# Eval("name") %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="საგად. კოდი" SortExpression="taxcode" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblDOB" runat="server"><%# Eval("taxcode") %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="მისამართი" SortExpression="address" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblDOB" runat="server"><%# Eval("address") %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ტელეფონი" SortExpression="phone" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblDOB" runat="server"><%# Eval("phone") %></asp:Label>
                            </ItemTemplate>
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

                <asp:SqlDataSource ID="DS_Suppliers" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>" SelectCommand="select * from suppliers" >
                    
                </asp:SqlDataSource>
            </div>     
        </div>
</asp:Content>
