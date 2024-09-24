<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="bean.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>



<%
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String cpassword = request.getParameter("cpassword");
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

	out.print(name);

	//Create UserRegistration object and set properties
	User user = new User();
	user.setName(name);
	user.setPhone(phone);
	user.setEmail(email);
	user.setPassword(hashedPassword); // Store the hashed password

	// Create DAO instance
	UserDao userDAO = new UserDao();

	try {
		// Insert user into the database
		userDAO.insertUser(user);
		out.print("<script type='text/javascript'>");
		out.print("alert('Successfully registered');");
		out.print("window.location.href = 'login.jsp';");
		out.print("</script>");
	} catch (SQLException e) {
		// Show an error message if registration fails
		out.print("<script type='text/javascript'>");
		out.print("alert('Registration failed');");
		out.print("window.location.href = 'register.jsp';");
		out.print("</script>");
		e.printStackTrace();
	}
%>