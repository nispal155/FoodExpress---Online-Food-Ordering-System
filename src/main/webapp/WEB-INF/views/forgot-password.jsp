<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Forgot Password" />
</jsp:include>

<section class="container">
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h2>Forgot Password</h2>
                <p>Reset your password</p>
            </div>
            <div class="auth-form">
            <c:if test="${not empty error}">
                <div class="message message-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="message message-info">
                    <i class="fas fa-info-circle"></i> ${message}
                </div>
            </c:if>

            <c:if test="${showCode}">
                <div class="message message-warning">
                    <h5><i class="fas fa-key"></i> Your Verification Code</h5>
                    <div class="verification-code">
                        ${verificationCode}
                    </div>
                    <p>Please copy this code and use it to reset your password.</p>
                    <p><i class="fas fa-info-circle"></i> <strong>Note:</strong> Email sending is currently disabled.
                       <a href="${pageContext.request.contextPath}/setup-email">Click here to enable email sending</a>.</p>
                </div>
            </c:if>

            <p>Enter your email address below and we'll send you a verification code to reset your password.</p>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <input type="hidden" name="action" value="request">

                <div class="form-group">
                    <label for="email" class="required">Email Address</label>
                    <input type="email" class="input-field" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="forgot-password-button">
                        <i class="fas fa-paper-plane"></i> Send Verification Code
                    </button>
                </div>
            </form>

            <div class="auth-footer">
                <p><a href="${pageContext.request.contextPath}/login">Back to Login</a></p>
            </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
