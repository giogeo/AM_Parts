<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="shop.aspx.cs" Inherits="Ribbon_WebApp.Mobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script src="http://cdn.jquerytools.org/1.2.7/full/jquery.tools.min.js"></script>
    <script src="scripts/jquery.zweatherfeed.min.js" type="text/javascript"></script>
    <script src="scripts/js/bootstrap.min.js"></script>
    <script src="scripts/js/sidebar_menu.js"></script>
    <link href="scripts/example_jquerytools.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="scripts/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="scripts/css/simple-sidebar.css" />
    <link rel="stylesheet" type="text/css" href="scripts/example_jquerytools.css" />
    <!-- LOAD YOUR CSS FILE WHILE PAYING ATTENTION TO ITS PATH! -->
    <link rel="stylesheet" type="text/css" href="./css/mycss.css" />
    <link rel="stylesheet" type="text/css" href="table.css" />
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
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#test').weatherfeed(['GGXX0004', 'GGXX0005', 'GGXX0001', 'GGXX0002'], {}, function (e) {
                $("div.scrollable").scrollable({
                    vertical: true,
                    size: 1,
                    circular: true
                }).navigator().autoscroll({
                    interval: 3000
                });
            });
        });
    </script>

    <script type="text/javascript">
        var x = document.getElementById("demo");

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            } else {
                x.innerHTML = "Geolocation is not supported by this browser.";
            }
        }

        function showPosition(position) {
            var latlon = position.coords.latitude + "," + position.coords.longitude;

            var img_url = "http://maps.googleapis.com/maps/api/staticmap?center="
            + latlon + "&zoom=17&size=300x300&sensor=true";
            document.getElementById("mapholder").innerHTML = "<img src='" + img_url + "'>";
        }

        function showError(error) {
            switch (error.code) {
                case error.PERMISSION_DENIED:
                    x.innerHTML = "User denied the request for Geolocation."
                    break;
                case error.POSITION_UNAVAILABLE:
                    x.innerHTML = "Location information is unavailable."
                    break;
                case error.TIMEOUT:
                    x.innerHTML = "The request to get user location timed out."
                    break;
                case error.UNKNOWN_ERROR:
                    x.innerHTML = "An unknown error occurred."
                    break;
            }
        }
    </script>

    <style type="text/css">
        table.gridtable {
            font-family: verdana,arial,sans-serif;
            font-size: 11px;
            color: #333333;
            border-width: 1px;
            border-color: #666666;
            border-collapse: collapse;
            font-weight: bold;
        }

            table.gridtable th {
                border-width: 1px;
                padding: 8px;
                border-style: solid;
                border-color: #666666;
                background-color: #dedede;
            }

        .first_td {
            width: 190px;
            padding: 2px 2px;
            text-align: left;
            vertical-align: top;
            border: 1px solid #f2eeee;
            font-size: 1em;
        }

        .all_td {
            width: 45px;
            padding: 2px 2px;
            text-align: left;
            vertical-align: top;
            border: 1px solid #f2eeee;
            font-size: 1em;
        }
    </style>
    <style type="text/css">

        #sidebar-wrapper {
            position: fixed;
            left: 0px;
            z-index: 1000;
            overflow-y: auto;
            margin-left: 1px;
            width: 55px;
            height: 100%;
            background: #000000;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        #sidebar-wrapper-wide {
            position: fixed;
            left: 0px;
            z-index: 1000;
            overflow-y: auto;
            margin-left: 1px;
            width: 255px;
            height: 100%;
            background: #000000;
            -webkit-transition: all 0.5s ease;
            -moz-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;

        }

        /* Sidebar Styles */

        .sidebar-nav {
            position: absolute;
            top: 0;
            margin: 0;
            padding: 0;
            width: 250px;
            list-style: none;
        }

            .sidebar-nav li {
                text-indent: 20px;
                line-height: 40px;
            }

            .sidebar-nav li a {
                    display: block;
                    color: #999999;
                    text-decoration: none;
                }

            .sidebar-nav li a:hover {
                        background: rgba(255, 255, 255, 0.2);
                        color: #fff;
                        text-decoration: none;
                    }

            .sidebar-nav li a:active,
            .sidebar-nav li a:focus {
                        text-decoration: none;
                    }

            .sidebar-nav &gt; .sidebar-brand {
                height: 65px;
                font-size: 18px;
                line-height: 60px;
            }

            .sidebar-nav &gt; .sidebar-brand a {
                    color: #999999;
                }

            .sidebar-nav &gt; .sidebar-brand a:hover {
                        background: none;
                        color: #fff;
                    }

       
            #wrapper {
                padding-left: 100px;
            }

           
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div data-role="page">
            <asp:TextBox ID="txt_name" runat="server" Visible="false"></asp:TextBox>
            <asp:TextBox ID="txt_wbID" runat="server" Visible="false"></asp:TextBox>
            <asp:TextBox ID="txt_tId" runat="server" Visible="false"></asp:TextBox>
            <asp:TextBox ID="txt_wbItems" runat="server" Visible="false"></asp:TextBox>
            <asp:TextBox ID="txt_Tit_rem" runat="server" Visible="false"></asp:TextBox>

            <div id="panel_head" runat="server" data-role="header" data-position="fixed" style="background: #488ad2;" visible="false">
                <h1 style="color: white;">AM-Parts</h1>
                <a href="#bars11" class="ui-btn ui-icon-bars ui-btn-icon-notext" style="min-height:100%; margin:auto; margin-top: -5px; margin-left: -5px; width:40px"></a>
            </div>
            <!-- /header -->
            
               
       
           
            
            

            <div data-role="content"> 
                               
                <div id="Main" runat="server" align="center">
                    <div class="scrollable vertical">
                        <div id="test" class="items"></div>
                    </div>
                    <div class="navi"></div>

                    <a href="#popupInfo" data-rel="popup" data-transition="window" class="ui-btn ui-icon-location ui-btn-icon-notext"></a>
                    <div data-role="popup" id="popupInfo" data-overlay-theme="b" data-theme="b">
                        <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
                        <div id="mapholder" class="popphoto"></div>
                    </div>
                </div>                

                <asp:ListView ID="ListView01" runat="server" OnItemDataBound="ListView01_ItemDataBound" DataSourceID="SqlDataSource01" Visible="false">
                    <ItemTemplate>
                        <div data-role='collapsible'>
                            <h3>
                                <img src='images/icons/ico-Currency.ico' height='20' title='ტენდერის ფასი' />
                                <%# Eval("tender_price", "{0:0.00}") +"    "+  Eval("Sup_name") %></h3>
                            <ul data-role='listview' data-autodividers='false' data-inset='true'>
                                <li>
                                    <label title='ტენდერის ნომერი' style="font-weight: bolder;"><%#  Eval("tender_num") %></label>
                                    <label title='ტენდერის კატეგორია'><%#  Eval("tender_category") %></label>
                                </li>
                                <li><a href='?action=T_Items&job=<%# Eval("t_id") %>'>ტენდერის ფასი:<asp:Label ID="l_tender_price" runat="server" Text='<%# Eval("tender_price", "{0:0.00}") %>'></asp:Label>
                                </a></li>
                                <asp:Label ID="l_tender_id" runat="server" CssClass="hidden" Text='<%# Eval("t_id") %>'> </asp:Label>
                                <li><a id="a_sold_to" runat="server" href='?TenderID=<%# Eval("t_id") %>'>მიწოდებულია:
                                    <asp:Label ID="l_sold_to" runat="server"></asp:Label></a></li>
                                <li><a href='?action=rem&job=<%# Eval("t_id") %>'>ასათვისებელია:
                                    <asp:Label ID="l_remained" runat="server"></asp:Label></a></li>
                                <li style='font-size: small;'>
                                    <label><%# Eval("tender_date", "{0:dd.MM.yyyy}") +" - "+ Eval("tender_ends", "{0:dd.MM.yyyy}") %></label></li>

                            </ul>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                    </EmptyDataTemplate>
                </asp:ListView>
                <asp:SqlDataSource ID="SqlDataSource01" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                    SelectCommand="select 
                                    tenders.id AS t_id, tenders.tender_num, tenders.contractor_id,
                                    tenders.tender_date, tenders.tender_ends, tenders.tender_price, 
                                    tenders.tender_category, 
                                    suppliers.id AS SupId, name AS Sup_name 
                                   from 
                                    tenders, suppliers
                                   where 
                                    tenders.contractor_id = suppliers.id"></asp:SqlDataSource>

                <p id="Show_goods" runat="server" visible="false">
                    <asp:TextBox ID="myFilter" runat="server" data-type="search" visible="true" ></asp:TextBox> 

                    <ul data-role='listview' data-filter="true" data-input="#myFilter" data-autodividers="false" data-inset="true">
                        <asp:ListView ID="TestListView" runat="server" DataSourceID="SqlDataSource2">
                            <ItemTemplate>
                                <li>
                                    <asp:HyperLink runat="server" ID="hl" NavigateUrl='<%# "mobile.aspx?ID="+ Eval("Id") %>' Text='<%#  Eval("name") + " - " +   Eval("product_code") %> '></asp:HyperLink>
                                </li>
                            </ItemTemplate>
                            <EmptyDataTemplate>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </ul>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                        SelectCommand="SELECT [Id], [product_code], [name] FROM [goods]"></asp:SqlDataSource>

                </p>

                <p id="show_Twaybils" runat="server" visible="false">

                    <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSource3">
                        <ItemTemplate>

                            <table class="table-body">
                                <tr class="table-header">
                                    <td>
                                        <asp:HyperLink runat="server" ID="Wb_HyperLink" NavigateUrl='<%# "mobile.aspx?action=waybills&Id="+ Eval("id") %>' Text='<%#  Eval("waybill_number") %> '></asp:HyperLink></td>
                                    <td><%#  Eval("waybill_date", "{0:d}") %></td>
                                </tr>
                            </table>

                        </ItemTemplate>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                        SelectCommand="SELECT * FROM tenders_waybills">
                        <FilterParameters>
                            <asp:ControlParameter Name="tender_id" ControlID="txt_name" PropertyName="Text" />
                        </FilterParameters>
                    </asp:SqlDataSource>
                </p>

                <p id="show_WbItems" runat="server" visible="false">

                    <table class="table-body">
                        <tr class="table-header">
                            <th class="first_td">დასახელება</th>
                            <th class="all_td">რაოდ.</th>
                            <th class="all_td">ფასი</th>
                            <th class="all_td">ჯამი</th>
                        </tr>
                    </table>
                    <asp:ListView ID="ListView3" runat="server" DataSourceID="SqlDataSource4">
                        <ItemTemplate>
                            <table class="table-body">
                                <tr>
                                    <td class="first_td"><%#  Eval("name") %></td>
                                    <td class="all_td"><%# Eval("quantity", "{0:0.00}") %></td>
                                    <td class="all_td"><%# Eval("price", "{0:0.00}") %></td>
                                    <td class="all_td"><%# Convert.ToDouble(Eval("quantity")) * Convert.ToDouble(Eval("price"))  %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                        SelectCommand="select tenders_items.*, goods.Id, goods.name from tenders_items, goods where goods.Id = tenders_items.goods_id" FilterExpression="waybill_id = '{0}'">
                        <FilterParameters>
                            <asp:ControlParameter Name="waybill_id" ControlID="txt_wbID" PropertyName="Text" />
                        </FilterParameters>
                    </asp:SqlDataSource>
                </p>

                <p id="Show_TndrItems" runat="server" visible="false">
                    <table class="table-body">
                        <tr class="table-header">
                            <th class="first_td">დასახელება</th>
                            <th class="all_td">რაოდ.</th>
                            <th class="all_td">ფასი</th>
                            <th class="all_td">სულ</th>
                        </tr>
                    </table>
                    <asp:ListView ID="ListView4" runat="server" DataSourceID="SqlDataSource5">
                        <ItemTemplate>
                            <table class="table-body">
                                <tr>
                                    <td class="first_td"><%#  Eval("name") %></td>
                                    <td class="all_td"><%# Eval("quantity", "{0:0.00}") %></td>
                                    <td class="all_td"><%# Eval("price", "{0:0.00}") %></td>
                                    <td class="all_td"><%# Convert.ToDouble(Eval("quantity")) * Convert.ToDouble(Eval("price")) %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                        SelectCommand="select * 
                                        from
                                        (select id AS WbId, tender_id AS t_id, expense_way, cost from tenders_waybills) T1
                                        INNER JOIN
                                        (select * from tenders_items) T2
                                        ON(T2.waybill_id = T1.WbId AND T1.expense_way IS NULL AND T1.cost IS NULL)
										INNER JOIN
										(select Id as gId, name from goods) T3
										ON(T3.gId = T2.goods_id)"
                        FilterExpression="t_id = '{0}'">
                        <FilterParameters>
                            <asp:ControlParameter Name="tender_id" ControlID="txt_tId" PropertyName="Text" />
                        </FilterParameters>
                    </asp:SqlDataSource>
                </p>

                <p id="Showitemsleft" runat="server" visible="false">

                    <table class="table-body">
                        <tr class="table-header">
                            <th class="first_td">დასახელება</th>
                            <th class="all_td">ნაშთი</th>
                            <th class="all_td">ფასი</th>
                        </tr>
                    </table>
                    <asp:ListView ID="ListView5" runat="server" DataSourceID="SqlDataSource6">
                        <ItemTemplate>
                            <table class="table-body">
                                <tr>
                                    <td class="first_td"><%#  Eval("name") %></td>
                                    <td class="all_td"><%# Eval("remains", "{0:0.00}") %></td>
                                    <td class="all_td"><%# Eval("price", "{0:0.00}") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:borjomiConnectionString %>"
                        SelectCommand="select tenders_items.*,  goods.Id AS gID, goods.name
                                                INTO #te1
                                                from tenders_items, goods
                                                where tenders_items.goods_id = goods.Id

                                                select #te1.goods_id, #te1.tender_id, #te1.name, #te1.price,  (#te1.quantity * #te1.tr_type) AS now
                                                into #te2
                                                from #te1

                                                select #te2.goods_id, #te2.tender_id, #te2.name, SUM(#te2.now) AS remains, #te2.price
                                                from #te2 group by #te2.goods_id, #te2.name, #te2.tender_id, #te2.price"
                        FilterExpression="tender_id = '{0}'">
                        <FilterParameters>
                            <asp:ControlParameter Name="tender_id" ControlID="txt_Tit_rem" PropertyName="Text" />
                        </FilterParameters>
                    </asp:SqlDataSource>
                </p>                

            </div>
            <!-- /content -->

            <div data-role="panel" id="bars" runat="server">
                <div data-role="navbar">
                    <ul>
                        <li><a href="Mobile.aspx?action=goods">
                            <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="images/icons/Goods_List.ico" Width="36px" /><br />
                            <span>პროდუქცია</span></a></li>
                        <br />
                        <li><a href="Mobile.aspx?action=addsup">
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/icons/Sell_Items.ico" Width="36px" /><br />
                            <span>მიწოდება</span></a></li>
                        <br />
                        <li><a href="Mobile.aspx?action=waybills">
                            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="images/icons/waybills-icone.ico" Width="36px" /><br />
                            <span>ზედნადები</span></a></li>
                        <br />
                        <li><a href="Mobile.aspx?action=list">
                            <img src="ribbon/images/procurement.png" width="36" /><br />
                            <span>ტენდერები</span></a></li>
                    </ul>
                </div>
                <!-- /panel -->

            </div>
            <!-- /bars -->
            
            <div data-role="footer" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a data-icon="carat-l" onclick="goBack()">უკან</a></li>
                        <li><a href="Mobile.aspx" data-icon="home" class="ui-btn-active">Home</a></li>
                        <li><a data-icon="carat-u" onclick="goUp()">UP</a></li>
                        <li><a data-icon="grid" href="#bars" data-rel="popup" data-transition="slideup">Menu</a></li>
                    </ul>
                </div>
                <!-- /navbar -->
            </div>
            <!-- /footer -->

        </div>
    </form>
</body>
</html>