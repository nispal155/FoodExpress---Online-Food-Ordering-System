<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Profile" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1>My Profile</h1>

    <!-- Success and Error Messages -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle"></i> Your profile has been updated successfully!
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <div class="row">
        <!-- Profile Information -->
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Profile Information</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                        <!-- Hidden username field to ensure it's submitted with the form -->
                        <input type="hidden" name="username" value="${user.username}">

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" value="${user.username}" readonly>
                                    <small class="text-muted">Username cannot be changed</small>
                                </div>

                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Full Name *</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">Email *</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone</label>
                                    <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}">
                                </div>

                                <div class="mb-3">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea class="form-control" id="address" name="address" rows="3">${user.address}</textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="role" class="form-label">Role</label>
                                    <input type="text" class="form-control" id="role" value="${user.role}" readonly>
                                </div>
                            </div>
                        </div>



                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Profile Picture -->
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Profile Picture</h2>
                </div>
                <div class="card-body text-center">
                    <div style="margin-bottom: 1rem;">
                        <c:choose>
                            <c:when test="${not empty user.profilePicture}">
                                <img src="${pageContext.request.contextPath}/${user.profilePicture}" alt="Profile Picture"
                                     style="width: 150px; height: 150px; object-fit: cover; border-radius: 50%;">
                            </c:when>
                            <c:otherwise>
                                <div style="width: 150px; height: 150px; background-color: #e9ecef; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                    <i class="fas fa-user" style="font-size: 4rem; color: #adb5bd;"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <form action="${pageContext.request.contextPath}/profile-picture-upload" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="profilePicture" class="form-label">Upload New Picture</label>
                            <input type="file" class="form-control" id="profilePicture" name="profilePicture" accept="image/*">
                            <small class="text-muted">Max file size: 10MB. Supported formats: JPG, JPEG, PNG, GIF</small>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-upload"></i> Upload
                        </button>
                    </form>
                </div>
            </div>

            <!-- Account Information -->
            <div class="card mt-4">
                <div class="card-header">
                    <h2 class="card-title">Account Information</h2>
                </div>
                <div class="card-body">
                    <p><strong>Member Since:</strong> <span id="memberSince">${user.createdAt}</span></p>
                    <p><strong>Last Login:</strong> <span id="lastLogin">${user.lastLogin}</span></p>

                    <script>
                        // Format dates
                        document.addEventListener('DOMContentLoaded', function() {
                            const memberSinceElement = document.getElementById('memberSince');
                            const lastLoginElement = document.getElementById('lastLogin');

                            if (memberSinceElement.textContent) {
                                const memberSinceDate = new Date(memberSinceElement.textContent);
                                memberSinceElement.textContent = memberSinceDate.toLocaleDateString();
                            }

                            if (lastLoginElement.textContent) {
                                const lastLoginDate = new Date(lastLoginElement.textContent);
                                lastLoginElement.textContent = lastLoginDate.toLocaleString();
                            }
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
