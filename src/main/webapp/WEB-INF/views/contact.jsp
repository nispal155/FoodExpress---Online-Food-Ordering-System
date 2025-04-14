<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Contact Us" />
</jsp:include>

<!-- Hero Section -->
<div class="hero-section" style="background-image: url('${pageContext.request.contextPath}/assets/images/contact-hero.jpg'); background-size: cover; background-position: center; padding: 5rem 0; text-align: center; color: white; position: relative;">
    <div style="background-color: rgba(0, 0, 0, 0.6); position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
    <div style="position: relative; z-index: 1;">
        <h1 style="font-size: 3rem; margin-bottom: 1rem;">Contact Us</h1>
        <p style="font-size: 1.2rem; margin-bottom: 0; max-width: 800px; margin-left: auto; margin-right: auto;">We'd love to hear from you! Reach out with any questions, feedback, or concerns.</p>
    </div>
</div>

<div class="container" style="padding: 4rem 0;">
    <!-- Success Message -->
    <c:if test="${param.success == 'true'}">
        <div class="alert alert-success" role="alert" style="margin-bottom: 2rem;">
            <i class="fas fa-check-circle"></i> Thank you for your message! We'll get back to you as soon as possible.
        </div>
    </c:if>
    
    <div class="row">
        <!-- Contact Form -->
        <div class="col-md-8" style="margin-bottom: 2rem;">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Send Us a Message</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/contact" method="post" id="contactForm" novalidate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name" class="form-label">Your Name *</label>
                                <input type="text" class="form-control ${not empty errors.name ? 'is-invalid' : ''}" id="name" name="name" value="${name}" required>
                                <c:if test="${not empty errors.name}">
                                    <div class="invalid-feedback">
                                        ${errors.name}
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Your Email *</label>
                                <input type="email" class="form-control ${not empty errors.email ? 'is-invalid' : ''}" id="email" name="email" value="${email}" required>
                                <c:if test="${not empty errors.email}">
                                    <div class="invalid-feedback">
                                        ${errors.email}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number (Optional)</label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${phone}">
                        </div>
                        
                        <div class="mb-3">
                            <label for="subject" class="form-label">Subject *</label>
                            <input type="text" class="form-control ${not empty errors.subject ? 'is-invalid' : ''}" id="subject" name="subject" value="${subject}" required>
                            <c:if test="${not empty errors.subject}">
                                <div class="invalid-feedback">
                                    ${errors.subject}
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="mb-3">
                            <label for="message" class="form-label">Message *</label>
                            <textarea class="form-control ${not empty errors.message ? 'is-invalid' : ''}" id="message" name="message" rows="5" required>${message}</textarea>
                            <c:if test="${not empty errors.message}">
                                <div class="invalid-feedback">
                                    ${errors.message}
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="privacy" name="privacy" required>
                            <label class="form-check-label" for="privacy">I agree to the <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">privacy policy</a> *</label>
                            <div class="invalid-feedback">
                                You must agree to the privacy policy.
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Contact Information -->
        <div class="col-md-4">
            <div class="card" style="margin-bottom: 2rem;">
                <div class="card-header">
                    <h2 class="card-title">Contact Information</h2>
                </div>
                <div class="card-body">
                    <div style="margin-bottom: 1.5rem;">
                        <h5 style="margin-bottom: 0.5rem;"><i class="fas fa-envelope" style="color: var(--primary-color); margin-right: 0.5rem;"></i> Email</h5>
                        <p style="margin-bottom: 0;"><a href="mailto:${contactEmail}" style="color: var(--dark-gray); text-decoration: none;">${contactEmail}</a></p>
                    </div>
                    
                    <div style="margin-bottom: 1.5rem;">
                        <h5 style="margin-bottom: 0.5rem;"><i class="fas fa-phone" style="color: var(--primary-color); margin-right: 0.5rem;"></i> Phone</h5>
                        <p style="margin-bottom: 0;"><a href="tel:${contactPhone}" style="color: var(--dark-gray); text-decoration: none;">${contactPhone}</a></p>
                    </div>
                    
                    <div>
                        <h5 style="margin-bottom: 0.5rem;"><i class="fas fa-map-marker-alt" style="color: var(--primary-color); margin-right: 0.5rem;"></i> Address</h5>
                        <p style="margin-bottom: 0;">${contactAddress}</p>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Business Hours</h2>
                </div>
                <div class="card-body">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>Monday - Friday:</span>
                        <span>9:00 AM - 10:00 PM</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>Saturday:</span>
                        <span>10:00 AM - 10:00 PM</span>
                    </div>
                    <div style="display: flex; justify-content: space-between;">
                        <span>Sunday:</span>
                        <span>11:00 AM - 9:00 PM</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Map Section -->
    <div style="margin-top: 4rem;">
        <h2 style="margin-bottom: 2rem; text-align: center; color: var(--primary-color);">Find Us</h2>
        <div style="width: 100%; height: 400px; background-color: #f5f5f5; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 16px rgba(0,0,0,0.1);">
            <!-- Replace with actual map embed code -->
            <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                <p style="color: var(--medium-gray);">Map will be displayed here</p>
            </div>
        </div>
    </div>
    
    <!-- FAQ Section -->
    <div style="margin-top: 4rem;">
        <h2 style="margin-bottom: 2rem; text-align: center; color: var(--primary-color);">Frequently Asked Questions</h2>
        
        <div class="accordion" id="faqAccordion">
            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading1">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapse1" aria-expanded="true" aria-controls="faqCollapse1">
                        How do I place an order?
                    </button>
                </h2>
                <div id="faqCollapse1" class="accordion-collapse collapse show" aria-labelledby="faqHeading1" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        To place an order, simply browse our restaurants, select the items you want, add them to your cart, and proceed to checkout. You'll need to create an account or log in if you haven't already, and then provide your delivery address and payment information.
                    </div>
                </div>
            </div>
            
            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading2">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapse2" aria-expanded="false" aria-controls="faqCollapse2">
                        How can I track my order?
                    </button>
                </h2>
                <div id="faqCollapse2" class="accordion-collapse collapse" aria-labelledby="faqHeading2" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Once your order is confirmed, you can track its status in real-time through the "My Orders" section of your account. You'll be able to see when your order is confirmed, being prepared, ready for pickup, and out for delivery.
                    </div>
                </div>
            </div>
            
            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading3">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapse3" aria-expanded="false" aria-controls="faqCollapse3">
                        What payment methods do you accept?
                    </button>
                </h2>
                <div id="faqCollapse3" class="accordion-collapse collapse" aria-labelledby="faqHeading3" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        We accept various payment methods including credit/debit cards and cash on delivery. You can select your preferred payment method during checkout.
                    </div>
                </div>
            </div>
            
            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading4">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapse4" aria-expanded="false" aria-controls="faqCollapse4">
                        How can I become a restaurant partner?
                    </button>
                </h2>
                <div id="faqCollapse4" class="accordion-collapse collapse" aria-labelledby="faqHeading4" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        If you're interested in becoming a restaurant partner, please contact us through the form on this page or email us directly at ${contactEmail}. Our team will get in touch with you to discuss the partnership process and requirements.
                    </div>
                </div>
            </div>
            
            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading5">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapse5" aria-expanded="false" aria-controls="faqCollapse5">
                        What if there's an issue with my order?
                    </button>
                </h2>
                <div id="faqCollapse5" class="accordion-collapse collapse" aria-labelledby="faqHeading5" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        If you experience any issues with your order, please contact our customer support team immediately. You can reach us through the contact form on this page, by email, or by phone. We're committed to resolving any problems as quickly as possible.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Privacy Policy Modal -->
<div class="modal fade" id="privacyModal" tabindex="-1" aria-labelledby="privacyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="privacyModalLabel">Privacy Policy</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h4>1. Information We Collect</h4>
                <p>We collect information you provide directly to us, such as your name, email address, phone number, and any other information you choose to provide when you contact us through our contact form.</p>
                
                <h4>2. How We Use Your Information</h4>
                <p>We use the information we collect to:</p>
                <ul>
                    <li>Respond to your inquiries and provide customer support</li>
                    <li>Send you updates, promotions, and marketing communications (if you opt in)</li>
                    <li>Improve our services and develop new features</li>
                    <li>Comply with legal obligations</li>
                </ul>
                
                <h4>3. Information Sharing</h4>
                <p>We do not sell, trade, or otherwise transfer your personal information to outside parties except as described in this policy. We may share your information with trusted third parties who assist us in operating our website, conducting our business, or servicing you.</p>
                
                <h4>4. Data Security</h4>
                <p>We implement appropriate security measures to protect your personal information. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security.</p>
                
                <h4>5. Your Rights</h4>
                <p>You have the right to access, correct, or delete your personal information. If you would like to exercise these rights, please contact us using the information provided on this page.</p>
                
                <h4>6. Changes to This Policy</h4>
                <p>We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.</p>
                
                <h4>7. Contact Us</h4>
                <p>If you have any questions about this privacy policy, please contact us using the information provided on this page.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">I Understand</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Form validation
    (function() {
        'use strict';
        
        // Fetch all forms we want to apply custom validation to
        var forms = document.querySelectorAll('#contactForm');
        
        // Loop over them and prevent submission
        Array.prototype.slice.call(forms).forEach(function(form) {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
