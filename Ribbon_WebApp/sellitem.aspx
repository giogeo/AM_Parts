<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sellitem.aspx.cs" ViewStateEncryptionMode="Always" Inherits="Ribbon_WebApp.sellitem" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />    
    <script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script src="http://cdn.jquerytools.org/1.2.7/full/jquery.tools.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="scripts/jquery.zweatherfeed.min.js" type="text/javascript"></script>
    <script src="scripts/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="scripts/js/sidebar_menu.js"></script>
    <link rel="stylesheet" type="text/css" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <link rel="stylesheet" type="text/css" href="scripts/example_jquerytools.css" />
    <link rel="stylesheet" type="text/css" href="scripts/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="scripts/css/simple-sidebar.css" />
    <link rel="stylesheet" type="text/css" href="scripts/example_jquerytools.css" />
    <link rel="stylesheet" type="text/css" href="scripts/rs_style.css" />
    <!-- LOAD YOUR CSS FILE WHILE PAYING ATTENTION TO ITS PATH! -->     
    
    <title>AM-Parts</title>

    <script type="text/javascript">
        function ErrorBox() {
            alert("Warning! You've Done Something Wrong");
        }

        function goBack() {
            window.history.back();
        }

        function goUp() {
            $(window).scrollTop(0);
        }

        function Refresh() {
            location.reload(true);
        }

        function numeric() {
            document.getElementById("txt_qty").setAttribute("type", "number");  
        }

        function hide_table() {
            document.getElementsByTagName("thead").setAttribute("style", "visibility: hidden");
        }

        function mycalc_price_0() {

            var qty = document.getElementById('<%= txt_qty.ClientID %>').value;
            var price = document.getElementById('<%= txt_price.ClientID %>').value;

            var result = parseFloat(qty) * parseFloat(price);
            if (!isNaN(result)) {
                document.getElementById('<%= txt_price_sum.ClientID %>').value = result;
            }
        }

        function mycalc_price() {            
                       
            var grid = document.getElementById("<%= GridView1.ClientID%>");
            for (var i = 0; i < grid.rows.length - 1; i++) {
                var sum = 0;
                var qty = 0;
                var txtAmountQTY = $("input[id*=txt_ItemQty]");
                var txtAmountPRICE = $("input[id*=txt_ItemPrice]");
                var txtAmountTOTALPRICE = $("input[id*=txt_ItemTotalPrice]");
                var txtFooterPrice = $("input[id*=txt_FooterTotalPrice]");
                
                var itms = txtFooterPrice[0];
                txtAmountTOTALPRICE[i].value = parseFloat(txtAmountQTY[i].value) * parseFloat(txtAmountPRICE[i].value);
                                
                for (var j = 0; j < txtAmountTOTALPRICE.length; ++j) {
                    var item = txtAmountTOTALPRICE[j];
                    sum += parseFloat(item.value);
                }
                // $("#<%= Label3.ClientID %>").text(sum.toString());
                itms.value = sum.toString();
            }            
        }
    </script>    

    <style type="text/css">
        .TotalPriceInGridview td {
            padding: 10px 5px 5px 5px;
        }

        .first_td {
            width: 50%;
            padding: 2px 2px;
            text-align: left;
            vertical-align: top;
            border: 1px solid #f2eeee;
            font-size: 1em;
        }
        
        .all_td {
            width: 16.5%;
            padding: 2px 2px;
            text-align: left;
            vertical-align: top;
            border: 1px solid #f2eeee;
            font-size: 1em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="content" >
            <asp:Label ID="Label3" runat="server"></asp:Label>
            <asp:Label ID="lbl_done" runat="server"></asp:Label>
            <div>
                <p id="sell_table" runat="server" visible="false">
                                        
                    <table class="rsGridContainer">
                        <tfoot class="rsGrid">
                            <tr class="rsGridHeaderRow">
                                <td class="first_td" style="visibility: hidden">
                                    <div>
                                        <asp:TextBox ID="txt_name" runat="server" Visible="true" CssClass=""></asp:TextBox>
                                    </div>
                                </td>
                                <td class="all_td" style="visibility: hidden">
                                    <div>
                                        <asp:TextBox ID="txt_qty" runat="server" Visible="true" CssClass="" onchange="return mycalc_price();" onkeypress="this.onchange();" onpaste="this.onchange();" oninput="this.onchange();" AutoPostBack="False"></asp:TextBox>
                                    </div>
                                </td>
                                <td class="all_td" style="visibility: hidden">
                                    <div>
                                        <asp:TextBox ID="txt_price" runat="server" Visible="true" CssClass="" onchange="return mycalc_price();" onkeypress="this.onchange();" onpaste="this.onchange();" oninput="this.onchange();" AutoPostBack="False"></asp:TextBox>
                                    </div>
                                </td>
                                <td class="all_td" style="visibility: hidden">
                                    <div>
                                        <asp:TextBox ID="txt_price_sum" runat="server" Visible="true" CssClass=""></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                        </tfoot>

                        <thead class="rsGrid">
                            <tr class="rsGridHeaderRow" style="background: none repeat scroll 0 0 ActiveCaption !important">
                                <th class="first_td">
                                    <div style="float: left">
                                        <asp:Label ID="Label1" runat="server" Text="გადახდის მეთოდი:" Font-Bold="True" ForeColor="WindowText"></asp:Label>
                                    </div>
                                    <br />
                                    <div style="float: left">
                                        <asp:DropDownList ID="Pay_Method_InputId" runat="server" CssClass="rsGridSelect">
                                            <asp:ListItem Value="0">სალარო / ბანკი</asp:ListItem>
                                            <asp:ListItem Value="1" Selected="True">ნაღდი (სალაროში)</asp:ListItem>
                                            <asp:ListItem Value="2">უნაღდო (ბანკში)</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </th>
                                <th class="all_td" colspan="3">
                                    <div style="float: left; width: 80px">
                                        <asp:Label ID="Label2" runat="server" Text="გადახდილია:" Font-Bold="True" ForeColor="WindowText"></asp:Label>
                                        <asp:TextBox ID="txt_paid" runat="server" Text="0" Type="number" CssClass="rsGridSelect" Width="70"></asp:TextBox>
                                    </div>
                                    <div id="add_grid_list" style="border: 1px solid #BBBBBB; border-radius: 5px 5px 5px 5px; box-shadow: 0 0 4px #BBBBBB; display: inline-block; font-size: 11px; margin-top: 30px; min-width: 20px; min-height: 15px; max-height: 35px; background-color: #d5cbcb; vertical-align: middle; visibility: visible;">
                                        <asp:ImageButton ID="btn_sell" runat="server" ImageUrl="~/images/icons/add_grid.ico" Height="35" OnClick="btn_sell_Click" />
                                    </div>
                                </th>
                            </tr>
                            <tr class="rsGridHeaderRow">
                                <th class="first_td">დასახელება</th>
                                <th class="all_td">რაოდ.</th>
                                <th class="all_td">ერთ.ფასი</th>
                                <th class="all_td">ჯამი</th>
                            </tr>
                            <tr class="rsGridHeaderRow">
                                <asp:GridView ID="GridView1" runat="server" ForeColor="#333333" GridLines="None" ShowFooter="True" CssClass="rsGridHeaderRow" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="False">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_goodsID" runat="server" Text='<%# Bind("g_id") %>' Style="display: none;"></asp:TextBox>
                                                <asp:TextBox ID="txt_ItemName" runat="server" Text='<%# Bind("name") %>' ReadOnly="true" CssClass="rsGridInput"></asp:TextBox>
                                            </ItemTemplate>
                                            <ControlStyle CssClass=" first_td" />
                                            <FooterStyle CssClass=" first_td" />
                                            <HeaderStyle CssClass=" first_td" />
                                            <ItemStyle HorizontalAlign="Left" CssClass=" first_td" />
                                        </asp:TemplateField>

                                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_g1" runat="server" Text='Text' Style="display: none;"></asp:TextBox>
                                                <asp:TextBox ID="txt_ItemQty" runat="server" Text='<%# Bind("qty") %>' Type="number" CssClass="rsGridInput" onchange="return mycalc_price();" onkeypress="this.onchange();" onpaste="this.onchange();" oninput="this.onchange();"></asp:TextBox>
                                            </ItemTemplate>
                                            <ControlStyle CssClass=" all_td" />
                                            <FooterStyle CssClass=" all_td" />
                                            <HeaderStyle CssClass=" all_td" />
                                            <ItemStyle HorizontalAlign="Left" CssClass=" all_td" />
                                        </asp:TemplateField>

                                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_g2" runat="server" Text='Text' Style="display: none;"></asp:TextBox>
                                                <asp:TextBox ID="txt_ItemPrice" runat="server" Text='<%# Bind("price") %>' Type="number" CssClass="rsGridInput" onchange="return mycalc_price();" onkeypress="this.onchange();" onpaste="this.onchange();" oninput="this.onchange();"></asp:TextBox>
                                            </ItemTemplate>
                                            <ControlStyle CssClass=" all_td" />
                                            <FooterStyle CssClass=" all_td" />
                                            <HeaderStyle CssClass=" all_td" />
                                            <ItemStyle HorizontalAlign="Left" CssClass="all_td" />
                                        </asp:TemplateField>

                                        <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <table class="TotalPriceInGridview">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txt_ItemTotalPrice" runat="server" Text='<%# Bind("totalprice") %>' ReadOnly="true" CssClass="rsGridInput"></asp:TextBox></td>
                                                        <td>
                                                            <a id="link_for_del" onclick="javascript: location.href='<%# String.Format("?action=del&item={0}", Eval("g_id")) %>'">
                                                                <img src="Ribbon/images/delete-row-xxl.png" width="24" /></a></td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox ID="txt_FooterTotalPrice" runat="server" ReadOnly="true"></asp:TextBox>
                                            </FooterTemplate>
                                            <ControlStyle CssClass=" all_td" />
                                            <FooterStyle CssClass=" all_td" />
                                            <HeaderStyle CssClass=" all_td" />
                                            <ItemStyle HorizontalAlign="Left" CssClass=" all_td" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="hidden" />
                                    <FooterStyle BackColor="ActiveCaption" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" VerticalAlign="Top" />
                                </asp:GridView>
                            </tr>
                        </thead>

                        <tbody class="rsGrid">
                        </tbody>
                    </table>
                    <a id="btn_insert" runat="server" class="ui-btn" data-ajax="false" onclick="Confirm()" visible="false" >ჩ ა ს ვ ი</a>                    
                    <script type="text/javascript">
                        function Confirm() {
                            var confirm_value = document.createElement("INPUT");
                            confirm_value.type = "hidden";
                            confirm_value.name = "confirm_value";
                            location.href = 'sellitem.aspx?req=add&confirm=yes';
                            if (confirm("Do you want to save data?")) {
                                confirm_value.value = "Yes";
                            } else {
                                confirm_value.value = "No";
                                location.href = 'sellitem.aspx?req=add&confirm=no';
                            }
                            document.forms[0].appendChild(confirm_value);
                        }                        
                    </script>
                </p> 
                <p>
                    <asp:GridView ID="GridView2" runat="server" Visible="false"></asp:GridView>
                </p>               
            </div>
            
            <div class="grid_content" style="display: none">
                <ul class="nav nav-tabs">
                    <li class="active">
                       <a href="#home" data-toggle="tab">Home</a>
                    </li>
                    <li>
                        <a href="#edit" data-toggle="tab">Edit</a>
                    </li>
                    <li>
                        <a href="#about" data-toggle="tab">About</a>
                    </li>
                </ul>
            </div>      
            
            <div class="grid_content" style="display: none">
                <div class="tab-content">
                    <div id="home" class="tab-pane fade in active">
                        <h3>HOME</h3>
                        <p>
                            <a href="index.html" class="ui-btn ui-icon-plus ui-btn-icon-right">Add</a>
                        </p>
                    </div>
                    <div id="edit" class="tab-pane fade">
                        <h3>Menu 1</h3>
                        <p>
                            <a href="index.html" class="ui-btn ui-icon-plus ui-btn-icon-right">Edit</a>
                        </p>
                    </div>
                    <div id="about" class="tab-pane fade">
                        <h3>Menu 2</h3>
                        <p>
                            <a href="index.html" class="ui-btn ui-icon-plus ui-btn-icon-right">About</a>
                        </p>
                    </div>
                </div>
            </div>   
        </div> <!-- /content -->  
    </form> 
</body>
</html>
