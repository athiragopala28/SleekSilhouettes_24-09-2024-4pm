<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="bean.Order" %>
<%@ page import="dao.OrderDao" %>
<%@ page import="bean.CartBean" %>
<%@ page import="dao.CartDao" %>

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

    // Retrieve order details from session
    List<CartBean> cartItems = (List<CartBean>) httpsession.getAttribute("cartItems");
    double totalAmount = 0.0;

    // Calculate total amount
    if (cartItems != null) {
        for (CartBean item : cartItems) {
            totalAmount += item.getAmount() * item.getQuantity();
        }
    }

    // Create and save the order
    Order order = new Order();
    order.setPaymentId((String) httpsession.getAttribute("paymentId")); // Assuming you set paymentId in session
    order.setUserEmail(userEmail);
    order.setTotalAmount(totalAmount);
    order.setStatus("Pending"); // You can change this based on your logic

    OrderDao orderDao = new OrderDao();
    boolean isOrderSaved = orderDao.saveOrder(order);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Order Confirmation</h1>
        <div class="alert alert-success" role="alert">
            Thank you for your order!
        </div>
        
        <h4>Your Order Details</h4>
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (cartItems == null || cartItems.isEmpty()) {
                %>
                    <tr>
                        <td colspan="4" class="text-center">No items in your order.</td>
                    </tr>
                <%
                    } else {
                        for (CartBean item : cartItems) {
                            double total = item.getAmount() * item.getQuantity();
                %>
                    <tr>
                        <td><%= item.getProductName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td><%= item.getAmount() %></td>
                        <td><%= total %></td>
                    </tr>
                <%
                        }
                %>
                <tr>
                    <td colspan="3" class="font-weight-bold">Total Amount:</td>
                    <td><%= totalAmount %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <h4>Order ID: <%= order.getPaymentId() %></h4>
        <p>User Email: <%= userEmail %></p>
        <p>Status: <%= order.getStatus() %></p>

        <a href="index.jsp" class="btn btn-primary">Continue Shopping</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
