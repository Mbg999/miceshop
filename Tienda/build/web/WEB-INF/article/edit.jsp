<%-- 
    Document   : edit
    Created on : 17-feb-2020, 11:10:28
    Author     : IES TRASSIERRA
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
            <h1>Create article</h1>
            <c:if test="${!empty err}"><em class="text-danger">${err}</em></c:if>
            <c:if test="${!empty success}"><em class="text-success">${success}</em></c:if>
            
            <form action="update" method="post">
                <!-- REFERENCIA -->
                <div class="form-group">
                    <label>Referencia</label>
                    <input type="text" value="${(!empty referencia[0]) ? referencia[0] : article.referencia}" disabled>
                    <input type="hidden" name="referencia" value="${(!empty referencia[0]) ? referencia[0] : article.referencia}">
                    <c:if test="${!empty referencia[1]}">
                        <em class="text-danger">${referencia[1]}</em>
                    </c:if>
                </div>
                <!-- /REFERENCIA -->
                <!-- DESCRIPCION -->
                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea name="descripcion" id="descripcion" placeholder="Descripción del artículo">${(!empty descripcion[0]) ? descripcion[0] : article.descripcion}</textarea>
                    <c:if test="${!empty descripcion[1]}">
                        <em class="text-danger">${descripcion[1]}</em>
                    </c:if>
                </div>
                <!-- /DESCIRPCION -->
                <!-- PRECIO -->
                <div class="form-group">
                    <label for="precio">Precio</label>
                    <input type="number" name="precio" id="precio" placeholder="0" value="${(!empty precio[0]) ? precio[0] : article.precio}">
                    <c:if test="${!empty precio[1]}">
                        <em class="text-danger">${precio[1]}</em>
                    </c:if>
                </div>
                <!-- /PRECIO -->
                <!-- PATH_IMAGEN -->
                <div class="form-group">
                    <label>Imagen</label>
                    <div>
                        <button type="button" id="urlBtn">Desde una URL</button>
                        <button type="button" id="archivoBtn">Desde un archivo (not implemented yet)</button>
                    </div>
                    <div>
                        <c:if test="${!empty path_imagen[0] || !empty article.path_imagen}">
                            <input type="text" name="path_imagen" id="url" placeholder="tu URL" value="${(!empty path_imagen[0]) ? path_imagen[0] : article.path_imagen}">
                        </c:if>
                        <c:if test="${empty path_imagen[0] && empty article.path_imagen}">
                            <input type="text" name="path_imagen" id="url" placeholder="tu URL" class="d-none" disabled>
                        </c:if>

                        <input type="file" name="path_imagen" id="archivo"
                               class="d-none" disabled>
                    </div>
                    <c:if test="${!empty path_imagen[1]}">
                        <em class="text-danger">${path_imagen[1]}</em>
                    </c:if>
                </div>
                <!-- /PATH_IMAGEN -->
                <!-- STOCK -->
                <div class="form-group">
                    <label for="stock">Stock</label>
                    <input type="number" name="stock" id="stock" placeholder="0" value="${(!empty stock[0]) ? stock[0] : article.stock}">
                    <c:if test="${!empty stock[1]}">
                        <em class="text-danger">${stock[1]}</em>
                    </c:if>
                </div>
                <!-- /STOCK -->
                <!-- SUBMIT BTN -->
                <div>
                    <button type="submit">Editar</button>
                </div>
                <!-- /SUBMIT BTN -->
            </form>
        </div>

        <!-- scripts -->
        <jsp:include page="/WEB-INF/shareds/scripts.html"/>
        <script>
            $(() => {
                $("#urlBtn").on("click", () => {
                    $("#url").removeClass("d-none").prop("disabled", false);
                    $("#archivo").addClass("d-none").prop("disabled", true);
                });

                $("#archivoBtn").on("click", () => {
                    $("#archivo").removeClass("d-none").prop("disabled", false);
                    $("#url").addClass("d-none").prop("disabled", true);
                });
            });
        </script>
    </body>
</html>
