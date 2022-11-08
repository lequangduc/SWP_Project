<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.FoodDAO"%>
<!DOCTYPE html>
<html>
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

        <title>AdminKit Demo - Bootstrap 5 Admin Template</title>

        <link href="./css/app.css" rel="stylesheet">
        <link href="./css/mycss.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    </head>


    <body>
        <jsp:useBean id="db" class="DAO.FoodDAO" />
        <div class="wrapper">
            <%@include file="../AdminPage/navigation.jsp" %>

            <div class="main">
                <%@include file="../AdminPage/navbar.jsp" %>
                <main class="content">
                    <div class="container">
                        <div class="card-title text-center mb-5">Update food</div>
                        <form action="${request.contextPath}/SWP_Project/ManageFood" method="POST" >
                    <c:set var="idfood" value="${param.idfood}"/>
                    <c:set var="food" value="${db.getFoodByID(idfood)}"/>
                    <input type="hidden" name="action" value="updatefood"/>
                            <div class="form-group">
                                <label for="idfood">ID Food</label>
                                <input type="text" class="form-control" id="idfood" name="idfood" readonly value="${food.food_id}">
                            </div>
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" value="${food.name}">
                            </div>
                            <div class="form-group">
                                <label for="product type">Product type</label>
                                <select name="type">
                                        <option value="${db.getFoodTypeName(food.foodtype_id)}">${db.getFoodTypeName(food.foodtype_id)}</option>
                                        <c:forEach var="pt" items="${db.listAllTypeName}">
                                            <c:if test="${db.getFoodTypeId(pt)!= food.foodtype_id}">
                                            <option value="${pt}">${pt}</option>
                                            </c:if>
                                        </c:forEach> 
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="price">Price</label>
                                <input type="number" min="0" step=1000 class="form-control" id="price" name="price" placeholder="Enter price" value="${food.price}">
                            </div>
                            <div class="form-group">
                                <label for="product info">Product info</label>
                                <textarea class="form-control" id="info" name="info" rows="3" >${food.foodDescription}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="image">Image</label>
                                <input type="text" class="form-control-file" id="image" name="image" value="${food.foodImage}">
                            </div>
                            <div class="form-group">
                            <input type="submit" name="action" value="Update">
                            </div>
                </form>
                            <p style="color:red; display: block;"><%=(request.getAttribute("errMessage") == null) ? ""
                    : request.getAttribute("errMessage")%></p>
                <p style="color:red; display: block;"><%=(request.getAttribute("Message") == null) ? ""
                    : request.getAttribute("Message")%></p>  
                    </div>
                </main>
            </div>

        </div>
        <script src="../js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    </body>
</html>

