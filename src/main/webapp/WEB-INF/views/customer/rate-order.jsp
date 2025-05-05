<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Rate Your Order" />
</jsp:include>

<div class="container">
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h2>Rate Your Order #${order.id}</h2>
                <p>Please rate your experience with this order</p>
            </div>

            <form action="${pageContext.request.contextPath}/rate-order" method="post" class="auth-form">
                <input type="hidden" name="orderId" value="${order.id}">

                <!-- Restaurant Rating Section -->
                <div class="form-group">
                    <h3>Restaurant Rating</h3>
                    <p>How would you rate your overall experience with ${order.restaurantName}?</p>

                    <div class="rating-stars">
                        <div class="star-rating">
                            <input type="radio" id="restaurant-5-stars" name="restaurantRating" value="5" />
                            <label for="restaurant-5-stars" class="star"><i class="fas fa-star"></i></label>
                            <input type="radio" id="restaurant-4-stars" name="restaurantRating" value="4" />
                            <label for="restaurant-4-stars" class="star"><i class="fas fa-star"></i></label>
                            <input type="radio" id="restaurant-3-stars" name="restaurantRating" value="3" />
                            <label for="restaurant-3-stars" class="star"><i class="fas fa-star"></i></label>
                            <input type="radio" id="restaurant-2-stars" name="restaurantRating" value="2" />
                            <label for="restaurant-2-stars" class="star"><i class="fas fa-star"></i></label>
                            <input type="radio" id="restaurant-1-star" name="restaurantRating" value="1" />
                            <label for="restaurant-1-star" class="star"><i class="fas fa-star"></i></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="restaurantComment">Comments (Optional)</label>
                        <textarea id="restaurantComment" name="restaurantComment" class="input-field" rows="3" placeholder="Share your experience with the restaurant..."></textarea>
                    </div>
                </div>

                <!-- Delivery Person Rating Section (if applicable) -->
                <c:if test="${order.deliveryUserId > 0}">
                    <div class="form-group">
                        <h3>Delivery Rating</h3>
                        <p>How would you rate your delivery experience?</p>

                        <div class="rating-stars">
                            <div class="star-rating">
                                <input type="radio" id="delivery-5-stars" name="deliveryRating" value="5" />
                                <label for="delivery-5-stars" class="star"><i class="fas fa-star"></i></label>
                                <input type="radio" id="delivery-4-stars" name="deliveryRating" value="4" />
                                <label for="delivery-4-stars" class="star"><i class="fas fa-star"></i></label>
                                <input type="radio" id="delivery-3-stars" name="deliveryRating" value="3" />
                                <label for="delivery-3-stars" class="star"><i class="fas fa-star"></i></label>
                                <input type="radio" id="delivery-2-stars" name="deliveryRating" value="2" />
                                <label for="delivery-2-stars" class="star"><i class="fas fa-star"></i></label>
                                <input type="radio" id="delivery-1-star" name="deliveryRating" value="1" />
                                <label for="delivery-1-star" class="star"><i class="fas fa-star"></i></label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="deliveryComment">Comments (Optional)</label>
                            <textarea id="deliveryComment" name="deliveryComment" class="input-field" rows="3" placeholder="Share your experience with the delivery..."></textarea>
                        </div>
                    </div>
                </c:if>

                <!-- Food Items Rating Section -->
                <div class="form-group">
                    <h3>Food Ratings</h3>
                    <p>How would you rate each item in your order?</p>

                    <c:forEach var="menuItem" items="${menuItems}">
                        <div class="food-rating-item">
                            <div class="food-rating-header">
                                <h4>${menuItem.name}</h4>
                                <div class="rating-stars">
                                    <div class="star-rating">
                                        <input type="radio" id="food-${menuItem.id}-5-stars" name="foodRating_${menuItem.id}" value="5" />
                                        <label for="food-${menuItem.id}-5-stars" class="star"><i class="fas fa-star"></i></label>
                                        <input type="radio" id="food-${menuItem.id}-4-stars" name="foodRating_${menuItem.id}" value="4" />
                                        <label for="food-${menuItem.id}-4-stars" class="star"><i class="fas fa-star"></i></label>
                                        <input type="radio" id="food-${menuItem.id}-3-stars" name="foodRating_${menuItem.id}" value="3" />
                                        <label for="food-${menuItem.id}-3-stars" class="star"><i class="fas fa-star"></i></label>
                                        <input type="radio" id="food-${menuItem.id}-2-stars" name="foodRating_${menuItem.id}" value="2" />
                                        <label for="food-${menuItem.id}-2-stars" class="star"><i class="fas fa-star"></i></label>
                                        <input type="radio" id="food-${menuItem.id}-1-star" name="foodRating_${menuItem.id}" value="1" />
                                        <label for="food-${menuItem.id}-1-star" class="star"><i class="fas fa-star"></i></label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="foodComment_${menuItem.id}">Comments (Optional)</label>
                                <textarea id="foodComment_${menuItem.id}" name="foodComment_${menuItem.id}" class="input-field" rows="2" placeholder="Share your thoughts on this item..."></textarea>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <button type="submit" class="button button-primary button-full">Submit Ratings</button>
            </form>
        </div>
    </div>
</div>

<!-- Add CSS for star rating -->
<style>
    .food-rating-item {
        margin-bottom: 20px;
        padding: 15px;
        border: 1px solid #eee;
        border-radius: 5px;
        background-color: #f9f9f9;
    }

    .food-rating-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
    }

    .food-rating-header h4 {
        margin: 0;
    }

    .rating-stars {
        margin: 10px 0;
    }

    .star-rating {
        display: flex;
        flex-direction: row-reverse;
        justify-content: flex-end;
    }

    .star-rating input {
        display: none;
    }

    .star-rating label {
        cursor: pointer;
        width: 30px;
        font-size: 24px;
        color: #ddd;
        transition: color 0.2s;
    }

    .star-rating label:hover,
    .star-rating label:hover ~ label,
    .star-rating input:checked ~ label {
        color: #FFD700;
    }
</style>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
