<%-- 
    Document   : CashierHomePage
    Created on : Nov 2, 2022, 4:51:25 PM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAO.TableDAO"%>
<%@page import="DAO.ReservationDAO"%>
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
            a{
                color: #fff;
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
      
        <div class="wrapper">
            <%@include file="./navigation.jsp" %>

            <div class="main">
                <%@include file="./navbar.jsp" %>
                <div class="parts">
                    <c:forEach var="tb" items="${db.allTable}">

                        <div class="part ${db.getTableByID(tb.tableID).status}">
                            Table - ${tb.tableID}
                            
                            <button  class="btn btn-secondary" type="button" >
                                <a href="./TableReservationDetails.jsp?id=${tb.tableID}">View Detail</a>                
                            </button>
                        </div>
                    </c:forEach>
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


