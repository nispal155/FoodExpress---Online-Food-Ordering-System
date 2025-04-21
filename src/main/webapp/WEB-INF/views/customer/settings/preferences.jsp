<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Preferences Settings" />
</jsp:include>

<div class="container" style="padding: 2rem 0;">
    <h1>Account Settings</h1>
    
    <!-- Success and Error Messages -->
    <c:if test="${param.success != null}">
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle"></i> ${param.success}
        </div>
    </c:if>
    
    <c:if test="${param.error != null}">
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${param.error}
        </div>
    </c:if>
    
    <div class="row">
        <!-- Settings Navigation -->
        <div class="col-md-3 col-sm-12">
            <div class="card" style="margin-bottom: 1.5rem;">
                <div class="card-header">
                    <h2 class="card-title">Settings</h2>
                </div>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/settings/account" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-user"></i> Account
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/notifications" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-bell"></i> Notifications
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/payment" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-credit-card"></i> Payment Methods
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/privacy" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-shield-alt"></i> Privacy
                    </a>
                    <a href="${pageContext.request.contextPath}/settings/preferences" 
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-sliders-h"></i> Preferences
                    </a>
                </div>
            </div>
            
            <div class="card">
                <div class="card-body">
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary btn-block">
                        <i class="fas fa-user-edit"></i> Edit Profile
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Settings Content -->
        <div class="col-md-9 col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Preferences</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/settings/preferences" method="post">
                        <div class="mb-4">
                            <h3>Dietary Preferences</h3>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="vegetarian" name="preference_vegetarian" value="true">
                                        <label class="form-check-label" for="vegetarian">
                                            Vegetarian
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="vegan" name="preference_vegan" value="true">
                                        <label class="form-check-label" for="vegan">
                                            Vegan
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="gluten_free" name="preference_gluten_free" value="true">
                                        <label class="form-check-label" for="gluten_free">
                                            Gluten-Free
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="dairy_free" name="preference_dairy_free" value="true">
                                        <label class="form-check-label" for="dairy_free">
                                            Dairy-Free
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="nut_free" name="preference_nut_free" value="true">
                                        <label class="form-check-label" for="nut_free">
                                            Nut-Free
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="low_carb" name="preference_low_carb" value="true">
                                        <label class="form-check-label" for="low_carb">
                                            Low-Carb
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Cuisine Preferences</h3>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="italian" name="preference_italian" value="true" checked>
                                        <label class="form-check-label" for="italian">
                                            Italian
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="chinese" name="preference_chinese" value="true" checked>
                                        <label class="form-check-label" for="chinese">
                                            Chinese
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="mexican" name="preference_mexican" value="true" checked>
                                        <label class="form-check-label" for="mexican">
                                            Mexican
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="indian" name="preference_indian" value="true">
                                        <label class="form-check-label" for="indian">
                                            Indian
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="japanese" name="preference_japanese" value="true">
                                        <label class="form-check-label" for="japanese">
                                            Japanese
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="thai" name="preference_thai" value="true">
                                        <label class="form-check-label" for="thai">
                                            Thai
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="mediterranean" name="preference_mediterranean" value="true">
                                        <label class="form-check-label" for="mediterranean">
                                            Mediterranean
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="american" name="preference_american" value="true" checked>
                                        <label class="form-check-label" for="american">
                                            American
                                        </label>
                                    </div>
                                    
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="middle_eastern" name="preference_middle_eastern" value="true">
                                        <label class="form-check-label" for="middle_eastern">
                                            Middle Eastern
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Spice Level Preference</h3>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="preference_spice_level" id="spice_mild" value="mild" checked>
                                <label class="form-check-label" for="spice_mild">
                                    Mild
                                </label>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="preference_spice_level" id="spice_medium" value="medium">
                                <label class="form-check-label" for="spice_medium">
                                    Medium
                                </label>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="preference_spice_level" id="spice_hot" value="hot">
                                <label class="form-check-label" for="spice_hot">
                                    Hot
                                </label>
                            </div>
                            
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="preference_spice_level" id="spice_extra_hot" value="extra_hot">
                                <label class="form-check-label" for="spice_extra_hot">
                                    Extra Hot
                                </label>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h3>Default Order Preferences</h3>
                            <div class="mb-3">
                                <label for="default_delivery_address" class="form-label">Default Delivery Address</label>
                                <input type="text" class="form-control" id="default_delivery_address" name="preference_default_delivery_address" value="${user.address}">
                            </div>
                            
                            <div class="mb-3">
                                <label for="default_delivery_instructions" class="form-label">Default Delivery Instructions</label>
                                <textarea class="form-control" id="default_delivery_instructions" name="preference_default_delivery_instructions" rows="2" placeholder="E.g., Ring doorbell, leave at door, etc."></textarea>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Preferences
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
