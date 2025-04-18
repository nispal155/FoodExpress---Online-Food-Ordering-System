<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Verify Code" />
</jsp:include>

<div class="container" style="max-width: 500px; margin: 2rem auto; padding: 2rem;">
    <div class="card">
        <div class="card-header">
            <h1 class="card-title">Verify Code</h1>
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
                    <p>Please copy this code and use it in the form below.</p>
                    <p class="mb-0"><span class="icon-info"></span> <strong>Note:</strong> Email sending is currently disabled.
                       <a href="${pageContext.request.contextPath}/setup-email" class="alert-link">Click here to enable email sending</a>.</p>
                </div>
            </c:if>

            <p>Please enter the verification code <c:if test="${!showCode}">sent to your email address</c:if><c:if test="${showCode}">shown above</c:if>.</p>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <input type="hidden" name="action" value="verify">

                <div class="form-group">
                    <label for="code">Verification Code</label>
                    <input type="text" class="form-control" id="code" name="code"
                           placeholder="Enter 6-digit code" required
                           pattern="[0-9]{6}" maxlength="6"
                           style="letter-spacing: 0.5em; font-size: 1.5rem; text-align: center;">
                    <div class="form-text">The code will expire in 15 minutes.</div>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        <span class="icon-check"></span> Verify Code
                    </button>
                </div>
            </form>

            <div class="text-center" style="margin-top: 1rem;">
                <a href="${pageContext.request.contextPath}/forgot-password">Back to Forgot Password</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
