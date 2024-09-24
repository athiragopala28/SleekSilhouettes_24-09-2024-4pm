<%@ page import="dao.FavoriteDAO"%>
<%@ page import="bean.User"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="java.io.IOException"%>

<%
	// Retrieve the current user object (replace with actual user retrieval logic)
	HttpSession httpsession = request.getSession();
	User user = (User) httpsession.getAttribute("user");

	// Redirect to login if user is not logged in
	if (user == null) {
		response.sendRedirect("login.jsp");
		return;
	}

	int userId = user.getUsersId(); // Get user ID

	// Retrieve action and product ID from the request
	String action = request.getParameter("action");
	String productIdStr = request.getParameter("productId");

	if (action != null && productIdStr != null) {
		int productId = Integer.parseInt(productIdStr);
		FavoriteDAO favoriteDAO = new FavoriteDAO();

		boolean success = false;

		if (action.equals("add")) {
			// Add product to favorites
			success = favoriteDAO.addFavorite(userId, productId);
		} else if (action.equals("remove")) {
			// Remove product from favorites
			success = favoriteDAO.removeFavorite(userId, productId);
		}

		if (success) {
			response.sendRedirect("viewfavourite.jsp"); // Redirect to the favorites page
		} else {
			out.println(
					"<div class='alert alert-danger'>An error occurred while processing your request.</div>");
		}
	} else {
		out.println("<div class='alert alert-warning'>Invalid action or product ID.</div>");
	}
%>
