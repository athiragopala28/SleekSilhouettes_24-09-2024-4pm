<%@ page import="bean.ContactBean"%>
<%@ page import="dao.ContactDao"%>
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
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
/* Your CSS styles */
.navbar-brand {
	flex-grow: 1;
	font-size: 1.5rem;
	text-align: left;
}

.navbar-nav .nav-item {
	margin-right: 10px;
}

.icon-color {
	color: #000000;
}

.btn-black {
	color: #000000;
	border-color: #000000;
	background-color: #ffffff;
}

.btn-black:hover {
	color: #000000;
	background-color: #f0f0f0;
	border-color: #000000;
}

.form-control {
	border-color: #4caf50;
}

footer {
	background-color: #001f3f; /* Navy blue */
	padding: 40px 0;
	color: #ffffff; /* White text color for contrast */
	border-top: 1px solid #dee2e6;
}

.footer-content {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	flex-wrap: wrap;
}

.footer-section {
	flex: 1;
	min-width: 200px;
}

.footer-section h5 {
	font-weight: bold;
	margin-bottom: 15px;
}

.footer-section ul {
	list-style: none;
	padding: 0;
}

.footer-section ul li {
	margin-bottom: 10px;
}

.footer-section a {
	color: #ffffff; /* White link color */
	text-decoration: none;
}

.footer-section a:hover {
	text-decoration: underline;
}

.social-icons a {
	color: #ffffff; /* White icon color */
	font-size: 20px;
	margin-right: 10px;
}

.social-icons a:hover {
	color: #adb5bd; /* Light gray on hover */
}

.card-custom {
	border: 1px solid #dee2e6;
	border-radius: .375rem;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="#">SLEEKSILHOUETTES</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="userdashboard.jsp">Home</a></li>
				<li class="nav-item dropdown">

						<li><a class="dropdown-item" href="feedback.jsp">Feedback</a></li>
						<li><a class="dropdown-item" href="contact.jsp">Contact</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>

	<div class="container mt-4">
		<%
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String message = request.getParameter("message");

			if (name != null && email != null && message != null) {
				ContactBean contact = new ContactBean();
				contact.setName(name);
				contact.setEmail(email);
				contact.setMessage(message);

				ContactDao contactDAO = new ContactDao();
				boolean success = contactDAO.saveContact(contact);

				if (success) {
		%>
		<p>Thank you for contacting us! We will get back to you shortly.</p>
		<%
			} else {
		%>
		<p>There was an error processing your request. Please try again
			later.</p>
		<%
			}
			} else {
		%>
		<p>All fields are required.</p>
		<%
			}
		%>
	</div>

	<footer>
		<div class="container footer-content">
			<div class="footer-section">
				<h5>About Us</h5>
				<ul>
					<li><a href="#">Company Info</a></li>
					<li><a href="#">Careers</a></li>
					<li><a href="contact.jsp">Contact</a></li>
				</ul>
			</div>
			<div class="footer-section">
				<h5>Customer Service</h5>
				<ul>
					<li><a href="#">Help Center</a></li>
					<li><a href="#">Returns</a></li>
					<li><a href="#">Shipping</a></li>
				</ul>
			</div>
			<div class="footer-section social-icons">
				<h5>Follow Us</h5>
				<a href="#" class="fab fa-facebook-f"></a> <a href="#"
					class="fab fa-twitter"></a> <a href="#" class="fab fa-instagram"></a>
			</div>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
