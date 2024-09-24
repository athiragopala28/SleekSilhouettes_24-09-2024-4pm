<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDao" %>
<%@ page import="bean.Product" %>
<%
	HttpSession httpsession = request.getSession(false);
	if (session != null) {
		String userEmail = (String) session.getAttribute("email");
		String userRole = (String) session.getAttribute("role");

		if (userEmail != null && userRole != null) {
			// Set the content type of the response
			/*  response.setContentType("text/html");
			
			 // Write the response content
			 response.getWriter().println("<html><body>");
			 response.getWriter().println("<h1>Welcome to the Dashboard</h1>");
			 response.getWriter().println("<p>Email: " + userEmail + "</p>");
			 response.getWriter().println("<p>Role: " + userRole + "</p>");
			 response.getWriter().println("</body></html>"); */
		} else {
			// Redirect to login page if user is not logged in
			response.sendRedirect("login.jsp");
		}
	} else {
		// Redirect to login page if session is null
		response.sendRedirect("login.jsp");
	}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Update Product</h2>

        <%
            // Retrieve the product ID from the request parameter
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.isEmpty()) {
                out.println("<div class='alert alert-danger'>Product ID is missing.</div>");
            } else {
                int productId = Integer.parseInt(idParam);
                ProductDao productDao = new ProductDao();
                Product product = productDao.getProductById(productId);

                if (product == null) {
                    out.println("<div class='alert alert-danger'>Product not found.</div>");
                } else {
                    // Check if form has been submitted
                    String productName = request.getParameter("productName");
                    String collection = request.getParameter("collection");
                    String priceStr = request.getParameter("price");
                    String imageUrl = request.getParameter("imageUrl");
                    String description = request.getParameter("description");

                    if (productName != null && collection != null && priceStr != null && description != null) {
                        try {
                            double price = Double.parseDouble(priceStr);
                            boolean success = productDao.updateProduct(productId, productName, collection, price, imageUrl, description);

                            if (success) {
                                out.print("<script>");
                                out.print("alert('Product updated successfully.');");
                                out.print("window.location.href = 'viewProduct.jsp';");
                                out.print("</script>");
                            } else {
                                out.print("<script>");
                                out.print("alert('Product update failed.');");
                                out.print("window.location.href = 'viewProduct.jsp';");
                                out.print("</script>");
                            }
                        } catch (NumberFormatException e) {
                            out.println("<div class='alert alert-danger'>Invalid price format.</div>");
                        }
                    } else {
                        out.println("<div class='alert alert-danger'>All fields are required.</div>");
                    }
                }
            }
        %>
    </div>
</body>
</html>