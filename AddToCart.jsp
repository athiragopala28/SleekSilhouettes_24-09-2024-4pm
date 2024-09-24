<%@ page import="dao.CartDao" %>
<%@ page import="bean.CartBean" %>
<%@ page import="bean.Product" %>
<%@ page import="dao.ProductDao" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.IOException" %>

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

    String productId = request.getParameter("productId");
    String quantityStr = request.getParameter("quantity");

    // Validate quantity input
    if (productId == null || quantityStr == null) {
        out.print("<script>alert('Invalid product or quantity.'); window.location.href='index.jsp';</script>");
        return;
    }

    int quantity = 0;
    try {
        quantity = Integer.parseInt(quantityStr);
    } catch (NumberFormatException e) {
        out.print("<script>alert('Invalid quantity. Please enter a number.'); window.location.href='index.jsp';</script>");
        return;
    }

    ProductDao productDao = new ProductDao();
    Product product = productDao.getProductById(Integer.parseInt(productId));

    if (product != null) {
        CartDao cartDao = new CartDao();
        CartBean existingItem = cartDao.getCartItemByUserEmailAndProductName(userEmail, product.getProductName());

        if (existingItem != null) {
            // Update the quantity and amount
            int newQuantity = existingItem.getQuantity() + quantity;
            double newAmount = product.getPrice() * newQuantity; // Assuming price is double
            existingItem.setQuantity(newQuantity);
            existingItem.setAmount(newAmount);
            cartDao.updateCartItem(existingItem);
            out.print("<script>alert('Check your cart!'); window.location.href='viewcartuser.jsp';</script>");
        } else {
            // Add new item to the cart
            CartBean cartItem = new CartBean();
            cartItem.setUserEmail(userEmail);
            cartItem.setProductName(product.getProductName());
            cartItem.setQuantity(quantity);
            cartItem.setAmount(product.getPrice());

            boolean added = cartDao.addToCart(cartItem);
            if (added) {
                out.print("<script>alert('Product added to cart successfully!'); window.location.href='viewcartuser.jsp';</script>");
            } else {
                out.print("<script>alert('Failed to add product to cart.'); window.location.href='viewcartuser.jsp';</script>");
            }
        }
    } else {
        out.print("<script>alert('Product not found.'); window.location.href='index.jsp';</script>");
    }
%>
