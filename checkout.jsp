<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CartDao" %>
<%@ page import="bean.CartBean" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.OrderDao" %>
<%@ page import="bean.Order" %>

<%
    HttpSession httpsession = request.getSession(false);
    String userEmail = null;

    if (httpsession != null) {
        userEmail = (String) httpsession.getAttribute("email");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    } else {
        response.sendRedirect("login.jsp");
        return;
    }

    CartDao cartDao = new CartDao();
    List<CartBean> cartItems = cartDao.getCartItemsByUserEmail(userEmail);
    double totalAmount = 0.0;

    if (!cartItems.isEmpty()) {
        for (CartBean item : cartItems) {
            totalAmount += item.getAmount() * item.getQuantity();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Checkout</h1>
        <p>Total Amount: ₹<%= totalAmount %></p>
        <button id="rzp-button1" class="btn btn-success">Pay Now</button>
    </div>

    <script>
        var options = {
            "key": "rzp_test_3FiYqdcHdWq0a2", // Enter the Key ID generated from the Razorpay Dashboard
            "amount": <%= totalAmount * 100 %>, // Amount is in currency subunits. Hence, multiplying by 100
            "currency": "INR",
            "name": "SleekSilhouettes",
            "description": "Order Payment",
            "handler": function (response) {
                // Save order details
                $.ajax({
                    type: "POST",
                    url: "saveOrder.jsp",
                    data: {
                        paymentId: response.razorpay_payment_id,
                        userEmail: "<%= userEmail %>",
                        totalAmount: <%= totalAmount %>
                    },
                    success: function (data) {
                        alert("Order placed successfully!");
                        window.location.href = "orderConfirmation.jsp"; // Redirect to confirmation page
                    },
                    error: function () {
                        alert("Error placing order. Please try again.");
                    }
                });
            },
            "prefill": {
                "name": "Your Name",
                "email": "<%= userEmail %>",
            },
            "theme": {
                "color": "#3399cc"
            }
        };

        var rzp1 = new Razorpay(options);
        document.getElementById('rzp-button1').onclick = function (e) {
            rzp1.open();
            e.preventDefault();
        }
    </script>
</body>
</html>
