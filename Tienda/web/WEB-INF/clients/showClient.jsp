<%-- 
    Document   : showClient
    Created on : 16-feb-2020, 13:33:04
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
        <title>La Ratonería | <fmt:message key="cliente"/></title>
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
                    <h2 class="mb-3"><fmt:message key="perfil de"/> ${showClient.nombre}</h2>
                    <div class="row">
                        <div class="col-8 mx-auto">
                            <div class="card">
                                <div class="card-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <!-- DNI -->
                                            <div class="col-12 col-lg-3">DNI:</div>
                                            <div class="col-12 col-lg-9 text-center text-lg-left">${showClient.DNI}</div>
                                            <!-- /DNI -->
                                            <c:if test="${client.DNI == showClient.DNI || client.admin}">
                                                <!-- NOMBRE -->
                                                <div class="col-12 col-lg-3"><fmt:message key="nombre"/>:</div>
                                                <div class="col-12 col-lg-9 text-center text-lg-left">${showClient.nombre}</div>
                                                <!-- /NOMBRE -->
                                                <!-- FEC_NAC -->
                                                <div class="col-12 col-lg-3"><fmt:message key="fecha de nacimiento"/>:</div>
                                                <div class="col-12 col-lg-9 text-center text-lg-left">${showClient.fec_nac}</div>
                                                <!-- /FEC_NAC -->
                                                <!-- DIRECCION -->
                                                <div class="col-12 col-lg-3"><fmt:message key="direccion"/>:</div>
                                                <div class="col-12 col-lg-9 text-center text-lg-left">${showClient.direccion}</div>
                                                <!-- /DIRECCION -->
                                                <div class="col-12 pt-3">
                                                    <%-- EDIT OWN PROFILE--%>
                                                    <c:if test="${client.DNI == showClient.DNI}">
                                                        <a href="/Tienda/clients/edit" class="btn btn-primary d-block d-lg-inline-block">
                                                            <fmt:message key="editar"/> <fmt:message key="mi perfil"/>
                                                        </a>
                                                    </c:if>
                                                    <%-- /EDIT OWN PROFILE --%>
                                                    <%-- ADMIN CONTROLS --%>
                                                    <c:if test="${client.admin}">
                                                        <a href="/Tienda/clients/editfromadmin?client=${showClient.DNI}" class="btn btn-warning d-block d-lg-inline-block">
                                                            <fmt:message key="editar"/> <fmt:message key="cliente"/>
                                                        </a>
                                                    </c:if>
                                                    <%-- /ADMIN CONTROLS --%>
                                                    <%-- TICKETS --%>
                                                    <c:if test="${!empty showClient.tickets && (client.DNI == showClient.DNI || client.admin)}">
                                                        <hr>
                                                        <h5 class="card-title">Tickets</h5>
                                                        <c:forEach var="ticket" items="${showClient.tickets}">
                                                            <p class="card-text text-center border border-bottom overflow-auto">
                                                                <span class="d-block d-lg-inline-block pt-lg-2"><fmt:message key="numero de ticket"/>: ${ticket.num_ticket} </span>
                                                                <span class="d-none d-lg-inline-block mx-1">|</span> 
                                                                <span class="d-block d-lg-inline-block"><fmt:message key="fecha"/>: ${ticket.fecha}</span>
                                                                <a class="btn btn-primary d-block float-lg-right" target="_blank" href="/Tienda/ticket?num_ticket=${ticket.num_ticket}">
                                                                    <fmt:message key="ver ticket"/>
                                                                </a>
                                                            </p>
                                                        </c:forEach>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
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
