<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDao" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
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
    <meta charset="UTF-8">
    <title>Delete Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <%
            ProductDao productDao = new ProductDao();
            String idParam = request.getParameter("productId");

            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int productId = Integer.parseInt(idParam);
                    boolean success = productDao.deleteProduct(productId);
                    
                    if (success) {
                    	out.print("<script>");
                        out.print("alert('Product deleted successfully.');");
                        out.print("window.location.href = 'viewProduct.jsp';");
                        out.print("</script>");                    } 
                    else {
                    	out.print("<script>");
                        out.print("alert('Failed to delete.');");
                        out.print("window.location.href = 'viewProduct.jsp';");
                        out.print("</script>");                    }
                } catch (NumberFormatException e) {
                    out.println("<div class='alert alert-danger'>Invalid product ID.</div>");
                }
            } else {
                out.println("<div class='alert alert-danger'>Product ID is missing.</div>");
            }
        %>
    </div>
</body>
</html>