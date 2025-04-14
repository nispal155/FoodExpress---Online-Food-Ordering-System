<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Login" />
</jsp:include>

<div class="row" style="margin-top: 2rem;">
    <div class="col-md-6 col-sm-12" style="margin: 0 auto; max-width: 500px;">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Login to Your Account</h2>
                <p>Enter your credentials to access your account</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="username" class="required">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="password" class="required">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>

                <div class="form-group" style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <input type="checkbox" id="remember" name="remember">
                        <label for="remember" style="display: inline;">Remember me</label>
                    </div>
                    <a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a>
                </div>

                <button type="submit" class="btn btn-primary btn-block">Login</button>
            </form>

            <div style="text-align: center; margin-top: 1.5rem;">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register</a></p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
