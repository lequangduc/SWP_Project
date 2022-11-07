<%-- 
    Document   : TableReservationDetails
    Created on : Nov 6, 2022, 3:20:23 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAO.TableDAO"%>
<%@page import="DAO.ReservationDAO"%>
<%@page import="DAO.FoodDAO"%>
<%@page import="DAO.AccountDAO"%>
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
            .underline {
                width: 10rem;
                height: 0.25rem;
                background: black;
                margin-left: auto;
                margin-right: auto;
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
        <jsp:useBean id="fooddao" class="DAO.FoodDAO" />
        <jsp:useBean id="dao" class="DAO.ReservationDAO" />
        <jsp:useBean id="accountdao" class="DAO.AccountDAO" />

        <div class="wrapper">
            <%@include file="./navigation.jsp" %>

            <div class="main">
                <%@include file="./navbar.jsp" %>
                <c:set var="id" value="${param.id}"/>
                <c:set var="status" value="${db.getTableByID(id).status}"/>
                <div class="container">
                    <h3 class="display-3" style="text-align: center">Table ${id}</h3>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
                            Set Status
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="CashierController?setstatus=available&id=${id}">Available</a>
                            <a class="dropdown-item" href="CashierController?setstatus=occupied&id=${id}">Occupied</a>
                            <a class="dropdown-item" href="CashierController?setstatus=reserved&id=${id}">Reserved</a>
                        </div>

                        <div style="margin-top:2%;padding-left: 5%">
                            <h4>Table ID : ${id}</h4>
                            <h4>Table Status : ${status}</h4> 
                            <h4>Next Reservation : ${dao.getNextReservationInfo(id)} </h4> 
                        </div>
                        <div class="underline"></div>
                        <c:if test="${status == 'occupied'}">
                            <c:set var="nowreservation" value="${dao.getReservation(id)}"/>
                            <c:if test="${not empty nowreservation}">
                                <h3 style="text-align: center;margin: 2% 5%">Reservation Info</h3>
                                <div style="margin-top:2%;padding-left: 5%">
                                    <h4>Reservation ID : ${nowreservation.reservation_id}</h4>
                                    <h4>Customer : ${accountdao.getAccountByID(nowreservation.customer_id).name} </h4>
                                </div>

                                <c:set var="order" value="${dao.getReservationDetailByID(nowreservation.reservation_id)}"/>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Number</th>
                                            <th>Food</th>
                                            <th>Quantity</th>
                                        </tr>
                                    </thead>
                                    <c:if test="${not empty order}">
                                        <tbody>

                                            <c:forEach var="eachorder" items="${order}">
                                                <c:set var="c" value="${c+1}"/>
                                                <tr>
                                                    <td>${c}</td>
                                                    <td>${fooddao.getFoodByID(eachorder.food_id).name}</td>
                                                    <td>${eachorder.quantity}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </c:if>
                                    <c:if test="${ empty order}">
                                        <h4>Not have any order </h4>
                                    </c:if>
                                </table>

                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                                    Add new order
                                </button>

                                <!-- Modal -->
                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Add new order</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="${request.contextPath}/SWP_Project/CashierController" method="POST">
                                                    <input type="hidden" name="action" value="addneworder">
                                                    <input type="hidden" name="id" value="${id}">
                                                    <input type="hidden" name="idorder" value="${nowreservation.reservation_id}"/>
                                                    <div class="input-group mb-3">
                                                        <div class="input-group-prepend">
                                                            <label class="input-group-text" for="food">Options</label>
                                                        </div>
                                                        <select class="custom-select" id="food" name="food">
                                                            <option selected>Choose...</option>
                                                            <c:forEach var="food" items="${fooddao.listAllFood}">
                                                                <option value="${food.food_id}">${food.name}</option>

                                                            </c:forEach>
                                                        </select>

                                                    </div>
                                                    <div class="form-group">
                                                        <label for="quantity">Quantity</label>
                                                        <input type="number" class="form-control" id="quantity" name="quantity" placeholder="Quantity .. ">
                                                    </div>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <input type="submit" class="btn btn-primary" value="Save changes"/>
                                                </form>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>


                    </div>
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



