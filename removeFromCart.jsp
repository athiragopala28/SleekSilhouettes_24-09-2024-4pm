<%@ page import="dao.CartDao" %>
<%@ page import="bean.CartBean" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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

    String productName = request.getParameter("productName");

    if (productName != null && !productName.isEmpty()) {
        CartDao cartDao = new CartDao();
        boolean removed = cartDao.removeCartItem(userEmail, productName); // Ensure this method is implemented

        if (removed) {
            out.println("<p>Product removed from cart successfully!</p>");
        } else {
            out.println("<p>Failed to remove product from cart.</p>");
        }
    } else {
        out.println("<p>Invalid product name.</p>");
    }
%>

<a href="viewcartuser.jsp">Go back to your cart</a>
