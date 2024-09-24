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

.form-control {
	border-color: #4caf50;
}

footer {
	background-color: #001f3f;
	padding: 40px 0;
	color: #ffffff;
	border-top: 1px solid #dee2e6;
}

.footer-content {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	flex-wrap: wrap;
}
</style>
<script type="text/javascript">
	function formvalidation() {
		var name = document.getElementById("name").value;
		var email = document.getElementById("email").value;
		var message = document.getElementById("message").value;

		// Validate name
		if (name == "") {
			alert("Name is Required!");
			document.getElementById("name").focus();
			return false;
		}

		// Validate email
		if (email == "") {
			alert("Email is Required!");
			document.getElementById("email").focus();
			return false;
		}

		// Validate message
		if (message == "") {
			alert("Message is Required!");
			document.getElementById("message").focus();
			return false;
		}

		// Display success message and redirect to the dashboard after submission
		alert("Contact Form submitted successfully!");
		return true;
	}
</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="#">SLEEK SILHOUETTES</a>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link active"
					href="userdashboard.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
			</ul>
		</div>
	</nav>

	<div class="container mt-4">
		<h2>Contact Us</h2>
		<form action="submitContact.jsp" method="post"
			onsubmit="return formvalidation()">
			<div class="mb-3">
				<label for="name" class="form-label">Name</label> <input type="text"
					class="form-control" id="name" name="name">
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">Email</label> <input
					type="email" class="form-control" id="email" name="email">
			</div>
			<div class="mb-3">
				<label for="message" class="form-label">Message</label>
				<textarea class="form-control" id="message" name="message"></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>

	<footer>
		<div class="container footer-content">
			<div class="footer-section">
				<h5>About Us</h5>
				<ul>
					<li><a href="#">Company Info</a></li>
					<li><a href="#">Careers</a></li>
					<li><a href="#">Contact</a></li>
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
