<%-- 
    Document   : show
    Created on : 17-feb-2020, 11:10:43
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
                    <!-- BREADCRUMB -->
                    <jsp:include page="/WEB-INF/shareds/breadcrumb.jsp"/>
                    <!-- /BREADCRUMB -->
                </header>
                <!-- PRODUCTOS -->
                <main class="col-12 col-lg-10 order-3 order-lg-2 bg-success">
                    <h2>Bienvenido a mi tienda</h2>
                    <!-- ARTICLE -->
                    <c:if test="${empty showArticle}">el articulo no existe</c:if>
                    <c:if test="${!empty showArticle}">
                        <div class="card">
                            <div class="card-body">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-12 col-lg-6">
                                            <img class="img-fluid" src="${showArticle.path_imagen}" alt="${showArticle.referencia}">
                                        </div>
                                        <div class="col-12 col-lg-6 pb-4">
                                            <p>${showArticle.descripcion}</p>
                                        </div>
                                        <div class="col-8 col-md-4">
                                            <form action="#" method="post">
                                                <div class="row">
                                                    <div class="col-6 pb-3">Precio:</div>
                                                    <div class="col-6">
                                                        <b>${showArticle.precio}</b>
                                                    </div>
                                                    <div class="col-6">
                                                        <label for="ctd">Cantidad: </label>
                                                    </div>
                                                    <div class="col-6 pb-3">
                                                        <input type="number" style="width: 60px;" name="ctd" id="ctd" class="form-control">
                                                    </div>
                                                    <div class="col-12">
                                                        <button type="submit" class="btn btn-primary btn-block">Añadir al carrito</button>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <!-- /ARTICLE -->
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
