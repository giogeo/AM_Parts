<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="Ribbon_WebApp.search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">
    <style type="text/css">
        #master-page {
            height: 82vh;
            background-color: aqua;
            background-size: 100% 100%;
        }

        #header {
            position: fixed !important;
            top: 1%0 !important;
            width: 13%;
            min-height: 80px;
            z-index: 1000;
            text-transform: capitalize;
        }

        #footer {
            bottom: 0;
            position: fixed !important;
            bottom: 0 !important;
            width: 100%;
        }

        #CarBrands_list {
            display: none;
        }

        .search-bar {
            position: fixed !important;
            top: 1%0 !important;
            left: 0;
            width: auto;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.1);
            max-height: calc(100vh - 100px);
            z-index: 1000;
            overflow-y: scroll;
        }

        .search-bar .list_cats {
            border: solid 1.8px #7f7f7f;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            background-color: white;
            width: auto;
            max-width: 99%;
            height: 30px;
            padding-top: 5px;
        }

        .search-bar table {
            background-color: white;
            width: 100%;
        }

        .content-bar {
            position: fixed !important;
            top: 1%0 !important;
            left: 200px;
            padding-left: 50px;
            width: 100%;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.1);
            max-height: calc(100vh - 100px);
            z-index: 1000;
            overflow-y: scroll;
        }

        .items-list {
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        div .items-list {
            display: inline-block;
            vertical-align: middle;
        }

        ::-webkit-scrollbar {
            width: 0;
        }
    </style>
    <script type="text/javascript">
        function SelectAll(id) {

            var frm = document.forms[0];

            for (i = 0; i < frm.elements.length; i++) {

                if (frm.elements[i].type == "checkbox") {
                    if (frm.elements[i].disabled == false)
                        frm.elements[i].checked = id.checked;
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <div id="master-page">
        <div class="search-bar">
            <asp:TextBox ID="txt_names" runat="server" Style="border: solid 1.8px #7f7f7f; -moz-border-radius: 4px; -webkit-border-radius: 4px; height: 28px;" onclick="this.placeholder='';" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'დასახელება':this.placeholder;" placeholder="დასახელება" />
            <div class="list_cats">
                <asp:TextBox ID="txt_n" runat="server" Style="box-shadow: none; outline: none; border: 0px; height: 28px; max-width: 160px; vertical-align: top" onclick="document.getElementById('CarBrands_list').style.display = 'block'; this.placeholder = '';" onfocus="this.select()" onblur="this.placeholder=!this.placeholder?'მარკა/მოდელი':this.placeholder;" placeholder="მარკა/მოდელი" MaxLength="10" ReadOnly="True" />
                <img class="common_sprite selected" src="https://cdn4.iconfinder.com/data/icons/mayssam/512/up-128.png" style="margin-left: 2px;" width="24" height="24" onclick="document.getElementById('CarBrands_list').style.display='none';" />
            </div>
            <div id="CarBrands_list">
                <asp:GridView ID="GridView1" runat="server" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
                    AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkRow" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Width="165" />
                    </Columns>
                </asp:GridView>
                <div class="">
                    <label style="float: left; padding-top: 3px;">
                        <input id="unchk" type="button" value="მონიშნულების მოხსნა" onclick="SelectAll(this);" class="rsButton" style="width: 100%; padding: 5px; font-size: medium; font-weight: bolder;" /><br />
                    </label>
                </div>                
            </div>
            <asp:Button ID="Button1" runat="server" CssClass="rsButton" OnClick="GetSelectedRecords" Style="width: 100%; height: 38px; font-size: x-large; font-weight: bolder;" Text="ძ  ე  ბ  ნ  ა" />

        </div>
        <!-- /search-navbar -->   
        

        <div class="content-bar">
            <asp:ListView ID="ListResults" runat="server">
                <ItemTemplate>
                    <asp:Panel ID="ItemsList" runat="server" CssClass="items-list product-view">

                        <div class="product-left">
                            <div class="thumb" style="overflow: hidden;">
                                <img id="itemThumb" src="/uploads/no_image.png" width="300" border="0" alt="<%#  Eval("name") %>" data-original-img="/uploads/no_image.png" style="cursor: pointer;">
                            </div>
                        </div>

                        <div class="product-right">
                            <h2><%#  Eval("name") %> </h2>

                            <div class="product-details">
                                <div class="info">ბრენდი: <span><%#  Eval("Manufacturer") %></span></div>
                                <div class="info">არტიკული: <span><%#  Eval("ProductCode") %></span></div>
                                <div class="info">OEM: <span><%#  Eval("OEM") %></span></div>


                                <div class="share">
                                </div>

                                <div class="price"><%#  Eval("Price") %> GEL</div>


                                <div class="stocksWrapper">
                                    <div class="InStock">*</div>

                                    <div class="InStock">მარაგში</div>
                                </div>
                            </div>
                            <div class="divider"></div>
                            <div class="product-description">
                                <div class="desc-title">მიესადაგება: </div>
                                <div class="desc-title"><%#  Eval("comment") %></div>
                            </div>

                            <div class="divider"></div>
                            <div class="note">*გთხოვთ, გაითვალისწნოთ, ინფორმაცია პროდუქციის შესახებ მიღებულია გუშინდელი ბაზიდან.</div>

                            <div class="clear"></div>
                        </div>
                    </asp:Panel>
                </ItemTemplate>
                <EmptyDataTemplate>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
        <!-- /content-navbar -->
    </div>
</asp:Content>