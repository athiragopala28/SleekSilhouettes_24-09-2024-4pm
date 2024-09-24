<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	HttpSession httpsession = request.getSession(false);
	if (httpsession != null) {
		String userEmail = (String) httpsession.getAttribute("email");
		String userRole = (String) httpsession.getAttribute("role");

		if (userEmail != null && userRole != null) {
			// User is logged in, proceed with the page content
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
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<style>
.form-container {
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #f9f9f9;
}

.form-container h2 {
	margin-bottom: 20px;
	text-align: center;
}

.btn-submit {
	background-color: #4caf50;
	color: white;
	border: none;
}

.btn-submit:hover {
	background-color: #45a049;
}

.error-message {
	color: red;
	font-size: 0.9rem;
	margin-top: 5px;
}
</style>
</head>
<body>

	<div class="container">
		<div class="form-container">
			<h2>Add Collection</h2>
			<form id="collectionForm" action="addcollectionService.jsp"
				method="post" onsubmit="return validateForm()">
				<div class="mb-3">
					<label for="collectionName" class="form-label">Collection
						Name</label> <input type="text" class="form-control" id="collectionName"
						name="collectionName" placeholder="Enter collection name">
					<div id="error-message" class="error-message"></div>
				</div>
				<button type="submit" class="btn btn-dark w-100">Add
					Collection</button>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		function validateForm() {
			var collectionName = document.getElementById("collectionName").value;
			var errorMessage = document.getElementById("error-message");

			if (collectionName.trim() === "") {
				errorMessage.textContent = "Collection Name is Required!";
				document.getElementById("collectionName").focus();
				return false;
			}

			// Clear previous error messages
			errorMessage.textContent = "";
			alert("Add Collection Form submitted successfully!");
			return true;
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
