<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
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

footer {
	background-color: #001f3f;
	padding: 40px 0;
	color: #ffffff;
	border-top: 1px solid #dee2e6;
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

.customer-feedback, .contact-us {
	background-color: #f0f0f0;
	padding: 20px;
	margin: 20px 0;
}
</style>
<title>Sleek Silhouettes</title>
</head>

<body>

	<!-- Navbar -->
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
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="womenDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Women</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="viewcollections.jsp">Collections</a></li>
							<li><a class="dropdown-item" href="viewmaterial.jsp">Materials</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="productsDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Products</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="viewProduct.jsp">Product
									Details</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<button class="btn btn-outline-black btn-black dropdown-toggle"
							type="button" id="customerCareDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">Customer Care</button>
						<ul class="dropdown-menu" aria-labelledby="customerCareDropdown">
							<li><a class="dropdown-item" href="feedback.jsp">Customer
									Feedback</a></li>
							<li><a class="dropdown-item" href="contact.jsp">Contact
									Us</a></li>
						</ul>
					</li>

				</ul>
				<form class="d-flex me-3" role="search" action="SearchResults.jsp"
					method="GET">
					<input class="form-control me-2" type="search" name="query"
						placeholder="Search Sleek Silhouettes" aria-label="Search">
					<button class="btn btn-search" type="submit">Search</button>
				</form>
				<div class="d-flex align-items-center gap-3">
					<a href="#" class="btn btn-outline-black icon-color"><i
						class="fas fa-heart"></i></a> <a href="login.jsp"
						class="btn btn-outline-black icon-color"><i
						class="fas fa-shopping-cart"></i></a> <a href="login.jsp"><button
							type="button" class="btn btn-black">Login/Register</button></a>
				</div>
			</div>
		</div>
	</nav>

	<!-- Carousel Section -->
	<div id="carouselExampleIndicators" class="carousel slide">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="./images/index1.jpg" class="d-block w-100" height="800px"
					alt="Slide 1">
			</div>
			<div class="carousel-item">
				<img src="./images/index2.jpg" class="d-block w-100" height="800px"
					alt="Slide 2">
			</div>
			<div class="carousel-item">
				<img src="./images/index3.jpg" class="d-block w-100" height="800px"
					alt="Slide 3">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>


	<footer>
		<div class="container">
			<div class="footer-content">
				<div class="footer-section">
					<h5>More About Shopping from Sleek Silhouettes</h5>
					<ul>
						<li><a href="#">Sleek Silhouettes</a></li>
						<li><a href="#">Join Our Team</a></li>
						<li><a href="#">Terms and Conditions</a></li>
						<li><a href="#">We Respect Your Privacy</a></li>
						<li><a href="#">Return and Refund Policy</a></li>
						<li><a href="#">FAQs</a></li>
					</ul>
				</div>
				<div class="footer-section">
					<h5>Customer Services</h5>
					<ul>
						<li><a href="#">Help & Support</a></li>
						<li><a href="#">Order Tracking</a></li>
						<li><a href="#">Shipping Information</a></li>
						<li><a href="#">Returns</a></li>
						<li><a href="#">Size Guide</a></li>
					</ul>
				</div>
				<div class="footer-section">
					<h5>Follow Us</h5>
					<div class="social-icons">
						<a href="#"><i class="fab fa-facebook"></i></a> <a href="#"><i
							class="fab fa-twitter"></i></a> <a href="#"><i
							class="fab fa-instagram"></i></a> <a href="#"><i
							class="fab fa-pinterest"></i></a>
					</div>
				</div>
			</div>
		</div>
		<div class="text-center mt-4">
			<p>&copy; 2024 Sleek Silhouettes. All rights reserved.</p>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
