<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Collection" %>
<%@ page import="dao.CollectionDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
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
<%
    List<Collection> collections = null;
    CollectionDao collectionDAO = new CollectionDao();
    
    try {
        collections = collectionDAO.getAllCollections();
    } catch (SQLException e) {
        e.printStackTrace();
        out.print("<script type='text/javascript'>");
        out.print("alert('An error occurred while fetching collections.');");
        out.print("window.location.href = 'index.jsp';");
        out.print("</script>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Collections | SleekSilhouettes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: gray;
            margin: 0;
        }
        .container {
            margin-top: 2rem;
        }
        .table-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 1rem;
        }
        h1 {
            color: #d9534f;
        }
        .btn {
            margin: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="table-container">
            <h1>Collections</h1>
            <a href="addcollections.jsp" class="btn btn-primary">Add New Collection</a>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Collection Name</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (collections != null && !collections.isEmpty()) { %>
                        <% for (Collection collection : collections) { %>
                            <tr>
                                <td><%= collection.getId() %></td>
                                <td><%= collection.getCollectionName() %></td>
                                <td><%= collection.getCreatedAt() %></td>
                                <td>
                                    <a href="editCollection.jsp?id=<%= collection.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="deleteCollection.jsp?id=<%= collection.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="4">No collections found.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
