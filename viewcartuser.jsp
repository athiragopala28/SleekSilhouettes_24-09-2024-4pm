<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CartDao" %>
<%@ page import="bean.CartBean" %>
<%@ page import="java.util.List" %>

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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Your Cart</h1>
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (cartItems.isEmpty()) {
                %>
                    <tr>
                        <td colspan="5" class="text-center">Your cart is empty.</td>
                    </tr>
                <%
                    } else {
                        double totalAmount = 0.0;
                        for (CartBean item : cartItems) {
                            double total = item.getAmount() * item.getQuantity();
                            totalAmount += total;
                %>
                    <tr>
                        <td><%= item.getProductName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td><%= item.getAmount() %></td>
                        <td><%= total %></td>
                        <td>
                            <a href="removeFromCart.jsp?productName=<%= item.getProductName() %>" class="btn btn-danger btn-sm">Remove</a>
                        </td>
                    </tr>
                <%
                        }
                %>
                    <tr>
                        <td colspan="3" class="font-weight-bold">Total Amount:</td>
                        <td><%= totalAmount %></td>
                        <td><a href="checkout.jsp" class="btn btn-success">Checkout</a></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
