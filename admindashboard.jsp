<%@page import="dao.ProductDao"%>
<%@page import="dao.CollectionDao"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.FeedbackDao"%>
<%@page import="dao.OrderDAO"%>
<!-- Import OrderDao -->
<%@page import="java.sql.SQLException"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.ServletException"%>

<%
	HttpSession httpsession = request.getSession(false);
	if (httpsession != null) {
		String userEmail = (String) httpsession.getAttribute("email");
		String userRole = (String) httpsession.getAttribute("role");

		if (userEmail == null || userRole == null) {
			response.sendRedirect("login.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<style>
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.navbar-brand {
	flex-grow: 1;
	font-size: 1.5rem;
	text-align: left;
}

.navbar-nav .nav-item {
	margin-right: 10px;
}

.icon-color {
	color: #000000;
}

.btn-black {
	color: #000000;
	border-color: #000000;
	background-color: #ffffff;
}

.btn-black:hover {
	color: #000000;
	background-color: #f0f0f0;
	border-color: #000000;
}

.btn-search {
	color: #000000;
	border-color: #000000;
	background-color: #ffffff;
}

.btn-search:hover {
	color: #000000;
	background-color: #f0f0f0;
	border-color: #000000;
}

.form-control {
	border-color: #4caf50;
}

.card {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-body {
	padding: 20px;
}

footer {
	background-color: #001f3f;
	padding: 20px 0;
	color: #ffffff;
	border-top: 1px solid #dee2e6;
	margin-top: auto;
}

.footer-content {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	flex-wrap: wrap;
}

.footer-section {
	flex: 1;
	min-width: 200px;
}

.footer-section h5 {
	font-weight: bold;
	margin-bottom: 15px;
}

.footer-section ul {
	list-style: none;
	padding: 0;
}

.footer-section ul li {
	margin-bottom: 10px;
}

.footer-section a {
	color: #ffffff;
	text-decoration: none;
}

.footer-section a:hover {
	text-decoration: underline;
}

.social-icons a {
	color: #ffffff;
	font-size: 20px;
	margin-right: 10px;
}

.social-icons a:hover {
	color: #adb5bd;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Sleek Silhouettes</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<!-- Existing Dropdowns -->
					<!-- Collections Dropdown -->
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="categoryDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Collections</button>
						<ul class="dropdown-menu" aria-labelledby="categoryDropdown">
							<li><a class="dropdown-item" href="addcollections.jsp">Add
									Collections</a></li>
							<li><a class="dropdown-item" href="viewcollections.jsp">View
									Collections</a></li>
						</ul>
					</li>
					<!-- Material Dropdown -->
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="materialDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Materials</button>
						<ul class="dropdown-menu" aria-labelledby="materialDropdown">
							<li><a class="dropdown-item" href="addmaterial.jsp">Add
									Material</a></li>
							<li><a class="dropdown-item" href="viewmaterial.jsp">View
									Material</a></li>
						</ul>
					</li>
					<!-- Product Dropdown -->
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="productDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Product</button>
						<ul class="dropdown-menu" aria-labelledby="productDropdown">
							<li><a class="dropdown-item" href="addproduct.jsp">Add
									Product</a></li>
							<li><a class="dropdown-item" href="viewProduct.jsp">View
									Product</a></li>
						</ul>
					</li>
					<!-- Customers Dropdown -->
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="customersDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Customers</button>
						<ul class="dropdown-menu" aria-labelledby="customersDropdown">
							<li><a class="dropdown-item" href="viewusers.jsp">View
									Users</a></li>
						</ul>
					</li>
					<!-- Feedback Dropdown -->
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="feedbackDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Feedback</button>
						<ul class="dropdown-menu" aria-labelledby="feedbackDropdown">
							<li><a class="dropdown-item" href="Viewfeedback.jsp">View
									Feedback</a></li>
						</ul>
					</li>
					<!-- Orders Dropdown -->
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="ordersDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Orders</button>
						<ul class="dropdown-menu" aria-labelledby="ordersDropdown">
							<li><a class="dropdown-item" href="vieworders.jsp">View
									Orders</a></li>
							<li><a class="dropdown-item" href="manageorders.jsp">Manage
									Orders</a></li>
						</ul>
					</li>
				</ul>
				<form class="d-flex me-3" role="search" action="SearchResults.jsp"
					method="get">
					<input class="form-control me-2" type="search" name="query"
						placeholder="Search Sleek Silhouettes" aria-label="Search">
					<button class="btn btn-search" type="submit">Search</button>
				</form>

				<a href="logout.jsp">
					<button type="button" class="btn btn-black">LogOut</button>
				</a>
			</div>
		</div>
	</nav>
	<br>
	<br>
	<br>
	<br>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<div class="text-content">
							<h5 class="card-title">Total Registered Users</h5>
							<p class="card-text">
								<%
									UserDao userDao = new UserDao();
									int usersCount = 0;
									try {
										usersCount = userDao.getUserCount();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								%>
								<%=usersCount%>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<div class="text-content">
							<h5 class="card-title">Total Collections</h5>
							<p class="card-text">
								<%
									CollectionDao collectionDao = new CollectionDao();
									int collectionCount = 0;
									try {
										collectionCount = collectionDao.getCollectionCount();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								%>
								<%=collectionCount%>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<div class="text-content">
							<h5 class="card-title">Total Products</h5>
							<p class="card-text">
								<%
									ProductDao productDao = new ProductDao();
									int productCount = 0;
									try {
										productCount = productDao.getProductCount();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								%>
								<%=productCount%>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<div class="text-content">
							<h5 class="card-title">Order Placed</h5>
							<p class="card-text">20</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script
			src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
