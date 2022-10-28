<jsp:useBean id="a" class="DAO.AccountDAO" scope="session"></jsp:useBean>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

        <title>AdminKit Demo - Bootstrap 5 Admin Template</title>

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

                <main class="content">
                <div class="container">
                    <div class="card-title text-center mb-5">Accounts List</div>
                    <div class="row">
                        <div class="table-responsive-sm">
                        <table class="table table-hover">
                            <thead class="thead-dark" >
                                <tr class="row">
                                    <th class="col-md-2 col-sm-12" scope="col">Username</th>
                                    <th class="col-md-2 col-sm-12" scope="col">Role</th>
                                    <th class="col-md-2" scope="col">Name</th>
                                    <th class="col-md-2" scope="col">Email</th>
                                    <th class="col-md-2" scope="col">Phone</th>
                                    <th class="col-md-2" scope="col">Action</th>
                                </tr>
                            <tbody class="tbody-striped" >
                                <c:forEach items="${a.listAccounts}" var="i">
                                    <tr class="row" style="margin-top:10px">
                                        <td class="col-md-2 col-sm-12" scope="row">${i.username}</td>
                                        <td class="col-md-2" scope="row">${i.role}</td>
                                        <td class="col-md-2" scope="row">${i.name}</td>
                                        <td class="col-md-2" scope="row">${i.email}</td>
                                        <td class="col-md-2" scope="row">${i.phone}</td>
                                        <td class="col-md-2"  scope="row">
                                            <a href="${request.contextPath}/SWP_Project/EmpAccountServlet?id=${i.account_id}">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            </thead>
                        </table>
                        </div>
                        </div>
                    </div>
                </main>

                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row text-muted">
                            <div class="col-6 text-start">
                                <p class="mb-0">
                                    <a class="text-muted" href="https://adminkit.io/" target="_blank"><strong>AdminKit</strong></a> - <a class="text-muted" href="https://adminkit.io/" target="_blank"><strong>Bootstrap Admin Template</strong></a>								&copy;
                                </p>
                            </div>
                            <div class="col-6 text-end">
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="https://adminkit.io/" target="_blank">Support</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="https://adminkit.io/" target="_blank">Help Center</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="https://adminkit.io/" target="_blank">Privacy</a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a class="text-muted" href="https://adminkit.io/" target="_blank">Terms</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <script src="js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    </body>
</html>
