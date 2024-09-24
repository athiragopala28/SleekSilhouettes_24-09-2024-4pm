<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="bean.Order" %>
<%@ page import="bean.UserProfileBean" %>
<%@ page import="dao.UserProfileDAO" %>

<%
    HttpSession httpsession = request.getSession(false);
    String email = null;

    // Retrieve the email from the session
    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

    // Redirect to login if session does not exist or email is not found
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch user details from the database
    UserProfileDAO userDAO = new UserProfileDAO();
    UserProfileBean user = userDAO.getUserByEmail(email);

    if (user == null) {
        response.sendRedirect("login.jsp?message=User not found");
        return;
    }

    // Retrieve service details from the request
    String productName = request.getParameter("serviceName");
    String quantityStr = request.getParameter("quantity"); // Get the quantity from request
    String paymentMethod = request.getParameter("paymentMethod"); // Payment method

    if (productName == null || quantityStr == null || paymentMethod == null) {
        response.sendRedirect("getservicesuser.jsp?message=Invalid service details");
        return;
    }

    int quantity = Integer.parseInt(quantityStr);
    String status = "Pending"; // Set default status
    Timestamp orderDate = new Timestamp(System.currentTimeMillis()); // Current timestamp for order date

    // Create Order object
    Order order = new Order();
    order.setUserEmail(email);
    order.setProductName(productName);
    order.setQuantity(quantity);
    order.setStatus(status);
    order.setOrderDate(orderDate);
    order.setPaymentMethod(paymentMethod);

    // Save order using OrderDAO
    OrderDAO orderDAO = new OrderDAO();
    boolean orderSaved = orderDAO.saveOrder(order);

    if (!orderSaved) {
        response.sendRedirect("error.jsp?message=Order could not be saved");
        return;
    }

    // Assuming you have a method to get the price per item
    double pricePerItem = 100.0; // Replace this with actual logic to fetch the price
    double totalAmount = quantity * pricePerItem; // Calculate total amount
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <title>Order Confirmation - SLEEK SILHOUETTES</title>
    <style>
        /* Your styles here */
        .booking-container {
            max-width: 600px;
            margin: auto;
            padding: 2rem;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="booking-container">
        <div class="booking-header">
            <h2>SLEEK SILHOUETTES</h2>
            <h4>Your Order for <%= productName %> has been placed!</h4>
        </div>
        <p>Thank you for your order, <%= user.getFullName() %>!</p>
        <p>Order Quantity: <%= quantity %></p>
        <p>Status: <%= status %></p>
        <p>Total Amount: &#x20B9; <%= totalAmount %></p> <!-- Corrected total amount display -->
        <p>Your order will be processed shortly.</p>
        <a href="index.jsp" class="btn btn-primary">Go to Home</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
