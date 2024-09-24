<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MaterialDao"%>
<%@ page import="bean.MaterialBean"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.CollectionDao"%>
<%@ page import="bean.Collection"%>
<%@ page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>Edit Material</title>
</head>
<body>
	<div class="container mt-5">
		<h2 class="text-center">Edit Material</h2>
		<%
			HttpSession httpsession = request.getSession(false);
			if (session != null) {
				String userEmail = (String) session.getAttribute("email");
				String userRole = (String) session.getAttribute("role");

				if (userEmail != null && userRole != null) {
					String idParam = request.getParameter("id");
					if (idParam != null && !idParam.isEmpty()) {
						try {
							int materialId = Integer.parseInt(idParam);
							MaterialDao materialDao = new MaterialDao();
							MaterialBean material = materialDao.getMaterialById(materialId);

							if (material != null) {
								CollectionDao collectionDao = new CollectionDao();
								List<Collection> collections = new ArrayList<>();

								try {
									collections = collectionDao.getAllCollections();
								} catch (SQLException e) {
									e.printStackTrace();
									out.println("<div class='alert alert-danger'>Failed to fetch collections.</div>");
								}
		%>
		<form action="updatematerial.jsp" method="post">
			<input type="hidden" name="id" value="<%=material.getMaterialId()%>">
			<div class="mb-3">
				<label for="materialName" class="form-label">Material Name</label> <input
					type="text" class="form-control" id="materialName"
					name="materialName" value="<%=material.getName()%>" required>
				<div class="mb-3">
					<label for="materialType" class="form-label">Material Type</label>
					<select class="form-select" id="materialType" name="materialType"
						required>
						<option value="">Select Material Type</option>
						<option value="Linen"
							<%="Linen".equals(material.getType()) ? "selected" : ""%>>Linen</option>
						<option value="Silk"
							<%="Silk".equals(material.getType()) ? "selected" : ""%>>Silk</option>
						<option value="Chiffon"
							<%="Chiffon".equals(material.getType()) ? "selected" : ""%>>Chiffon</option>
						<option value="Crepe"
							<%="Crepe".equals(material.getType()) ? "selected" : ""%>>Crepe</option>
						<option value="Satin"
							<%="Satin".equals(material.getType()) ? "selected" : ""%>>Satin</option>
						<option value="Nylon"
							<%="Nylon".equals(material.getType()) ? "selected" : ""%>>Nylon</option>
						<option value="Georgette"
							<%="Georgette".equals(material.getType()) ? "selected" : ""%>>Georgette</option>
						<option value="Velvet"
							<%="Velvet".equals(material.getType()) ? "selected" : ""%>>Velvet</option>
						<option value="Rayon"
							<%="Rayon".equals(material.getType()) ? "selected" : ""%>>Rayon</option>
					</select>
				</div>
				<div class="mb-3">
					<label for="description" class="form-label">Description</label>
					<textarea class="form-control" id="description" name="description"
						rows="6" required><%=material.getDescription()%></textarea>
				</div>
				<button type="submit" class="btn btn-primary">Update</button>
				<a href="viewmaterial.jsp" class="btn btn-secondary">Cancel</a>
		</form>
		<%
			} else {
								out.println("<p class='text-center'>Material not found.</p>");
							}
						} catch (NumberFormatException e) {
							out.println("<p class='text-center'>Invalid Material ID.</p>");
						}
					} else {
						out.println("<p class='text-center'>Material ID is missing.</p>");
					}
				} else {
					out.println("<p class='text-center'>You must be logged in to edit materials.</p>");
				}
			} else {
				out.println("<p class='text-center'>Session expired. Please log in again.</p>");
			}
		%>
	</div>
</body>
</html>
