<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script type="text/javascript">
	function formvalidation() {
		var materialName = document.getElementById("materialName").value;
		var materialType = document.getElementById("materialType").value;
		var description = document.getElementById("description").value;

		if (materialName == "") {
			alert("Material Name is Required!");
			document.getElementById("materialName").focus();
			return false;
		}
		if (materialType == "") {
			alert("Material Type is Required!");
			document.getElementById("materialType").focus();
			return false;
		}
		if (description == "") {
			alert("Description is Required!");
			document.getElementById("description").focus();
			return false;
		}
		alert("Add Material Form submitted successfully!");
		return true;
	}
</script>
<meta charset="UTF-8">
<title>Add Material</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h2 class="text-center">Add New Material</h2>

		<form action="addmaterial_action.jsp" method="POST"
			onsubmit="return formvalidation()">
			<div class="mb-3">
				<label for="materialName" class="form-label">Material Name</label> <input
					type="text" class="form-control" id="materialName"
					name="materialName" >
			</div>
			<div class="mb-3">
				<label for="materialType" class="form-label">Material Type</label> <select
					class="form-select" id="materialType" name="materialType" >
					<option value="">Select Material Type</option>
					<option value="Linen">Linen</option>
					<option value="Silk">Silk</option>
					<option value="Chiffon">Chiffon</option>
					<option value="Crepe">Crepe</option>
					<option value="Satin">Satin</option>
					<option value="Nylon">Nylon</option>
					<option value="Georgette">Georgette</option>
					<option value="Velvet">Velvet</option>
					<option value="Rayon">Rayon</option>
				</select>
			</div>
			<div class="mb-3">
				<label for="description" class="form-label">Description</label>
				<textarea class="form-control" id="description" name="description"
					rows="3" ></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Add Material</button>
			<a href="viewmaterial.jsp" class="btn btn-secondary">Back to View
				Materials</a>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
