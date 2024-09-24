<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.UserProfileDAO" %>
<%@ page import="bean.UserProfileBean" %>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>

<%
    HttpSession httpsession = request.getSession(false);
    
    // Check if session is null or if the "user" attribute is missing
    if (httpsession == null || httpsession.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve the email from the session
    String email = (String) httpsession.getAttribute("email");

    // Create an instance of UserProfileDAO
    UserProfileDAO userDAO = new UserProfileDAO();

    // Retrieve the UserProfileBean by email
    UserProfileBean userProfile = userDAO.getUserByEmail(email);

    // Check if user profile is found
    if (userProfile == null) {
        response.sendRedirect("profile.jsp?message=User+not+found.");
        return;
    }

    // Fetch message parameter if exists
    String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile | SleekSilhouettes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: gray;
            margin: 0;
        }

        .form-container {
            max-width: 400px;
            width: 100%;
            padding: 2rem;
            background-color: silver;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        h1 {
            color: #d9534f;
            margin: 0;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #d9534f;
            color: #fff;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #c9302c;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <form action="profileupdated.jsp" method="post">
            <div class="form-header">
                <h1>SleekSilhouettes</h1>
            </div>
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" value="<%= userProfile.getFullName() %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= userProfile.getEmail() %>" required readonly>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phone" value="<%= userProfile.getPhone() %>" required>
            </div>

            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= userProfile.getAddress() %>">
            </div>

            <input type="submit" value="Update Profile">
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
