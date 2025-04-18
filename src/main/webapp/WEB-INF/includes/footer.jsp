        </div>
    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>Food Express</h3>
                    <p>Your favorite food, delivered fast to your doorstep.</p>
                </div>

                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/restaurants">Restaurants</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h3>Contact Us</h3>
                    <p><span class="icon-location"></span> 123 Food Street, Cuisine City</p>
                    <p><span class="icon-phone"></span> (123) 456-7890</p>
                    <p><span class="icon-envelope"></span> info@foodexpress.com</p>
                </div>

                <div class="footer-section">
                    <h3>Follow Us</h3>
                    <div class="social-links">
                        <a href="#">FB</a>
                        <a href="#">TW</a>
                        <a href="#">IG</a>
                        <a href="#">LI</a>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; @ 2025 Food Express. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Mobile menu toggle
        document.getElementById('mobileMenuBtn').addEventListener('click', function() {
            document.getElementById('navMenu').classList.toggle('show');
        });
    </script>
</body>
</html>
