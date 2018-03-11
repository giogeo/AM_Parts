<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="WebForm2.aspx.cs" Inherits="Ribbon_WebApp.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        function myFunction(lnk) {

            var row = lnk.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;
            var compatable = row.cells[0].innerText;


            var str = "ზეთი";
            var n = compatable.includes(str);
           
            if (n == false) {

                //Alternating Row Color

                row.style.backgroundColor = "#C2D69B";

            } else {
                row.style = "display:none";
            }
            
        }

        $(document).ready(function () {            
                $('#txt_Search_Price').val('giorgi');           

        });

        $("[id*=txt_Search_Name]").live("keyup", function () {
            var grid = document.getElementById('<%= GridView1.ClientID%>');           
            
            for (var i = 1; i < grid.rows.length -1; i++) {
                var compatable = grid.rows[i].cells[0].innerText;
                var tt = grid.rows[i];
                txt_value = $("#txt_Search_Name").attr('value');
                if (txt_value.length >= 3) {
                    if (compatable.includes(txt_value)) {
                        tt.style.backgroundColor = "#C2D69B";
                        tt.style = "display:display";
                    } else {
                        tt.style = "display:none";
                    }
                }                                
            }            
        });
    </script>
    <style type="text/css">
        .tcd_srch {
            display:inline-block;
            vertical-align: top;
        }

        .tcd_srch .chk {
            display: flex;
            flex-direction: column;
        }

        

        #txt_search {
            border: none;
            -webkit-box-shadow: 0 0 0px 1000px white inset;
            padding: 0  0;
            padding-top: 1px;
            text-align: left;
        }

        #btn_search {
            background-image: url("images/icons/1464133560_Search.ico");
            background-repeat: no-repeat;
            background-position:center;
            background-size: 32px 32px;
            width: 36px;
            height: 36px;
            background-color: transparent;
            border: none;
        }
        
        *:focus {
            outline: none;
        }

        input {
            
        }

        .hide {
            display: none;
        }

        .to_minus {            
            background: url("images/minus.png") no-repeat center top;
            background-size: 32px 32px;
        }

        .to_minus input[type=image] {
            display: none;
        }

        .buttonfield {
            vertical-align: top;
            padding-top: 6px;
        }

        .TableCSS {
            border-collapse: collapse;
            border: none !important;
            border-style: none;
            background-color: none;
            width: 700px;
        }
        .TableHeader {
            background-color: rgba(255,255,255, 0.85);
            color:  black;
            font-size: 15px;
            font-family: Verdana;
            height: 25px;
            text-align: left;
        }
        .TableData {
            background-color: rgba(255,255,255, 0.45);
            color: black;
            font-family: MS Sans Serif;
            font-size: 13px;
            font-weight: bold;
        }                                                                
    </style>
    <script type="text/javascript">
        window.onload = function () {
            
            $('input[type=image]').live('click', function () {
                $(this).attr("src", "images/preloader.gif");
                $(this).css("width", "32px");

            });

            $('.to_minus').live('click', function () {
                $(this).css("background", "url(images/preloader.gif) no-repeat center top");
                $(this).css("background-size", "32px 32px");
                window.history.back();
            });

            $('input.example').on('change', function () {
                $('input.example').not(this).prop('checked', false);
            });

            var inputs = document.getElementsByTagName ("input")            
            for (var i = 0; i < inputs.length; i++) {
                //alert("The " + i + ". input type = " + inputs[i].type);
            }
        }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" ShowFooter="true">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" ClientIDMode="Static" Text='<%# Bind("name") %>' />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txt_Search_Name" runat="server" ClientIDMode="Static" />
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" ClientIDMode="Static" Text='<%# Bind("price") %>' onclick="myFunction(this)" />
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txt_Search_Price" runat="server" ClientIDMode="Static" onchange="myFunction(this)" />
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div class="tcd_srch" style="border: solid 1.5px #e5e0e0">
            <asp:TextBox ID="txt_search" runat="server" Height="36" />
            <asp:Button ID="btn_search" runat="server" OnClick="btn_search_Click" />
        </div>
        <div class="tcd_srch">
            <fieldset>
                <legend>ძებნა რის მიხედვით:</legend>
                <label for="art_info">
                    <input id="art_info" runat="server" type="checkbox" class="example" />Art. Info/Detales
                </label><br />

                <label for="by_oem">
                    <input ID="by_oem" runat="server" type="checkbox" class="example" />Compatible Cars By OEM
                </label><br />
                
                <label for="by_cross">
                    <input ID="by_cross" runat="server" type="checkbox" class="example" />Replacement/Cross
                </label>
            </fieldset>


           
            
        </div>
        
        <br /><br />
        <asp:GridView ID="GridView2" runat="server">
        </asp:GridView>
        <br /><br />
        <asp:GridView ID="gvTree" runat="server" OnRowDataBound="gvTree_RowDataBound" OnRowCommand="gvTree_RowCommand" OnSelectedIndexChanged="gvTree_SelectedIndexChanged" AutoGenerateColumns="false" GridLines="None" BorderStyle="None" >
            <Columns>
                <asp:BoundField DataField="STR_ID" HeaderText="STR_ID" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" >
                    <HeaderStyle CssClass="hide"></HeaderStyle>
                    <ItemStyle CssClass="hide"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="STR_ID_PARENT" HeaderText="STR_ID_PARENT" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide">
                    <HeaderStyle CssClass="hide"></HeaderStyle>
                    <ItemStyle CssClass="hide"></ItemStyle>
                </asp:BoundField>
                <asp:ButtonField ButtonType="Image" ImageUrl="~/images/plus.png"  CommandName="Select" ItemStyle-Width="32" ItemStyle-CssClass="buttonfield"  />
                <asp:TemplateField HeaderText="STR_DES_TEXT">
                    <ItemTemplate>
                        <table class="TableCSS">
                            <tr class="TableHeader">

                                <td colspan="3" style="width: 99%">
                                    <asp:Label ID="PARENT_STR_DES_TEXT" runat="server" Text='<%# Bind("STR_DES_TEXT") %>' />
                                </td>
                            </tr>
                            <tr class="TableData">
                                <td style="width: 4%"></td>
                                <td colspan="2" style="width: 95%">
                                    <asp:ListView ID="lst_sub_tree" runat="server">
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td class="hide">
                                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("STR_ID") %>' /></td>
                                                    <td class="hide">
                                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("STR_ID_PARENT") %>' /></td>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("STR_DES_TEXT") %>' /></td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <HeaderStyle CssClass="hide" />
                </asp:TemplateField>
                <asp:BoundField DataField="DESCENDANTS" HeaderText="DESCENDANTS" >
                    <HeaderStyle CssClass="hide" />
                    <ItemStyle CssClass="hide" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <br /><br />
        
        
    </form>
</body>
</html>