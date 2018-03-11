<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessDB.aspx.cs" Inherits="Ribbon_WebApp.AccessDB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="style.css" rel="Stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="92%" cellpadding="3" cellspacing="1" rules="rows">
                          <thead>
                            <tr>
                              <th align="left"><h3 title="დასახელება">დასახელება</h3></th>                             
                            
                              <th align="left"><h3 title="საგადასახადო კოდი">კოდი</h3></th>                             
                            
                              <th align="left"><h3 title="იურიდიული მისამართი">მისამართი</h3></th>                             
                            </tr>
                          </thead>
        <asp:ListView ID="ListView01" runat="server" DataSourceID="DataList" Visible="true">
             <ItemTemplate>
                            
                      
                        
                          <tbody>
                            <tr>
                              <td align="left" ><label title='ტენდერის SPA ნომერი'><%#  Eval("companyName") %></label></td>
                                <td align="left" ><label title='ტენდერის SPA ნომერი'><%#  Eval("taxID") %></label></td>
                              <td align="right" ><label title='ტენდერის კატეგორია'><%#  Eval("regAddress") %></label></td>
                            </tr>
                          </tbody>    
                            
                                            
                                              
             
             </ItemTemplate>
             <EmptyDataTemplate>                
                
             </EmptyDataTemplate>
             </asp:ListView>
            </table>
            <asp:AccessDataSource ID="DataList" runat="server" DataFile="SuppliersDB.accdb" SelectCommand="select * from companies where id < 5" ></asp:AccessDataSource>
    </div>
        <asp:TextBox ID="TextBox1" runat="server" AutoPostBack="true"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="ჩასწორება" OnClick="Button1_Click" />

        <asp:GridView ID="GridView1" runat="server" ForeColor="#333333" GridLines="None" Width="97%" AutoGenerateColumns="False">
            <Columns>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <table width="92%" cellpadding="3" cellspacing="1" rules="rows" class="rsGrid">
                            <tr>
                                <td>
                                    <asp:Label ID="CompanyName" runat="server" Text='<%# Bind("companyName") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="TaxID" runat="server" Text='<%# Bind("taxID") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="RegAddress" runat="server" Text='<%# Bind("regAddress") %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Mobile" runat="server" Text='<%# Bind("mobile") %>'></asp:Label>
                                </td>
                            </tr>
                        </table>                        
                    </ItemTemplate>
                </asp:TemplateField>                
            </Columns>
        </asp:GridView>
        
    </form>
</body>
</html>
