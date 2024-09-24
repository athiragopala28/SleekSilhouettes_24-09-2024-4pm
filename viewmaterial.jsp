<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="dao.MaterialDao" %>
<%@ page import="bean.MaterialBean" %>
<%@ page import="java.util.List" %>

<%
    MaterialDao materialDao = new MaterialDao();
    List<MaterialBean> materials = null;

    try {
        materials = materialDao.getAllMaterials();
    } catch (Exception e) {
        e.printStackTrace(); // Handle exceptions appropriately
        out.println("<div class='alert alert-danger'>Failed to retrieve materials.</div>");
    }
%>
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
    <title>View Materials</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">View Materials</h2>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (materials != null) {
                        for (MaterialBean material : materials) {
                %>
                <tr>
                    <td><%= material.getMaterialId() %></td>
                    <td><%= material.getName() %></td>
                    <td><%= material.getType() %></td>
                    <td><%= material.getDescription() %></td>
                    <td>
                        <a href="editmaterial.jsp?id=<%= material.getMaterialId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="deletematerial.jsp?id=<%= material.getMaterialId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this material?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
        <a href="addmaterial.jsp" class="btn btn-primary">Add New Material</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
