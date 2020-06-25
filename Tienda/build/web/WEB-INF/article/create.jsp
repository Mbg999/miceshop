<%-- 
    Document   : create
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
            
            <form action="store" method="post">
                <!-- REFERENCIA -->
                <div class="form-group">
                    <label for="referencia">Referencia</label>
                    <input type="text" name="referencia" id="referencia" placeholder="Referencia" value="${referencia[0]}">
                    <c:if test="${!empty referencia[1]}">
                        <em class="text-danger">${referencia[1]}</em>
                    </c:if>
                </div>
                <!-- /REFERENCIA -->
                <!-- DESCRIPCION -->
                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea name="descripcion" id="descripcion" placeholder="Descripción del artículo">${descripcion[0]}</textarea>
                    <c:if test="${!empty descripcion[1]}">
                        <em class="text-danger">${descripcion[1]}</em>
                    </c:if>
                </div>
                <!-- /DESCIRPCION -->
                <!-- PRECIO -->
                <div class="form-group">
                    <label for="precio">Precio</label>
                    <input type="number" name="precio" id="precio" placeholder="0" value="${precio[0]}">
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
                        <input type="text" name="path_imagen" id="url" placeholder="tu URL" value="${path_imagen[0]}"
                               class="d-none" disabled>

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
                    <input type="number" name="stock" id="stock" placeholder="0" value="${stock[0]}">
                    <c:if test="${!empty stock[1]}">
                        <em class="text-danger">${stock[1]}</em>
                    </c:if>
                </div>
                <!-- /STOCK -->
                <!-- SUBMIT BTN -->
                <div>
                    <button type="submit">Crear</button>
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
