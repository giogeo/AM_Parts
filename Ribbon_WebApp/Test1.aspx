<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test1.aspx.cs" Inherits="Ribbon_WebApp.Test1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<%@ Register Assembly="SlimeeLibrary" Namespace="SlimeeLibrary" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="style.css" rel="Stylesheet" type="text/css" />
    <link href="example/css/style.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript">
        function getElements() {
            var x = document.getElementsByTagName("input");

            for (i = 0; i < x.length; i++) {
                var y = document.getElementsByTagName("input")[i].value;

                if (y.length < 1) {
                    document.getElementsByTagName("input")[i].setAttribute("class", "inp_col");
                }
            }
        }

        function Clear() {
            var text = document.getElementsByClassName('inp_col');
            for (var i = 0; i < text.length; i++) {
                text[i].setAttribute("class", "black_col");
            }
        }

        function show_locatoin() {
            var path = window.location.href;
            var newpath = path + "?id=8";
            alert(newpath);
            
        }

        function scrDown() {
            var maxY = window.scrollMaxY;
            window.scrollTo(0, maxY);
        }

        function autocomp0() {
            var alt = document.getElementById('txt_updID').value;
            
            document.getElementById('hidden1').value = alt;

            var hid_txt = document.getElementById('hidden1').value
            //alert(hid_txt);
                
                //document.getElementById().value = 
        }
    </script>
    <style type="text/css">
        .auto-style2 {
            width: 100%;
        }
        .auto-style3 {
            height: 22px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <ajaxToolkit:ModalPopupExtender ID="Login_Popup_Modal" runat="server" PopupControlID="Login_Panel" TargetControlID="btn_login" CancelControlID="Button2" BackgroundCssClass="ModalBackground">
        </ajaxToolkit:ModalPopupExtender>


        <div id="Login_Panel" runat="server" class="popup-wrapper" style="min-width: 400px;">
            <div class="popup-header">Welcome back </div>

            <div class="popup-content">
                <div class="form-group">
                    <input type="email" placeholder="Email" id="email" />
                </div>
                <div class="form-group">
                    <input type="password" placeholder="Password" id="password" />
                </div>
                <div class="form-group">
                    <button class="btn-success" style="width: 100%;">Sign in</button>
                </div>
            </div>
        </div>
        <asp:Button ID="btn_login" runat="server" Text="Button" />
        <input type="hidden" name="hidden1" id="hidden1" value="" runat="server" />
        <div id="Test_Update_MultyRows">
            <asp:GridView ID="GRD_MultyUpdate" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <ajaxToolkit:AutoCompleteExtender
                                ID="AutoCompleteExtender1"
                                runat="server" TargetControlID="txt_updID"
                                UseContextKey="true" CompletionInterval="500"
                                CompletionSetCount="20"
                                ServiceMethod="GetCompletionList"
                                MinimumPrefixLength="4">
                            </ajaxToolkit:AutoCompleteExtender>
                            <asp:TextBox ID="txt_updID" runat="server" ClientIDMode="Static" Text='<%#  Eval("id") %>' onkeyup="autocomp();"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:TextBox ID="txt_updPrice" runat="server" Text='<%#  Eval("cost") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <div>
            

            <asp:TextBox ID="TextBox1" runat="server" ClientIDMode="Static" CssClass="inp_col"></asp:TextBox>
            </div>
            <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
        </div>

        <div id="MainPanel" runat="server">
            <div class="gridTable">
                <div id="procurement_list" runat="server">
                    <asp:ListView ID="ListView01" runat="server" DataSourceID="SqlDataTendersList" Visible="true">
                        <ItemTemplate>
                            <div data-role='collapsible'>
                                <table width="92%" cellpadding="3" cellspacing="1" rules="rows">
                                    <thead>
                                        <tr>
                                            <th align="center" colspan="2">
                                                <h3 title="მომწოდებლის დასახელება"><%#  Eval("name") %></h3>

                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th align="left" style="width: 30%;">
                                                <asp:Label ID="lbltender_num" Text='<%#  Eval("tender_num") %>' runat="server"></asp:Label></th>
                                            <td align="right" style="width: 70%;">
                                                <label title='ტენდერის კატეგორია'><%#  Eval("tender_category") %></label></td>
                                        </tr>

                                        <tr>
                                            <th align="left" style="width: 30%;"><a title='ტენდერის სახელშეკრულებო ღირებულება' href='?action=T_Items&job='>ტენდერის ფასი: </a>
                                                <td align="right" style="width: 70%;"><a title='ტენდერის სახელშეკრულებო ღირებულება' href='?action=T_Items&job='><%# Eval("tender_price", "{0:0.00}") %></a></td>
                                        </tr>
                                    </tbody>

                                    <tfoot>
                                        <tr>
                                            <th colspan="2">
                                                <h2>
                                                    <label><%# Eval("tender_date", "{0:dd.MM.yyyy}") +" - "+ Eval("tender_ends", "{0:dd.MM.yyyy}") %></label><asp:ImageButton ID="del_box" runat="server" ImageUrl="~/Ribbon/images/icon_delate.png" Width="24" OnClick="del_box_Click" />
                                                    <asp:Label ID="lblTenderId" Text='<%#  Eval("id") %>' runat="server" Visible="false"></asp:Label></h2>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataTendersList" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                        SelectCommand="select tenders.*, suppliers.id, suppliers.name  from tenders, suppliers where suppliers.id = tenders.contractor_id ORDER BY tender_date DESC"></asp:SqlDataSource>

                </div>
            </div>
        </div>
        <div id="footerpanel">
            
            </br></br>
            <input type="text" class="inp_col" />
            <input type="text" class="inp_col" />
            <input type="text" class="inp_col" />
            <span>
                <input type="button" value="Clear" onclick="Clear()" /></span>
            <span>
                <input type="button" value="Chk_Color" onclick="getElements()" /></span>
        </div>

        <div id="RsGrid_Panel">
            <asp:Button ID="Button1" runat="server" Text="Button" />
            <a id="xx" href="#" onclick="location.replace('http://example.com/#');">sdfdss</a><br />
            <a id="yy" onclick="scrDown();">asdasdasasdsd</a>
            <table class="rsGrid">
                <thead class="rsGridHeaderRow">
                    <th class="gridRow" style="width: 55px"></th>
                    <th class="gridRow" style="text-align: left; width: 17%">
                        <table>
                            <tr>
                                <td><span>ზედნადების N</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton1_Click" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton2_Click" /></td>
                            </tr>
                        </table>
                    </th>
                    <th class="gridRow" style="text-align: left; width: 13%">
                        <table>
                            <tr>
                                <td><span>თარიღი</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton3_Click" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton4_Click" /></td>
                            </tr>
                        </table>
                    </th>
                    <th class="gridRow" style="text-align: left; width: 11%">
                        <table>
                            <tr>
                                <td><span>შემოსავლები</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton5_Click" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton6_Click" /></td>
                            </tr>
                        </table>
                    </th>
                    <th class="gridRow" style="text-align: left; width: 11%">
                        <table>
                            <tr>
                                <td><span>ხარჯები</span></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/Ribbon/images/arrow_down.png" Height="18px" OnClick="ImageButton7_Click" /></td>
                                <td>
                                    <asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/Ribbon/images/arrow_up.png" Height="18px" OnClick="ImageButton8_Click" /></td>
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
                </thead>
                tfoot class="rsGrid">
                            <tr class="rsGridHeaderRow">

                                <td>
                                    <asp:TextBox ID="good_id_inputId" runat="server" Style="padding: 0.25em 0.75em; float: left;" Width="35px"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="good_bar_code_inputId" runat="server" Style="padding: 0.25em 0.75em; float: left;" Width="70px"></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="good_name_inputId" AutoPostBack="true" runat="server" Style="padding: 0.25em 0.75em; float: left; width: 350px;" /></td>
                                <td>
                                    <input list="good_unit_List" id="good_unit_selectedValueId" runat="server" name="good_unit_selectedValueName" class="rsGridSelect">
                                    <datalist id="good_unit_List">
                                        <option value="">აირჩიეთ</option>
                                        <option value="1">ცალი</option>
                                        <option value="3">გრამი</option>
                                        <option value="4">ლიტრი</option>
                                        <option value="5">ტონა</option>
                                        <option value="7">სანტიმეტრი</option>
                                        <option value="8">მეტრი</option>
                                        <option value="9">კილომეტრი</option>
                                        <option value="10">კვ.სმ</option>
                                        <option value="11">კვ.მ</option>
                                        <option value="12">მ³</option>
                                        <option value="13">მილილიტრი</option>
                                        <option value="2">კგ</option>
                                        <option value="99">სხვა</option>
                                        <option value="14">შეკვრა</option>
                                    </datalist>


                                </td>
                                <td>
                                    <input type="text" id="good_quantity_inputName" runat="server" name="good_quantity_input" style="padding: 0.25em 0.75em; float: left; width: 50px;" onkeyup="good_totalPrice();" /></td>
                                <td>
                                    <input type="text" id="good_unitPrice_inputName" runat="server" name="good_unitPrice_input" onclick="this.value = ''" style="padding: 0.25em 0.75em; float: left; width: 40px;" onkeyup="good_totalPrice();" /></td>
                                <td>
                                    <input type="text" id="good_totalPrice_inputName" runat="server" name="good_totalPrice_input" style="padding: 0.25em 0.75em; float: left; width: 65px;" /></td>
                                <td>
                                    <asp:Button ID="AddRow_Command" runat="server" Text="+" Height="28px" Width="50px" CssClass="rsButton" /></td>
                            </tr>
                </tfoot>
                <tbody class="rsGridHeaderRow">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" GridLines="None" Width="100.5%" CssClass="grid">
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
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("shemos", "{0:0.00}") %>'></asp:Label>
                                    </td>
                                    <td class="gridRow">
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("gasav", "{0:0.00}") %>'></asp:Label>
                                    </td>
                                    <td class="gridRow">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                    </td>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </tbody>
            </table>

            <table class="auto-style2">
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                    <td class="auto-style3"></td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>
            </table>

        </div>

        <div id="GetNumsFromString">
            <asp:TextBox ID="txt_OnlyNums" runat="server"></asp:TextBox>
            <asp:Button ID="btn_GetOnlyNums" runat="server" Text="Button" OnClick="btn_GetOnlyNums_Click" />
        </div>


    </form>
</body>
</html>
