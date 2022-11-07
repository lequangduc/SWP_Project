<%-- 
    Document   : booking
    Created on : Sep 29, 2022, 8:32:28 PM
    Author     : admin
--%>
<%@page import="entity.Reservation"%>
<%@page import="DAO.ReservationDAO"%>
<%@page import="entity.Account"%>
<%@page import="entity.TableType"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TableTypeDAO"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Restoran - Bootstrap Restaurant Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <link href="css/mycss.css" rel="stylesheet" />
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon" />

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&family=Pacifico&display=swap"
            rel="stylesheet"
            />

        <!-- Icon Font Stylesheet -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet" />
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />
        <link
            href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous"
            />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet" />

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet" />

        <!--Datatable css-->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.css">

    </head>

    <body>
        <div class="container-xxl bg-white p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <div class="container-xxl position-relative p-0">
                <nav
                    class="navbar navbar-expand-lg navbar-dark bg-dark px-4 px-lg-5 py-3 py-lg-0"
                    >
                    <a href="HomeServlet" class="navbar-brand p-0">
                        <h1 class="text-primary m-0">
                            <i class="fa fa-utensils me-3"></i>Restoran
                        </h1>
                        <!-- <img src="img/logo.png" alt="Logo"> -->
                    </a>
                    <button
                        class="navbar-toggler"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse"
                        >
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0 pe-4">
                            <a href="HomeServlet" class="nav-item nav-link active">Home</a>
                            <a href="about.jsp" class="nav-item nav-link">About</a>
                            <a href="service.jsp" class="nav-item nav-link">Service</a>
                            <a href="menu.jsp" class="nav-item nav-link">Menu</a>

                            <a href="contact.jsp" class="nav-item nav-link">Contact</a>
                        </div>
                        <!-- <a href="BookingServlet" class="btn btn-primary py-2 px-4">Book A Table</a> -->
                        <!-- create a Book A  Table button link to  container-xxl py-5 px-0 wow fadeInUp-->
                        <%
                            Account p = (Account)session.getAttribute("loggedAccount");
                            if (p == null) {
                        %>
                            <a href="BookingServlet" class="btn btn-primary py-2 px-4">Book A Table</a>
                        <%
                            } else {
                        %>
                            <a href="#book-table" class="btn btn-primary py-2 px-4">Book A Table</a>
                        <%
                            }
                        %>

                        <c:if test="${empty userLogin}">
                            <button class="btn">
                                <a
                                    data-toggle="modal"
                                    data-target="#loginModal"
                                    class="nav-item nav-link"
                                    ><i class="fa fa-user"></i> Login</a
                                >
                            </button>
                        </c:if>
                        <c:if test="${not empty userLogin}">
                            <a class=" nav-item nav-link text-primary" data-bs-toggle="modal" data-bs-target="#bill-modal"><i class="bi bi-receipt"></i> RESERVATION</a>
                            <i class="fa fa-user ml-3"></i>   ${userLogin}
                            <a class="ml-3" href="LoginServlet"><i class="fa fa-times"> Logout</i></a>

                        </c:if>

                    </div>
                </nav>

                <div class="modal fade" id="bill-modal" tabindex="-1" aria-labelledby="modal-title" aria-hiden="true" style="display: none;" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modal-title">View more table</h5>
                                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">
                                <table id="table_id" class="stripe hover order-column">
                                    <thead>
                                        <tr>
                                            <th>Table</th>
                                            <th>Reservation ID</th>
                                            <th>Table Number</th>
                                            <th>Date</th>
                                            <th></th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        
                                        <%
                                            Account acc = (Account) session.getAttribute("loggedAccount");
                                            ReservationDAO rdao = new ReservationDAO();
                                            if (acc != null) {

                                                ArrayList<Reservation> list = rdao.getCusReservation(acc.getAccount_id());

                                                for (int i = 0; i < list.size(); i++) {%>
                                        <tr id="clear">
                                            <td><%=acc.getAccount_id()%></td>
                                            <td id="rid"><%=list.get(i).getReservation_id()%></td>
                                            <td id="tid"><%=list.get(i).getTable_id()%></td>
                                            <td><%=list.get(i).getDateReservation()%></td>
                                            <td>
                                                <button class="btn btn-primary" id="remove">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        
                                        <%}%>
                                        <%}%>
                                        
                                    </tbody>
                                </table>
                            </div>

                            <div class=" modal-footer ">
                                <button type="button " class="btn btn-secondary " data-bs-dismiss="modal">Close</button>

                            </div>

                        </div>
                    </div>
                </div>

                <div id="loginModal" class="modal fade" role="dialog">
                    <div class="modal-dialog modal-lg" role="content">
                        <!--Login Modal content-->

                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title">Login</h3>

                                <button type="button" class="close" data-dismiss="modal">
                                    &times;
                                </button>
                            </div>
                            <div class="modal-body">
                                <form name="loginform" action="LoginServlet" method="post" onSubmit="return validateLoginForm(event);">
                                    <div class="form-group row">
                                        <label for="" class="col-12 col-md-3 col-form-label">Username</label>

                                        <div class="col-12 col-md-4">
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="userName"
                                                name="userName"
                                                placeholder="enter username"
                                                value="${resusername}"
                                                />
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <span style="color:red" id="LunameErr">
                                        </div>

                                    </div>
                                    <div class="form-group row">
                                        <label for="" class="col-12 col-md-3 col-form-label">Password</label>

                                        <div class="col-12 col-md-4">
                                            <input
                                                type="password"
                                                class="form-control"
                                                id="password"
                                                name="password"
                                                placeholder="enter password"
                                                value="${respassword}"
                                                />
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <span style="color:red" id="LpasswordErr">
                                        </div>
                                    </div>
                                    <div class="form-row mt-4">
                                        <div style="color:red" class="offset-md-4 col-md-10">
                                            ${LoginError}
                                        </div>
                                    </div>
                                    <div class="form-row mt-4">
                                        <div class="offset-md-4 col-md-10">
                                            <button type="submit" class="btn btn-primary btn-sm ml-1">
                                                Login
                                            </button>
                                            <button type="button" id="register-btn" data-toggle="modal"
                                                    data-target="#registerModal" class="btn btn-secondary btn-sm ml">
                                                Register
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>


                <div id="registerModal" class="modal fade" role="dialog">
                    <div class="modal-dialog modal-lg" role="content">
                        <!--Register Modal content-->

                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title">Register</h3>

                                <button type="button" class="close" data-dismiss="modal">
                                    &times;
                                </button>
                            </div>
                            <div class="modal-body">
                                <form name="registerform" action="RegisterServlet" method="post" onSubmit="return validateRegisterForm0(event);">
                                    <div class="form-group row">
                                        <label
                                            for=""
                                            class="col-12 col-md-3 col-form-label"
                                            >Username</label
                                        >

                                        <div class="col-12 col-md-4">
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="userName"
                                                name="userName"
                                                placeholder="Please enter username"
                                                />

                                        </div>
                                        <div class="col-12 col-md-4">
                                            <span style="color:red" id="unameErr">
                                        </div>

                                    </div>
                                    <div class="form-group row">
                                        <label
                                            for=""
                                            class="col-12 col-md-3 col-form-label"
                                            >Password</label
                                        >

                                        <div class="col-12 col-md-4">
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="password"
                                                name="password"
                                                placeholder="Please enter password"
                                                />
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <span style="color:red" id="passwordErr">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label
                                            for=""
                                            class="col-12 col-md-3 col-form-label"
                                            >Email</label
                                        >

                                        <div class="col-12 col-md-4">
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="email"
                                                name="email"
                                                placeholder="Please enter your email"
                                                />
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <span style="color:red" id="emailErr">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label
                                            for=""
                                            class="col-12 col-md-3 col-form-label"
                                            >Phone</label
                                        >

                                        <div class="col-12 col-md-4">
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="phone"
                                                name="phone"
                                                placeholder="Please enter 10 digits"
                                                />

                                        </div>
                                        <div class="col-12 col-md-4">
                                            <span style="color:red" id="phoneErr">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label
                                            for=""
                                            class="col-12 col-md-3 col-form-label"
                                            >Name</label
                                        >

                                        <div class="col-12 col-md-4">
                                            <input
                                                type="text"
                                                class="form-control"
                                                id="name"
                                                name="name"
                                                placeholder="Please enter your name"
                                                />
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <span style="color:red" id="nameErr">
                                        </div>
                                    </div>

                                    <div class="form-row mt-4">
                                        <div class="offset-md-4 col-md-10">
                                            <button type="submit" class="btn btn-primary btn-sm ml-1">
                                                Register
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="container-xxl py-5 bg-dark hero-header mb-5">
                    <div class="container my-5 py-5">
                        <div class="row align-items-center g-5">
                            <div class="col-lg-6 text-center text-lg-start">
                                <h1 class="display-3 text-white animated slideInLeft">
                                    Enjoy Our<br />Delicious Meal
                                </h1>
                                <p class="text-white animated slideInLeft mb-4 pb-2">
                                    Tempor erat elitr rebum at clita. Diam dolor diam ipsum sit.
                                    Aliqu diam amet diam et eos. Clita erat ipsum et lorem et sit,
                                    sed stet lorem sit clita duo justo magna dolore erat amet
                                </p>
                                <a
                                    href="#book-table"
                                    class="btn btn-primary py-sm-3 px-sm-5 me-3 animated slideInLeft"
                                    >Book A Table</a
                                >
                            </div>
                            <div class="col-lg-6 text-center text-lg-end overflow-hidden">
                                <img class="img-fluid" src="img/hero.png" alt="" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Navbar & Hero End -->


            <!-- Reservation Start -->
            <div id="book-table" class="container-xxl py-5 px-0 wow fadeInUp" data-wow-delay="0.1s">
                <div class="row g-0">
                    <div class="col-md-6">
                        <div class="video">
                            <button type="button" class="btn-play" data-bs-toggle="modal" data-src="https://www.youtube.com/embed/DWRcNpR6Kdc" data-bs-target="#videoModal">
                                <span></span>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-6 bg-dark d-flex align-items-center">
                        <div class="p-5 wow fadeInUp" data-wow-delay="0.2s">
                            <h5 class="section-title ff-secondary text-start text-primary fw-normal">Reservation</h5>
                            <h1 class="text-white mb-4">Book A Table Online</h1>
                            <form action="BookingServlet" method="post">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" id="name" placeholder="Your Name" name="name" value="${name}" required>
                                            <label for="name">Your Name</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="tel" class="form-control" id="phone" placeholder="Your Phone" pattern="^09[0-9]{8}" name="phone" value="${phone}" required>
                                            <label for="phone">Your Phone</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating date" id="date3" data-target-input="nearest">
                                            <input type="text" class="form-control datetimepicker-input" id="datetime" placeholder="Date & Time" data-target="#date3" data-toggle="datetimepicker" name="date" required/>
                                            <label for="datetime">Date & Time</label>
                                        </div>
                                    </div>
                                    <!-- <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="number" min="1" class="form-control" id="people" placeholder="No of people" name="people" required>
                                            <label for="people">No of people</label>
                                        </div>
                                    </div> -->
                                    <!-- view table map button-->
                                    <div class="col-md-6">
                                        
                                            <a href="TableMapServlet?action=viewTableMap" target="_blank" class="btn btn-primary form-floating" style="width:100%;height:auto;">View Table Map</a>
                                        
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <select class="form-select" id="type" name="type" required>
                                                <option value="">Select Type of Table</option>
                                                <%
                                                    TableTypeDAO dao = new TableTypeDAO();
                                                    ArrayList<TableType> typeList = dao.getAllListType();

                                                %>
                                                <%for (TableType t : typeList) {%>
                                                <option value="<%=t.getTabletypeID()%>"><%=t.getTabletypeName()%></option>
                                                <%}%>
                                            </select>
                                            <label for="select1">Type of table</label>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <select class="form-select" id="table" name="table"  required>
                                                <option value="">Select table...</option>
                                            </select>
                                            <label for="select12">Available Table</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating">
                                            <textarea class="form-control" placeholder="Special Request" id="message" style="height: 100px"></textarea>
                                            <label for="message">Special Request</label>
                                        </div>
                                    </div>
                                    <p class="text-warning">${error}</p>
                                    <div class="col-12">
                                        <button class="btn btn-primary w-100 py-3" type="submit">Book Now</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="videoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content rounded-0">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Youtube Video</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- 16:9 aspect ratio -->
                            <div class="ratio ratio-16x9">
                                <iframe class="embed-responsive-item" src="" id="video" allowfullscreen allowscriptaccess="always" allow="autoplay"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Reservation Start -->


            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
                <div class="container py-5">
                    <div class="row g-5">
                        <div class="col-lg-3 col-md-6">
                            <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Company</h4>
                            <a class="btn btn-link" href="">About Us</a>
                            <a class="btn btn-link" href="">Contact Us</a>
                            <a class="btn btn-link" href="">Reservation</a>
                            <a class="btn btn-link" href="">Privacy Policy</a>
                            <a class="btn btn-link" href="">Terms & Condition</a>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Contact</h4>
                            <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                            <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                            <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                            <div class="d-flex pt-2">
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Opening</h4>
                            <h5 class="text-light fw-normal">Monday - Saturday</h5>
                            <p>09AM - 09PM</p>
                            <h5 class="text-light fw-normal">Sunday</h5>
                            <p>10AM - 08PM</p>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Newsletter</h4>
                            <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                            <div class="position-relative mx-auto" style="max-width: 400px;">
                                <input class="form-control border-primary w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                                <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="copyright">
                        <div class="row">
                            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                                &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved. 

                                <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                                Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a><br><br>
                                Distributed By <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                            </div>
                            <div class="col-md-6 text-center text-md-end">
                                <div class="footer-menu">
                                    <a href="">Home</a>
                                    <a href="">Cookies</a>
                                    <a href="">Help</a>
                                    <a href="">FQAs</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <script
            src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"
        ></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>

        <script>
                                    const tooltips = document.querySelectorAll('.tt')
                                    tooltips.forEach(t => {
                                        new bootstrap.Tooltip(t)
                                    })
        </script>

        <script type="text/javascript">
            $(window).on('load', function () {
                if (${LoginError!=null} || ${Registersuccess!=null}) {
                    $('#loginModal').modal('show');
                }
                if (${RegError!=null}) {
                    $('#registerModal').modal('show');
                    alert("${RegError}");
                }
            });
        </script>

        <script class="text/javascript">
            function validateLoginForm(event) {
                event.preventDefault();
                if (document.loginform.userName.value == "") {
                    //alert("User Name can not be left blank");
                    document.loginform.userName.focus();
                    document.getElementById("LunameErr").textContent =
                            "*User name can not be left blank";
                    return false;
                } else if (document.loginform.password.value == "") {
                    //alert("Password can not be left blank");
                    document.loginform.password.focus();
                    document.getElementById("LpasswordErr").textContent =
                            "*Password can not be left blank";
                    return false;
                } else {
                    document.loginform.submit(); // fire submit event
                }
            }
            function validateRegisterForm0(event) {
                event.preventDefault(); // this will prevent the submit event.
                if (document.registerform.userName.value == "") {
                    //alert("User Name can not be left blank");
                    document.registerform.userName.focus();
                    document.getElementById("unameErr").textContent =
                            "*User name can not be left blank";
                    return false;
                } else if (document.registerform.password.value == "") {
                    //alert("Password can not be left blank");
                    document.registerform.password.focus();
                    document.getElementById("passwordErr").textContent =
                            "*Password can not be left blank";
                    return false;
                } else if (document.registerform.email.value == "") {
                    //alert("Email can not be left blank");
                    document.registerform.email.focus();
                    document.getElementById("emailErr").textContent =
                            "*Email can not be left blank";
                    return false;
                } else if (document.registerform.phone.value == "") {
                    //alert("Phone can not be left blank");
                    document.registerform.phone.focus();
                    document.getElementById("phoneErr").textContent =
                            "*Phone can not be left blank";
                    return false;
                } else if (document.registerform.name.value == "") {
                    //alert("Name can not be left blank");
                    document.registerform.name.focus();
                    document.getElementById("nameErr").textContent =
                            "*Name can not be left blank";
                    return false;
                } else {
                    document.registerform.submit(); // fire submit event
                }
            }
        </script>
        <script>
            const myModal = document.getElementById('myModal')
            const myInput = document.getElementById('myInput')

            myModal.addEventListener('shown.bs.modal', () => {
                myInput.focus()
            })
        </script>

        <!-- jquery cho chọn bàn và thể loại -->
        <script>
            $(document).ready(function () {
                //lấy id là type trg select tag dùng hàm change của jquery --> trigger
                $('#type').change(function () {
                    //lấy giá trị type_id khi chọn option
                    var id = $(this).val();
                    console.log(id);
                    // ajax
                    $.ajax({
                        url: 'TableReservationServlet', //url là trang servlet của mình
                        type: 'POST',
                        data: {"type_ID": id}, // truyền giá trị đến cái url
                        error: function () //nếu lỗi sẽ báo console
                        {
                            console.log("error");
                        },
                        success: function (data) { //ko lỗi sẽ thực hiện đưa danh sách vào select tag có id là table
                            //Xóa các table cũ khi chọn các type khác
                            $("#table")
                                    .find('option')
                                    .remove()
                                    .end()


                            for (var i = 0; i < data.length; i++)
                            {
                                // - Dùng vòng lặp để check thử xem status từ các bàn trg url truyền tới có
                                // cái nào là available ko
                                if (data[i].status === 'available')
                                {
                                    //Nếu có thì sẽ dùng hàm append để thêm vào các option và set value và text cho các option
                                    $("#table")
                                            .append($("<option>",
                                                    {
                                                        value: data[i].tableID,
                                                        text: 'table no: ' + data[i].tableID
                                                    }));
                                }
                            }
                        }
                    });
                });
            });
        </script>



        <!-- Template Javascript -->
        <script src="js/main.js"></script>

        <!-- Jquery Ajax -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

        <script>
            const myModal = document.getElementById('myModal')
            const myInput = document.getElementById('myInput')

            myModal.addEventListener('shown.bs.modal', () => {
                myInput.focus()
            })
        </script>

        <script>
            $(document).ready(function () {
                $('#table_id').DataTable();
            });
        </script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>

        <!--Datatable jquery-->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>

        <!--Delete Reservation-->
        <script>
            $(document).ready(function () {
                // Dùng event click button có id là remove
                $('#remove').click(function ()
                {

                    // khi click thì sẽ lấy text của các id rid và tid 
                    // rid là reservation ID - tid là table ID
                    var rid = $("#rid").text();
                    var tid = $("#tid").text();
                    $.ajax({
                        url: 'CancelBill', //đường dẫn của cái servlet hủy bill
                        type: 'GET',
                        data: {
                            // truyền 2 giá trị qua url xử lý hủy đơn và cập nhật trạng thái của bàn
                            "rid": rid,
                            "tid": tid
                        },
                        error: function ()
                        {
                            console.log("error");
                        },
                        success: function (data) //đoạn này ko dùng thì có thể để yên
                        {

                        }
                    });
                    $("#clear").remove();
                });
            });
        </script>
    </body>

</html>
