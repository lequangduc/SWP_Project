<%-- 
    Document   : KitchenStaffHomePage
    Created on : Nov 7, 2022, 4:59:07 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAO.TableDAO"%>
<%@page import="DAO.ReservationDAO"%>
<%@page import="DAO.FoodDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cashier Home Page</title>


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
            .parts {
                background-color:#fff;
                min-height: calc(100vh - 100px);
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(223.33px, 1fr));
                grid-template-rows: repeat(auto-fit, minmax(96px, 1fr));
            }
            .part {
                padding: 1rem 2rem;
                cursor: pointer;
                font-size: 1rem;
                text-transform: none;
                background-color:#BCEAD5;
                margin : 2em 1em;

            }
        </style>


        <link rel="stylesheet" href="./css/bootstrap.min.css" />
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet" href="./css/app.css"/>
        <link rel="stylesheet" href="./css/mycss.css"/>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet"/>

    </head>
    <body>
        <jsp:useBean id="db" class="DAO.TableDAO" />
        <jsp:useBean id="dao" class="DAO.ReservationDAO" />
        <jsp:useBean id="fdao" class="DAO.FoodDAO" />
        <c:set var="count" value="0"/>
        <div class="wrapper">
            <%@include file="./navigation.jsp" %>

            <div class="main">
                <%@include file="./navbar.jsp" %>
                <div class="container">
                    <c:forEach var="tb" items="${db.allTable}">
                        <c:if test="${tb.status == 'occupied'}">
                            <div>

                                <c:set var="nowreservation" value="${dao.getReservation(tb.tableID)}"/>



                                <c:set var="order" value="${dao.getListDetail(nowreservation.reservation_id)}"/>
                                <c:set var="c" value="0"/>

                                <c:if test="${not empty order}">
                                    <c:set var="resid" value="${nowreservation.reservation_id}"/>
                                    <c:out value="Reservation ${resid}- Table ${tb.tableID}"/>
                                    <c:set var="order" value="${dao.getListDetail(resid)}"/>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Number</th>
                                                <th>Food</th>
                                                <th>Quantity</th>
                                                <th>Completed</th>
                                            </tr>
                                        </thead>

                                        <tbody>


                                            <c:forEach var="eachorder" items="${order}">
                                                <c:set var="c" value="${c+1}"/>
                                                <c:set var="food" value="${fdao.getFoodByID(eachorder.food_id)}"/>
                                                <tr>
                                                    <td>${c}</td>
                                                    <td>${food.getName()}</td>
                                                    <td>${eachorder.quantity}</td>
                                                    <td><input required type="checkbox"></td>
                                                </tr>
                                                
                                            </c:forEach>
                                        </tbody>
                                        <button class="btn btn-info"><a href="KitchenStaffController?action=kitchenaction&setstatus=reserved&id=${tb.tableID}">Reserved</a></button>

                                    </table>


                                    <c:set var="count" value="${count+1}"/>
                                </c:if>



                            </div>
                        </c:if>

                    </c:forEach>
                    <c:if test="${count == 0}">
                        <h3 style="text-align: center">NOT HAVE ANY ORDER NOW</h3>
                    </c:if>
                </div>
                <!-- Button trigger modal -->

                <p style="color:red; display: block;"><%=(request.getAttribute("errMessage") == null) ? ""
                            : request.getAttribute("errMessage")%></p>
                    <p style="color:red; display: block;"><%=(request.getAttribute("Message") == null) ? ""
                            : request.getAttribute("Message")%></p>  
                    <%@include file="./footer.jsp"%>
            </div>

        </div>

        <script src="./js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

    </body>
</html>



