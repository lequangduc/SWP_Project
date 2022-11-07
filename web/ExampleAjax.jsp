<%-- 
    Document   : ExampleAjax
    Created on : Oct 28, 2022, 8:11:08 AM
    Author     : lenovo
--%>

<%@page import="entity.TablesType"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TableTypeDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <select name="type" id="type">
            <option value="">Select type...</option>
            <%
                TableTypeDAO dao = new TableTypeDAO();
                ArrayList<TablesType> typeList = dao.getAllListType();

            %>
            <%for (TablesType t : typeList) {%>
            <option value="<%=t.getType_id()%>"><%=t.getTypeName()%></option>
            <%}%>
        </select>
        <label for="select12">Type Table</label>

        <select name="type" id="table">
            <option value="">Select table...</option>
        </select>
        <label for="select12">Table</label>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#type').change(function () {
                    var id = $(this).val();
                    console.log(id);
                    $.ajax({
                        url: 'TableServlet',
                        type: 'POST',
                        data: {"type_ID": id},
                        error: function ()
                        {
                            console.log("error");
                        },
                        success: function (data) {
                            $("#table")
                                    .find('option')
                                    .remove()
                                    .end()
                            for (var i = 0; i < data.length; i++)
                            {
                                if (data[i].status === 'available')
                                {
                                    $("#table")
                                            .append($("<option>",
                                                    {
                                                        value: data[i].table_id,
                                                        text: 'table no: ' + data[i].table_id
                                                    }));
                                }
                            }
                        }
                    });
                });
            });
        </script>
    </body>
</html>
