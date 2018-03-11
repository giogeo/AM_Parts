<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="add_procurement.aspx.cs" Inherits="Ribbon_WebApp.add_procurement" %>
<%@ Register Assembly="SlimeeLibrary" Namespace="SlimeeLibrary" TagPrefix="cc2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Left_side" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Center_side" runat="server">
    <div class="textbox">

        <div>
            <h1>
                ტენდერები</h1>
            <h2>
                ახალი ტენდერის დამატების ფორმა</h2>
            <table style="text-align: left; width: 100%;">
                <tr>
                    <th>ტენდერის ნომერი SPA</th>   <th>შემსყიდველი</th>
                </tr>                
                <tr>                    
                    <td><asp:TextBox ID="txt_tndr_num" runat="server" Height="20px" Width="200px"></asp:TextBox></td>   <td><asp:DropDownList ID="dropdown_suppliers" runat="server" Height="25px" Width="205px">
                </asp:DropDownList></td>
                </tr>

                 <tr>
                    <th>ტენდერის ჩატარების თარიღი</th>   <th>ტენდერის მოქმედების ვადა</th>
                </tr>
                <tr>
                    <td><cc2:DatePicker ID="txt_tndr_date" runat="server" Width="180px" SelectedStyle-HorizontalAlign="Left" FirstDayOfWeek="Monday" Height="20px" PaneWidth="300px" Font-Bold="True" CalendarTableStyle-HorizontalAlign="Left"></cc2:DatePicker></td>   
                    <td><cc2:DatePicker ID="txt_tndr_ends" runat="server" Width="180px" SelectedStyle-HorizontalAlign="Left" FirstDayOfWeek="Monday" Height="20px" PaneWidth="300px" Font-Bold="True" CalendarTableStyle-HorizontalAlign="Left"></cc2:DatePicker></td>
                
                </tr>

                 <tr>
                    <th>ტენდერის ფასი</th>   <th>ტენდერის კატეგორია</th>
                </tr>
                <tr>
                    <td><asp:TextBox ID="txt_tndr_price" runat="server" Height="20px" Width="200px"></asp:TextBox></td>   <td><asp:TextBox ID="txt_tndr_cat" runat="server" Height="20px" Width="200px"></asp:TextBox></td>
                </tr>
                <tr>
                    <th colspan="2"><br /><br /><label>ტენდერით გათვალისწინებული საქონლის ჩამონათვალი</label><br /><br /></th> 
                </tr> 
                </table>  
        </div>
       
        <div style="width:89%; vertical-align:top; margin-left:-40px;">  
            <table>
                <tr>
                    <td colspan="2">                        
                        <asp:UpdatePanel ID="Up1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" >
                        <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" GridLines="None" HorizontalAlign="Justify" CssClass="grid">
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                
                               <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>                                       
                                        <asp:TextBox ID="txt_TenderId" runat="server" Text='<%# Bind("ItemID") %>' Width="5px" visible="false"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                
                                 <asp:TemplateField HeaderText="საქონლის სახელი">
                                    <ItemTemplate>                                       
                                        <asp:TextBox ID="txt_TenderName" runat="server" Text='<%# Bind("ItemName") %>' Width="330px" ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="ზომის ერთ.">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_TenderUnit" runat="server" Text='<%# Bind("ItemUnit") %>' Width="50px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="რაოდ.">
                                    <ItemTemplate>                                  
                                        <asp:TextBox ID="txt_TenderQty" runat="server" Text='<%# Bind("ItemQty") %>' Width="40px"></asp:TextBox>                                    
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="ფასი">
                                    <ItemTemplate>                                  
                                        <asp:TextBox ID="txt_TenderPrice" runat="server" Text='<%# Bind("ItemPrice") %>' Width="50px"></asp:TextBox>                                    
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="საქ.კოდი">
                                    <ItemTemplate>
                                        <asp:UpdatePanel runat="server" ID="UpId" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                            <ContentTemplate>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txt_TenderItemCode" UseContextKey="true" CompletionInterval="500" ServiceMethod="GetCompletionList" MinimumPrefixLength="2">
                                                </cc1:AutoCompleteExtender>
                                                <asp:TextBox ID="txt_TenderItemCode" runat="server" Text='<%# Bind("ItemCode") %>' Width="150px" OnTextChanged="TxtId_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            </ContentTemplate> 
                                        </asp:UpdatePanel>                                       
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                        </ContentTemplate>
                        </asp:UpdatePanel>                       
                        
                    </td> 
                </tr>
            </table>                   
        </div>

        <div>                                    
            <asp:ImageButton ID="Btn_Add_Rows" runat="server" OnClick="Btn_addrow_clicked" ImageUrl="ribbon/images/add__rows.png" ToolTip="სტრიქონის დამატება" Height="38px" />                                        
            <asp:TextBox ID="nun_of_rows" runat="server"></asp:TextBox>
            <asp:ImageButton ID="Btn_Add_To_DB" runat="server" OnClick="Btn_Add_To_DB_clicked" ImageUrl="ribbon/images/Folder-Add-icon.png" ToolTip="ბაზაში დამატება" Height="29px"/>
        </div>

        <div>                    
            <h2>
                <asp:Label ID="Label1" runat="server"></asp:Label> <span>Copyright &copy; 2015: ავტორი  გიორგი გოგოლაძე.</span>
            </h2>
            
        </div>
        
    </div>
</asp:Content>
