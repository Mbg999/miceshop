<%-- 
    Document   : identifier
    Created on : 15-feb-2020, 21:44:23
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
                    <div class="row">
                        <!-- FEEDBACK MESSAGES -->
                        <c:if test="${!empty err}">
                            <div class="col-12">
                                <p class="alert alert-danger">${err}</p>
                            </div>
                        </c:if>
                        <!-- /FEEDBACK MESSAGES -->
                        <!-- LOGIN FORM -->
                        <div class="col-12 col-md-6 px-5 pb-5">
                            <h2 class="mb-3">Entrar</h2>
                            <form action="/Tienda/login" method="post">
                                <!-- DNI -->
                                <div class="form-group">
                                    <label for="DNIl">DNI</label>
                                    <input type="text" name="DNIl" class="form-control" id="DNIl" placeholder="DNI" value="${DNIl[0]}">
                                    <c:if test="${!empty DNIl[1]}">
                                        <em class="text-danger">${DNIl[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /DNI -->
                                <!-- PASSWORD -->
                                <div class="form-group">
                                    <label for="passwordl"><fmt:message key="password"/></label>
                                    <input type="password" name="passwordl" class="form-control" id="passwordl" placeholder="<fmt:message key="password"/>">
                                    <c:if test="${!empty passwordl[1]}">
                                        <em class="text-danger">${passwordl[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /PASSWORD -->
                                <div>
                                    <button type="submit" class="btn btn-block btn-primary"><fmt:message key="iniciar sesion"/></button>
                                </div>
                            </form>
                        </div>
                        <!-- /LOGIN FORM -->


                        <!-- SIGNUP FORM -->
                        <div class="col-12 col-md-6 px-5 pb-5">
                            <h2 class="mb-3 text-light"><fmt:message key="nuevo"/> <fmt:message key="cliente"/></h2>
                            <form action="/Tienda/signup" method="post">
                                <!-- DNI -->
                                <div class="form-group">
                                    <label for="DNI">DNI</label>
                                    <input type="text" name="DNI" id="DNI" class="form-control" placeholder="DNI" value="${DNI[0]}">
                                    <c:if test="${!empty DNI[1]}">
                                        <em class="text-danger">${DNI[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /DNI -->

                                <!-- NOMBRE -->
                                <div class="form-group">
                                    <label for="nombre"><fmt:message key="nombre"/></label>
                                    <input type="text" name="nombre" id="nombre" class="form-control" placeholder="<fmt:message key="nombre"/>" value="${nombre[0]}">
                                    <c:if test="${!empty nombre[1]}">
                                        <em class="text-danger">${nombre[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /NOMBRE -->
                                <!-- FEC_NAC -->
                                <div class="form-group">
                                    <label for="fec_nac"><fmt:message key="fecha de nacimiento"/></label>
                                    <input type="date" name="fec_nac" id="fec_nac" class="form-control" value="${fec_nac[0]}">
                                    <c:if test="${!empty fec_nac[1]}">
                                        <em class="text-danger">${fec_nac[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /FEC_NAC -->
                                <!-- DIRECCION -->
                                <div class="form-group">
                                    <label for="direccion"><fmt:message key="direccion"/></label>
                                    <input type="text" name="direccion" id="direccion" class="form-control" placeholder="<fmt:message key="direccion"/>" value="${direccion[0]}">
                                    <c:if test="${!empty direccion[1]}">
                                        <em class="text-danger">${direccion[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /DIRECCION -->
                                <!-- PASSWORD -->
                                <div class="form-group">
                                    <label for="password"><fmt:message key="password"/></label>
                                    <input type="password" name="password" id="password" class="form-control" placeholder="<fmt:message key="password"/>">
                                    <c:if test="${!empty password[1]}">
                                        <em class="text-danger">${password[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /PASSWORD -->
                                <div>
                                    <button type="submit" class="btn btn-block btn-primary"><fmt:message key="registrar"/></button>
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
