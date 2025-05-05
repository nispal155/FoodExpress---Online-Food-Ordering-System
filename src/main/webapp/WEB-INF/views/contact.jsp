<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Food Express - Contact Us" />
</jsp:include>

<!-- Hero Section -->
<section class="page-hero">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <h1>Contact Us</h1>
        <p>We'd love to hear from you! Reach out with any questions, feedback, or concerns.</p>
    </div>
</section>

<section class="container">
    <!-- Success Message -->
    <c:if test="${param.success == 'true'}">
        <div class="message message-success">
            <i class="fas fa-check-circle"></i> Thank you for your message! We'll get back to you as soon as possible.
        </div>
    </c:if>

    <div class="contact-grid">
        <!-- Contact Form -->
        <div class="contact-form-container">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Send Us a Message</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/contact" method="post" id="contactForm" novalidate class="contact-form">
                        <div class="form-row">
                            <div class="form-column">
                                <div class="form-group">
                                    <label for="name" class="required">Your Name</label>
                                    <input type="text" class="input-field ${not empty errors.name ? 'input-error' : ''}" id="name" name="name" value="${name}" required>
                                    <c:if test="${not empty errors.name}">
                                        <div class="error-message">
                                            ${errors.name}
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <div class="form-column">
                                <div class="form-group">
                                    <label for="email" class="required">Your Email</label>
                                    <input type="email" class="input-field ${not empty errors.email ? 'input-error' : ''}" id="email" name="email" value="${email}" required>
                                    <c:if test="${not empty errors.email}">
                                        <div class="error-message">
                                            ${errors.email}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number (Optional)</label>
                            <input type="tel" class="input-field" id="phone" name="phone" value="${phone}">
                        </div>

                        <div class="form-group">
                            <label for="subject" class="required">Subject</label>
                            <input type="text" class="input-field ${not empty errors.subject ? 'input-error' : ''}" id="subject" name="subject" value="${subject}" required>
                            <c:if test="${not empty errors.subject}">
                                <div class="error-message">
                                    ${errors.subject}
                                </div>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label for="message" class="required">Message</label>
                            <textarea class="input-field ${not empty errors.message ? 'input-error' : ''}" id="message" name="message" rows="5" required>${message}</textarea>
                            <c:if test="${not empty errors.message}">
                                <div class="error-message">
                                    ${errors.message}
                                </div>
                            </c:if>
                        </div>

                        <div class="form-group checkbox-container">
                            <input type="checkbox" class="checkbox" id="privacy" name="privacy" required>
                            <label class="checkbox-label required" for="privacy">I agree to the <a href="javascript:void(0)" class="privacy-link" id="privacyLink">privacy policy</a></label>
                            <div class="error-message">
                                You must agree to the privacy policy.
                            </div>
                        </div>

                        <button type="submit" class="button contact-button">Send Message</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Contact Information -->
        <div class="contact-info-container">
            <div class="card contact-info-card">
                <div class="card-header">
                    <h2 class="card-title">Contact Information</h2>
                </div>
                <div class="card-body">
                    <div class="contact-info-item">
                        <h5><i class="fas fa-envelope"></i> Email</h5>
                        <p><a href="mailto:${contactEmail}">${contactEmail}</a></p>
                    </div>

                    <div class="contact-info-item">
                        <h5><i class="fas fa-phone"></i> Phone</h5>
                        <p><a href="tel:${contactPhone}">${contactPhone}</a></p>
                    </div>

                    <div class="contact-info-item">
                        <h5><i class="fas fa-map-marker-alt"></i> Address</h5>
                        <p>${contactAddress}</p>
                    </div>
                </div>
            </div>

            <div class="card business-hours-card">
                <div class="card-header">
                    <h2 class="card-title">Business Hours</h2>
                </div>
                <div class="card-body">
                    <div class="business-hours-item">
                        <span>Monday - Friday:</span>
                        <span>9:00 AM - 10:00 PM</span>
                    </div>
                    <div class="business-hours-item">
                        <span>Saturday:</span>
                        <span>10:00 AM - 10:00 PM</span>
                    </div>
                    <div class="business-hours-item">
                        <span>Sunday:</span>
                        <span>11:00 AM - 9:00 PM</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Map Section -->
    <div class="map-section">
        <h2 class="section-title">Find Us</h2>
        <div class="map-container">
            <!-- Replace with actual map embed code -->
            <div class="map-placeholder">
                <p>Map will be displayed here</p>
            </div>
        </div>
    </div>

    <!-- FAQ Section -->
    <div class="faq-section">
        <h2 class="section-title">Frequently Asked Questions</h2>

        <div class="faq-accordion" id="faqAccordion">
            <div class="faq-item">
                <div class="faq-question" id="faqQuestion1">
                    <h3>How do I place an order?</h3>
                    <span class="faq-icon">+</span>
                </div>
                <div class="faq-answer" id="faqAnswer1">
                    <p>To place an order, simply browse our restaurants, select the items you want, add them to your cart, and proceed to checkout. You'll need to create an account or log in if you haven't already, and then provide your delivery address and payment information.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" id="faqQuestion2">
                    <h3>How can I track my order?</h3>
                    <span class="faq-icon">+</span>
                </div>
                <div class="faq-answer" id="faqAnswer2">
                    <p>Once your order is confirmed, you can track its status in real-time through the "My Orders" section of your account. You'll be able to see when your order is confirmed, being prepared, ready for pickup, and out for delivery.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" id="faqQuestion3">
                    <h3>What payment methods do you accept?</h3>
                    <span class="faq-icon">+</span>
                </div>
                <div class="faq-answer" id="faqAnswer3">
                    <p>We accept various payment methods including credit/debit cards and cash on delivery. You can select your preferred payment method during checkout.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" id="faqQuestion4">
                    <h3>How can I become a restaurant partner?</h3>
                    <span class="faq-icon">+</span>
                </div>
                <div class="faq-answer" id="faqAnswer4">
                    <p>If you're interested in becoming a restaurant partner, please contact us through the form on this page or email us directly at ${contactEmail}. Our team will get in touch with you to discuss the partnership process and requirements.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" id="faqQuestion5">
                    <h3>What if there's an issue with my order?</h3>
                    <span class="faq-icon">+</span>
                </div>
                <div class="faq-answer" id="faqAnswer5">
                    <p>If you experience any issues with your order, please contact our customer support team immediately. You can reach us through the contact form on this page, by email, or by phone. We're committed to resolving any problems as quickly as possible.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Privacy Policy Modal -->
<div class="privacy-modal" id="privacyModal" style="display: none;">
    <div class="modal-container">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="privacyModalLabel">Privacy Policy</h5>
                <button type="button" class="modal-close" aria-label="Close">&times;</button>
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
                <button type="button" class="button modal-button">I Understand</button>
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

        // Modal functionality
        var modal = document.getElementById('privacyModal');
        var link = document.getElementById('privacyLink');
        var closeBtn = document.querySelector('.modal-close');
        var modalBtn = document.querySelector('.modal-button');

        link.addEventListener('click', function() {
            modal.style.display = 'block';
        });

        closeBtn.addEventListener('click', function() {
            modal.style.display = 'none';
        });

        modalBtn.addEventListener('click', function() {
            modal.style.display = 'none';
        });

        window.addEventListener('click', function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        });

        // FAQ Accordion functionality
        var faqQuestions = document.querySelectorAll('.faq-question');

        faqQuestions.forEach(function(question) {
            question.addEventListener('click', function() {
                var answerId = this.id.replace('Question', 'Answer');
                var answer = document.getElementById(answerId);
                var icon = this.querySelector('.faq-icon');

                // Toggle the answer visibility
                if (answer.style.display === 'block') {
                    answer.style.display = 'none';
                    icon.textContent = '+';
                } else {
                    answer.style.display = 'block';
                    icon.textContent = '-';
                }
            });
        });

        // Show the first FAQ answer by default
        document.getElementById('faqAnswer1').style.display = 'block';
        document.querySelector('#faqQuestion1 .faq-icon').textContent = '-';
    })();
</script>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
