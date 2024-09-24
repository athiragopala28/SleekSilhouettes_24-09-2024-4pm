<%@ page import="dao.CartDao"%>

<%
	int userId = (Integer) session.getAttribute("userId");
	int productId = Integer.parseInt(request.getParameter("productId"));

	CartDao cartDao = new CartDao();
	boolean success = cartDao.removeProductFromCart(userId, productId);

	if (success) {
		response.sendRedirect("cart.jsp");
	} else {
		out.println("Failed to remove product from cart.");
	}
%>
