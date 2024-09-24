<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MaterialDao" %>
<%@ page import="bean.MaterialBean" %>
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
<html>
<head>
<meta charset="UTF-8">
<title>Update Material</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h2>Update Material</h2>

		<%
			// Retrieve the material ID from the request parameter
			String idParam = request.getParameter("id");

			if (idParam == null || idParam.isEmpty()) {
				out.println("<div class='alert alert-danger'>Material ID is missing.</div>");
			} else {
				int materialId = Integer.parseInt(idParam);
				MaterialDao materialDao = new MaterialDao();
				MaterialBean material = materialDao.getMaterialById(materialId);

				if (material == null) {
					out.println("<div class='alert alert-danger'>Material not found.</div>");
				} else {
					// Check if form has been submitted
					String materialName = request.getParameter("materialName");
					String materialType = request.getParameter("materialType");
					String description = request.getParameter("description");

					if (materialName != null && materialType != null && description != null &&
					    !materialName.trim().isEmpty() && !materialType.trim().isEmpty() && !description.trim().isEmpty()) {
						
						// Update MaterialBean with form data
						material.setName(materialName);
						material.setType(materialType);
						material.setDescription(description);

						try {
							boolean success = materialDao.updateMaterial(material);
							if (success) {
								out.print("<script>");
								out.print("alert('Material updated successfully.');");
								out.print("window.location.href = 'viewmaterial.jsp';");
								out.print("</script>");
							} else {
								out.print("<script>");
								out.print("alert('Material update failed.');");
								out.print("window.location.href = 'viewmaterial.jsp';");
								out.print("</script>");
							}
						} catch (Exception e) {
							out.println("<div class='alert alert-danger'>Error updating material: " + e.getMessage() + "</div>");
						}
					} else {
						out.println("<div class='alert alert-danger'>All fields are required.</div>");
					}
				}
			}
		%>
	</div>
</body>
</html>
