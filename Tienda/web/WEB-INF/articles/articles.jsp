<%-- 
    Document   : index
    Created on : 17-feb-2020, 11:10:18
    Author     : IES TRASSIERRA
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
        <title>La Ratonería | <fmt:message key="articulos"/></title>
    <jsp:include page="/WEB-INF/shareds/head.html"/>
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
                    <h2><fmt:message key="titulo inicio"/></h2>
                    <h5 class="mb-3"><fmt:message key="subtitulo inicio"/></h5>
                    <!-- GRID OF ARTICLES -->
                    <jsp:include page="/WEB-INF/shareds/grid.jsp"/>
                    <!-- /GRID OF ARTICLES -->
                </main>
                <!-- /PRODUCTOS -->
                <!-- FOOTER -->
                <jsp:include page="/WEB-INF/shareds/footer.jsp"/>
                <!-- /FOOTER -->
            </div>
        </div>
                
        <!-- scripts -->
        <jsp:include page="/WEB-INF/shareds/scripts.html"/>
    </body>
</html>
