<%@ Page Language="C#" EnableEventValidation="false" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="addwbitems.aspx.cs" Inherits="Ribbon_WebApp.addwbitems" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">
    <style type="text/css">
        .top_div {
            vertical-align: top;
            height: 78px;
            width: 150px;
            font-size: smaller;
            text-align: center;
            display: inline-block;
        }

        label {
            display: inline-block;
            padding-top: 3px;
        }

        .CenterGrid {
            width: 80%;
            border: solid 2px black;
            min-width: 80%;
            margin-left: auto;
            margin-right: auto;
        }

        .NextButton {
            background: url(https://www.iconfinder.com/data/icons/material-audio-video/12/skip-next-24.png) no-repeat 0 0;
            border: 0;
            height: 32px;
            width: 32px;
            cursor: pointer;
        }

        .SelectAll {
            background: url(https://www.iconfinder.com/data/icons/erp-software-icon-set-1/512/select_all-32.png) no-repeat 0 0;
            border: 0;
            height: 32px;
            width: 32px;
            cursor: pointer;
            content: "my tooltip";
        }
    </style>
    <script type="text/javascript">
        function Check_SelectAll() {

            //Change the GridView Id here
            var objGridView = document.getElementById("<%=GridView1.ClientID %>");
            //Get all input elements in Gridview
            var inputList = objGridView.getElementsByTagName("input");
            //The First element is the Header Checkbox
            var headerCheckBox = inputList[0];
            var checked = true;
            var unchecked = false;
            if (inputList[0].type == "checkbox") {
                if (headerCheckBox.checked) {
                    headerCheckBox.checked = unchecked;
                    __doPostBack("Obj", '');
                }
                else {
                    headerCheckBox.checked = checked;
                    document.getElementById('NextDiv').style.display = 'inline-block';
                    __doPostBack("Obj", '');
                }
            }            
        }

        function wb_chacked(lnk) {
            var row = lnk.parentNode.parentNode;
            var rowIndex = row.rowIndex;
            //Change the GridView Id here
            var objGridView = document.getElementById("<%=GridView1.ClientID %>");
            //Get all input elements in Gridview
            var inputList = objGridView.getElementsByTagName("input");
            //The First element is the Header Checkbox
            var headerCheckBox = inputList[rowIndex];
            var checked = true;
            var unchecked = false;
            if (inputList[rowIndex].type == "checkbox") {
                if (headerCheckBox.checked) {
                    document.getElementById('NextDiv').style.display = 'inline-block';
                }
                else {
                    document.getElementById('NextDiv').style.display = 'none';
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <div id="top_panel" style="vertical-align: top; background-color: aqua; height: 80px;">
        <div class="top_div">
            <label>
                <span>პროდუქციის შედარება
                </span>
            </label>
            <br />
            <br />
            <asp:ImageButton ID="Image1" runat="server" ImageUrl="http://icons.iconarchive.com/icons/icons8/windows-8/128/Editing-Compare-icon.png" Height="32px" ToolTip="ზედნადებებში არსებული პროდუქცია რომელიც არ არის ძველ ბაზაში" OnClick="Image1_Click" />
        </div>
        <div class="top_div">
            <label>
                <span>ზედნადებები
                </span>
            </label>
            <br />
            <br />
            <asp:ImageButton ID="Image2" runat="server" ImageUrl="https://cdn4.iconfinder.com/data/icons/Pretty_office_icon_part_2/128/earning-statements.png" Height="35px" OnClick="Image2_Click" />
        </div>
        <div id="NextDiv" class="top_div" style="display: none;">
            <label>
                <span>პროდუქცია
                </span>
            </label>
            <br />
            <br />
            <asp:Button ID="btn_next" runat="server" CssClass="NextButton" OnClick="btn_next_Click" />
        </div>
    </div>    

    <div id="wb_step1" runat="server" visible="false">
        <asp:GridView ID="GridView1" runat="server" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound" CssClass="rsGridHeaderRow CenterGrid" AutoGenerateColumns="False">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:TemplateField HeaderStyle-CssClass="SelectAll">
                        <HeaderTemplate> 
                            <asp:CheckBox ID="wb_chk_AllRows" runat="server" AutoPostBack="true" OnCheckedChanged="wb_chk_AllRows_CheckedChanged" ToolTip="ყველას მონიშვნა" style="display:none;" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="wb_chkRow" runat="server" onclick="return wb_chacked(this);" />
                        </ItemTemplate>
                    </asp:TemplateField>  
                
                <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="lbl_wb_seller" runat="server" Text='<%# Bind("seller") %>' Width="80px"></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="80px" />
                    <FooterStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                    <ItemStyle HorizontalAlign="Left" Width="80px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="lbl_wb_sellerTaxCode" runat="server" Width="120px"></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="120px" />
                    <FooterStyle Width="120px" />
                    <HeaderStyle Width="120px" />
                    <ItemStyle HorizontalAlign="Left" Width="120px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Left">                   
                    <ItemTemplate>
                        <asp:Label ID="lbl_wb_num" runat="server" Text='<%# Bind("waybills_number") %>' Width="100px"></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="100px" />
                    <FooterStyle Width="100px" />
                    <HeaderStyle Width="100px" />
                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="lbl_wb_cost" runat="server" Text='<%# Bind("wb_cost") %>' Width="75px"></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="75px" />
                    <FooterStyle Width="75px" />
                    <HeaderStyle Width="75px" />
                    <ItemStyle HorizontalAlign="Center" Width="75px" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="lbl_wb_date" runat="server" Text='<%# Bind("waybills_date") %>' Width="180px"></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="180px" />
                    <FooterStyle Width="180px" />
                    <HeaderStyle Width="180px" />
                    <ItemStyle HorizontalAlign="Left" Width="180px" />
                </asp:TemplateField>

            </Columns>
            <FooterStyle BackColor="ActiveCaption" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" VerticalAlign="Top" />
        </asp:GridView>
    </div>

    <div id="wb_step2" runat="server" visible="false">
        <asp:GridView ID="GridView2" runat="server" OnRowDataBound="GridView2_RowDataBound" ForeColor="#333333" GridLines="None" CssClass="rsGridHeaderRow CenterGrid" AutoGenerateColumns="False" ShowFooter="true">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>

                <asp:BoundField DataField="products_code" HeaderText="Art. №">
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                    <ControlStyle Width="100px" />
                    <FooterStyle Width="100px" />
                    <HeaderStyle Width="100px" />
                </asp:BoundField>

                <asp:TemplateField HeaderText="Art. Name">
                    <ItemTemplate>
                        <asp:Label ID="lbl_gds_name" runat="server" Width="250px"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="250px" />
                    <ControlStyle Width="250px" />
                    <FooterStyle Width="250px" />
                    <HeaderStyle Width="250px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Unit Name">
                    <ItemTemplate>
                        <asp:Label ID="lbl_unit_name" runat="server" Width="90px"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                    <ControlStyle Width="90px" />
                    <FooterStyle Width="90px" />
                    <HeaderStyle Width="90px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Unit Price">
                    <FooterTemplate>
                        <asp:Button ID="btn_InsDiffGoods" runat="server" CssClass="NextButton" OnClick="btn_InsDiffGoods_Click" />
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbl_unit_price" runat="server" Width="90px"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                    <ControlStyle Width="90px" />
                    <FooterStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />                   
                    <HeaderStyle Width="90px" />
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" VerticalAlign="Top" />
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView>
    </div>

    <div id="wb_content" runat="server" class="CenterGrid" style="vertical-align: top; min-height: 80px;" visible="false">
        <asp:Label ID="lbl_slrName" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lbl_slrId" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lbl_isSupplier" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lbl_wbCost" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lbl_wbDate" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lbl_wbNumber" runat="server"></asp:Label>
        <br />
        <asp:DropDownList ID="ddl_Pay_Method_Id" runat="server" CssClass="rsGridSelect" Width="100%">
            <asp:ListItem Selected="True" Value="0">გადახდის მეთოდი</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:TextBox ID="txt_wbPaid" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="btn_wbInsert" runat="server" Text="Insert" OnClick="btn_wbInsert_Click" />
        

    </div>
    <br />
    <asp:GridView ID="GridView3" runat="server" GridLines="None" CssClass="rsGridHeaderRow CenterGrid" Visible="false">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" VerticalAlign="Top" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    
</asp:Content>
