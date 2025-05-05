<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Reset Password" />
</jsp:include>

<section class="container">
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h2>Reset Password</h2>
                <p>Create a new password for your account</p>
            </div>
            <div class="auth-form">
            <c:if test="${not empty error}">
                <div class="message message-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <p>Please enter your new password below.</p>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post" id="resetPasswordForm">
                <input type="hidden" name="action" value="reset">

                <div class="form-group">
                    <label for="newPassword" class="required">New Password</label>
                    <input type="password" class="input-field" id="newPassword" name="newPassword" required minlength="6">
                    <div class="form-hint">Password must be at least 6 characters long.</div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="required">Confirm Password</label>
                    <input type="password" class="input-field" id="confirmPassword" name="confirmPassword" required minlength="6">
                </div>

                <div class="form-group">
                    <button type="submit" class="reset-password-button">
                        <i class="fas fa-key"></i> Reset Password
                    </button>
                </div>
            </form>
            </div>
        </div>
    </div>
</section>

<script>
    // Client-side validation for password matching
    document.getElementById('resetPasswordForm').addEventListener('submit', function(event) {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            event.preventDefault();
            alert('Passwords do not match. Please try again.');
        }
    });
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
