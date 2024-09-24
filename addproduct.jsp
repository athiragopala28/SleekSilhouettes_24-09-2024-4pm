<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.CollectionDao"%>
<%@ page import="bean.Collection"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.SQLException"%>

<%
	HttpSession httpsession = request.getSession(false);
	if (httpsession != null) {
		String userEmail = (String) httpsession.getAttribute("email");
		String userRole = (String) httpsession.getAttribute("role");

		if (userEmail == null || userRole == null) {
			response.sendRedirect("login.jsp");
			return;
		}
	} else {
		response.sendRedirect("login.jsp");
		return;
	}

	// Fetch collections from the database
	CollectionDao collectionDao = new CollectionDao();
	List<Collection> collections = null;

	try {
		collections = collectionDao.getAllCollections();
	} catch (SQLException e) {
		e.printStackTrace();
		out.println("<div class='alert alert-danger'>Failed to fetch collections.</div>");
		collections = new ArrayList<>();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Add Product</title>
<style>
.container {
	max-width: 600px;
	margin-top: 30px;
}
</style>
<script>
        function validatePrice(input) {
            // Remove any non-digit characters
            input.value = input.value.replace(/\D/g, '');
        }

        function showAlert(message, type) {
            const alertBox = document.createElement('div');
            alertBox.className = `alert alert-${type} alert-dismissible fade show`;
            alertBox.role = 'alert';
            alertBox.innerHTML = `${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>`;
            document.body.prepend(alertBox);
        }

        function validateForm() {
            var productName = document.getElementById("productName").value.trim();
            var collection = document.getElementById("collection").value;
            var price = document.getElementById("price").value.trim();
            var imageUrl = document.getElementById("imageUrl").value.trim();
            var description = document.getElementById("description").value.trim();

            if (productName === "") {
                alert("Product Name is required!", "danger");
                document.getElementById("productName").focus();
                return false;
            }

            if (collection === "") {
                alert("Please select a Collection!", "danger");
                document.getElementById("collection").focus();
                return false;
            }

            if (price === "") {
                alert("Price is required!", "danger");
                document.getElementById("price").focus();
                return false;
            }

            if (isNaN(price)) {
                alert("Price must be a whole number!", "danger");
                document.getElementById("price").focus();
                return false;
            }

            if (imageUrl === "") {
                alert("Product Image URL is required!", "danger");
                document.getElementById("imageUrl").focus();
                return false;
            }

            if (description === "") {
                alert("Description is required!", "danger");
                document.getElementById("description").focus();
                return false;
            }

            if (description.length < 1000 || description.length > 2000) {
    			alert("Description must be between 1000 and 2000 words!", "danger"!");
                document.getElementById("description").focus();
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
	<div class="container">
		<h2 class="text-center">Add New Product</h2>
		<form action="saveproduct.jsp" method="post"
			onsubmit="return validateForm()">
			<div class="mb-3">
				<label for="productName" class="form-label">Product Name</label> <input
					type="text" class="form-control" id="productName"
					name="productName" required>
			</div>

			<div class="mb-3">
				<label for="collection" class="form-label">Select Collection</label>
				<select class="form-select" id="collection" name="collection"
					required>
					<option value="" disabled selected>Select Collection</option>
					<%
						for (Collection collection : collections) {
							out.print(
									"<option value=\"" + collection.getId() + "\">" + collection.getCollectionName() + "</option>");
						}
					%>
				</select>
			</div>

			<div class="mb-3">
				<label for="price" class="form-label">Price (whole number
					only)</label> <input type="text" class="form-control" id="price"
					name="price" required oninput="validatePrice(this)">
			</div>

			<div class="mb-3">
				<label for="imageUrl" class="form-label">Product Image URL</label> <input
					type="url" class="form-control" id="imageUrl" name="imageUrl"
					required>
			</div>

			<div class="mb-3">
				<label for="description" class="form-label">Description
					(1000-2000 words)</label>
				<textarea class="form-control" id="description" name="description"
					rows="6" required></textarea>
			</div>

			<button type="submit" class="btn btn-primary">Save</button>
		</form>

		<!-- Include Bootstrap JavaScript -->
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

		<!-- JavaScript to handle the alert message -->
		<script>
            // Check for URL parameter to show alert
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            const type = urlParams.get('type');

            if (message) {
                showAlert(message, type);
            }
        </script>
	</div>
</body>
</html>
