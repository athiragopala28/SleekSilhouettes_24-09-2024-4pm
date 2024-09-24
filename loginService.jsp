<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="dao.*"%>
<%@page import="bean.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	

	//out.print(email + " " + password);
	try{
		UserDao userDao = new UserDao();
		User user = userDao.getUserByEmail(email);
		if (email.equals("admin@gmail.com") && password.equals("Admin123@")) {
			HttpSession httpsession = request.getSession();
			httpsession.setAttribute("email", email);
			httpsession.setAttribute("role", "admin");
			out.print("<script type='text/javascript'>");
			out.print("alert('Successfully logged');");
			out.print("window.location.href = 'admindashboard.jsp';");
			out.print("</script>");
		}

		else if (user != null && BCrypt.checkpw(password, user.getPassword())) {
			HttpSession httpsession = request.getSession();
			httpsession.setAttribute("email", email);
			httpsession.setAttribute("role", "user");
			out.print("<script type='text/javascript'>");
			out.print("alert('Successfully logged');");
			out.print("window.location.href = 'userdashboard.jsp';");
			out.print("</script>");
		}
		else{
			out.print("<script type='text/javascript'>");
			out.print("alert('Incorrect details | User not registered');");
			out.print("window.location.href = 'register.jsp';");
			out.print("</script>");
		}
	}catch(Exception e)
	{
		out.print(e);
	}
	

	
%>