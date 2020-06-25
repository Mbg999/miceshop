<%-- 
    Document   : footer
    Created on : 18-feb-2020, 17:00:48
    Author     : miguel
--%>

<%-- LANGUAGE --%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="${locale}" scope="session"/>
<fmt:setBundle basename="languages.tags"/>

<footer class="col-12 bg-dark text-light">
    <div class="row">
        <div class="col-12 col-lg-4 text-center text-lg-left">
            <p class="py-2 px-4 mb-0"><fmt:message key="autor"/>: Miguel Belmonte Granados</p>
        </div>
        <div class="col-12 col-lg-4 text-center">
            <p class="py-2 px-4 mb-0"><fmt:message key="asignatura"/>: DWES (JSP)</p>
        </div>
        <div class="col-12 col-lg-4 text-center text-lg-right">
            <p class="py-2 px-4 mb-0"><fmt:message key="profesor"/>: Pedro Jimenez Latorre</p>
        </div>
    </div>
</footer>