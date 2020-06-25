<%-- 
    Document   : edit
    Created on : 16-feb-2020, 16:17:40
    Author     : Miguel
--%>

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
            <c:if test="${!empty err}">
                <div>
                    <h3 class="text-danger">${err}</h3>
                </div>
            </c:if>
            <c:if test="${!empty success}">
                <div>
                    <h3 class="text-success">${success}</h3>
                </div>
            </c:if>

            <!-- UPDATE FORM -->
            <div>
                <form action="update" method="post">
                    <!-- DNI -->
                    <input type="text" value="${(!empty DNI[0]) ? DNI[0] : client.DNI}" disabled>
                    <input type="hidden" name="DNI" value="${(!empty DNI[0]) ? DNI[0] : client.DNI}">
                    <c:if test="${!empty DNI[1]}">
                        <em class="text-danger">${DNI[1]}</em>
                    </c:if>
                    <!-- /DNI -->
                    <!-- NOMBRE -->
                    <div class="form-group">
                        <label for="nombre">Name</label>
                        <input type="text" name="nombre" id="nombre" placeholder="Your name" value="${(nombre[0]) ? nombre[0] : client.nombre}">
                        <c:if test="${!empty nombre[1]}">
                            <em class="text-danger">${nombre[1]}</em>
                        </c:if>
                    </div>
                    <!-- /NOMBRE -->
                    <!-- FEC_NAC -->
                    <div class="form-group">
                        <label for="fec_nac">Fecha de nacimiento</label>
                        <input type="date" name="fec_nac" id="fec_nac" value="${(fec_nac[0]) ? fec_nac[0] : client.fec_nac}">
                        <c:if test="${!empty fec_nac[1]}">
                            <em class="text-danger">${fec_nac[1]}</em>
                        </c:if>
                    </div>
                    <!-- /FEC_NAC -->
                    <!-- DIRECCION -->
                    <div class="form-group">
                        <label for="direccion">Direccion</label>
                        <input type="text" name="direccion" id="direccion" placeholder="Your direction" value="${(direccion[0]) ? direccion[0] : client.direccion}">
                        <c:if test="${!empty direccion[1]}">
                            <em class="text-danger">${direccion[1]}</em>
                        </c:if>
                    </div>
                    <!-- /DIRECCION -->
                    <!-- PASSWORD -->
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" name="password" id="password" placeholder="Your password" value="${(password[0]) ? password[0] : client.password}">
                        <c:if test="${!empty password[1]}">
                            <em class="text-danger">${password[1]}</em>
                        </c:if>
                    </div>
                    <!-- /PASSWORD -->
                    <div>
                        <input type="submit" value="Update">
                    </div>
                </form>
            </div>
            <!-- /UPDATE FORM -->
        </div>
                        
        <!-- scripts -->
        <jsp:include page="/WEB-INF/shareds/scripts.html"/>
    </body>
</html>
