<%-- 
    Document   : index
    Created on : 15-feb-2020, 22:12:57
    Author     : Miguel
--%>
<jsp:forward page="articles"/>
<%--
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="WEB-INF/shareds/head.html"/>
    </head>
    <body>
        
        <div id="main-container" class="container">
            <div class="row">
                <header class="col-12 order-1 p-0">
                    <jsp:include page="/WEB-INF/shareds/navbar.jsp"/>
                </header>
                <!-- PRODUCTOS -->
                <main class="col-12 col-lg-8 order-3 order-lg-2 bg-success">
                    MAIN
                </main>
                <!-- /PRODUCTOS -->
                <!-- SIDEBAR -->
                <aside class="col-12 col-lg-4 order-2 order-lg-3 bg-primary">
                    ASIDE
                </aside>
                <!-- /SIDEBAR -->
                <footer class="col-12 bg-warning order-4">
                    <div class="row">
                        <div class="col-12 col-lg-3">
                            footer-1
                        </div>
                        <div class="col-12 col-lg-3">
                            footer-2
                        </div>
                        <div class="col-12 col-lg-3">
                            footer-3
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        
        
        
        <h1>Hello World!</h1>
        ${client}
        <c:forEach var="article" items="${articles}">
            <p>${article}</p>
        </c:forEach>
        <!-- scripts -->
        <jsp:include page="WEB-INF/shareds/scripts.html"/>
    </body>
</html>
--%>
