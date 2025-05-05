<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="${param.pageTitle}" />
    <jsp:param name="activeLink" value="admin" />
</jsp:include>

<!-- Admin CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
<c:if test="${not empty param.customCss}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${param.customCss}">
</c:if>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<div class="admin-container">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp">
        <jsp:param name="activeMenu" value="${param.activeMenu}" />
    </jsp:include>

    <div class="admin-content">
        <!-- Content will be inserted here -->
        <jsp:doBody />
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
