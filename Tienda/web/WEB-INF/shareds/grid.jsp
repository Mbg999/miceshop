<%-- 
    Document   : grid
    Created on : 18-feb-2020, 16:37:19
    Author     : miguel
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- LANGUAGE --%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="${locale}" scope="session"/>
<fmt:setBundle basename="languages.tags"/>


<jsp:useBean id="MyUtils" class="utils.MyUtils"/>
<!-- NO ARTICLES MSG -->
<c:if test="${empty articles}">
    <div class="card">
        <div class="card-body">
            <p class="alert alert-info"><fmt:message key="no hay articulos"/></p>
        </div>
    </div>
</c:if>
<!-- /NO ARTICLES MSG -->
<!-- ARTICLES CARDS -->
<c:if test="${!empty articles}">
    <div class="card-columns align-center">
        <c:forEach var="article" items="${articles}">
            <div class="card w-100">
                <img class="card-img-top" src="${MyUtils.getImg(article.path_imagen)}" alt="${article.referencia}">
                <div class="card-body">
                    <p class="card-text">${article.descripcion}</p>
                    <p class="card-text text-right"><fmt:message key="precio"/>: <b>${article.precio}&euro;</b></p>
                    <a type="button" class="btn btn-primary btn-block"
                       href="/Tienda/articles/show?ref=${article.referencia}">
                        <fmt:message key="ver producto"/> 
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</c:if>
<!-- /ARTICLES CARDS -->