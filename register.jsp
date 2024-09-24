<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<title>SleekSilhouettes</title>
<style>
body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background-color: gray;
}

.login-container {
	max-width: 400px;
	width: 100%;
	padding: 2rem;
	background-color: silver;
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
		var name = document.getElementById("name").value;
		var phoneNumber = document.getElementById("phone").value;
		var email = document.getElementById("email").value;
		var password = document.getElementById("password").value;
		var confirmPassword = document.getElementById("cpassword").value;
		var namePattern = /^[A-Z][a-zA-Z-' ]+$/;

		var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]{8,12}$/;
		var phonePattern = /^[0-9]{10}$/;

		if (name === "") {
			alert("Name required");
			document.getElementById("name").focus();
			return false;
		}
		if (!namePattern.test(name)) {
			alert("Please enter a valid name");
			document.getElementById("name").focus();
			return false;
		}
		if (phoneNumber === "") {
			alert("Phone Number required");
			document.getElementById("phone").focus();
			return false;
		}
		if (!phonePattern.test(phoneNumber)) {
			alert("Please enter a valid 10-digit phone number.");
			document.getElementById("phone").focus();
			return false;
		}
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
		if (password !== confirmPassword) {
			alert("Passwords do not match.");
			document.getElementById("cpassword").focus();
			return false;
		}
		return true;
	}

	function togglePasswordVisibility(fieldId, iconId) {
		var passwordField = document.getElementById(fieldId);
		var toggleIcon = document.getElementById(iconId);
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
			<h3>SleekSilhouettes</h3>
			<p class="text-muted">Please register for your account</p>
		</div>
		<form action="registerService.jsp" method="" onsubmit="return validateform()">
			<div class="mb-3">
				<label for="name" class="form-label">Name</label> <input type="text"
					class="form-control" id="name" name="name">
			</div>
			<div class="mb-3">
				<label for="phone" class="form-label">Phone Number</label> <input
					type="text" class="form-control" id="phone" name="phone">
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">Email ID</label> <input
					type="email" class="form-control" id="email" name="email"
					aria-describedby="emailHelp">
				<div id="emailHelp" class="form-text">We'll never share your
					email with anyone else.</div>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">Password</label>
				<div class="input-group">
					<input type="password" class="form-control" id="password"
						name="password"> <span class="input-group-text"
						onclick="togglePasswordVisibility('password', 'togglePasswordIcon')">
						<i class="bi bi-eye-slash" id="togglePasswordIcon"></i>
					</span>
				</div>
			</div>
			<div class="mb-3">
				<label for="cpassword" class="form-label">Confirm Password</label>
				<div class="input-group">
					<input type="password" class="form-control" id="cpassword"
						name="cpassword"> <span class="input-group-text"
						onclick="togglePasswordVisibility('cpassword', 'toggleConfirmPasswordIcon')">
						<i class="bi bi-eye-slash" id="toggleConfirmPasswordIcon"></i>
					</span>
				</div>
			</div>

			<input type="submit" value="Register"
				class="btn btn-primary btn-custom">
			<div class="text-center mt-3">
				<a href="login.jsp">Already have an account? Login</a>
			</div>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
