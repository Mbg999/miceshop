<%-- 
    Document   : show
    Created on : 17-feb-2020, 11:10:43
    Author     : IES TRASSIERRA
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="MyUtils" class="utils.MyUtils"/>

<%-- LANGUAGE --%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="${locale}" scope="session"/>
<fmt:setBundle basename="languages.tags"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>La Ratonería | ref: ${article.referencia}</title>
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
                    <!-- ARTICLE -->
                    <c:if test="${empty article}"><fmt:message key="articulo no existe"/></c:if>
                    <c:if test="${!empty article}">
                        <div class="card">
                            <div class="card-body">
                                <div class="container">
                                    <div class="row">
                                        <!-- FEEDBACK MSG -->
                                        <c:if test="${!empty feedbackMsg}">
                                            <c:if test="${feedbackSuccess}">
                                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                </c:if>
                                                <c:if test="${!feedbackSuccess}">
                                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                    </c:if>
                                                    ${feedbackMsg}
                                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                            </c:if>
                                            <!-- /FEEDBACK MSG -->
                                            <div class="col-12">
                                                <h2>Ref: ${article.referencia}</h2>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <img class="img-fluid" src="${MyUtils.getImg(article.path_imagen)}" alt="${article.referencia}">
                                            </div>
                                            <div class="col-12 col-lg-6 pb-4">
                                                <p>${article.descripcion}</p>
                                            </div>
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-10 mx-auto">
                                                        <div class="card mt-3">
                                                            <div class="card-body">
                                                                <div class="container-fluid">
                                                                    <div class="row">
                                                                        <!-- PRECIO -->
                                                                        <div class="col-4 col-md-3"><fmt:message key="precio"/>:</div>
                                                                        <div class="col-8 col-md-9">${article.precio}&euro;</div>
                                                                        <!-- /PRECIO -->
                                                                        <!-- TO CART FROM -->
                                                                        <div class="col-12">
                                                                            <c:if test="${article.stock > 0}">
                                                                                <form action="/Tienda/cart/add" method="post" class="row">
                                                                                    <input type="hidden" name="referencia" value="${article.referencia}">
                                                                                    <!-- STOCK -->
                                                                                    <div class="col-4 col-md-3">
                                                                                        stock:
                                                                                    </div>
                                                                                    <div class="col-8 col-md-9">
                                                                                        ${article.stock}
                                                                                    </div>
                                                                                    <!-- /STOCK -->
                                                                                    <!-- CANTIDAD -->
                                                                                    <div class="col-4 col-md-3">
                                                                                        <label for="ctd"><fmt:message key="cantidad"/>:</label>
                                                                                    </div>
                                                                                    <div class="col-8 col-md-9">
                                                                                        <input type="number" style="width: 60px;" name="ctd" id="ctd" class="form-control" placeholder="0">
                                                                                    </div>
                                                                                    <!-- /CANTIDAD -->
                                                                                    <!-- SUBMIT BTN -->
                                                                                    <div class="col-12">
                                                                                        <button type="submit" class="btn btn-primary btn-block mt-3"><fmt:message key="add carrito"/></button>
                                                                                    </div>
                                                                                    <!-- /SUBMIT BTN -->
                                                                                </form>
                                                                            </c:if>
                                                                            <c:if test="${article.stock < 1}">
                                                                                <div class="col-12">
                                                                                    <p class="text-danger"><fmt:message key="sin stock"/></p>
                                                                                </div>
                                                                            </c:if>
                                                                        </div>
                                                                        <!-- /TO CART FROM -->
                                                                        <%-- ADMIN CONTROLS --%>
                                                                        <c:if test="${client.admin}">
                                                                            <div class="col-12">
                                                                                <a href="/Tienda/articles/edit?ref=${article.referencia}" class="btn btn-warning btn-block mt-2">
                                                                                    <fmt:message key="editar"/> <fmt:message key="articulo"/>
                                                                                </a>
                                                                            </div>
                                                                        </c:if>
                                                                        <%-- /ADMIN CONTROLS --%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <!-- /ARTICLE -->
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
