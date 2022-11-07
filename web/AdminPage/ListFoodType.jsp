<%-- 
    Document   : ListFoodType
    Created on : Oct 28, 2022, 10:15:13 AM
    Author     : admin
--%>


<%@page import="java.util.Map"%>
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
            table {
                border-collapse: collapse;
                border-spacing: 0;
                margin: 0 auto;
                width: 700px;
            }

            table th,
            table td {
                border: 1px solid #ccc;
                padding: 10px;
            }

            table th {
                background-color: #f3f3f3;
            }
            h2{
                text-align: center;
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
                <h2>LIST FOOD TYPE</h2>

                    <p style="color:red; display: block;"><%=(request.getAttribute("Status") == null) ? ""
                            : request.getAttribute("Status")%></p> 
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Number Of Dish</th>
                            <th>Action</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        
                        <c:forEach var="types" items="${db.listAllTypeName}">
                        <tr>
                            <td>${types.idfoodtype}</td>
                            <td>${types.foodtypename}</td>
                            <td>${db.countDish(types.idfoodtype)}</td>
                            <td><button><a href="${request.contextPath}/SWP_Project/AdminPage/UpdateFoodType.jsp?idtype=${types.idfoodtype}">Update</a></button></td>
                            <c:if test="${db.countDish(types.idfoodtype) > 0}">
                                <td><button onClick="alert('Cann\'t Delete This Type ')"><a href="#">Delete</a></button></td>
                            </c:if>
                            <c:if test="${db.countDish(types.idfoodtype) == 0}">
                                <td><button><a href="${request.contextPath}/SWP_Project/ManageFood?type=deletetypefood&idtype=${types.idfoodtype}">Delete</a></button></td>
                            </c:if>
                            
                        </tr>
                       </c:forEach>



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
