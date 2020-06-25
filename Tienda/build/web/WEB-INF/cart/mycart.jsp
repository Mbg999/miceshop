<%-- 
    Document   : mycart
    Created on : 20-feb-2020, 10:17:54
    Author     : IES TRASSIERRA
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>La Ratonería | <fmt:message key="mi carrito"/></title>
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
                        <c:if test="${!empty errors}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <ul>
                                    <c:forEach var="err" items="${errors}">
                                        <li>${err}</li>
                                        </c:forEach>
                                </ul>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                        <!-- /FEEDBACK MESSAGES -->
                        <!-- SIGNUP FORM -->
                        <div class="col-12">
                            <h2 class="mb-3"><fmt:message key="mi carrito"/></h2>
                            <!-- EMPTY CART -->
                            <c:if test="${empty cart}">
                                <p class="alert alert-info"><fmt:message key="tu carrito esta vacio"/></p>
                            </c:if>
                            <!-- /EMPTY CART -->
                            <!-- NOT EMPTY CART -->
                            <c:if test="${!empty cart}">
                                <fmt:parseNumber var="total" integerOnly="true" 
                                                 type="number" value="0" />
                                <div class="row">
                                    <div class="col-12 col-lg-8">
                                        <table class="table table-responsive">
                                            <thead class="bg-dark text-light">
                                                <tr>
                                                    <th><fmt:message key="articulo"/></th>
                                                    <th><fmt:message key="precio"/></th>
                                                    <th><fmt:message key="cantidad"/></th>
                                                    <th>Total</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-light text-dark">
                                                <c:forEach var="article" items="${cart.articles}">
                                                    <fmt:parseNumber var="total" integerOnly="true" 
                                                                     type="number" value="${total+(article.value.precio*article.value.ctd)}" />
                                                    <tr>
                                                        <td>
                                                            <img src="${MyUtils.getImg(article.value.path_imagen)}" class="mr-3" style="height:100px; width: 100px;" alt="${article.value.referencia}">
                                                            <span>
                                                                <c:if test="${fn:length(article.value.descripcion) > 15}">
                                                                    ${fn:substring(article.value.descripcion, 0, 15)}...
                                                                </c:if>
                                                                <c:if test="${fn:length(article.value.descripcion) < 15}">
                                                                    ${article.value.descripcion}
                                                                </c:if>
                                                            </span>
                                                        </td>
                                                        <td>${article.value.precio}&euro;</td>
                                                        <td>
                                                            <form action="/Tienda/cart/update" method="post" class="form-inline">
                                                                <input type="hidden" name="referencia" value="${article.value.referencia}">
                                                                <input type="number" style="width: 60px;" name="ctd" id="ctd" class="form-control" value="${article.value.ctd}">
                                                                <button type="submit" class="btn btn-primary"><fmt:message key="actualizar"/></button>
                                                            </form>
                                                            <c:if test="${!empty ctd && errRef == article.value.referencia}">
                                                                <em class="text-danger">${ctd}</em>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            ${article.value.precio * article.value.ctd}&euro;
                                                        </td>
                                                        <td>
                                                            <form action="/Tienda/cart/delete/article" method="post" class="form-inline">
                                                                <input type="hidden" name="referencia" value="${article.value.referencia}">
                                                                <button type="submit" class="btn btn-danger">&times;</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-12 col-lg-4">
                                        <div class="card mx-auto" style="width: 300px;">
                                            <div class="card-body">
                                                <h3>Total: ${total}&euro;</h3>
                                                <div>
                                                    <form action="/Tienda/cart/purchase" method="post" class="form-inline">
                                                        <input type="hidden" name="referencia" value="${article.value.referencia}">
                                                        <button type="submit" class="btn btn-primary btn-block"><fmt:message key="comprar"/></button>
                                                    </form>
                                                </div>
                                                <div>
                                                    <form action="/Tienda/cart/delete" method="post" class="form-inline">
                                                        <button type="submit" class="btn btn-danger btn-block"><fmt:message key="vaciar carrito"/></button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <!-- /NOT EMPTY CART -->
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
