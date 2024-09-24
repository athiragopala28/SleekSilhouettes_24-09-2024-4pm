<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.io.IOException" %>

<%
    String paymentId = request.getParameter("paymentId");
    String userEmail = request.getParameter("userEmail");
    double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

    Order order = new Order();
    order.setPaymentId(paymentId);
    order.setUserEmail(userEmail);
    order.setTotalAmount(totalAmount);
    order.setStatus("Pending"); // or "Completed" based on your logic

    OrderDao orderDao = new OrderDao();
    boolean isSaved = orderDao.saveOrder(order);

    if (isSaved) {
        // Optionally, clear the cart after order placement
        CartDao cartDao = new CartDao();
        cartDao.clearCart(userEmail);
        response.getWriter().write("Order saved successfully.");
    } else {
        response.getWriter().write("Failed to save order.");
    }
%>
