<%@ page import="bean.ContactBean, dao.ContactDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container mt-4">
		<%
			// Retrieve form data
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String message = request.getParameter("message");

			if (name != null && !name.isEmpty() && email != null && !email.isEmpty() && message != null
					&& !message.isEmpty()) {
				// Create ContactBean object and set values
				ContactBean contact = new ContactBean();
				contact.setName(name);
				contact.setEmail(email);
				contact.setMessage(message);

				// Create ContactDao and save the contact details
				ContactDao contactDAO = new ContactDao();
				boolean success = contactDAO.saveContact(contact);

				if (success) {
					// If successful, show success message and redirect
					out.print("<script>alert('Your contact information has been submitted successfully!');");
					out.print("window.location.href = 'userdashboard.jsp';</script>");
				} else {
					// If there was an error
					out.print("<script>alert('There was an error processing your request. Please try again later.');");
					out.print("window.location.href = 'contact.jsp';</script>");
				}
			} else {
				// If form data is missing, show error and redirect back to form
				out.print("<script>alert('All fields are required. Please fill out the form completely.');");
				out.print("window.location.href = 'contact.jsp';</script>");
			}
		%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
