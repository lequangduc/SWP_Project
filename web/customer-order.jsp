<%-- 
    Document   : customer-order
    Created on : Nov 7, 2022, 10:49:57 PM
    Author     : Admin
--%>


<%@page import="java.util.List"%>
<%@page import="entity.Food"%>
<%@page import="entity.Reservation_details"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Account"%>
<%@page import="entity.Reservation"%>
<%@page import="entity.Table"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.TableDAO"%>
<%@page import="DAO.ReservationDAO"%>
<%@page import="DAO.FoodDAO"%>
<%@page import="DAO.AccountDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Order</title>
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&family=Pacifico&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <jsp:useBean id="db" class="DAO.TableDAO" />
        <jsp:useBean id="fooddao" class="DAO.FoodDAO" />
        <jsp:useBean id="dao" class="DAO.ReservationDAO" />
        <jsp:useBean id="accountdao" class="DAO.AccountDAO" />
        <div class="main">
            <div class="container">
                <%
                    int tableId = Integer.parseInt(request.getParameter("tableOrderId"));
                    Table table = new TableDAO().getTableByID(tableId);
                    String status = table.getStatus();

                %>
                <h3 class="display-3" style="text-align: center">Table <%=tableId%></h3>
                <div class="dropdown">
                    <button class="btn btn-info" type="button" >
                        <a href="booking.jsp">Back</a>
                    </button>
                    <div style="margin-top:2%;padding-left: 5%">
                        <h4>Table ID :<%=request.getParameter("tableOrderId")%></h4>

                        <h4>Table Status : <%=status%></h4> 
                        <h4>Next Reservation : <%=new ReservationDAO().getNextReservationInfo(tableId)%> </h4> 
                    </div>

                    <!-- create form to input food  -->


                    <%
                        Reservation res = new ReservationDAO().getReservation(tableId);
                        int reservationId = new ReservationDAO().getReservation(tableId).getReservation_id();
                        Account cusAcc = null;
                        if (res != null) {
                            int cusId = res.getCustomer_id();
                            cusAcc = new AccountDAO().getAccountByID(cusId);
                        }

                    %>
                    <div style="margin-top:2%;padding-left: 5%">
                        <h4>Reservation ID : <%= reservationId%></h4>
                        <%
                            if (cusAcc != null) {
                        %>
                        <h4>Customer : <%=cusAcc.getName()%> </h4>
                        <%}%>
                    </div>
                    <%
                        ArrayList<Reservation_details> order = new ReservationDAO().getListDetail(reservationId);
                    %>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Number</th>
                                <th>Food</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>

                        <%
                            if (!order.isEmpty()) {
                        %>
                        <tbody>


                            <%
                                int c = 0;
                                for (Reservation_details eachorder : order) {
                                    c++;
                            %>

                            <tr>
                                <td><%=c%></td>
                                <td><%=new FoodDAO().getFoodByID(eachorder.getFood_id()).getName()%></td>
                                <td><%=eachorder.getQuantity()%></td>
                            </tr>
                            <%}%>

                        </tbody>
                        <%}%>
                        <%
                            if (order.isEmpty()) {
                        %>
                        <h4>Not have any order </h4>
                        <%}%>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                            Add new order
                        </button>
                        <!--                            <button type="button" class="btn btn-primary" >
                                                        <a href="CashierController?setstatus=reserved&id=<%=tableId%>"> Reserved</a>
                                                    </button>-->
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
                                        <form action="${request.contextPath}/SWP_Project/CustomerOrderServlet" method="POST">
                                            <input type="hidden" name="action" value="addneworder">
                                            <input type="hidden" name="id" value="<%=tableId%>">
                                            <input type="hidden" name="idorder" value="<%=reservationId%>"/>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <label class="input-group-text" for="food">Options</label>
                                                </div>
                                                <select class="custom-select" id="food" name="food">
                                                    <option selected>Choose...</option>

                                                    <%
                                                        List<Food> foods = new FoodDAO().getListAllFood();
                                                        for (Food food : foods) {
                                                    %>
                                                    <option value="<%=food.getFood_id()%>"><%=food.getName()%></option>
                                                    <%}%>
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
                    </table>
                    </c:if>


                </div>
            </div>
        </div>









        <script src="./js/app.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
