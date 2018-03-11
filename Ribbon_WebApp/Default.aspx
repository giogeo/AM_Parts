<%@ Page Title="ავტონაწილების მაღაზია" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Ribbon_WebApp.Default" %>

<%@ Register Assembly="SlimeeLibrary" Namespace="SlimeeLibrary" TagPrefix="cc2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">
    <style media="screen">
        .noPrint {
            display: block !important;
        }

        .yesPrint {
            display: block !important;
        }
    </style>

    <style media="print">
        .noPrint {
            display: none !important;
        }

        .yesPrint {
            display: block !important;
        }
    </style>

    <style type="text/css">
        table {
            border-collapse: collapse;
        }

        textarea:focus, input:focus {
            outline: none;
        }

        .wide {
            width: 120px;
            column-width: 120px;
        }

        .auto-style2 {
            height: 59px;
        }
    </style>

    <script type="text/javascript">
        function printdiv() {
            var Print = window.open('', '', 'height=' + screen.height + ',width=' + screen.width + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes');
            var prtContent = document.getElementById("procurement_list");
            Print.document.write("<html><body>");

            Print.document.write(prtContent.innerHTML);
            Print.document.write("</body></html>");
            Print.document.close();
            Print.focus();
            Print.print();
            Print.close();
        }

        function goBack() {
            window.history.back();
        }

        function goBack_1() {
            window.history.go(-1);
            return false;
        }

        function goUp() {
            $(window).scrollTop(0);
        }
    </script>

    <script type="text/javascript">
        function redirect() {
            var url = "default.aspx";
            window.open(url);
        }
    </script>

    <script type="text/javascript">
        function uncheck13() {

            document.getElementById("<%=myCheck1.ClientID%>").checked = false;
            document.getElementById("<%=myCheck3.ClientID%>").checked = false;
        }

        function uncheck23() {
            document.getElementById("<%=myCheck2.ClientID%>").checked = false;
            document.getElementById("<%=myCheck3.ClientID%>").checked = false;
        }

        function uncheck12() {
            document.getElementById("<%=myCheck1.ClientID%>").checked = false;
            document.getElementById("<%=myCheck2.ClientID%>").checked = false;
        }

        function change1() {
            var txt = document.getElementById('lang2').innerHTML;
            // document.getElementById('lang2').innerHTML='EN';
            if (txt == 'EN') {
                document.getElementById('lang2').innerHTML = 'ქა';
            } else {
                document.getElementById('lang2').innerHTML = 'EN';
            }
        }

        var reg = "abgdevzTiklmnopJrstufqRySCcZwWxjh`~#";
        var sp = "ÀÁÂÃÄÅÆÈÉÊËÌÍÏÐÑÒÓÔÖ×ØÙÚÛÜÝÞßàáãä„“¹";
        var uni = "აბგდევზთიკლმნოპჟრსტუფქღყშჩცძწჭხჯჰ„“№";
        function reg2uni(text) {
            for (var i = 0; i < text.length; i++) {
                if (reg.indexOf(text.charAt(i), 0) >= 0) {
                    text = text.substring(0, i) + uni.charAt(reg.indexOf(text.charAt(i))) + text.substring(i + 1, text.length);
                }
            }
            return text;
        }

        function GetWeatherTbilisi() {
            var MyDiv1 = document.getElementById('DIV1').innerHTML;
            tooltip.pop(null, MyDiv1, { overlay: false, position: 4, effect: 'slide' });
            return false;
        } setTimeout(open, 500);
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <link href="themes/2/tooltip.css" rel="stylesheet" type="text/css" />
    <script src="themes/2/tooltip.js" type="text/javascript"></script>
    <script type="text/javascript">       
        function GetSelectedRow(lnk) {

            var row = lnk.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;
            var customerId = row.cells[0].innerHTML;
            var GoodsName = row.cells[2].innerHTML;
            var GoodsPrice = row.cells[6].innerHTML;

            var tx_boxID = document.getElementById('<%= txt_id.ClientID %>');
            var tx_boxName = document.getElementById('<%= txt_name.ClientID %>');
            tx_boxID.value = customerId;
            tx_boxName.value = GoodsName;
            document.getElementById('light').style.display = 'block';
            document.getElementById('fade').style.display = 'block';

            return false;
        }

        function hide_target() {
            document.getElementById('Div2').style.visibility = 'hidden';
            document.getElementById('Div3').style.visibility = 'hidden';
            alert('Hi Man');
        }
        
        function showhide_adv_search() {
            var div = document.getElementById('advance_search');

            if (div.style.display !== "none") {
                div.style.display = "none";
                document.getElementById('Img_advanced').src = "images/icons/adv_search.ico";
                document.location = "default.aspx?action=goods";
            }
            else {
                div.style.display = "block";
                document.getElementById('Img_advanced').src = "images/icons/zoom-out.png";
            }
        }

        function redirect_to_advsearch() {
            location.href = 'search.aspx#itemlist';
        }
    
        function open_pleasewait() {
            document.all.pleasewaitScreen.style.pixelTop = (document.body.scrollTop + 50)
            document.all.pleasewaitScreen.style.visibility = "visible";
            window.setTimeout('close_pleasewait()', 1500)
        }

        function close_pleasewait() {
            document.all.pleasewaitScreen.style.visibility = "hidden";
        }
        </script> 

    <style type="text/css">
        .pleasewait_modal {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            left: 0;
            background-color: #e8e8e8;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 130px;
            height: 130px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 128px;
                width: 128px;
            }

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
            float: left;
        }

        .rsOKBtn {
            background-image: url(images/icons/ok_tick_16.ico);
            background-size: 15px 15px;
            background-repeat: no-repeat;
            background-position: 25% 55%;
            font-family: Arial;
            font-size: 10pt;
            font-weight: normal;
            border: 1px solid #BBBBBB;
            border-radius: 5px 5px 5px 5px;
            box-shadow: 0 0 4px #BBBBBB;
            height: 30px;
            line-height: 30px;
            width: 90px;
            border: 0px;
        }

        .rsExtBtn {
            background-image: url(images/icons/Btn_Erase.ico);
            background-size: 15px 15px;
            background-repeat: no-repeat;
            background-position: 5% 55%;
            font-family: Arial;
            font-size: 10pt;
            font-weight: normal;
            border: 1px solid #BBBBBB;
            border-radius: 5px 5px 5px 5px;
            box-shadow: 0 0 4px #BBBBBB;
            height: 30px;
            line-height: 30px;
            width: 90px;
            border: 0px;
        }
    </style>
       
    <div id="light" class="white_content">
        <div style="background: #488ad2; color: #b6ff00 !important; min-height: 60px;">
            <div class="rsTabLeftPanel">
                <a href="javascript:void(0)" onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
            </div>
        </div>

        <div style="background: rgb(248, 248, 248) !important; min-height: 740px;">
            <div>
                <asp:TextBox ID="txt_id" runat="server" CssClass="hide_column"></asp:TextBox>
                <asp:TextBox ID="txt_name" runat="server" CssClass="rsButton" Width="250"></asp:TextBox>
                <asp:TextBox ID="txt_price" runat="server" CssClass="rsButton" Width="50"></asp:TextBox>
                <input list='browsers' id="suppliersName" runat="server" class="rsButton">
                <asp:Button ID="btn_add_sup_price" runat="server" Text="+ დამატება" CssClass="rsButton" OnClick="btn_add_sup_price_Click" />
            </div>
        </div>
    </div>    
    <div id="fade" class="black_overlay"></div>

    <div id="Div3" runat="server" class="black_overlay"></div>
    <div id="Div2" runat="server" class="white_content" style="display: none;">
        <a href="javascript:void(0)" onclick="goBack();" id="A1" runat="server" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
        <div style="background: #488ad2; color: #b6ff00 !important; min-height: 60px;"></div>

        <div style="background: rgb(248, 248, 248) !important; min-height: 740px;">
            <asp:ListView ID="ListView4" runat="server">
                <ItemTemplate>
                    <table class="rsGrid">
                        <tr class="rsGridDataRow">
                            <td style="text-align: left; font-weight: bolder;">
                                <asp:Label ID="Label2" runat="server" Text='<%#  Eval("seller_name") %>'></asp:Label></td>
                            <td style="text-align: left">
                                <asp:Label ID="Label3" runat="server" Text='<%#  Eval("seller_price", "{0:0.00}") %>'></asp:Label></td>
                        </tr>
                    </table>
                </ItemTemplate>
                <EmptyDataTemplate>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>

    </div>

    <div id="pleasewaitScreen" class="pleasewait_modal" style="visibility: hidden;">
        <div class="center">
            <img alt="" src="images/loader.gif" />
        </div>
    </div>

    <asp:Button ID="btn_edit_item" runat="server" Style="display: none;" />
    
        <div ID="pnl_edtitem" runat="server" style="max-height: 500px; height:390px; width:690px; overflow: auto;">
            <asp:Label ID="lbl_editgoodsId" runat="server" CssClass="hide_column" />
            <div class="ItemInfoBox" id="item_name">
                <div class="ItemInfoBox_title">დასახელება: </div>
                <div class="ItemInfoBox_body">
                    <br />
                    <div style="width: 5px; display: none">
                        <abbr>ID:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox TabIndex="0" ReadOnly="true" ID="txt_editgoodsID" runat="server" Style="width: 100px; border: none" />
                            <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='ინდექსი: ID'" />
                        </div>
                    </div>
                    <div style="width: 190px">
                        <abbr>საქ. კოდი:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox TabIndex="0" ID="txt_editgoodsCode" runat="server" Style="width: 165px; border: none" />
                            <asp:ImageButton ID="Query_InTecdoc" runat="server" ImageUrl="images/icons/sync_arrow.ico" Height="15" OnClick="Query_InTecdoc_Click" ToolTip="TECDOC-ში მოძებნა" />

                        </div>
                    </div>
                    <div style="width: 190px">
                        <abbr>კლიენტის კოდი:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox TabIndex="0" ID="txt_editsuppliersCode" runat="server" Style="width: 165px; border: none" />
                            <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='მომწოდებლი/გამყიდველის კოდი RS.ge-ზე'" />
                        </div>
                    </div>
                    <div style="width: 250px">
                        <abbr>შტრიხ კოდი:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox TabIndex="0" ID="txt_editgoodsBarCode" runat="server" Style="width: 220px; border: none" />
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
                            <asp:TextBox TabIndex="0" ID="txt_editgoodsOEM" runat="server" Style="width: 150px; border: none" />
                            <img alt="info" src="images/icons/sync_arrow.ico" height="15" onmouseover="this.title='TECDOC-ში მოძებნა'" />
                        </div>
                    </div>
                    <div style="width: 225px">
                        <abbr>კატეგორია:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            GE<asp:TextBox type="text" TabIndex="0" ID="txt_editgoodsCategory" runat="server" Style="width: 180px; border: none" />
                            <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='პროდუქტის კატეგორია'" />
                        </div>
                    </div>
                    <div style="width: 225px">
                        <abbr>მწარმოებელი:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox type="text" TabIndex="0" ID="txt_edit_Brand_Manufacturer" runat="server" Style="width: 190px; border: none" />
                            <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='მწარმოებელი / ბრენდი'" />
                        </div>
                    </div>
                </div>

                <div class="ItemInfoBox_body">
                    <div style="width: 350px">
                        <abbr>სახელწოდება:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox TabIndex="0" ID="txt_editgoodsName" runat="server" Style="width: 313px; border: none" />
                            <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='პროდუქტის სრული სახელწოდება'" />
                        </div>
                    </div>
                    <div style="width: 150px">
                        <abbr>ერთეული:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            GE<asp:TextBox TabIndex="0" ID="txt_editgoodsUnit" runat="server" Style="width: 100px; border: none" />
                            <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='ცალი, ლიტრი ....'" />
                        </div>
                    </div>
                    <div style="width: 130px">
                        <abbr>ფასი:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox TabIndex="0" ID="txt_editgoodsPrice" runat="server" Style="width: 100px; border: none" />
                            <img alt="info" src="images/icons/information.ico" height="15" onmouseover="this.title='საქონლის საბითუმო ფასი'" />
                        </div>
                    </div>
                </div>

                <div class="ItemInfoBox_body">
                    <div style="width: 630px">
                        <abbr>დეტალები / აღწერილობა:</abbr><br />
                        <div style="background: #fff; border: 1px solid black;">
                            <asp:TextBox type="text" TabIndex="0" ID="txt_editgoodsDescription" runat="server" Style="border-style: none; border-color: inherit; border-width: medium; min-height: 100px; max-width: 630px" TextMode="MultiLine" Width="620px"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <br />
                <hr>
                <br />
                <div class="ItemInfoBox_body">
                    <asp:Button ID="btn_add_new_good" runat="server" Visible="false" CssClass="rsOKBtn" Text="ADD" OnClick="btn_add_new_good_Click" />
                    <asp:Button ID="btn_update_save" runat="server" CssClass="rsOKBtn" Text="OK" OnClick="btn_update_save_Click1" />
                    <asp:Button ID="btn_update_cancell" runat="server" CssClass="rsExtBtn" Text="Cancell" />
                </div>
                <br />
            </div>            
        </div>

    <cc1:ModalPopupExtender ID="edt_mod_popupextender" runat="server" TargetControlID="btn_edit_item" PopupControlID="pnl_edtitem" BackgroundCssClass="ModalBackground">
    </cc1:ModalPopupExtender>
    

    <div class="textbox">               
        <asp:TextBox ID="txt_wbid" runat="server" Visible="false"></asp:TextBox>
        <asp:TextBox ID="txt_tid" runat="server" Visible="false"></asp:TextBox>
        <asp:TextBox ID="tempsortxtx" runat="server" Visible="false"></asp:TextBox>

        <div id="Div_Products" runat="server" visible="false">
            <table style="border-collapse: collapse;" class="ge-en">
                <tfoot>
                    <div id="Div_Insert" runat="server" class="box-set" visible="false">
                        <figure class="box1">
                            <asp:TextBox ID="name" runat="server" CssClass="txt_serch" Width="300px"></asp:TextBox>
                            <asp:TextBox ID="unit" runat="server" CssClass="txt_serch" Width="80px" AutoPostBack="True"></asp:TextBox>
                            <asp:TextBox ID="code" runat="server" CssClass="txt_serch" Width="80px"></asp:TextBox>
                            <asp:TextBox ID="price" runat="server" CssClass="txt_serch" Width="80px"></asp:TextBox>
                        </figure>
                        <figure class="box2">
                            <asp:Button ID="Button1" runat="server" Text="add" CssClass="btn_edit" OnClick="add_to_db" />
                        </figure>
                    </div>
                </tfoot>

                <thead>
                    <tr style="max-width: 250px">
                        <td>
                            <div class="rsInputLang" style="width: 5px; height: 32px"><a id="lang2" style="text-decoration: none; font-size: larger; color: #fff;" onclick="change1();">EN</a></div>
                        </td>
                        <td>
                            <asp:TextBox ID="name_inputID" AutoPostBack="true" AutoCompleteType="Disabled" onkeyup="if (document.getElementById('lang2').innerHTML == 'ქა') { name_inputID.value=reg2uni(name_inputID.value); }" runat="server" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td>
                            <div style="width: 30px; cursor: pointer;">
                                <img id="Img_advanced" alt="Img_advanced" src="images/icons/adv_search.ico" width="32" title="დეტალური ძებნა" onclick="redirect_to_advsearch()" />
                            </div>
                        </td>
                    </tr>

                    <tr id="advance_search" style="display: none; max-width: 50px; border: none;">

                        <td colspan="2">
                            <asp:TextBox ID="txt_ItemName" runat="server" placeholder='დასახელება' onfocus="this.placeholder = ''" onblur="this.placeholder = 'დასახელება'" Style="border: solid 1.8px #7f7f7f; -moz-border-radius: 4px; -webkit-border-radius: 4px; width: 250px; height: 30px"></asp:TextBox>
                            <asp:TextBox ID="txt_CompatableWith" runat="server" placeholder='მანქანის მარკა ან მოდელი' onfocus="this.placeholder = ''" onblur="this.placeholder = 'მანქანის მარკა ან მოდელი'" Style="border: solid 1.8px #7f7f7f; -moz-border-radius: 4px; -webkit-border-radius: 4px; width: 250px; height: 30px"></asp:TextBox>
                            <asp:TextBox ID="txt_ProductPrice" runat="server" placeholder='ფასი' onfocus="this.placeholder = ''" onblur="this.placeholder = 'ფასი'" Style="border: solid 1.8px #7f7f7f; -moz-border-radius: 4px; -webkit-border-radius: 4px; width: 250px; height: 30px"></asp:TextBox>
                        </td>
                        <td>
                            <div style="width: 32px; height: 32px">
                                <asp:ImageButton ID="Img_advanced_srch" runat="server" ImageUrl="images/icons/1464133560_Search.ico" Width="32" Height="32" ToolTip="მოძებნა" OnClick="Img_advanced_srch_Click" />
                            </div>
                        </td>
                    </tr>
                </thead>

                <tbody>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="20" Width="95%" CssClass="gv">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" ItemStyle-CssClass="hide_column" HeaderStyle-CssClass="hide_column">
                                <HeaderStyle CssClass="hide_column"></HeaderStyle>

                                <ItemStyle CssClass="hide_column"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="description" HeaderText="description" ReadOnly="false" SortExpression="description" ItemStyle-CssClass="hide_column" HeaderStyle-CssClass="hide_column">
                                <HeaderStyle CssClass="hide_column"></HeaderStyle>

                                <ItemStyle CssClass="hide_column"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name">
                                <ControlStyle Width="350px" />
                                <ItemStyle Wrap="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="unit_name" HeaderText="unit_name" SortExpression="unit_name">
                                <ItemStyle Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="product_code" HeaderText="product_code" SortExpression="product_code">
                                <ItemStyle Width="30px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="price" SortExpression="price">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" OnClientClick="return GetSelectedRow(this)" OnClick="lnkSelect_Click">
                                        <asp:Image ID="Image1" runat="server" ImageUrl="images/icons/bl_gel.png" onmouseover="this.src='images/icons/1463187846_Add.ico'" onmouseout="this.src='images/icons/bl_gel.png'" Width="24" />
                                    </asp:LinkButton>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("price", "{0:0.00}") %>'></asp:Label></td>
                                </ItemTemplate>
                                <ItemStyle Width="80px" />
                            </asp:TemplateField>

                            <asp:CommandField ShowDeleteButton="True" ControlStyle-CssClass="rsButton">
                                <ControlStyle CssClass="rsButton"></ControlStyle>
                            </asp:CommandField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ImageButton ID="Advance_ImgBtn" runat="server" ImageUrl="~/images/icons/advanse_edit.ico" Height="24" ToolTip="დეტალური რედაქტირება" OnClick="Advance_ImgBtn_Click" />
                                    <asp:ImageButton ID="Replace_ImgBtn" runat="server" ImageUrl="~/images/icons/substitute_icon.ico" Height="24" ToolTip="შემცვლელის ნახვა" OnClick="Replace_ImgBtn_Click" OnClientClick="open_pleasewait()" />
                                </ItemTemplate>
                                <ItemStyle Width="55px" />
                            </asp:TemplateField>
                            <asp:ButtonField CommandName="Select" Text="_____" ControlStyle-CssClass="btn_Info" ControlStyle-Height="30" ItemStyle-Width="30" />
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
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>" SelectCommand="select Id, name,  unit_name, price, product_code, suppliers_code, description, comment from goods order by name,product_code"
                        UpdateCommand="UPDATE [goods] SET [name]= @name, [unit_name]= @unit_name, [product_code]= @product_code, [price]= @price WHERE [id] = @id;"
                        DeleteCommand="DELETE FROM [goods] WHERE [id] = @id" FilterExpression="product_code LIKE '%{0}%' OR suppliers_code LIKE '%{0}%' OR name LIKE '%{0}%' OR description LIKE '%{0}%' OR comment LIKE '%{0}%'">
                        <FilterParameters>
                            <asp:ControlParameter Name="product_code" ControlID="name_inputID" PropertyName="Text" />
                        </FilterParameters>
                    </asp:SqlDataSource>
                </tbody>
            </table>

            <asp:Button ID="btn_showreplacements" runat="server" Style="display: none;" />
            <asp:Panel ID="Panel_ShowReplacements" runat="server" CssClass="modalPopup" Height="500px" Style="overflow: auto; overflow-x: hidden;">
                <p>
                    <a href="#" id="btn_exit_replacement" runat="server" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
                </p>
                <asp:GridView ID="GRD_Replacement" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="rsGrid">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="ARL_ART_ID">
                            <ControlStyle CssClass="hide_column" />
                            <FooterStyle CssClass="hide_column" />
                            <HeaderStyle CssClass="hide_column" />
                            <ItemStyle CssClass="hide_column" />
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <table>
                                    <tbody class="rsGridContainer">
                                        <tr>
                                            <td class="">
                                                <asp:LinkButton ID="lbl_SUP_BRAND" runat="server" OnClick="lbl_SUP_BRAND_Click" Text='<%# Bind("SUP_BRAND") %>' ToolTip="პროდუქტის დეტალების სანახავად დააჭირეთ აქ"></asp:LinkButton>
                                            </td>
                                            <td class="">
                                                <asp:Label ID="lbl_ART_ARTICLE_NR" runat="server" Text='<%# Bind("ART_ARTICLE_NR") %>'></asp:Label>
                                            </td>
                                            <td class="">
                                                <asp:LinkButton ID="lbl_TEX_TEXT" runat="server" OnClick="lbl_TEX_TEXT_Click" Text='<%# Bind("TEX_TEXT") %>' ToolTip="რომელ ავტომობილს მიესადაგება"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ItemTemplate>
                            <ControlStyle Width="280" />
                            <FooterStyle Width="280" />
                            <HeaderStyle Width="280" />
                            <ItemStyle HorizontalAlign="Left" CssClass="rsGrid" />
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                </asp:GridView>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ShowReplacement_popupextender" runat="server" TargetControlID="btn_showreplacements" PopupControlID="Panel_ShowReplacements" CancelControlID="btn_exit_replacement" BackgroundCssClass="ModalBackground">
            </cc1:ModalPopupExtender>

            <asp:Button ID="btn_showusedin" runat="server" Style="display: none;" />
            <asp:Panel ID="Pnl_UsedInCars" runat="server" CssClass="modalPopup" Height="500px" Style="overflow: auto; overflow-x: hidden;">
                <p>
                    <a href="#" id="btn_exit_showusedin" runat="server" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
                </p>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="rsGrid">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="hide_column"></td>
                                            <td class="rsGridDataRow" style="text-align: left">
                                                <asp:Label ID="lbl_UsedInCars_Name" runat="server" Text='<%# Bind("TEX_TEXT") %>'></asp:Label>
                                            </td>
                                            <td class="hide_column"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ItemTemplate>
                            <ControlStyle Width="400" />
                            <FooterStyle Width="400" />
                            <HeaderStyle Width="400" />
                            <ItemStyle HorizontalAlign="Left" CssClass="rsGrid" />
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                </asp:GridView>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ShowUsedIn_popupextender" runat="server" TargetControlID="btn_showusedin" PopupControlID="Pnl_UsedInCars" CancelControlID="btn_exit_showusedin" BackgroundCssClass="ModalBackground">
            </cc1:ModalPopupExtender>

            <asp:Button ID="btn_showitemdetales" runat="server" Style="display: none;" />
            <asp:Panel ID="Pnl_ItemDetales" runat="server" CssClass="modalPopup" Height="500px" Style="overflow: auto; overflow-x: hidden;">
                <p>
                    <a href="#" id="btn_exit_showitemdetales" runat="server" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
                </p>

                <div class="clear-both" style="width: 90px; float: left">
                    <p>
                    </p>
                    <p>
                    </p>
                </div>
                <div id="sub-left" style="width: 450px; float: left; vertical-align: top">
                    <table>
                        <tr>
                            <th colspan="2" class="ui-header">
                                <asp:Label ID="lbl_Category" runat="server"></asp:Label>
                                -
                                <asp:Label ID="lbl_BrandName" runat="server"></asp:Label>
                            </th>
                        </tr>
                        <tr>
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="false" CellPadding="5" ForeColor="#333333" GridLines="None" CssClass="ui-grid-c" CellSpacing="5">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>

                                            <th>
                                                <asp:Label ID="lbl_TEX_TEXT" runat="server" Text='<%# Bind("TEX_TEXT") %>' Width="350px" Style="text-align: left"></asp:Label>
                                            </th>

                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <td>
                                                <asp:Label ID="lbl_ACR_VALUE" runat="server" Text='<%# Bind("ACR_VALUE") %>' Width="80px" Style="text-align: left"></asp:Label>
                                            </td>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#333333" />
                            </asp:GridView>
                        </tr>
                    </table>
                </div>

            </asp:Panel>
            <cc1:ModalPopupExtender ID="ShowItemDetales_popupextender" runat="server" TargetControlID="btn_showitemdetales" PopupControlID="Pnl_ItemDetales" CancelControlID="btn_exit_showitemdetales" BackgroundCssClass="ModalBackground">
            </cc1:ModalPopupExtender>

        </div>

        <div id="MainPanel" runat="server" visible="false">            

            <div class="gridTable">
                <table>
                    <tbody style="vertical-align: top;" class="panelback">
                        <tr>
                            <td rowspan="5" class="_01">
                                <asp:ListView ID="ListView5" runat="server" Visible="true">
                                    <ItemTemplate>
                                        <button class='two_btn_small' style="background: #0<%# Convert.ToInt32( Eval("contractor_id"))*4 %>859;" name="bt2" type="button" onclick="window.location='waybills.aspx';" title='<%#  Eval("name") %>'>
                                            <asp:LinkButton ID="Lnkbtn_CountOfSupply" runat="server" OnClick="Lnkbtn_CountOfSupply_Click" Text='<%#  Eval("t_price", "{0:n}") %>' ForeColor="White"></asp:LinkButton><br />
                                            <asp:LinkButton ID="LinkButton2" runat="server" Text='<%# String.Format("{0:n}", Convert.ToDouble(Eval("t_price")) - Convert.ToDouble( Eval("Sul"))) %>' ForeColor="White"></asp:LinkButton>
                                        </button>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>">
                                </asp:SqlDataSource>
                            </td>

                            <td class="_02">
                                <button class='two_btn_large' style="background: #d6dd2e;">
                                    <img src="images/icons/Cargo-Suppliers.ico" style="width: 24px; height: 24px;" title="მიწოდებულია სულ">
                                    <asp:LinkButton ID="Lnkbtn_SumOfSupply" runat="server" ToolTip="მიწოდებულია სულ"></asp:LinkButton><br />
                                    <img src="images/icons/Everaldo-Crystal-Clear-App-kcm-partitions.ico" style="width: 24px; height: 24px;" title="ასათვისებელი ნაშთი">
                                    <asp:LinkButton ID="Lnkbtn_RemOfSupply" runat="server" ToolTip="ასათვისებელი ნაშთი"></asp:LinkButton>
                                </button>
                                <br />

                            </td>

                            <td class="_02">
                                <button class='two_btn_large' style="background: #99BBE1" id="but01" name="bt1" type="button" onclick="window.location='?action=tenders#procurements';">
                                    <asp:Image ID="img010" runat="server" ImageUrl="Ribbon/images/procurement.png" />
                                    <asp:LinkButton ID="Lnkbtn_CountTenders" runat="server" OnClick="LinkButton2_Click"></asp:LinkButton>
                                    <br />
                                    <asp:LinkButton ID="Lnkbtn_SumOfTenders" runat="server" OnClick="LinkButton3_Click"></asp:LinkButton>
                                </button>
                            </td>
                        </tr>

                        <tr>
                            <td class="_02" colspan="3">
                                <asp:ListView ID="ListView2" runat="server" DataSourceID="DS_WayBills_List">
                                    <ItemTemplate>
                                        <button class='two_btn_small' style="background: #0<%# Convert.ToInt32( Eval("contractor_id"))*1+7 %>8<%# Convert.ToInt32( Eval("contractor_id"))*1+7 %>; width: 102px;">
                                            <asp:LinkButton ID="LinkButton3" runat="server" ToolTip='<%# string.Format("{0} - {1}: {2} ",  Eval("name"), "ვალი", Convert.ToDouble(Eval("jami")) - Convert.ToDouble(Eval("payd"))  ) %>' ForeColor="White"><%#  Eval("jami", "{0:0.00}") %>ლარი</asp:LinkButton><br />
                                        </button>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                    </EmptyDataTemplate>
                                </asp:ListView>
                                <asp:SqlDataSource ID="DS_WayBills_List" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                                    SelectCommand="select * 
                                                    into #t01
                                                    from
                                                    (select id as S_id, contractor_id, waybill_number, cost, paid from tenders_waybills) T1

                                                    inner join 
                                                    (select id, name, is_supplier from suppliers) T2
                                                    ON(T2.id = T1.contractor_id )
                                                    where cost is not null AND is_supplier = '-1'

                                                    select contractor_id, sum(cost) as jami
													into #t02
                                                    from #t01
                                                    group by contractor_id
													
													select contractor_id, sum(paid) as payd
													into #t03
                                                    from #t01
                                                    group by contractor_id

													select suppliers.id, suppliers.name, #t02.contractor_id as kl_id, #t02.jami, #t03.*
													from suppliers, #t02, #t03
													where #t02.contractor_id = #t03.contractor_id AND suppliers.id = #t02.contractor_id"></asp:SqlDataSource>
                            </td>

                        </tr>

                        <tr>
                            <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" Visible="false" />
                        </tr>

                        <tr>
                            <td class="_02" style="visibility: hidden;">
                                <button class="two_btn_small" style="background: #D24423;">
                                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="WhiteBox">Button</asp:LinkButton>
                                </button>
                                <button class='two_btn_small' style="background: #EDB912;">
                                    <asp:LinkButton ID="LinkButton5" runat="server" CssClass="WhiteBox">Button</asp:LinkButton>
                                </button>

                            </td>
                            <td class="_02" style="visibility: hidden;">
                                <button class="two_btn_small" style="background: #EDB912;">
                                    <asp:LinkButton ID="LinkButton8" runat="server" CssClass="WhiteBox">Button</asp:LinkButton>
                                </button>
                                <button class='two_btn_small' style="background: #EDB912;">
                                    <asp:LinkButton ID="LinkButton9" runat="server" CssClass="WhiteBox">Button</asp:LinkButton>
                                </button>

                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="procurement_list" runat="server">
            <table width="92%" cellpadding="3" cellspacing="5">
                <tr>
                    <td align="right"></td>
                    <td id="order_row" runat="server" align="right">დაალაგე:
                         <asp:CheckBox ID="myCheck1" runat="server" onclick="uncheck23()" AutoPostBack="true" Text="თარიღით" />
                        <asp:CheckBox ID="myCheck2" runat="server" onclick="uncheck13()" AutoPostBack="true" Text="ფასით" />
                        <asp:CheckBox ID="myCheck3" runat="server" onclick="uncheck12()" AutoPostBack="true" Text="მომწოდებლით" />
                    </td>
                </tr>
            </table>

            <asp:ListView ID="ListView01" runat="server" Visible="true" OnItemDataBound="ListView01_ItemDataBound">
                <ItemTemplate>
                    <div data-role='collapsible'>
                        <table width="92%" cellpadding="3" cellspacing="1" rules="rows">
                            <thead>
                                <tr>
                                    <th align="left">
                                        <h3 title="მომწოდებლის დასახელება"><%#  Eval("Sup_name") %></h3>
                                    </th>
                                    <td>
                                        <asp:ImageButton ID="del_box" runat="server" ImageUrl="~/Ribbon/images/icon_delate.png" Width="24" OnClick="del_box_Click" OnClientClick="javascript:if (confirm('ნამდვილად გნებავთ წაშლა?')) return true; else return false;" /></td>
                                </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <th align="left" style="width: 30%;">
                                        <label title='ტენდერის SPA ნომერი'><%#  Eval("tender_num") %></label></th>
                                    <td align="right" style="width: 70%;">
                                        <label title='ტენდერის კატეგორია'><%#  Eval("tender_category") %></label></td>
                                </tr>

                                <tr>
                                    <th align="left" style="width: 30%;">
                                        <asp:Label ID="l_tender_id" runat="server" CssClass="hide_column" Text='<%# Eval("t_id") %>'> </asp:Label>
                                        <a title='ტენდერის სახელშეკრულებო ღირებულება' href='?TenderID=<%# Eval("t_id") %>'>ტენდერის ფასი: </a>
                                    </th>
                                    <td align="right" style="width: 70%;"><a title='ტენდერის სახელშეკრულებო ღირებულება' href='?action=T_Items&job=<%# Eval("t_id") %>'>
                                        <asp:Label ID="l_tender_price" runat="server" Text='<%# Eval("tender_price", "{0:0.00}") %>'></asp:Label></a></td>
                                </tr>

                                <tr>
                                    <th align="left" style="width: 30%;"><a title='შემსყიდველის მიერ მოწოდებული პროდუქცია თანხით' href='?TenderID=<%# Eval("t_id") %>'>მიწოდებულია: </a>
                                        <td align="right" style="width: 70%;"><a id="a_sold_to" runat="server" title='შემსყიდველის მიერ მოწოდებული პროდუქცია თანხით' href='?TenderID=<%# Eval("t_id") %>'>
                                            <asp:Label ID="l_sold_to" runat="server"></asp:Label></a></td>
                                </tr>

                                <tr>
                                    <th align="left" style="width: 30%;"><a title='შესაძლო პროდუქციის შესყიდვა თანხით' href='?action=rem&job=<%# Eval("t_id") %>'>ნაშთი: </a>
                                        <td align="right" style="width: 70%;"><a title='შესაძლო პროდუქციის შესყიდვა თანხით' href='?action=rem&job=<%# Eval("t_id") %>'>
                                            <asp:Label ID="l_remained" runat="server"></asp:Label></a></td>
                                </tr>
                            </tbody>

                            <tfoot>
                                <tr>
                                    <th colspan="2">
                                        <h2>
                                            <label><%# Eval("tender_date", "{0:dd.MM.yyyy}") +" - "+ Eval("tender_ends", "{0:dd.MM.yyyy}") %></label>
                                            <asp:Label ID="lblTenderId" Text='<%#  Eval("t_id") %>' runat="server" Visible="false"></asp:Label></h2>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </ItemTemplate>
                <EmptyDataTemplate>
                </EmptyDataTemplate>
            </asp:ListView>

            <asp:SqlDataSource ID="SqlDataTendersList" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"></asp:SqlDataSource>
        </div>

        <div id="Procurements_Waybills" runat="server">
            <table width="92%" cellpadding="3" cellspacing="1" rules="rows">
                <thead>
                    <tr>
                        <th align="left" style="width: 40%;">
                            <h2 title="ზედნადების ნომერი">ზედნადების ნომერი</h2>
                        </th>
                        <th align="right" style="width: 30%;">
                            <h2 title="მოწოდების თარიღი">თარიღი</h2>
                        </th>
                        <th align="right" style="width: 30%;">
                            <h2 title="თანხა/ჯამი">თანხა</h2>
                        </th>
                    </tr>
                </thead>
                <asp:ListView ID="ListOfWaybills" runat="server" DataSourceID="SqlDataTendersWaybillsList" OnItemDataBound="ListOfWaybills_ItemDataBound" OnPreRender="ListOfWaybills_PreRender" ItemPlaceholderID="PlaceHolder001">
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <td align="left" style="width: 40%;">
                                    <label title='ზედნადების ნომერი'><%#  Eval("waybill_number") %></label></td>
                                <td align="right" style="width: 30%;">
                                    <label title='ზედნადების ჩაბარების თარიღი'><%#  Eval("waybill_date", "{0:dd.MM.yyyy}") %></label></td>
                                <td align="right" style="width: 30%;">
                                    <asp:LinkButton ID="LinkButton1" runat="server" ToolTip="ზედნადების ჯამური თანხა" OnClick="LinkButton1_Click">
                                        <asp:Label ID="lblTotl" runat="server" Text='<%#  Eval("cost", "{0:0.00}") %>'></asp:Label>
                                    </asp:LinkButton></td>
                                <asp:Label ID="lblWayId" Text='<%#  Eval("id") %>' runat="server" Visible="false"></asp:Label>
                                <asp:Label ID="lblTenderId" Text='<%#  Eval("tender_id") %>' runat="server" Visible="false"></asp:Label>
                            </tr>
                        </tbody>
                    </ItemTemplate>

                    <LayoutTemplate>
                        <asp:PlaceHolder ID="PlaceHolder001" runat="server" />
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                                <td style="text-align: right; font-weight: bolder;">სულ:
                                    <asp:Label ID="lblTotal" runat="server" /></td>
                            </tr>
                        </tfoot>

                    </LayoutTemplate>

                    <EmptyDataTemplate>
                    </EmptyDataTemplate>
                </asp:ListView>
            </table>

            <asp:SqlDataSource ID="SqlDataTendersWaybillsList" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                SelectCommand="select * from tenders_waybills where tender_id is not null and expense_type = '-1'"></asp:SqlDataSource>

        </div>

        <div id="Procurements_Items" runat="server">
            <div>
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/icons/writing_file.ico" Width="48" OnClick="ImageButton1_Click" />
            </div>
            <table width="92%" cellpadding="4" cellspacing="1" rules="rows">
                <thead>
                    <tr>
                        <th align="left" style="width: 40%;">
                            <h2 title="ტენდერის საქონლის სახელწოდება">დასახელება</h2>
                        </th>
                        <th align="right" style="width: 20%;">
                            <h2 title="საქონლის რაოდენობა">რაოდ.</h2>
                        </th>
                        <th align="right" style="width: 20%;">
                            <h2 title="საქონლის ფასი">ფასი</h2>
                        </th>
                        <th align="right" style="width: 20%;">
                            <h2 title="სულ: ჯამი">ჯამი</h2>
                        </th>
                    </tr>
                </thead>

                <asp:ListView ID="ListOf_TendersItems" runat="server" DataSourceID="SqlDataTendersItems" OnItemDataBound="ListOf_TendersItems_ItemDataBound" OnPreRender="ListOf_TendersItems_PreRender" Visible="true " ItemPlaceholderID="PlaceHolder002">
                    <ItemTemplate>
                        <tbody>
                            <tr>
                                <td align="left" style="width: 40%;">
                                    <label title='ტენდერის საქონლის სახელწოდება'><%#  Eval("name") %></label></td>
                                <td align="right" style="width: 20%;">
                                    <label title='საქონლის რაოდენობა'><%#  Eval("quantity", "{0:0.00}") %></label></td>
                                <td align="right" style="width: 20%;">
                                    <label title='საქონლის ფასი'><%#  Eval("price", "{0:0.00}") %></label></td>
                                <td align="right" style="width: 20%;">
                                    <asp:Label ID="lblTotl2" runat="server" Text='<%#  Convert.ToDouble(Eval("quantity"))* Convert.ToDouble(Eval("price")) %>'></asp:Label></td>
                            </tr>
                        </tbody>
                    </ItemTemplate>

                    <LayoutTemplate>
                        <asp:PlaceHolder ID="PlaceHolder002" runat="server" />
                        <tfoot>
                            <tr>
                                <td colspan="4" style="text-align: right; font-weight: bolder;">სულ:<asp:Label ID="lblTotal2" runat="server" />
                                </td>
                            </tr>
                        </tfoot>
                    </LayoutTemplate>

                    <EmptyDataTemplate>
                    </EmptyDataTemplate>
                </asp:ListView>
            </table>
            <asp:SqlDataSource ID="SqlDataTendersItems" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                SelectCommand="SELECT *
                                FROM
                                (select Id as gId, name from goods) T1
                               INNER JOIN
                                (select tenders_items.*, tenders_waybills.id as wbId, tenders_waybills.tender_id, tenders_waybills.expense_type, tenders_waybills.cost from tenders_items, tenders_waybills where expense_type is null and cost is null and tenders_items.waybill_id = tenders_waybills.id) T2
                               ON(T1.gId = T2.goods_id)"></asp:SqlDataSource>
        </div>

        <div id="Procurements_ItemsLeft" runat="server">            
            <table width="92%" cellpadding="4" cellspacing="1" rules="rows">
                <thead>
                    <tr>
                        <th align="left" style="width: 60%;">
                            <h2 title="ტენდერის საქონლის სახელწოდება">დასახელება</h2>
                        </th>
                        <th align="right" style="width: 40%;">
                            <h2 title="საქონლის რაოდენობა">ნაშთი.</h2>
                        </th>                       
                    </tr>
                </thead>

                <asp:ListView ID="ListView3" runat="server" DataSourceID="SqlDataTendersItemsLeft" Visible="true">
                    <ItemTemplate>
                        
                        <tbody>
                            <tr>
                                <td align="left" style="width: 60%;">
                                    <label title='ტენდერის საქონლის სახელწოდება'><%#  Eval("name") %></label></td>
                                <td align="right" style="width: 40%;">
                                    <label title='ასათვისებელი საქონლის რაოდენობა'><%#  Eval("remained", "{0:0.00}")  %></label></td>                                
                            </tr>
                        </tbody>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                    </EmptyDataTemplate>
                </asp:ListView>
            </table>
            <asp:SqlDataSource ID="SqlDataTendersItemsLeft" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"></asp:SqlDataSource>
        </div>

    </div>  
         
</asp:Content>
