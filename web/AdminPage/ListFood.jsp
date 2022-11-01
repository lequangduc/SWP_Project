<%-- 
    Document   : ListFood
    Created on : Oct 25, 2022, 10:35:33 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.FoodDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
        <meta name="author" content="AdminKit">
        <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

        <!--        <link rel="preconnect" href="https://fonts.gstatic.com">-->
        <link rel="shortcut icon" href="img/icons/icon-48x48.png" />

        <link rel="canonical" href="https://demo-basic.adminkit.io/" />


        <style>
            table tr td{
                padding: 20px .625em .625em .625em;   

            }
            table tr th{
                padding: 20px .625em .625em .625em;   
                text-align: center;
            }
            table{
                margin-right: auto;
                margin-left: auto;
            }
            input{
                padding:10px 20px 10px 20px;
            }
            h2{
                text-align: center;
            }
            input{width: 500px;text-align: center}
            .row-content{
                display: flex;
            }
        </style>
        <link href="./css/app.css" rel="stylesheet"/>
        <link href="./css/mycss.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css"/>
    </head>
    <body>
        <jsp:useBean id="db" class="DAO.FoodDAO" />
        <div class="wrapper">
            <%@include file="../AdminPage/navigation.jsp" %>

            <div class="main">
                <%@include file="../AdminPage/navbar.jsp" %>
                <h2>LIST ALL FOOD</h2>
                <div class="row-content">
                    <button><a href="${request.contextPath}/SWP_Project/ManageFood?type=all">All Food</a></button>
                    <c:forEach var="item" items="${db.listAllTypeName}">
                        <button><a href="${request.contextPath}/SWP_Project/ManageFood?type=${item.foodtypename}">${item.foodtypename}</a></button>
                    </c:forEach>
                    
                    
                </div>
                     <p style="color:red; display: block;"><%=(request.getAttribute("Status") == null) ? ""
                            : request.getAttribute("Status")%></p> 
                <table border="1">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Type</th>
                            <th>Description</th>
                            <th>Action</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="type" value="${requestScope.type}"/>
                        
                        <c:if test="${type == null || type == ''}">
                            <c:forEach var="pt" items="${db.listAllFood}">
                                <tr>
                                    <td>${pt.name}</td>
                                    <td>${pt.price}</td>
                                    <td>${db.getFoodTypeName(pt.foodtype_id)}</td>
                                    <td>${pt.foodDescription}</td>
                                    <td><button><a href="${request.contextPath}/SWP_Project/AdminPage/UpdateFoodPage.jsp?idfood=${pt.food_id}">Update</a></button></td>
                                    <td><button><a href="${request.contextPath}/SWP_Project/ManageFood?type=delete&id=${pt.food_id}">Delete</a></button></td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${type != null}">
                            <c:forEach var="pt" items="${db.getListFoodByType(type)}">
                                <tr>
                                    <td>${pt.name}</td>
                                    <td>${pt.price}</td>
                                    <td>${db.getFoodTypeName(pt.foodtype_id)}</td>
                                    <td>${pt.foodDescription}</td>
                                    <td><button><a href="${request.contextPath}/SWP_Project/UpdateFoodPage.jsp?idfood=${pt.food_id}">Update</a></button></td>
                                    <td><button><a href="${request.contextPath}/SWP_Project/ManageFood?type=delete&id=${pt.food_id}">Delete</a></button></td>
                                </tr>
                            </c:forEach>
                        </c:if>

                    </tbody>
                </table>

                    <p style="color:red; display: block;"><%=(request.getAttribute("errMessage") == null) ? ""
                        : request.getAttribute("errMessage")%></p>
                <p style="color:red; display: block;"><%=(request.getAttribute("Message") == null) ? ""
                            : request.getAttribute("Message")%></p>  
                    <%@include file="footer.jsp"%>
            </div>

        </div>
        <script src="../js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    </body>
</html>
