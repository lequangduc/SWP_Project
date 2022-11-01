<%@page import="entity.TableDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
   
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="img/icons/icon-48x48.png" />

    <link rel="canonical" href="https://demo-basic.adminkit.io/" />

    <title>Manage Table List</title>

    <link href="./css/app.css" rel="stylesheet">
    <link href="./css/mycss.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

</head>
<body>
    <div class="wrapper">
        <%@include file="navigation.jsp" %>
        <div class="main">
            <%@include file="navbar.jsp" %>
            <div class="content">
                <!-- search table -->
                <div class="container-fluid p-0">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">Search Table</h5>
                                </div>
                                <div class="card-body">
                                    <form action="TableServlet?action=searchtable" method="post">
                                        <div class="row">
                                            <div class="col-md-6 col-xl-3">
                                                <div class="form-group  mb-3">
                                                    <label class="form-label" for="inputState">Table Status</label>
                                                    <select id="inputState" class="form-control" name="status_search">
                                                        <option value="all">All</option>
                                                        <option value="available">Available</option>
                                                        <option value="reserved">Reserved</option>
                                                        <option value="occupied">Occupied</option>
                                                    </select>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-6 col-xl-3">
                                                <div class="form-group  mb-3">
                                                    <label class="form-label    " for="inputState">Table Type</label>
                                                    <select id="inputState" class="form-control" name="type_search">
                                                        <option value="all">All</option>
                                                        <%
                                                            ArrayList<String> listTableType = (ArrayList<String>) request.getAttribute("tableTypeName");
                                                            for (String tableType : listTableType) {
                                                                out.println("<option value='" + tableType + "'>" + tableType + "</option>");
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- search button -->
                                            <div class="col-md-6 col-xl-3">
                                                <div class="form-group  mb-3">
                                                    <label class="form-label    " for="inputState">Search</label>
                                                    <button type="submit" class="btn btn-primary btn-block">Search</button>
                                                </div>
                                            </div>
                                            <!-- add button click add show modal -->
                                            <div class="col-md-6 col-xl-3">
                                                <div class="form-group  mb-3">
                                                    <label class="form-label    " for="inputState">Add</label>
                                                    <button type="button" class="btn btn-primary btn-block" data-toggle="modal" data-target="#addTableModal">Add</button>
                                                </div>
                                            </div>
                                            <!-- <div class="col-md-6 col-xl-3">
                                                <div class="form-group  mb-3">
                                                    <label class="form-label    " for="inputState">Add</label>
                                                    <a id="addTableButton" class="btn btn-primary btn-block">Add</a>
                                                </div>
                                            </div> -->
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- create modal to add table -->
                <div class="modal fade  " id="addTableModal" tabindex="-1" role="dialog" aria-labelledby="addTableModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addTableModalLabel">Add Table</h5>
                                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body  ">
                                <form action="TableServlet?action=addtable" method="post">
                                    <div class="row">
                                        <div class="col-md-6 col-xl-6">
                                            <div class="form-group  mb-3">
                                                <label class="form-label" for="inputState">Table Type</label>
                                                <select id="inputState" class="form-control" name="type_add">
                                                    <%
                                                       
                                                        for (String tableType : listTableType) {
                                                            out.println("<option value='" + tableType + "'>" + tableType + "</option>");
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-xl-6">
                                            <div class="form-group  mb-3">
                                                <label class="form-label    " for="inputState">Table Status</label>
                                                <select id="inputState" class="form-control" name="status_add">
                                                    <option value="available">Available</option>
                                                    <option value="reserved">Reserved</option>
                                                    <option value="occupied">Occupied</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Add</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- create modal to update table -->
                <div class="modal fade  " id="updateTableModal" tabindex="-1" role="dialog" aria-labelledby="updateTableModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateTableModalLabel">Update Table</h5>
                                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body  ">
                                <form action="TableServlet?action=updatetable" method="post">
                                    <div class="row">
                                        <div class="col-md-6 col-xl-6">
                                            <div class="form-group  mb-3">
                                                <label class="form-label" for="inputState">Table Type</label>
                                                <!-- data type -->
                                                <select class="form-control" name="type_update">
                                                    <%
                                                       
                                                        for (String tableType : listTableType) {
                                                            out.println("<option value='" + tableType + "'>" + tableType + "</option>");
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-xl-6">
                                            <div class="form-group  mb-3">
                                                <label class="form-label    " for="inputState">Table Status</label>
                                                <select id="inputState" class="form-control" name="status_update">
                                                    <option value="available">Available</option>
                                                    <option value="reserved">Reserved</option>
                                                    <option value="occupied">Occupied</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="idtable_makeupdate" id="idtable_makeupdate" value=""/>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Update</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- create modal to corfirm delete table -->
                <div class="modal fade  " id="deleteTableModal" tabindex="-1" role="dialog" aria-labelledby="deleteTableModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteTableModalLabel">Delete Table</h5>
                                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body  ">
                                <form action="TableServlet?action=deletetable" method="post">
                                    <div class="row">
                                        <div class="col-md-12 col-xl-12">
                                            <div class="form-group  mb-3">
                                                <label class="form-label" for="inputState">Are you sure to delete this table?</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <input type="hidden" name="idtable_makedelete" id="idtable_makedelete" value=""/>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Delete</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- create modal to view table -->

                

                <!-- create table list from database -->
                <table class="table" id="table_0">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Table Type</th>
                            <th scope="col">Capacity</th>
                            <th scope="col">Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<TableDetail> tableList = (ArrayList<TableDetail>)request.getAttribute("tableList");
                            for (TableDetail table : tableList) {
                            
                        %>
                            <tr>
                                <th scope="row"><%=table.getTableID()%></th>
                                <td><%=table.getType()%></td>
                                <td><%=table.getCapacity()%></td>
                                <td><%=table.getStatus()%></td>
                                <td>
                                    <!-- update button send table information to modal -->
                                    <button type="button" id="open-updateTableDialog" class="btn btn-primary" data-toggle="modal" data-target="#updateTableModal"  onClick="onClick_toUpdate('<%=table.getTableID()%>')">
                                        Update
                                    </button>

                                    
                                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteTableModal" onClick="onClick_toDelete('<%=table.getTableID()%>')">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        <% } %>

                       

                    </tbody>

                </table>

            </div>
        </div>
    </div>
    <script>
        // pass table information to update modal
        function onClick_toUpdate(tableID) {
            
            $('#idtable_makeupdate').val(tableID);
            console.log(tableID);
        };

        // pass table information to delete modal
        function onClick_toDelete(tableID) {
            $('#idtable_makedelete').val(tableID);
            console.log(tableID);
        };
        

    </script>
    <script src="js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
</body>
</html>