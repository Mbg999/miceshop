<%-- 
    Document   : edit
    Created on : 17-feb-2020, 11:10:28
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
        <title>La Ratonería | <fmt:message key="editar"/> <fmt:message key="articulo"/></title>
        <jsp:include page="/WEB-INF/shareds/head.html"/>
    </head>
    <body>
        ${URL}
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
                            <h2 class="mb-3"><fmt:message key="editar articulo con referencia"/>: ${(!empty referencia[0]) ? referencia[0] : article.referencia}</h2>
                            <form action="/Tienda/articles/update" method="post" enctype="multipart/form-data">
                                <!-- REFERENCIA -->
                                <div class="form-group">
                                    <label><fmt:message key="referencia"/></label>
                                    <input type="text" value="${(!empty referencia[0]) ? referencia[0] : article.referencia}" class="form-control" disabled>
                                    <input type="hidden" name="referencia" value="${(!empty referencia[0]) ? referencia[0] : article.referencia}">
                                    <c:if test="${!empty referencia[1]}">
                                        <em class="text-danger">${referencia[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /REFERENCIA -->
                                <!-- DESCRIPCION -->
                                <div class="form-group">
                                    <label for="descripcion"><fmt:message key="descripcion"/></label>
                                    <textarea name="descripcion" id="descripcion" class="form-control" placeholder="<fmt:message key="descripcion del articulo"/>">${(!empty descripcion[0]) ? descripcion[0] : article.descripcion}</textarea>
                                    <c:if test="${!empty descripcion[1]}">
                                        <em class="text-danger">${descripcion[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /DESCIRPCION -->
                                <!-- PRECIO -->
                                <div class="form-group">
                                    <label for="precio"><fmt:message key="precio"/></label>
                                    <input type="number" name="precio" id="precio" class="form-control" placeholder="0" value="${(!empty precio[0]) ? precio[0] : article.precio}">
                                    <c:if test="${!empty precio[1]}">
                                        <em class="text-danger">${precio[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /PRECIO -->
                                <!-- STOCK -->
                                <div class="form-group">
                                    <label for="stock">Stock</label>
                                    <input type="number" name="stock" id="stock" class="form-control" placeholder="0" value="${(!empty stock[0]) ? stock[0] : article.stock}">
                                    <c:if test="${!empty stock[1]}">
                                        <em class="text-danger">${stock[1]}</em>
                                    </c:if>
                                </div>
                                <!-- /STOCK -->
                                <!-- PATH_IMAGEN -->
                                <div class="form-group">
                                    <label class="d-block"><fmt:message key="imagen"/></label>
                                    <img width="300px" class="d-block mb-3" src="${MyUtils.getImg((!empty article.path_imagen) ? article.path_imagen : path_imagen)}" alt="${(empty path_imagen) ? '' : path_imagen}">
                                    <label for="img" class="btn btn-primary"><fmt:message key="selecciona una imagen"/></label>
                                    <span id="selectedImg" class="d-none"><fmt:message key="imagen seleccionada"/></span>
                                    <input type="file" name="img" id="img" class="invisible">
                                </div>
                                <!-- /PATH_IMAGEN -->
                                <!-- SUBMIT BTN -->
                                <div>
                                    <button type="submit" class="btn btn-primary"><fmt:message key="actualizar"/></button>
                                </div>
                                <!-- /SUBMIT BTN -->
                            </form>
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
        <script>
            "use strict"
            window.addEventListener("load", ()=>{
                document.getElementById("img").addEventListener("change", function(){
                   document.getElementById("selectedImg").classList.remove("d-none"); 
                });
            });
        </script>
    </body>
</html>