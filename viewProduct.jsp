<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDao"%>
<%@ page import="bean.Product"%>
<%@ page import="java.util.List"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>View Products</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Product List</h2>
<%
    ProductDao productDao = new ProductDao();
    List<Product> products = productDao.getAllProducts();
%>
<table class="table table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Collection</th>
            <th>Price</th>
            <th>Image</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            if (products != null && !products.isEmpty()) {
                for (Product product : products) {
        %>
        <tr>
            <td><%= product.getId() %></td>
            <td><%= product.getProductName() %></td>
            <td><%= product.getCollectionName() %></td>
            <td><%= product.getPrice() %></td>
            <td><img src="<%= product.getImageUrl() %>" alt="Product Image" width="50" height="50"/></td>
            <td><%= product.getDescription() %></td>
            
            <td>
                <a href="EditProduct.jsp?productId=<%= product.getId() %>" class="btn btn-primary">Edit</a>
                <a href="DeleteProduct.jsp?productId=<%= product.getId() %>" class="btn btn-danger">Delete</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="8" class="text-center">No products found.</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>
       
                <tr>
                    <td colspan="7" class="text-center">
                        <a href="addproduct.jsp" class="btn btn-primary">Add New Product</a>
                    </td>
                </tr>
            </tfoot>
      
    </div>

    <!-- Include Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>