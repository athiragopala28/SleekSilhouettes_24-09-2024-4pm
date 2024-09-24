<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
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
    String collectionIdStr = request.getParameter("id");
    if (collectionIdStr != null) {
        int collectionId = Integer.parseInt(collectionIdStr);
        CollectionDao collectionDao = new CollectionDao();

        boolean isDeleted = collectionDao.deleteCollection(collectionId);

        if (isDeleted) {
            out.print("<script type='text/javascript'>");
            out.print("alert('Collection deleted successfully!');");
            out.print("window.location.href = 'viewcollections.jsp';");
            out.print("</script>");
        } else {
            out.print("<script type='text/javascript'>");
            out.print("alert('Failed to delete collection. Please try again.');");
            out.print("window.location.href = 'viewcollections.jsp';");
            out.print("</script>");
        }
    } else {
        response.sendRedirect("viewcollections.jsp");
    }
%>
