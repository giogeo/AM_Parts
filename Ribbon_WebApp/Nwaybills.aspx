<%@ Page Title="დაამატე ზედნადები" Language="C#" MasterPageFile="~/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Nwaybills.aspx.cs" Inherits="Ribbon_WebApp.WebForm1" %>
<%@ MasterType VirtualPath="~/Site1.Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="SlimeeLibrary" Namespace="SlimeeLibrary" TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">
    <script type="text/javascript">

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

        function sp2uni(text) {
            for (var i = 0; i < text.length; i++) {
                if (sp.indexOf(text.charAt(i), 0) >= 0) {
                    text = text.substring(0, i) + uni.charAt(sp.indexOf(text.charAt(i))) + text.substring(i + 1, text.length);
                }
            }
            return text;
        }

        function uni2reg(text) {
            for (var i = 0; i < text.length; i++) {
                if (uni.indexOf(text.charAt(i), 0) >= 0) {
                    text = text.substring(0, i) + reg.charAt(uni.indexOf(text.charAt(i))) + text.substring(i + 1, text.length);
                }
            }
            return text;
        }

        function reg2sp(text) {
            for (var i = 0; i < text.length; i++) {
                if (reg.indexOf(text.charAt(i), 0) >= 0) {
                    text = text.substring(0, i) + sp.charAt(reg.indexOf(text.charAt(i))) + text.substring(i + 1, text.length);
                }
            }
            return text;
        }

        function change1() {
            var txt = document.getElementById('rsInputLang').innerHTML;
            // document.getElementById('lang2').innerHTML='EN';
            if (txt == 'EN') {
                document.getElementById('rsInputLang').innerHTML = 'ქა';
            } else {
                document.getElementById('rsInputLang').innerHTML = 'EN';
            }
        }

        function change2() {
            var txt = document.getElementById('rsInputLang2').innerHTML;
            // document.getElementById('lang2').innerHTML='EN';
            if (txt == 'EN') {
                document.getElementById('rsInputLang2').innerHTML = 'ქა';
            } else {
                document.getElementById('rsInputLang2').innerHTML = 'EN';
            }
        }

        function changeId() {
            document.getElementsByName("BuyerId_inputId")[0].setAttribute("id", "Contractor_inputId");
        }

        function Chk_Textboxes() {
            var x = document.getElementsByTagName("input");

            for (i = 0; i < x.length; i++) {
                var y = document.getElementsByTagName("input")[i].value;

                if (y.length < 1) {
                    document.getElementsByTagName("input")[i].setAttribute("class", "Red_col");
                }
            }
        }

        function good_totalPrice() {
            var txtFirstNumberValue = document.getElementById('good_quantity_input').value;
            var txtSecondNumberValue = document.getElementById('good_unitPrice_input').value;
            var result = parseFloat(txtFirstNumberValue) * parseFloat(txtSecondNumberValue);
            if (!isNaN(result)) {
                document.getElementById('good_totalPrice_input').value = result;
            }
        }

        function uncheck1() {
            document.getElementById("<%= Chk_waybill.ClientID %>").checked = false;
            document.getElementById("<%= Chk_tender.ClientID %>").checked = true;
            document.getElementById("<%= Confirm_Chk_tender_Value.ClientID %>").value = "true";
            document.getElementById("<%= Confirm_Chk_waybill_Value.ClientID %>").value = "false";

            if (document.getElementById("<%= Chk_tender.ClientID %>").checked) {
                document.getElementById("sectionTenders").style.visibility = "visible";

            } else {
                document.getElementById("sectionWayBills").style.visibility = "hidden";
            }

            document.getElementById("sectionTenders").style.display = "block";
            document.getElementById("sectionWayBills").style.display = "none";
        }

        function uncheck2() {
            document.getElementById("<%= Chk_tender.ClientID %>").checked = false;
            document.getElementById("<%= Chk_waybill.ClientID %>").checked = true;
            document.getElementById("<%= Confirm_Chk_waybill_Value.ClientID %>").value = "true";
            document.getElementById("<%= Confirm_Chk_tender_Value.ClientID %>").value = "false";

            if (document.getElementById("<%= Chk_waybill.ClientID %>").checked) {
                document.getElementById("sectionTenders").style.visibility = "hidden";
            } else {
                document.getElementById("sectionWayBills").style.visibility = "visible";
            }

            document.getElementById("sectionWayBills").style.display = "block";
            document.getElementById("sectionTenders").style.display = "none";
        }

        function validate() {
            var tndr_box = document.getElementById('<%= TenderId_inputId.ClientID %>');

            if (document.getElementById('<%= chk_ShowTender.ClientID %>').checked) {
                tndr_box.style.display = "block";

            } else {
                tndr_box.style.display = "none";

            }
        }

        function txt_changed(ctrl) {
            if (ctrl != null && ctrl.value != null && ctrl.value.length >= 2) {
                __doPostBack(ctrl.id, '');
            } setTimeout(txt_changed(ctrl), 10);
        }

        function do_Post_Back() {
            __doPostBack("Obj", '');
        }

        function filtr_name_changed() {
            setTimeout('do_Post_Back()', 5500)
        }

        function test_99() {
            var txt_search_value = document.getElementById('autocomplite_good_name').value;
            document.getElementById('good_name_inputId').value = txt_search_value;

            var txt_res = document.getElementById('good_name_inputId').value;
            alert(txt_search_value);
        }

    </script>

    <style type="text/css">
        .mrg20 {
            padding-left: 10px;
        }
        .modalBackground {
            background-color: #CCCCFF;
            filter: alpha(opacity=50);
            opacity: 0.5;
        }

        .ModalWindow {
            border: solid 1px#c0c0c0;
            background: #f0f0f0;
            padding: 0px 10px 10px 10px;
            position: absolute;
            top: -1000px;
        }

        #header-div {
            position: fixed !important;
            top: 1%0 !important;
            width: 100%;           
            text-transform: capitalize;
        }

        #main-div {
            height: 81vh;
            top: 1%0 !important;
            display: flex;
        }

        .panel-one {
            margin-top: 70px;
            margin-left: 2px;            
            flex: 1 1 auto;
            border: solid 2px WindowText;
        }      

        .wb_info_title p {
            vertical-align: middle;
            text-align: center;                        
        }

        .sectionFields div {
            flex: 1 1 auto;
            float: left;
            padding-left: 2px;
            margin-left: 2px;
            max-width: 205px;
            margin-bottom: 15px;  
            font-size: 12px;          
        }

        .sectionFields .roundbox {           
            table-layout: fixed;            
            box-sizing: border-box !important;
            border-radius: 4px;
            border-collapse: separate;
            border-spacing: 0;
            border: 2px solid  #bebef7;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            text-align: left;
            width: 100%;
            max-width: 170px;
        }       

        .sectionFields > table, tbody, tr, td, input, option, select {
            padding: 1px 1px;
            border: none;
            outline: none;
            background: none;
            font-weight: bold;
            padding-left: 0; 
            max-width: 150px;           
        }

        .lock  {
            width: 15px;
        }

        .panel-two {
            margin-top: 70px;
            margin-left: 2px;            
            flex: 1 1 auto;
            border: solid 2px WindowText;
        }

        #rsGrid_grdWaybillGoods table, caption, tbody, tfoot, thead, tr, th, td {
            margin: 0;
            padding: 0;
            border: 1px;
            font-size: 100%;
            font: inherit;
            vertical-align: top;
        }

        #rsGrid_grdWaybillGoods table {            
            border-spacing: 0;
        }

        .hasDatepicker div {            
            z-index: 9999;            
            margin-top: -210px;
            margin-left: 75px;
            max-width: 250px;
        }

        .content_menu_item .ppw {
            background-image: url("images/icons/home-grn.png");
            background-repeat: no-repeat;
            background-size: 100% 100%;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .content_menu_item .waybillsTable {
            background-image: url("images/rs_ge.jpg");
            background-repeat: no-repeat;
            background-size: 100% 100%;
            border: 1px solid #BBBBBB; 
            border-radius: 5px 5px 5px 5px; 
            vertical-align:central;            
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .content_menu_item .tendersTable {
            background-image: url("Ribbon/images/procurement.png");
            background-repeat: no-repeat;
            background-size: 100% 100%;
            border: 1px solid #BBBBBB; 
            border-radius: 5px 5px 5px 5px; 
            vertical-align:central;            
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .content_menu_item td {
            visibility: hidden;
        }

        .header-control {
            height: 28px;
        }

        .header-control img {
            height: 28px;
        }

        
    </style>
    <link href="scripts/css/style_00.css" rel="Stylesheet" type="text/css" />    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <div id="qw" runat="server"  >
        <div id="table_2_0">
            <div class="content_menu" style="height: 76.5vh">
                <div class="content_menu_item">
                   <table class="ppw">
                       <tr>
                           <td></td>
                       </tr>
                   </table>
                </div>  
                
                <div class="content_menu_item">
                    <table class="tendersTable" onclick="uncheck1();">
                        <tbody>
                            <tr>
                                <td>
                                    <label ></label>
                                </td>
                                <td>
                                    <input type="checkbox" ID="Chk_tender" runat="server" ClientIDMode="Static" />
                                </td>
                                <td>
                                    <asp:HiddenField runat="server" ID="Confirm_Chk_tender_Value" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="content_menu_item">
                    <table class="waybillsTable" onclick="uncheck2();">
                        <tbody>
                            <tr>
                                <td>
                                    <label></label>
                                </td>
                                <td>
                                    <input type="checkbox" ID="Chk_waybill" ClientIDMode="Static" runat="server" />
                                </td>
                                <td>
                                    <asp:HiddenField runat="server" ID="Confirm_Chk_waybill_Value" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>  
                
                <div class="content_menu_item">
                    <div id="add_grid_list" style="visibility: visible;">
                        <asp:ImageButton ID="lnkPopup" runat="server" ImageUrl="~/images/icons/add_grid.ico" style="border: 1px solid #BBBBBB; width: 100%; height: 100%; border-radius: 5px 5px 5px 5px; vertical-align:central" />
                    </div>
                </div>              
            </div>

            <div class="content_inner">

                <div class="tag_menu sectionTitle">
                    <span>ძირითადი ინფორმაცია</span>
                </div>                

                <div ID="sectionTenders" runat="server" ClientIDMode="Static" class="section" style="display: none;">
                    <div class="sectionFields">
                        <div>
                            <p class="wb_info_title">ტენდერის № (SPA/CMR) </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <input type="text" id="TenderNumber_inputID" runat="server" name="TenderNumber_inputName" style="width: 160px; text-align: left" /></td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div>
                            <p class="wb_info_title">ტენდერის თარიღი (დან) </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <cc2:DatePicker ID="TenderDateFrom" runat="server" Width="145px" SelectedStyle-HorizontalAlign="Left" FirstDayOfWeek="Monday" Height="18px" PaneWidth="300px" Font-Bold="True" CalendarTableStyle-HorizontalAlign="Left"></cc2:DatePicker>
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div style="margin-left: 25px;">
                            <p class="wb_info_title">ტენდერის თარიღი (მდე) </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <cc2:DatePicker ID="TenderDateTo" runat="server" Width="145px" SelectedStyle-HorizontalAlign="Left" FirstDayOfWeek="Monday" Height="18px" PaneWidth="300px" Font-Bold="True" CalendarTableStyle-HorizontalAlign="Left" CssClass="hasDatepicker"></cc2:DatePicker>
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div style="margin-left: 25px;">
                            <p class="wb_info_title">ტენდერის კატეგორია </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <input type="text" id="TenderCategory_inputId" runat="server" name="TenderCategory_inputName" /></td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div>
                            <p class="wb_info_title">შემსყიდველი </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <asp:DropDownList ID="Contractor_inputId" runat="server" name="Contractor_inputName" Width="165px">
                                                <asp:ListItem Selected="True" Value="">აირჩიეთ</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>                

                <div ID="sectionWayBills" runat="server" ClientIDMode="Static" class="section" style="display: none;">
                    <div class="sectionFields">
                        <div id="WaybillNumber">
                            <p class="wb_info_title">ზედნადების № </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <input type="text" tabindex="0" id="WaybillNumber_inputID" runat="server" name="WaybillNumber_inputName" style="text-align: left" onclick="this.value = ''" /></td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="InvoiceID">
                            <p class="wb_info_title">ზედნადების ტიპი</p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <asp:DropDownList ID="WaybillType_inputID" TabIndex="0" runat="server" Style="text-align: center">
                                                <asp:ListItem Selected="True" Value="">აირჩიეთ</asp:ListItem>
                                                <asp:ListItem Value="1">ყიდვა</asp:ListItem>
                                                <asp:ListItem Value="-1">გაყიდვა მაღაზიიდან</asp:ListItem>
                                                <asp:ListItem Value="-1">მიწოდება (ტენდერი)</asp:ListItem>
                                            </asp:DropDownList></td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="TenderNumber">
                            <p class="wb_info_title">ტენდერი?</p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock">
                                            <input type="checkbox" tabindex="0" ID="chk_ShowTender" runat="server" ClientIDMode="Static" name="ShowTender" onclick="validate();" /></td>
                                        <td>
                                            <asp:DropDownList ID="TenderId_inputId" TabIndex="0" runat="server" AutoPostBack="true" name="TenderId_inputName" Width="165px" ClientIDMode="Static" Style="display: none">
                                                <asp:ListItem Selected="True" Value="">ტენდერის N°.</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="WaybillDate">
                            <p class="wb_info_title">გააქტიურების თარიღი </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <cc2:DatePicker ID="WaybillDate_inputID" TabIndex="0" runat="server" FirstDayOfWeek="Monday" Height="18px" PaneWidth="300px" Font-Bold="True" AlternateMonthStyle-BackColor="YellowGreen" class="hasDatepicker"></cc2:DatePicker>
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="ClientName" style="margin-left: 25px;">
                            <p class="wb_info_title">მყიდველი / გამყიდველი </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <asp:DropDownList ID="BuyerId_inputId" runat="server" name="Buyer_inputName">
                                                <asp:ListItem Selected="True" Value="">აირჩიეთ</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="PayType">
                            <p class="wb_info_title">გადახდის მეთოდი </p>
                            <table class="roundbox">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <asp:DropDownList ID="Pay_Method_InputId" runat="server">
                                                <asp:ListItem Selected="True" Value="0">სალარო / ბანკი</asp:ListItem>
                                                <asp:ListItem Value="1">ნაღდი (სალაროში)</asp:ListItem>
                                                <asp:ListItem Value="2">უნაღდო (ბანკში)</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div id="PayedAmount">
                            <p class="wb_info_title">გადახდილია</p>
                            <table class="roundbox" style="max-width: 83px;">
                                <tbody>
                                    <tr>
                                        <td class="lock"></td>
                                        <td>
                                            <asp:TextBox ID="txt_paid" runat="server" Text="0" />                                            
                                        </td>
                                        <td class="lock"></td>
                                    </tr>
                                </tbody>
                            </table>                            
                        </div>

                    </div>
                </div>

                <div class="dataTables_scroll">
                    <div class="dataTables_scrollBody" style="position: relative; overflow: auto; width: 100%; height: 62vh">

                        <div id="out_waybills" runat="server">
                            <asp:GridView ID="GridView2" runat="server" ClientIDMode="Static" OnRowDataBound="GridView2_RowDataBound" 
                                AutoGenerateColumns="False" CellPadding="3"
                                ShowHeaderWhenEmpty="True" ShowFooter="true"
                                BackColor="WhiteSmoke" AlternatingRowStyle-BackColor="Silver"
                                HeaderStyle-Font-Size="Medium" AllowSorting="True"
                                Style="width: 100%; word-wrap: break-word; table-layout: fixed;">
                                <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="mrg20">
                                        <HeaderTemplate>
                                            <table id="waybill_table" role="grid" style="width: 100%;">
                                                <thead class="odd">
                                                    <tr role="row">
                                                        <th>№</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="odd">
                                                    <tr role="row">
                                                        <td class="header-control">
                                                            <asp:TextBox ID="good_Id_txt" runat="server" Width="20" ReadOnly="true" />
                                                        </td>
                                                    </tr>
                                                </tbody>

                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_GridNum" runat="server" Text='<%# Bind("GridNum") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Height="40px" Width="40px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="mrg20">
                                        <HeaderTemplate>
                                            <table id="waybill_table" role="grid" style="width: 100%">
                                                <thead class="odd">
                                                    <tr role="row">
                                                        <th>საქონლის კოდი</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="odd">
                                                    <tr role="row">
                                                        <td class="header-control">
                                                            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                                                                TargetControlID="good_bar_code_input"
                                                                UseContextKey="true"
                                                                CompletionInterval="500"
                                                                ServiceMethod="GetCompletionList"
                                                                MinimumPrefixLength="4"
                                                                CompletionListCssClass="autoCompleteList"
                                                                CompletionListItemCssClass="autoCompleteListItem"
                                                                CompletionListHighlightedItemCssClass="autoCompleteSelectedListItem">
                                                            </ajaxToolkit:AutoCompleteExtender>
                                                            <asp:TextBox ID="good_bar_code_input" runat="server" ClientIDMode="Static" OnTextChanged="good_name_inputId_TextChanged" CssClass="calendar-input" Width="100%" autocomplete="off" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ItemCode" runat="server" ClientIDMode="Static" Text='<%# Bind("ItemCode") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Height="40px" Width="130px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="mrg20">
                                        <HeaderTemplate>
                                            <table id="waybill_table" role="grid" style="width: 100%;">
                                                <thead class="odd">
                                                    <tr role="row">
                                                        <th>სახელწოდება</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="odd">
                                                    <tr role="row">
                                                        <td class="header-control">
                                                            <asp:TextBox ID="good_name_input" runat="server" ClientIDMode="Static" CssClass="calendar-input" autocomplete="off" Width="100%" />
                                                        </td>
                                                    </tr>
                                                </tbody>

                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ItemName" runat="server" ClientIDMode="Static" Text='<%# Bind("ItemName") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="mrg20">
                                        <HeaderTemplate>
                                            <table id="waybill_table" role="grid" style="width: 100%;">
                                                <thead class="odd">
                                                    <tr role="row">
                                                        <th>განზომილება</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="odd">
                                                    <tr role="row">
                                                        <td class="header-control">
                                                            <input id="good_unit_selectedValueId" runat="server" type="text" list="good_unit_List" clientidmode="Static" size="10" cssclass="calendar-input" />
                                                            <datalist id="good_unit_List" runat="server">
                                                                <option value="ცალი"></option>
                                                                <option value="ლიტრი"></option>
                                                                <option value="კომპლ."></option>
                                                                <option value="გრამი"></option>
                                                                <option value="ტონა"></option>
                                                                <option value="სანტიმეტრი"></option>
                                                                <option value="მეტრი"></option>
                                                                <option value="კილომეტრი"></option>
                                                                <option value="კვ.სმ"></option>
                                                                <option value="კვ.მ"></option>
                                                                <option value="მ³"></option>
                                                                <option value="მილილიტრი"></option>
                                                                <option value="კგ"></option>
                                                                <option value="შეკვრა"></option>
                                                            </datalist>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ItemUnit" runat="server" ClientIDMode="Static" Text='<%# Bind("ItemUnit") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Height="40px" Width="120px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="mrg20">
                                        <HeaderTemplate>
                                            <table id="waybill_table" role="grid" style="width: 100%;">
                                                <thead class="odd">
                                                    <tr role="row">
                                                        <th>რაოდენობა</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="odd">
                                                    <tr role="row">
                                                        <td class="header-control">
                                                            <asp:TextBox ID="good_quantity_input" runat="server" ClientIDMode="Static" CssClass="calendar-input" onkeyup="good_totalPrice();" autocomplete="off" Width="100%" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ItemQty" runat="server" ClientIDMode="Static" Text='<%# Bind("ItemQty") %>' />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_totalItems" runat="server" ReadOnly="true" />
                                        </FooterTemplate>
                                        <HeaderStyle Height="40px" Width="90px" />
                                        <FooterStyle Height="40px" Width="90px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="mrg20">
                                        <HeaderTemplate>
                                            <table id="waybill_table" role="grid" style="width: 100%;">
                                                <thead class="odd">
                                                    <tr role="row">
                                                        <th>ერთ. ფასი</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="odd">
                                                    <tr role="row">
                                                        <td class="header-control">
                                                            <asp:TextBox ID="good_unitPrice_input" runat="server" ClientIDMode="Static" CssClass="calendar-input" onclick="this.value = ''" autocomplete="off" onkeyup="good_totalPrice();" Width="100%" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ItemPrice" runat="server" ClientIDMode="Static" Text='<%# Bind("ItemPrice") %>' />
                                        </ItemTemplate>
                                        
                                        <HeaderStyle Height="40px" Width="90px" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="mrg20" FooterStyle-CssClass="mrg20">
                                        <HeaderTemplate>
                                            <table id="waybill_table" role="grid" style="width: 100%">
                                                <thead class="odd">
                                                    <tr role="row">
                                                        <th>ჯამი</th>
                                                        <th>ოპერაცია</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="odd">
                                                    <tr role="row">
                                                        <td class="header-control">
                                                            <asp:TextBox ID="good_totalPrice_input" runat="server" ClientIDMode="Static" Width="45" />
                                                        </td>
                                                        <td class="header-control">
                                                            <asp:ImageButton ID="InsertToWaybill" runat="server" OnClick="AddRow_Command_Click" Height="28px" ImageUrl="https://cdn0.iconfinder.com/data/icons/bold-purple-free-samples/32/Import_Circle_File_Downloaded_Download-32.png" ToolTip="ზედნადებში ჩამატება" />
                                                            <asp:ImageButton ID="SaveWaybill" runat="server" OnClick="SaveWaybill_Click" Height="28px" ImageUrl="https://cdn3.iconfinder.com/data/icons/social-media-2125/80/view-32.png" />
                                                            <asp:LinkButton ID="Button2" runat="server" OnClick="Button2_Click" Style="text-decoration: none; text-align: center; cursor: pointer;">
                                                                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/icons/1484933561_Save.ico" />
                                                            </asp:LinkButton>                                                            
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ItemTotalPrice" runat="server" ClientIDMode="Static" Text='<%# Bind("ItemTotalPrice") %>' />
                                            <asp:HiddenField ID="HiddenField_GoodId" runat="server" Value='<%# Bind("GoodId") %>' />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txt_SumOfWaybill" runat="server" ReadOnly="true"></asp:TextBox>
                                        </FooterTemplate>
                                        <HeaderStyle Height="40px" Width="200px" />
                                        <FooterStyle Height="40px" Width="200px" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle Font-Size="Medium" Height="100%" />
                                <AlternatingRowStyle BackColor="Silver" />
                            </asp:GridView>
                        </div>

                        <script>
                            // Get the input box
                            var txt_products_code = document.getElementById('good_bar_code_input');
                            var txt_products_name = document.getElementById('good_name_input');
                            // Init a timeout variable to be used below
                            var timeout = null;

                            // Listen for keystroke events
                            txt_products_code.onchange = function (e) {

                                // Clear the timeout if it has already been set.
                                // This will prevent the previous task from executing
                                // if it has been less than <MILLISECONDS>
                                clearTimeout(timeout);

                                // Make a new timeout set to go off in 800ms
                                timeout = setTimeout(function () {
                                    doneTyping();
                                }, 1500);
                            };
                            txt_products_name.onchange = function (e) {

                                // Clear the timeout if it has already been set.
                                // This will prevent the previous task from executing
                                // if it has been less than <MILLISECONDS>
                                clearTimeout(timeout);

                                // Make a new timeout set to go off in 800ms
                                timeout = setTimeout(function () {
                                    doneTyping();
                                }, 1500);
                            };

                            //user is "finished typing," do something
                            //form1.submit();
                            function doneTyping() {
                                __doPostBack('txt_waybillsnum', '')
                            }
                        </script>

                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <asp:GridView ID="GridView1" runat="server" Visible="false" ForeColor="#333333" GridLines="None" ShowFooter="True" CssClass="" AutoGenerateColumns="False">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lbl_GridNum" runat="server" Text='<%# Bind("GridNum") %>' Width="58px"></asp:Label>
                            </ItemTemplate>
                            <ControlStyle Width="58px" />
                            <FooterStyle Width="58px" />
                            <HeaderStyle Width="58px" />
                            <ItemStyle HorizontalAlign="Left" Width="58px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:TextBox ID="lbl_ItemCode" runat="server" Text='<%# Bind("ItemCode") %>' Width="90px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                            </ItemTemplate>
                            <ControlStyle Width="90px" />
                            <FooterStyle Width="90px" />
                            <HeaderStyle Width="90px" />
                            <ItemStyle HorizontalAlign="Left" Width="90px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:TextBox ID="lbl_ItemName" runat="server" Text='<%# Bind("ItemName") %>' Width="374px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                            </ItemTemplate>
                            <ControlStyle Width="374px" />
                            <FooterStyle Width="374px" />
                            <HeaderStyle Width="374px" />
                            <ItemStyle HorizontalAlign="Left" Width="374px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:TextBox ID="lbl_ItemUnit" runat="server" Text='<%# Bind("ItemUnit") %>' Width="98px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                            </ItemTemplate>
                            <ControlStyle Width="98px" />
                            <FooterStyle Width="98px" />
                            <HeaderStyle Width="98px" />
                            <ItemStyle HorizontalAlign="Left" Width="98px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            
                            <ItemTemplate>
                                <asp:TextBox ID="lbl_ItemQty" runat="server" Text='<%# Bind("ItemQty") %>' Width="75px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                            </ItemTemplate>
                            <ControlStyle Width="70px" />
                            <FooterStyle Width="70px" />
                            <HeaderStyle Width="70px" />
                            <ItemStyle HorizontalAlign="Left" Width="70px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:TextBox ID="lbl_ItemPrice" runat="server" Text='<%# Bind("ItemPrice") %>' Width="58px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                            </ItemTemplate>
                            <ControlStyle Width="58px" />
                            <FooterStyle Width="58px" />
                            <HeaderStyle Width="58px" />
                            <ItemStyle HorizontalAlign="Left" Width="58px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            
                            <ItemTemplate>
                                <asp:TextBox ID="lbl_ItemTotalPrice" runat="server" Text='<%# Bind("ItemTotalPrice") %>' Width="87px" ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                            </ItemTemplate>
                            <ControlStyle Width="87px" />
                            <FooterStyle Width="87px" />
                            <HeaderStyle Width="87px" />
                            <ItemStyle HorizontalAlign="Left" Width="87px" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                            </ItemTemplate>
                            <ControlStyle Width="60px" />
                            <FooterStyle Width="60px" />
                            <HeaderStyle Width="60px" />
                            <ItemStyle HorizontalAlign="Left" Width="60px" />
                        </asp:TemplateField>

                    </Columns>
                    <FooterStyle BackColor="ActiveCaption" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" VerticalAlign="Top" />
                </asp:GridView>
    
    <ajaxToolkit:ModalPopupExtender ID="ModalPopup_Grid" runat="server"
                    TargetControlID="lnkPopup" PopupControlID="panEdit"
                    BackgroundCssClass="modalBackground"
                    PopupDragHandleControlID="panEdit">
                </ajaxToolkit:ModalPopupExtender>
    
    <asp:Panel ID="panEdit" runat="server" Height="560px" CssClass="ModalWindow" Style="width: 60vw">
        <div id="HeadInModal" style="padding-top: 0px; max-height: 552px;">
            <table style="width: 100%">
                <tr>
                    <td class=" gridRow rsGridInput" style="width: 19px">
                        <asp:TextBox ID="TextBox1" runat="server" Width="19" ReadOnly="true" />

                    </td>
                    <td class="gridRow rsGridInput" style="width: 28px">
                        <asp:TextBox ID="TextBox2" runat="server" Width="28" ReadOnly="true" />

                    </td>
                    <td class="gridRow rsGridInput" style="width: 74px">
                        <asp:TextBox ID="filtr_code" runat="server" ClientIDMode="Static" OnTextChanged="filtr_code_TextChanged" AutoComplete="off" Width="74" />

                    </td>
                    <td class="gridRow rsGridInput" style="min-width: 279px">
                        <asp:TextBox ID="filtr_name" runat="server" ClientIDMode="Static" OnTextChanged="filtr_name_TextChanged" AutoComplete="off" Width="279" />

                    </td>
                    <td class="gridRow rsGridInput" style="width: 69px">
                        <asp:TextBox ID="filter_brand" runat="server" ClientIDMode="Static" OnTextChanged="filter_brand_TextChanged" Width="69" />

                    </td>
                    <td class="gridRow rsGridInput" style="width: 39px">
                        <asp:TextBox ID="TextBox4" runat="server" Width="39" ReadOnly="true" />

                    </td>
                    <td class="gridRow rsGridInput" style="width: 39px">
                        <asp:TextBox ID="TextBox5" runat="server" ReadOnly="true" onchange="return filtr_name_changed()" onkeypress="this.onchange();" onpaste="this.onchange();" oninput="this.onchange();" Width="39" />

                    </td>

                </tr>
            </table>

            <script>
                $("[id*=filtr_code]").live("keyup", function () {
                    var grid = document.getElementById('<%= Grd1.ClientID%>');
                    var rowsCount = <%=Grd1.Rows.Count %>;
                    if(rowsCount > 0) {
                        for (var i = 1; i < grid.rows.length - 1; i++) {
                            var compatable = grid.rows[i].cells[2].innerText;
                            var tt = grid.rows[i];
                            txt_value = $("[id*=filtr_code]").attr('value');
                            if (compatable.includes(txt_value)) {
                                tt.style.backgroundColor = "#C2D69B";
                                tt.style = "display:display";
                            } else {
                                tt.style = "display:none";
                            }                                    
                        }
                    } else {
                        clearTimeout(timeout);

                        // Make a new timeout set to go off in 800ms
                        timeout = setTimeout(function () {
                            doneTyping();
                        }, 1500);
                    }                         
                });
            </script>

            <script>
                $("[id*=filtr_name]").live("keyup", function () {
                    var grid = document.getElementById('<%= Grd1.ClientID%>');
                    var rowsCount = <%=Grd1.Rows.Count %>;
                    if(rowsCount > 0) {
                        for (var i = 1; i < grid.rows.length - 1; i++) {
                            var compatable = grid.rows[i].cells[3].innerText;
                            var tt = grid.rows[i];
                            txt_value = $("[id*=filtr_name]").attr('value');
                            if (compatable.includes(txt_value)) {
                                tt.style.backgroundColor = "#C2D69B";
                                tt.style = "display:display";
                            } else {
                                tt.style = "display:none";
                            }                                    
                        }
                    } else {
                        clearTimeout(timeout);

                        // Make a new timeout set to go off in 800ms
                        timeout = setTimeout(function () {
                            doneTyping();
                        }, 1500);
                    }                         
                });
            </script>

            <script>
                // Get the input box
                var txt_CarsBrands = document.getElementById('filter_brand');                            
                // Init a timeout variable to be used below
                var timeout = null;

                // Listen for keystroke events
                txt_CarsBrands.onchange = function (e) {

                    // Clear the timeout if it has already been set.
                    // This will prevent the previous task from executing
                    // if it has been less than <MILLISECONDS>
                    clearTimeout(timeout);

                    // Make a new timeout set to go off in 800ms
                    timeout = setTimeout(function () {
                        doneTyping();
                    }, 1500);
                };
            </script>

            <div id="" style="max-height: 500px; overflow: auto; width: 100%">
                <asp:GridView ID="Grd1" runat="server" RowStyle-CssClass="gridRow rsGridInput" AutoGenerateColumns="False" RowStyle-Font-Size="14px" Style="width: 100%">
                    <Columns>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20" HeaderStyle-Width="20" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkRow" runat="server" Width="20" />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chk_AllRows" runat="server" AutoPostBack="true" OnCheckedChanged="chk_AllRows_CheckedChanged" Width="20" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="29" HeaderStyle-Width="29" HeaderStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Item Code" ItemStyle-Width="75" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="75" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="txt_ItemCode" runat="server" Text='<%# Bind("product_code") %>' Width="75" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="name" ItemStyle-Width="280" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="280" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lbl_ItemName" runat="server" Text='<%# Bind("name") %>' Width="280" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="UnitName" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="70" HeaderStyle-Width="70" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lbl_UnitName" runat="server" Text='<%# Bind("unit_name") %>' Width="70" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ItemQty" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40" HeaderStyle-Width="40" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:TextBox ID="txt_ItemQty" runat="server" Width="40" autocomplete="off" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="price" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40" HeaderStyle-Width="40" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:TextBox ID="txt_ItemPrice" runat="server" Text='<%# Bind("price") %>' Width="40" autocomplete="off" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <HeaderStyle BackColor="#3AC0F2" ForeColor="White" HorizontalAlign="Left" />
                </asp:GridView>
            </div>

            <div style="clear: both"></div>

            <div id="" style="padding-left: 13px; padding-bottom: 13px; font-size: 13px;">
                <asp:LinkButton ID="btn_ins" runat="server" OnClick="GetSelectedRecords" CssClass="rsButton" Style="text-decoration: none;">დამატება</asp:LinkButton>
                <asp:Button ID="btnCancel" runat="server" Text="EXIT" CssClass="rsButton" OnClick="btnCancel_Click" />
            </div>
        </div>
    </asp:Panel>
            
    </asp:Content>
