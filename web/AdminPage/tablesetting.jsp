<%-- 
    Document   : tablesettingtest
    Created on : Nov 3, 2022, 8:52:35 AM
    Author     : Admin
--%>

<%@page import="controller.TableMapServlet"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DBContext.DBContext"%>
<%@page import="java.io.OutputStream"%>
<%@page import="entity.TableDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en" class="active">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Dynamic Admin Panel :: Setting</title>
        <link href="https://bhojon.bdtask-demo.com/demo-classic/assets/css/jquery-ui.min.css" rel="stylesheet" type="text/css">
        <link href="https://bhojon.bdtask-demo.com/demo-classic/assets/css/fontawesome-iconpicker.min.css" rel="stylesheet" type="text/css">

        <link href="https://bhojon.bdtask-demo.com/demo-classic/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="https://bhojon.bdtask-demo.com/demo-classic/assets/css/jquery-ui-timepicker-addon.min.css" rel="stylesheet" type="text/css">
        <link href="https://bhojon.bdtask-demo.com/demo-classic/assets/datatables/css/dataTables.min.css" rel="stylesheet" type="text/css">

        <link href="https://bhojon.bdtask-demo.com/demo-classic/assets/css/custom.min.css" rel="stylesheet" type="text/css">
        <link href="./css/app.css" rel="stylesheet">
        <link href="./css/mycss.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">


        <link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/accounts/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/addon/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/hrm/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/itemmanage/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/ordermanage/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/production/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/purchase/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/report/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/reservation/assets/css/style.css" rel="stylesheet"><link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/setting/assets/css/style.css" rel="stylesheet">

        <script src="https://bhojon.bdtask-demo.com/demo-classic/assets/js/jquery-1.12.4.min.js" type="text/javascript"></script>
        <style>
            .loading:after {
                content: ' .';
                animation: dots 1s steps(5, end) infinite;
            }
            @keyframes dots {
                20%, 20% {
                    color: rgba(0,0,0,1);
                    text-shadow:
                        .25em 0 0 rgba(0,0,0,0),
                        .5em 0 0 rgba(0,0,0,0);
                }
                40% {
                    color: #F00;
                    text-shadow:
                        .25em 0 0 rgba(0,0,0,0),
                        .5em 0 0 rgba(0,0,0,0);
                }
                60% {
                    text-shadow:
                        .25em 0 0 #F00,
                        .5em 0 0 rgba(0,0,0,0);
                }
                80%, 100% {
                    text-shadow:
                        .25em 0 0 #666,
                        .5em 0 0 #666;
                }
            }

            /* css panel */
            .panel {
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 10px;
                margin-bottom: 20px;
                background-color: antiquewhite;
                min-height: 600px;
            }

            .draggable{
                cursor: move;
                padding: 0;
            }

            /* css boxpad with table image */
            .boxpad {
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 10px;
                margin-bottom: 20px;
                background-color: antiquewhite;
                height: 60px;
            }


            /* css .table-type fit boxpad*/
            .table-type {
                width: 100%;
                height: 100%;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 10px;
                margin-bottom: 20px;
                /* background-color: rgb(137, 97, 44); */
                /* background image for table */
                background-image: url("https://bhojon.bdtask-demo.com/demo-classic/assets/images/table.png");
            }

            /* css  information */
            .information {
                width: 100%;
                height: 100%;
                display: flex;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 10px;
                margin-bottom: 20px;
                background-color: rgb(137, 97, 44);
            }

            /* css saveMap button to the right */
            .saveMap{
                position: absolute;
                right: 1%;
            }
            .uploadMap {
                position: absolute;
                right: 20%;
            }






        </style>
    </head>
    <body class="sidebar-mini   active pace-done">
        <div class="wrapper">
            <%@include file="navigation.jsp" %>
            <div class="main">
                <%@include file="navbar.jsp" %>
                <div class="content" style="padding-top: 0;">
                    <!-- modal form to upload file table map -->
                    <div class="modal fade  bd-example-modal-lg" id="uploadMap" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Upload Map</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body  ">
                                    <form action="TableMapServlet" method="post" enctype="multipart/form-data">
                                        <div class="form-group  ">
                                            <label for="file">File</label>
                                            <input type="file" class="form-control" id="file" name="table-map">
                                        </div>
                                        <!-- button -->
                                        <div class="form-group  ">
                                            <button type="submit" id="upload-button" class="btn btn-primary" disabled>Upload</button>
                                            <!-- close -->
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!--  -->
                    <%
                        String message = (String) request.getAttribute("message");
                        if (message != null) {

                    %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong><%=message%></strong> table map!
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <!-- button to view the map in modal -->
                        <a href="TableMapServlet?action=viewTableMap" target="_blank" class="btn btn-primary" >
                            View Map
                        </a>



                    </div>
                    <% } %> 

                    <!-- count how many tables -->
                    <div class="row">
                        <div class="col-md-12 information">
                            <!-- count number of tables -->
                            <%
                                ArrayList<TableDetail> tables = (ArrayList<TableDetail>) request.getAttribute("tableList");
                            %>
                            <h3 class="numberoftables" >Number of tables: <%=tables.size()%></h3>

                            <!-- button to take the screen shot open modal -->
                            <button type="button" class="btn btn-dribbble saveMap">
                                Save Map
                            </button>
                            <!-- button to upload map to server-->
                            <button type="button" class="btn btn-primary uploadMap" data-toggle="modal" data-target="#uploadMap">
                                Upload Map
                            </button>
                                <!-- <button id="btn-Preview-Image" style="float:right" class="btn btn-primary">SAVE MAP</button> -->
                        </div>
                    </div>  
                    <link href="https://bhojon.bdtask-demo.com/demo-classic/application/modules/setting/assets/css/tablesetting.css" rel="stylesheet" type="text/css">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="panel panel-default thumbnail">
                                <div class="panel-body">
                                    <div class="row" id="gallery">
                                        <%

                                            for (TableDetail table : tables) {
                                        %>
                                        <div class="text-center boxpad draggable ui-draggable ui-draggable-handle" id="<%=table.getTableID()%>" style="position: relative; left: 13px; top: -8px;padding:0;margin:0;width: 60px;" data-itemid="<%=table.getTableID()%>">
                                            <input name="sortid[]" type="hidden" value="<%=table.getTableID()%>" autocomplete="off">
                                            <!-- <div style="padding:0;margin:0;width: 60px;"> -->
                                            <p class="table-type"><%=table.getTableID()%></p>
                                            <!-- </div> -->
                                        </div>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script src="https://bhojon.bdtask-demo.com/demo-classic/application/modules/setting/assets/js/tablesetting_script.js" type="text/javascript"></script> </div> 
            </div>                    
        </div> 
    </div> 

    <script src="js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    <script src="https://bhojon.bdtask-demo.com/demo-classic/ordermanage/order/showljslang" type="text/javascript"></script>
    <script src="https://bhojon.bdtask-demo.com/demo-classic/ordermanage/order/basicjs" type="text/javascript"></script>
    <script src="https://bhojon.bdtask-demo.com/demo-classic/assets/js/jquery-ui.min.js" type="text/javascript"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

    <script>
        var url = window.location;
        // for sidebar menu entirely but not cover treeview
        $('ul.sidebar-menu a').filter(function () {
            return this.href != url;
        }).parent().removeClass('active');

        // for sidebar menu entirely but not cover treeview
        $('ul.sidebar-menu a').filter(function () {
            return this.href == url;
        }).parent().addClass('active');

        // for treeview
        $('ul.treeview-menu a').filter(function () {
            return this.href == url;
        }).parentsUntil(".sidebar-menu > .treeview-menu").addClass('active');

        const saveMap = document.querySelector('.saveMap');
        // download image when load this page



        saveMap.addEventListener('click', () => {
            html2canvas(document.querySelector(".panel")).then(canvas => {
                const url = canvas.toDataURL('image/png');
                const a = document.createElement('a');
                a.href = url;
                a.download = 'map.png';
                a.click();
            });
        })

        // if there is no file selected, disable the upload button
        document.querySelector('#file').addEventListener('change', function () {
            if (this.value) {
                document.querySelector('#upload-button').disabled = false;
            } else {
                document.querySelector('#upload-button').disabled = true;
            }
        });
        
        


    </script>
</body>
</html>
