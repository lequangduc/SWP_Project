<%-- 
    Document   : navigation
    Created on : Oct 5, 2022, 2:05:09 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
            <nav id="sidebar" class="sidebar js-sidebar">
                <div class="sidebar-content js-simplebar">
                    <a class="sidebar-brand" href="index.html">
                        <span class="align-middle">Admin Page</span>
                    </a>
                    <ul class="sidebar-nav" >
                        <li class="sidebar-header">
                            Dashboard
                        </li>
                        <li class="sidebar-header" data-toggle="collapse" data-target="#pagecomponent">
                            Manage Order
                        </li>
                        <div id="pagecomponent" class="collapse">
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="index.html">
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
                        <li class="sidebar-header" data-toggle="collapse" data-target="#toolcomponent">
                            Manage Food
                        </li>
                        <div id="toolcomponent" class="collapse">
                            <li class="sidebar-item" data-toggle="collapse" data-target="#subcomponent1">
                                <span class="sidebar-link">
                                     <span class="align-middle">Manage Category</span>
                                </span>
                            </li>
                            <div id="subcomponent1" class="collapse">
                                <li class="sidebar-item" >
                                    <a class="sidebar-link">
                                         <span class="align-middle subtype">&nbsp + Add Category</span>
                                    </a>
                                </li>
                                <li class="sidebar-item" >
                                    <a class="sidebar-link">
                                        </re> <span class="align-middle subtype">&nbsp + Category List</span>
                                    </a>
                                </li>
                            </div>
                            
                            <li class="sidebar-item" data-toggle="collapse" data-target="#subcomponent2">
                                <a class="sidebar-link">
                                     <span class="align-middle">Manage Food</span>
                                </a>
                            </li>
                            <div id="subcomponent2" class="collapse">
                                <li class="sidebar-item" >
                                    <a class="sidebar-link">
                                         <span class="align-middle subtype">&nbsp + Add Food</span>
                                    </a>
                                </li>
                                <li class="sidebar-item" >
                                    <a class="sidebar-link">
                                         <span class="align-middle subtype">&nbsp + Food List</span>
                                    </a>
                                </li>
                                <li class="sidebar-item" >
                                    <a class="sidebar-link">
                                         <span class="align-middle subtype">&nbsp + Menu Food</span>
                                    </a>
                                </li>
                                
                            </div>
                            
                            
                        </div>

                        <li class="sidebar-header" data-toggle="collapse" data-target="#tablecomponent" >
                            Manage Table
                        </li>
                        <div id="tablecomponent" class="collapse">
                            <li class="sidebar-item">
                                <a class="sidebar-link" href="charts-chartjs.html">
                                     <span class="align-middle">Table List</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a class="sidebar-link" href="maps-google.html">
                                    <span class="align-middle">Table Setting</span>
                                </a>
                            </li>
                        </div>
                      <li class="sidebar-header" data-toggle="collapse" data-target="#plugincomponent" >
                            Reservation 
                        </li>
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
                    </ul>


                </div>
            </nav>
        
    </body>
</html>
