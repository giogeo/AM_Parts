<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="M_App.aspx.cs" Inherits="Ribbon_WebApp.M_App" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.min.css" />
    <script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.4.3/jquery.mobile-1.4.3.min.js"></script>
    <script src="http://cdn.jquerytools.org/1.2.7/full/jquery.tools.min.js"></script>
    <script src="scripts/js/bootstrap.min.js"></script>
    <script src="scripts/js/sidebar_menu.js"></script>
    <script src="scripts/jquery.zweatherfeed.min.js"></script>
    <link rel="stylesheet" type="text/css" href="scripts/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="scripts/css/simple-sidebar.css" />
    <link rel="stylesheet" type="text/css" href="scripts/example_jquerytools.css" />
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


            <div data-role="header" data-position="fixed" style="background: #488ad2;">
                <h1 style="color: white;">AM-Parts</h1>
                <a href="#bars" class="ui-btn ui-icon-bars ui-btn-icon-notext"></a>
            </div>
            <!-- /header -->

            <div data-role="content">

                <div id="sidebar-wrapper" onmouseover="this.id='sidebar-wrapper-wide'" onmouseout="this.id='sidebar-wrapper'">
                    <ul class="sidebar-nav">
                        <li class="sidebar-brand">
                            <br>
                        </li>
                        <li class="sidebar-brand">
                            <a href="#" class="navbar-brand glyphicon glyphicon-plus" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true">Profile</span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-cloud" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true">My Home Page</span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-cloud" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true">Search</span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-cloud" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true"><font color="#337AB7"> STATISTICS</font></span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-envelope" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true">Reports</span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-envelope" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true">Statistic</span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-envelope" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true"><font color="#337AB7"> ADMINISTRATION</font></span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-envelope" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true">Users</span></a>
                        </li>
                        <li>
                            <a href="#" class="navbar-brand glyphicon glyphicon-envelope" style="padding-left: 0;">
                                <span class="glyphicon" aria-hidden="true">Messages</span></a>
                        </li>
                    </ul>
                </div>
                <!-- /Sidebar -->

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

            </div>
            <!-- /content -->

            <div data-role="panel" id="bars">
                <div data-role="navbar">
                    <ul style="width: 100%; background-color: aqua">
                        <li><a href="Mobile.aspx?action=goods">
                            <span>პროდუქცია</span></a></li>
                        <br />
                        <li><a href="Mobile.aspx?action=addsup">
                            <span>მიწოდება</span></a></li>
                        <br />
                        <li><a href="Mobile.aspx?action=waybills">
                            <span>ზედნადები</span></a></li>
                        <br />
                        <li><a href="Mobile.aspx?action=list">
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
                    </ul>
                </div>
                <!-- /navbar -->
            </div>
            <!-- /footer -->

        </div>
    </form>
</body>
</html>