<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="Ribbon_WebApp.Test2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

        .ItemInfoBox {            
            text-align: center;
            background: url(images/Window.PNG) no-repeat;
            background-size: cover;
            width: 650px;	
        }

            

        .ItemInfoBox_title {
            background: url(ribbon/themes/windows7/images/menu_top.png) no-repeat;            
            position: relative;
            background-size: cover;
            width: 100%;
        }

        .ItemInfoBox_title:hover {
            background: url(ribbon/themes/windows7/images/orb_hover.png) no-repeat;
        }


        .ItemInfoBox_body {
            background-image: url(images/menu_middle.png); 
            position: relative;
            left: 2px; 
            right: 25px;
            bottom: 15px;      
        }

        .ItemInfoBox div { 
            display: inline-block;             
        }

        textarea:focus, input:focus {
            outline: none;
        }

        .showTitle {
            display: none;
        }

        span:hover + .showTitle {
            display: block;
        }

        abbr {
            padding: 0 5px;
            margin: 0 auto;
            float:left;
        }

        .Calendar {
            width: 350px;
            border-color: #E9E9E9;
        }

        .SelectedDayStyle {
            background: #f4f4f4;
            color: Maroon;
        }

        .TodayDayStyle {
            background-color: #000000;
            color: White;
        }

        .OtherMonthDayStyle {
            color: #cccccc;
        }

        .DayHeaderStyle {
            background-color: #e9e9e9;
            background-image: url(images/blog/cal-header-bg.jpg);
        }

        .DayStyle {
            border: 1px solid #cccccc;
            height: 40px;
        }

        .TitleStyle {
            background-color: #ffffff;
            color: #000000;
            padding: 2px;
        }


    </style>
    <script type="text/javascript">
        var MIN_TEXTLENGTH = 4;
        
        function checkPostback(ctrl) {
            if (ctrl != null && ctrl.value && ctrl.value.length >= MIN_TEXTLENGTH) {
                __doPostBack(ctrl.id, '');
            } setTimeout(checkPostback(ctrl), 1500);
        }

        function row_filtring(grd) {

            

                alert(grd.id);

            }
            
            
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:TextBox ID="TextBox2" text="PostBack" OnKeyUp="checkPostback(this);" runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>

        <asp:ListView ID="ListView1" runat="server"
            InsertItemPosition="FirstItem" DataSourceID="SqlDataSource1" Visible="false">
            <LayoutTemplate>
                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
            </LayoutTemplate>
            <ItemTemplate>
                <div>
                    Name: <%# Eval("name") %><br />
                    Age: <%# Eval("tender_category") %>
                </div>
            </ItemTemplate>
            <InsertItemTemplate>
                <div>
                    Name:
                    <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("name") %>' /><br />
                    Age:
                    <asp:TextBox ID="txtAge" runat="server" Text='<%# Bind("tender_category") %>' /><br />
                    <asp:Button ID="butInsert" runat="server" CommandName="Insert" Text="Add" />
                </div>
            </InsertItemTemplate>
        </asp:ListView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" SelectCommand="select tenders.*, suppliers.id, suppliers.name  from tenders, suppliers where suppliers.id = tenders.contractor_id ORDER BY tender_date DESC"
            ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"></asp:SqlDataSource>
        <p>
            &nbsp;
        </p>
        <p>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </p>

        <p>
            <asp:GridView ID="GridView" runat="server" AutoGenerateColumns="False" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="20" Width="95%" CssClass="gv">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" ItemStyle-CssClass="hide_column" HeaderStyle-CssClass="hide_column" />
                    <asp:BoundField DataField="name" HeaderText="name" SortExpression="name">
                        <ControlStyle Width="350px" />
                        <ItemStyle Wrap="True" />
                    </asp:BoundField>


                    <asp:BoundField DataField="price" HeaderText="price" SortExpression="price">
                        <ItemStyle Width="30px" />
                    </asp:BoundField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ID="Replace_ImgBtn" runat="server" ImageUrl="~/images/icons/substitute_icon.ico" Height="24" ToolTip="შემცვლელის ნახვა" OnClick="Replace_ImgBtn_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Width="30px" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Width="30px" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Width="30px" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Wrap="True" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </p>

        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><asp:Button ID="Button4" runat="server" Text="Button" OnClick="Button4_Click" />
        <asp:ScriptManager ID="Scriptmanager1" runat="server"></asp:ScriptManager>
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="TextBox1"
            UseContextKey="true" CompletionInterval="1500"
            CompletionSetCount="20"
            ServiceMethod="GetCompletionList" MinimumPrefixLength="4">
        </ajaxToolkit:AutoCompleteExtender>
        <br />
        <br />
        <br />
        <br />
        <br />



        <div class="ItemInfoBox" id="item_name">
            <div class="ItemInfoBox_title">დასახელება: </div>
            <div class="ItemInfoBox_body">
                <br />
                <div style="width: 130px">
                    <abbr>ID:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <input type="text" tabindex="0" id="txt_GoodsId" runat="server" readonly="readonly" name="name_GoodsId" style="width: 100px; border: none" />
                        <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='ინდექსი: ID'" />
                    </div>
                </div>
                <div style="width: 250px">
                    <abbr>საქ. კოდი:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <input type="text" tabindex="0" id="txt_ProductCode" runat="server" name="name_ProductCode" style="width: 225px; border: none" />
                        <asp:ImageButton ID="imj" runat="server" ImageUrl="images/icons/sync_arrow.ico" Height="15" ToolTip="TECDOC-ში მოძებნა" OnClick="imj_Click" />

                    </div>
                </div>
                <div style="width: 250px">
                    <abbr>შტრიხ კოდი:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <input type="text" tabindex="0" id="txt_BarCode" runat="server" name="name_BarCode" style="width: 220px; border: none" />
                        <span>
                            <img alt="info" src="images/icons/information.ico" height="15" /></span>
                        <img class="showTitle" src="images/icons/barcode_stock_id.ico" height="30" width="90" />
                    </div>
                </div>

            </div>

            <div class="ItemInfoBox_body">
                <div style="width: 180px">
                    <abbr>OEM კოდი:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <input type="text" tabindex="0" id="txt_OEM" runat="server" name="name_OEM" style="width: 150px; border: none" />
                        <img alt="info" src="images/icons/sync_arrow.ico" height="15" onmouseover="this.title='TECDOC-ში მოძებნა'" />
                    </div>
                </div>
                <div style="width: 225px">
                    <abbr>კატეგორია:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        GE<input type="text" tabindex="0" id="txt_Category" runat="server" name="name_Category" style="width: 180px; border: none" />
                        <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='პროდუქტის კატეგორია'" />
                    </div>
                </div>
                <div style="width: 225px">
                    <abbr>მწარმოებელი:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <input type="text" tabindex="0" id="txt_Brand_Manufacturer" runat="server" name="name_Brand_Manufacturer" style="width: 190px; border: none" />
                        <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='მწარმოებელი / ბრენდი'" />
                    </div>
                </div>
            </div>

            <div class="ItemInfoBox_body">
                <div style="width: 350px">
                    <abbr>სახელწოდება:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <input type="text" tabindex="0" id="txt_Goods_Name" runat="server" name="name_Goods_Name" style="width: 313px; border: none" />
                        <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='პროდუქტის სრული სახელწოდება'" />
                    </div>
                </div>
                <div style="width: 150px">
                    <abbr>ერთეული:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        GE<input type="text" tabindex="0" id="txt_Unit" runat="server" name="name_unit" style="width: 100px; border: none" />
                        <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='ცალი, ლიტრი ....'" />
                    </div>
                </div>
                <div style="width: 130px">
                    <abbr>ფასი:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <input type="text" tabindex="0" id="txt_Price" runat="server" name="name_Price" style="width: 100px; border: none" />
                        <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='საქონლის საბითუმო ფასი'" />
                    </div>
                </div>
            </div>

            <div class="ItemInfoBox_body">
                <div style="width: 630px">
                    <abbr>დეტალები / აღწერილობა:</abbr><br />
                    <div style="background: #fff; border: 1px solid black;">
                        <asp:TextBox type="text" TabIndex="0" ID="Text9" runat="server" Style="border-style: none; border-color: inherit; border-width: medium; min-height: 100px; max-width: 630px" TextMode="MultiLine" Width="620px"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />



        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />

        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" /><asp:Button ID="Button2" runat="server" Text="Button2" OnClick="Button2_Click" />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>




        <br />
        <br />
        <br />

        <input list='browsers' id="sup_list" runat="server">
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Button" />
        <asp:Button ID="Button31" runat="server" Text="Show" OnClick="Button31_Click" />
        <br />
        <br />
        <br /><br />
        <br />
        <asp:Button ID="Button5" runat="server" Text="Button777" OnClick="Button5_Click" />
        <br />
        <asp:GridView ID="GridView2" runat="server" ShowFooter="true" AutoGenerateColumns="False" AllowSorting="True" Width="902px">
            <Columns>
                <asp:BoundField DataField="Id"></asp:BoundField>

                <asp:BoundField DataField="name" ItemStyle-Width="350px" >


                    <ItemStyle Width="350px"></ItemStyle>
                </asp:BoundField>


                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:TextBox ID="txt_ItCode" runat="server" ClientIDMode="Static" onclick="row_filtring(this);" Text='<%# Eval("product_code") %>' Width="100"></asp:TextBox>
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:TextBox ID="txt_SupCode" runat="server" Text='<%# Eval("suppliers_code") %>' Width="100"></asp:TextBox>
                    </ItemTemplate>

                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:TextBox ID="txt_Comment" runat="server" Text='<%# Eval("comment") %>' Width="100"></asp:TextBox>
                        <asp:Button ID="btn_upd" runat="server" OnClick="btn_upd_Click" Text="UPDATE" />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txt_FiltrRow" runat="server" ClientIDMode="Static" ></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
        <br /><br /><br />
        <asp:Calendar ID="Calendar1" runat="server" OnDayRender="Calendar1_DayRender" NextPrevFormat="ShortMonth" CssClass="Calendar">
            <SelectedDayStyle CssClass="SelectedDayStyle" />
            <TodayDayStyle CssClass="TodayDayStyle" />
            <OtherMonthDayStyle CssClass="OtherMonthDayStyle" />
            <DayHeaderStyle CssClass="DayHeaderStyle" />
            <DayStyle CssClass="DayStyle" />
            <TitleStyle CssClass="TitleStyle" />
        </asp:Calendar>
        <br /><br />
        <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList><asp:Button ID="Button6" runat="server" Text="Button09" OnClick="Button6_Click" />
    </form>   

    
    </body>
</html>