<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Email Configuration" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <div class="row">
        <div class="col-md-3">
            <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp" />
        </div>
        
        <div class="col-md-9">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title">Email Configuration</h1>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty message}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle"></i> ${message}
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/admin/email-config" method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="username" class="form-label">Email Username</label>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           value="${param.username}" required>
                                    <div class="form-text">Your email address (e.g., example@gmail.com)</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="password" class="form-label">Email Password</label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           value="${param.password}" required>
                                    <div class="form-text">For Gmail, use an App Password (not your regular password)</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="host" class="form-label">SMTP Host</label>
                                    <input type="text" class="form-control" id="host" name="host" 
                                           value="${param.host != null ? param.host : 'smtp.gmail.com'}" required>
                                    <div class="form-text">SMTP server address (e.g., smtp.gmail.com)</div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="port" class="form-label">SMTP Port</label>
                                    <input type="number" class="form-control" id="port" name="port" 
                                           value="${param.port != null ? param.port : '587'}" required>
                                    <div class="form-text">SMTP server port (e.g., 587 for TLS, 465 for SSL)</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="from" class="form-label">From Address</label>
                                    <input type="text" class="form-control" id="from" name="from" 
                                           value="${param.from != null ? param.from : 'Food Express <your-email@gmail.com>'}" required>
                                    <div class="form-text">The name and email that will appear in the From field</div>
                                </div>
                                
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="enabled" name="enabled" 
                                           ${param.enabled == 'on' ? 'checked' : ''}>
                                    <label class="form-check-label" for="enabled">Enable Email Sending</label>
                                    <div class="form-text">If disabled, verification codes will be displayed on screen instead of sent by email</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-info" role="alert">
                            <h5><i class="fas fa-info-circle"></i> Gmail Configuration Instructions</h5>
                            <ol>
                                <li>Enable 2-Step Verification on your Google Account</li>
                                <li>Go to your Google Account → Security → App passwords</li>
                                <li>Select "Mail" and "Other (Custom name)"</li>
                                <li>Enter "Food Express" and click "Generate"</li>
                                <li>Use the generated 16-character password in the "Email Password" field above</li>
                            </ol>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Configuration
                            </button>
                            
                            <button type="submit" name="action" value="test" class="btn btn-secondary">
                                <i class="fas fa-vial"></i> Test Connection
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
