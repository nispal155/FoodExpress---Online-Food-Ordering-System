<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Forgot Password" />
</jsp:include>

<div class="container" style="max-width: 500px; margin: 2rem auto; padding: 2rem;">
    <div class="card">
        <div class="card-header">
            <h1 class="card-title">Forgot Password</h1>
        </div>
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <span class="icon-warning"></span> ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-info" role="alert">
                    <span class="icon-info"></span> ${message}
                </div>
            </c:if>

            <c:if test="${showCode}">
                <div class="alert alert-warning" role="alert">
                    <h5><span class="icon-key"></span> Your Verification Code</h5>
                    <div style="font-size: 24px; font-weight: bold; text-align: center;
                                padding: 10px; margin: 10px 0; background-color: #f8f9fa;
                                border-radius: 5px; letter-spacing: 5px;">
                        ${verificationCode}
                    </div>
                    <p>Please copy this code and use it to reset your password.</p>
                    <p class="mb-0"><span class="icon-info"></span> <strong>Note:</strong> Email sending is currently disabled.
                       <a href="${pageContext.request.contextPath}/setup-email" class="alert-link">Click here to enable email sending</a>.</p>
                </div>
            </c:if>

            <p>Enter your email address below and we'll send you a verification code to reset your password.</p>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <input type="hidden" name="action" value="request">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        <span class="icon-envelope"></span> Send Verification Code
                    </button>
                </div>
            </form>

            <div class="text-center" style="margin-top: 1rem;">
                <a href="${pageContext.request.contextPath}/login">Back to Login</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
