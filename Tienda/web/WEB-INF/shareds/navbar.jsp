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

<nav class="navbar navbar-expand-lg navbar-dark bg-dark position-sticky sticky-top">
    <!-- BRAND -->
    <a href="/Tienda/index.jsp" class="navbar-brand">
        <img src="/Tienda/imgs/logo.png" alt="La Ratonería" title="La Ratonería" style="width:80px">
    </a>
    <!-- /BRAND -->
    <!-- TOGGLER -->
    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarcontent"
            aria-controls="navbarcontent" aria-expanded="false" aria-label="toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <!-- /TOGGLER -->
    <!-- NAVBAR CONTENT -->
    <div class="collapse navbar-collapse" id="navbarcontent">
        <!-- LINKS -->
        <ul class="navbar-nav ml-auto">
            <li class='nav-item ${(pageContext.request.requestURI.endsWith("articles.jsp")) ? "active" : ""}'>
                <a href="/Tienda/index.jsp" class="nav-link">
                    <fmt:message key="inicio"/>
                </a>
            </li>
            <li class="nav-item">
                <a href="/Tienda/cart" class="nav-link ${(pageContext.request.requestURI.endsWith("cart.jsp")) ? 'active' : ''}">
                    <fmt:message key="mi carrito"/>
                </a>
            </li>
            <c:if test="${empty client}">
                <li class="nav-item ${(pageContext.request.requestURI.endsWith("identifier.jsp")) ? 'active' : ''}">
                    <a href="/Tienda/clients" class="nav-link">
                        <fmt:message key="entra o registrate"/>
                    </a>
                </li>
            </c:if>
            <c:if test="${!empty client}">
                <li class="nav-item ${(pageContext.request.requestURI.endsWith("showClient.jsp")) ? 'active' : ''}">
                    <a href="/Tienda/clients/show?client=${client.DNI}" class="nav-link">
                        <fmt:message key="mi perfil"/>
                    </a>
                </li>
                <%-- ADMIN CONTROLS --%>
                <c:if test="${client.admin}">
                    <%-- CLIENTS --%>
                    <li class="nav-item dropdown 
                        ${(pageContext.request.requestURI.endsWith("signupfromadmin.jsp") || 
                          pageContext.request.requestURI.endsWith("showallclients.jsp") || 
                          pageContext.request.requestURI.endsWith("editfromadmin.jsp")) ? 'active' : ''}">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <fmt:message key="clientes"/>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <a href="/Tienda/signupfromadmin" class="dropdown-item ${(pageContext.request.requestURI.endsWith("signupfromadmin.jsp")) ? 'active' : ''}">
                                <fmt:message key="nuevo cliente"/>
                            </a>
                            <a href="/Tienda/clients/showall" class="dropdown-item ${(pageContext.request.requestURI.endsWith("showallclients.jsp") || pageContext.request.requestURI.endsWith("editfromadmin.jsp")) ? 'active' : ''}">
                                <fmt:message key="ver clientes"/>
                            </a>
                        </div>
                    </li>
                    <%-- /CLIENTS --%>
                    <%-- ARTICLES --%>
                    <li class="nav-item dropdown 
                        ${(pageContext.request.requestURI.endsWith("create.jsp") || 
                          pageContext.request.requestURI.endsWith("edit.jsp") || 
                          pageContext.request.requestURI.endsWith("showall.jsp")) ? 'active' : ''}">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <fmt:message key="articulo"/>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                            <a href="/Tienda/articles/create" class="dropdown-item ${(pageContext.request.requestURI.endsWith("create.jsp")) ? 'active' : ''}">
                                <fmt:message key="nuevo articulo"/>
                            </a>
                            <a href="/Tienda/articles/showall" class="dropdown-item ${(pageContext.request.requestURI.endsWith("showall.jsp") ||
                                                                                     pageContext.request.requestURI.endsWith("edit.jsp")) ? 'active' : ''}">
                                <fmt:message key="ver articulos"/>
                            </a>
                        </div>
                    </li>
                    <%-- /ARTICLES --%>
                </c:if>
                <%-- /ADMIN CONTROLS --%>
                <li class="nav-item ${(pageContext.request.requestURI.endsWith("show.jsp")) ? 'active' : ''}">
                    <a href="/Tienda/logout" class="nav-link">
                        <fmt:message key="cerrar sesion"/>
                    </a>
                </li>
            </c:if>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <fmt:message key="idioma"/>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                    <a href="/Tienda/changelang?lang=en" class="dropdown-item ${(locale == 'en') ? 'active' : ''}">
                        <fmt:message key="ingles"/>
                    </a>
                    <a href="/Tienda/changelang?lang=es" class="dropdown-item ${(locale == 'es') ? 'active' : ''}">
                        <fmt:message key="español"/>
                    </a>
                </div>
            </li>
        </ul>
        <!-- /LINKS -->
    </div>
    <!-- /NAVBAR CONTENT -->
    <%--<%= request.getRequestURI() %>--%>

</nav>