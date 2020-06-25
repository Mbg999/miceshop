<%-- 
    Document   : showAllClients
    Created on : 23-feb-2020, 10:35:22
    Author     : Miguel
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- LANGUAGE --%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="${locale}" scope="session"/>
<fmt:setBundle basename="languages.tags"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>La Ratonería | <fmt:message key="todos los"/> <fmt:message key="clientes"/></title>
        <jsp:include page="/WEB-INF/shareds/head.html"/>
        <link href="/Tienda/librerias/datatables/datatables.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div id="main-container" class="container">
            <div class="row">
                <header class="col-12 p-0">
                    <!-- NAVBAR -->
                    <jsp:include page="/WEB-INF/shareds/navbar.jsp"/>
                    <!-- /NAVBAR -->
                </header>
                <!-- PRODUCTOS -->
                <main class="col-12 pt-4">
                    <h2 class="mb-3"><fmt:message key="todos los"/> <fmt:message key="clientes"/></h2>
                    <table id="table" class="table w-100"></table>
                </main>
                <!-- /PRODUCTOS -->
                <!-- FOOTER -->
                <jsp:include page="/WEB-INF/shareds/footer.jsp"/>
                <!-- /FOOTER -->
            </div>
        </div>
                
        <!-- scripts -->
        <jsp:include page="/WEB-INF/shareds/scripts.html"/>
        <script src="/Tienda/librerias/datatables/datatables.min.js" type="text/javascript"></script>
        <script>
            "use strict";
            let url = "/Tienda/clients/alljson";
            let ref = "/Tienda/clients/show?client=";
            let es = [
                        {data: "dni", title: "DNI"},
                        {data: "nombre", title: "Nombre"},
                        {data: "admin", title: "Admin"}
                    ];
            let en = [
                        {data: "dni", title: "DNI"},
                        {data: "nombre", title: "Name"},
                        {data: "admin", title: "Admin"}
                    ];
        </script>
        <script src="/Tienda/librerias/datatable.js"></script>
    </body>
</html>
