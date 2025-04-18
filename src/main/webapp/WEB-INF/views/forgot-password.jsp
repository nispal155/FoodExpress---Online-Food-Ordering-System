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
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert alert-info" role="alert">
                    <i class="fas fa-info-circle"></i> ${message}
                </div>
            </c:if>

            <c:if test="${showCode}">
                <div class="alert alert-warning" role="alert">
                    <h5><i class="fas fa-key"></i> Your Verification Code</h5>
                    <div style="font-size: 24px; font-weight: bold; text-align: center;
                                padding: 10px; margin: 10px 0; background-color: #f8f9fa;
                                border-radius: 5px; letter-spacing: 5px;">
                        ${verificationCode}
                    </div>
                    <p class="mb-0">Please copy this code and use it to reset your password.</p>
                </div>
            </c:if>

            <p>Enter your email address below and we'll send you a verification code to reset your password.</p>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <input type="hidden" name="action" value="request">

                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane"></i> Send Verification Code
                    </button>
                </div>
            </form>

            <div class="mt-3 text-center">
                <a href="${pageContext.request.contextPath}/login">Back to Login</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
