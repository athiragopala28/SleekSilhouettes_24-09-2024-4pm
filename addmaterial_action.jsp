<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MaterialDao"%>
<%@ page import="bean.MaterialBean"%>
<%@ page import="java.sql.SQLException"%>

<%
	String materialName = request.getParameter("materialName");
	String materialType = request.getParameter("materialType");
	String description = request.getParameter("description");

	boolean success = false;
	MaterialDao materialDao = new MaterialDao();

	try {
		MaterialBean material = new MaterialBean();
		material.setName(materialName);
		material.setType(materialType);
		material.setDescription(description);

		success = materialDao.addMaterial(material); // Check method signature for boolean return type
	} catch (Exception e) { // Catch a general Exception if SQLException is not thrown
		e.printStackTrace();
	}

	if (success) {
		out.print("<script>");
		out.print("alert('Material added successfully.');");
		out.print("window.location.href = 'viewmaterial.jsp';");
		out.print("</script>");
	} else {
		out.print("<script>");
		out.print("alert('Failed to add material.');");
		out.print("window.location.href = 'addmaterial.jsp';");
		out.print("</script>");
	}
%>
