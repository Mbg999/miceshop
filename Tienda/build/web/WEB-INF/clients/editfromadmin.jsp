<%-- 
    Document   : editfromadmin
    Created on : 16-feb-2020, 16:17:51
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
        <title>La Ratonería | <fmt:message key="edit"/> <fmt:message key="cliente"/></title>
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
                    <div class="row">
                        <!-- FEEDBACK MESSAGES -->
                        <c:if test="${!empty err}">
                            <div class="col-12">
                                <p class="alert alert-danger">${err}</p>
                            </div>
                        </c:if>
                        <c:if test="${!empty success}">
                            <div class="col-12">
                                <p class="alert alert-success">${success}</p>
                            </div>
                        </c:if>
                        <!-- /FEEDBACK MESSAGES -->
                        <!-- SIGNUP FORM -->
                        <div class="col-10 px-5 mx-auto">
                            <h2 class="mb-3"><fmt:message key="edicion del usuario con DNI"/>: ${(!empty DNI[0]) ? DNI[0] : client.DNI}</h2>
                            <form action="updatefromadmin" method="post">
                                <!-- DNI -->
                                <input type="text" value="${(!empty DNI[0]) ? DNI[0] : client.DNI}" class="form-control" disabled>
                                <input type="hidden" name="DNI" value="${(!empty DNI[0]) ? DNI[0] : client.DNI}">
                                <c:if test="${!empty DNI[1]}">
                                    <em class="text-danger">${DNI[1]}</em>
                                </c:if>
                                <!-- /DNI -->
                                <!-- NOMBRE -->
                                <div class="form-group">
                                    <label for="nombre"><fmt:message key="name"/></label>
                                    <input type="text" name="nombre" id="nombre" class="form-control" placeholder="<fmt:message key="edicion del usuario con DNI"/>" value="${(nombre[0]) ? nombre[0] : client.nombre}">
                                    <c:if test="${!empty nombre[1]}">
                                        <em class="text-danger">${nombre[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /NOMBRE -->
                                <!-- FEC_NAC -->
                                <div class="form-group">
                                    <label for="fec_nac"><fmt:message key="fecha de nacimiento"/></label>
                                    <input type="date" name="fec_nac" id="fec_nac" class="form-control" value="${(fec_nac[0]) ? fec_nac[0] : client.fec_nac}">
                                    <c:if test="${!empty fec_nac[1]}">
                                        <em class="text-danger">${fec_nac[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /FEC_NAC -->
                                <!-- DIRECCION -->
                                <div class="form-group">
                                    <label for="direccion"><fmt:message key="direccion"/></label>
                                    <input type="text" name="direccion" id="direccion" class="form-control" placeholder="<fmt:message key="direccion"/>" value="${(direccion[0]) ? direccion[0] : client.direccion}">
                                    <c:if test="${!empty direccion[1]}">
                                        <em class="text-danger">${direccion[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /DIRECCION -->
                                <!-- PASSWORD -->
                                <div class="form-group">
                                    <label for="password"><fmt:message key="password"/></label>
                                    <input type="password" name="password" id="password" class="form-control" placeholder="<fmt:message key="password"/>" value="${(password[0]) ? password[0] : client.password}">
                                    <c:if test="${!empty password[1]}">
                                        <em class="text-danger">${password[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /PASSWORD -->
                                <!-- ADMIN -->
                                <div class="form-group form-check">
                                    <input type="checkbox" id="admin" name="admin" value="true" class="form-check-input" ${(admin || uclient.admin) ? 'checked' : ''}>
                                    <label for="admin" class="form-check-label">is admin</label>
                                </div>
                                <!-- /ADMIN -->
                                <div>
                                    <button type="submit" class="btn btn-primary"><fmt:message key="actualizar"/></button>
                                </div>
                            </form>
                        </div>
                        <!-- /SIGNUP FORM -->
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