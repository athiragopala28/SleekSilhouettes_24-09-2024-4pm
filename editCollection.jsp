<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CollectionDao" %>
<%@ page import="bean.Collection" %>
<%
	HttpSession httpsession = request.getSession(false);
	if (session != null) {
		String userEmail = (String) session.getAttribute("email");
		String userRole = (String) session.getAttribute("role");

		if (userEmail != null && userRole != null) {
			// Proceed with the page
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
    <title>Edit Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Edit Collection</h2>
        <%
            String idParam = request.getParameter("id");
            CollectionDao collectionDao = new CollectionDao();
            Collection collection = null;

            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int collectionId = Integer.parseInt(idParam);
                    collection = collectionDao.getCollectionById(collectionId);
                } catch (NumberFormatException e) {
                    out.println("<div class='alert alert-danger'>Invalid collection ID.</div>");
                }
            }

            if (collection == null) {
                out.println("<div class='alert alert-danger'>Collection not found.</div>");
                return;
            }
        %>

        <form action="updatecollection.jsp" method="post">
            <input type="hidden" name="id" value="<%= collection.getId() %>">
            
            <div class="mb-3">
                <label for="collectionName" class="form-label">Collection Name:</label>
                <input type="text" class="form-control" id="collectionName" name="collectionName" value="<%= collection.getCollectionName() %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Update Collection</button>
            <a href="viewcollections.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
