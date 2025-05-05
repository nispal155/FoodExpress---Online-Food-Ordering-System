<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Admin - Test User Creation" />
</jsp:include>

<div style="max-width: 800px; margin: 50px auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
    <h1 style="color: #FF5722; margin-bottom: 20px;">Test User Creation</h1>
    
    <c:if test="${not empty param.success}">
        <div style="background-color: #e8f5e9; color: #2e7d32; padding: 15px; border-radius: 4px; margin-bottom: 20px;">
            User created successfully!
        </div>
    </c:if>
    
    <c:if test="${not empty param.error}">
        <div style="background-color: #ffebee; color: #d32f2f; padding: 15px; border-radius: 4px; margin-bottom: 20px;">
            Error: ${param.error}
        </div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/admin/users/create" method="post" style="margin-top: 20px;">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div>
                <h3 style="border-bottom: 1px solid #eee; padding-bottom: 10px;">Account Information</h3>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Username *</label>
                    <input type="text" name="username" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Password *</label>
                    <input type="password" name="password" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Email *</label>
                    <input type="email" name="email" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Role *</label>
                    <select name="role" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                        <option value="">Select a role</option>
                        <option value="ADMIN">Admin</option>
                        <option value="CUSTOMER">Customer</option>
                        <option value="DELIVERY">Delivery Person</option>
                    </select>
                </div>
            </div>
            
            <div>
                <h3 style="border-bottom: 1px solid #eee; padding-bottom: 10px;">Personal Information</h3>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Full Name *</label>
                    <input type="text" name="fullName" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Phone</label>
                    <input type="text" name="phone" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Address</label>
                    <textarea name="address" rows="3" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;"></textarea>
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold;">Account Status</label>
                    <div style="display: flex; align-items: center;">
                        <label style="position: relative; display: inline-block; width: 50px; height: 24px; margin-right: 10px;">
                            <input type="checkbox" name="isActive" checked style="opacity: 0; width: 0; height: 0;">
                            <span style="position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 24px;">
                                <span style="position: absolute; content: ''; height: 16px; width: 16px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%;"></span>
                            </span>
                        </label>
                        <span>Active Account</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; text-align: right;">
            <a href="${pageContext.request.contextPath}/admin/users" style="display: inline-block; padding: 10px 20px; background-color: #f0f0f0; color: #333; border-radius: 4px; text-decoration: none; margin-right: 10px;">Cancel</a>
            <button type="submit" style="padding: 10px 20px; background-color: #FF5722; color: white; border: none; border-radius: 4px; cursor: pointer;">Create User</button>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
