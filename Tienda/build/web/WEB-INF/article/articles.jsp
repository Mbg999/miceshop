<%-- 
    Document   : index
    Created on : 17-feb-2020, 11:10:18
    Author     : IES TRASSIERRA
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tienda | Articles</title>
    <jsp:include page="/WEB-INF/shareds/head.html"/>
    </head>
    <body>
        <div id="main-container" class="container">
            <div class="row">
                <header class="col-12 order-1 p-0">
                    <!-- NAVBAR -->
                    <jsp:include page="/WEB-INF/shareds/navbar.jsp"/>
                    <!-- /NAVBAR -->
                </header>
                <!-- PRODUCTOS -->
                <main class="col-12 col-lg-10 order-3 order-lg-2 bg-success">
                    <h2>Bienvenido a mi tienda</h2>
                    <!-- GRID OF ARTICLES -->
                    <jsp:include page="/WEB-INF/shareds/grid.jsp"/>
                    <!-- /GRID OF ARTICLES -->
                </main>
                <!-- /PRODUCTOS -->
                <!-- SIDEBAR -->
                <jsp:include page="/WEB-INF/shareds/aside.jsp"/>
                <!-- /SIDEBAR -->
                <!-- FOOTER -->
                <jsp:include page="/WEB-INF/shareds/footer.jsp"/>
                <!-- /FOOTER -->
            </div>
        </div>
                
        <!-- scripts -->
        <jsp:include page="/WEB-INF/shareds/scripts.html"/>
    </body>
</html>
