<%-- 
    Document   : navigation
    Created on : Oct 5, 2022, 2:05:09 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
        <link rel="stylesheet" href="AdminPage/css/mycss.css">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
            <%-- <nav id="sidebar" class="sidebar js-sidebar">
                <div class="sidebar-content js-simplebar">
                    <a class="sidebar-brand" href="index.jsp">
                        <span class="align-middle">Admin Page</span>
                    </a>
                    <ul class="sidebar-nav" >
                        <li class="active"><a href="${request.contextPath}/SWP_Project/AdminPage"><button style="border:none" class="sidebar-header">
                            Dashboard
                        </button></a></li>
                        <li class="active"><button style="border:none;" class="sidebar-header" data-toggle="collapse" data-target="#pagecomponent">
                            Manage Order
                        </button></li>
                        <div id="pagecomponent" class="collapse">
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="index.jsp">
                                     <span class="align-middle">Order List</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="pages-profile.html">
                                     <span class="align-middle">Cancel Order</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="pages-sign-in.html">
                                    <span class="align-middle">Pending Order</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="pages-sign-up.html">
                                     <span class="align-middle">Complete Order</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="pages-blank.html">
                                     <span class="align-middle">Blank</span>
                                </a>

                            </li>
                        </div>
                        
                        <li class="active"><button style="border:none" class="sidebar-header" data-toggle="collapse" data-target="#toolcomponent">
                            Manage Food
                        </button></li>
                        <div id="toolcomponent" class="collapse">
                            <li class="sidebar-item" data-toggle="collapse" data-target="#subcomponent1">
                                <span class="sidebar-link">
                                     <span class="align-middle">Manage Category</span>
                                </span>
                            </li>
                            <div id="subcomponent1" class="collapse">
                                <li class="sidebar-item" >
                                    <a class="sidebar-link" href="${request.contextPath}/SWP_Project/ManageFood?link=AddFoodType.jsp">
                                         <span class="align-middle subtype">&nbsp + Add Category</span>
                                    </a>
                                </li>
                                <li class="sidebar-item" >
                                    <a class="sidebar-link" href = "${request.contextPath}/SWP_Project/ManageFood?link=ListFoodType.jsp">
                                        </re> <span class="align-middle subtype">&nbsp + Category List</span>
                                    </a>
                                </li>
                            </div>
                            
                            <li class="sidebar-item" data-toggle="collapse" data-target="#subcomponent2">
                                <a class="sidebar-link" >
                                     <span class="align-middle">Manage Food</span>
                                </a>
                            </li>
                            <div id="subcomponent2" class="collapse">
                                <li class="sidebar-item" >
                                    <a class="sidebar-link" href = "${request.contextPath}/SWP_Project/ManageFood?link=AddFoodPage.jsp">
                                         <span class="align-middle subtype">&nbsp + Add Food</span>
                                    </a>
                                </li>
                                <li class="sidebar-item" >
                                    <a class="sidebar-link" href="${request.contextPath}/SWP_Project/ManageFood?link=ListFood.jsp">
                                         <span class="align-middle subtype">&nbsp + Food List</span>
                                    </a>
                                </li>
                                
                            </div>
                            
                            
                        </div>

                        <li class="active"><button style="border:none;" class="sidebar-header" data-toggle="collapse" data-target="#tablecomponent" >
                            Manage Table
                        </button></li>
                        <div id="tablecomponent" class="collapse">
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="${request.contextPath}/SWP_Project/TableServlet?action=managetablelist">
                                     <span class="align-middle">Table List</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="${request.contextPath}/SWP_Project/TableServlet?action=settable">
                                    <span class="align-middle">Table Setting</span>
                                </a>
                            </li>
                        </div>
                      <li class="active"><button style="border:none;" class="sidebar-header" data-toggle="collapse" data-target="#plugincomponent" >
                            Reservation 
                        </button></li>
                        <div id="plugincomponent" class="collapse">
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="charts-chartjs.html">
                                     <span class="align-middle">Reservation</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="maps-google.html">
                                    <span class="align-middle">Add Reservation</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="maps-google.html">
                                    <span class="align-middle">Unavailable day</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="maps-google.html">
                                    <span class="align-middle">Reservation Setting</span>
                                </a>
                            </li>
                        </div>
                        <li class="active"><button style="border: none;" class="sidebar-header" data-toggle="collapse" data-target="#subcomponent3" >
                            Manage Employee Accounts
                        </button></li>
                        <div id="subcomponent3" class="collapse">
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="${request.contextPath}/SWP_Project/AdminPage/AccountList.jsp">
                                     <span class="align-middle">Accounts List</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="${request.contextPath}/SWP_Project/AdminPage/CreateAccount.jsp">
                                    <span class="align-middle">Create Accounts</span>
                                </a>
                            </li>
                        </div>
                    </ul>


                </div>
            </nav> --%>
        
    </body>
</html>
