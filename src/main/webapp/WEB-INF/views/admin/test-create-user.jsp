<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - Test Create User" />
</jsp:include>

<div style="max-width: 800px; margin: 50px auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
    <h1 style="color: #FF5722; margin-bottom: 20px;">Test Create User</h1>
    
    <p>This is a test page to verify that the user creation functionality is working correctly.</p>
    
    <div style="margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/admin/users/create" class="btn btn-primary" style="background-color: #FF5722; border-color: #FF5722;">
            Go to Create User Form
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
