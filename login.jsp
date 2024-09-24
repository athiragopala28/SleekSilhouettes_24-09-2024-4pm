<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<title>SleekSilhouettes</title>
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        background-color: gray; /* New background color for the entire page */
    }

    .login-container {
        max-width: 400px;
        width: 100%;
        padding: 2rem;
        background-color:silver; /* New background color for the login container */
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    

    .login-header {
        text-align: center;
        margin-bottom: 1.5rem;
    }

    .btn-custom {
        width: 100%;
    }

    .input-group-text {
        cursor: pointer;
    }
</style>
<script type="text/javascript">
    function validateform() {
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;

        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]{8,12}$/;

        if (email === "") {
            alert("Email required");
            document.getElementById("email").focus();
            return false;
        }
        if (!emailPattern.test(email)) {
            alert("Please enter a valid email address.");
            document.getElementById("email").focus();
            return false;
        }
        if (password === "") {
            alert("Password required");
            document.getElementById("password").focus();
            return false;
        }
        if (!passwordPattern.test(password)) {
            alert("Password must be 8-12 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character.");
            document.getElementById("password").focus();
            return false;
        }
        return true;
    }

    function togglePasswordVisibility() {
        var passwordField = document.getElementById("password");
        var toggleIcon = document.getElementById("togglePasswordIcon");
        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.classList.remove("bi-eye-slash");
            toggleIcon.classList.add("bi-eye");
        } else {
            passwordField.type = "password";
            toggleIcon.classList.remove("bi-eye");
            toggleIcon.classList.add("bi-eye-slash");
        }
    }
</script>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h3>SleekSilhouettes </h3>
            <p class="text-muted">Please login to your account</p>
        </div>
        <form action="loginService.jsp" method="post" onsubmit="return validateform()">
            <div class="mb-3">
                <label for="email" class="form-label">Email ID</label>
                <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp">
                <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password">
                    <span class="input-group-text" onclick="togglePasswordVisibility()">
                        <i class="bi bi-eye-slash" id="togglePasswordIcon"></i>
                    </span>
                </div>
            </div>
            <div class="text-end mt-3">
                <a href="forgotpass.jsp">Forgot your password?</a>
            </div>
            <input type="submit" value="Sign in" class="btn btn-primary">
            <div class="text-center mt-3">
                <a href="register.jsp">No account yet? Create one</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
