<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.UserProfileDAO" %>
<%@ page import="bean.UserProfileBean" %>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>
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
    // Retrieve form data from the request
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    // Create a new UserProfileBean object and set its properties
    UserProfileBean userProfile = new UserProfileBean();
    userProfile.setFullName(fullName);
    userProfile.setEmail(email);
    userProfile.setPhone(phone);
    userProfile.setAddress(address);

    // Create an instance of UserProfileDAO
    UserProfileDAO userDAO = new UserProfileDAO();

    // Insert the user profile into the profiles table
    boolean isInserted = userDAO.insertOrUpdateUserProfile(userProfile);

    // Redirect based on the result of the insertion
    if (isInserted) {
    	out.print("<script type='text/javascript'>");
		out.print("alert('Profile updated successfully');");
		out.print("window.location.href = 'userdashboard.jsp';");
		out.print("</script>");    }
    else {
    	out.print("<script type='text/javascript'>");
		out.print("alert('Failed to update profile');");
		out.print("window.location.href = 'addcollections.jsp';");
		out.print("</script>");
    }
%>