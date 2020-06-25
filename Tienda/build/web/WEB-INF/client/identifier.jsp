<%-- 
    Document   : identifier
    Created on : 15-feb-2020, 21:44:23
    Author     : Miguel
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="/WEB-INF/shareds/head.html"/>
    </head>
    <body>
        <div id="main-container">
            <jsp:include page="/WEB-INF/shareds/navbar.jsp"/>
            <c:if test="${!empty err}">
                <div>
                    <h3 class="text-danger">${err}</h3>
                </div>
            </c:if>
            <!-- LOGIN FORM -->
            <div>
                <form action="/Tienda/login" method="post">
                    <!-- DNI -->
                    <div class="form-group">
                        <label for="DNIl">DNI</label>
                        <input type="text" name="DNIl" id="DNIl" placeholder="Your DNI" value="${DNIl[0]}">
                        <c:if test="${!empty DNIl[1]}">
                            <em class="text-danger">${DNIl[1]}</em>
                        </c:if>
                    </div>
                    <!-- /DNI -->
                    <!-- PASSWORD -->
                    <div class="form-group">
                        <label for="passwordl">password</label>
                        <input type="password" name="passwordl" id="passwordl" placeholder="Your password">
                        <c:if test="${!empty passwordl[1]}">
                            <em class="text-danger">${passwordl[1]}</em>
                        </c:if>
                    </div>
                    <!-- /PASSWORD -->
                    <div>
                        <input type="submit" value="Login">
                    </div>
                </form>
            </div>
            <!-- /LOGIN FORM -->


            <!-- SIGNUP FORM -->
            <div>
                <form action="/Tienda/signup" method="post">
                    <!-- DNI -->
                    <div class="form-group">
                        <label for="DNI">DNI</label>
                        <input type="text" name="DNI" id="DNI" placeholder="Your DNI" value="${DNI[0]}">
                        <c:if test="${!empty DNI[1]}">
                            <em class="text-danger">${DNI[1]}</em>
                        </c:if>
                    </div>
                    <!-- /DNI -->

                    <!-- NOMBRE -->
                    <div class="form-group">
                        <label for="nombre">Name</label>
                        <input type="text" name="nombre" id="nombre" placeholder="Your name" value="${nombre[0]}">
                        <c:if test="${!empty nombre[1]}">
                            <em class="text-danger">${nombre[1]}</em>
                        </c:if>
                    </div>
                    <!-- /NOMBRE -->
                    <!-- FEC_NAC -->
                    <div class="form-group">
                        <label for="fec_nac">Fecha de nacimiento</label>
                        <input type="date" name="fec_nac" id="fec_nac" value="${fec_nac[0]}">
                        <c:if test="${!empty fec_nac[1]}">
                            <em class="text-danger">${fec_nac[1]}</em>
                        </c:if>
                    </div>
                    <!-- /FEC_NAC -->
                    <!-- DIRECCION -->
                    <div class="form-group">
                        <label for="direccion">Direccion</label>
                        <input type="text" name="direccion" id="direccion" placeholder="Your direction" value="${direccion[0]}">
                        <c:if test="${!empty direccion[1]}">
                            <em class="text-danger">${direccion[1]}</em>
                        </c:if>
                    </div>
                    <!-- /DIRECCION -->
                    <!-- PASSWORD -->
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" name="password" id="password" placeholder="Your password">
                        <c:if test="${!empty password[1]}">
                            <em class="text-danger">${password[1]}</em>
                        </c:if>
                    </div>
                    <!-- /PASSWORD -->
                    <div>
                        <input type="submit" value="Signup">
                    </div>
                </form>
            </div>
            <!-- /SIGNUP FORM -->
        </div>

        <!-- scripts -->
        <jsp:include page="/WEB-INF/shareds/scripts.html"/>
    </body>
</html>
