<%@ page import="java.util.List" %>
<%@ page import="bean.Product" %>
<%@ page import="dao.ProductDao" %>

<%
    ProductDao productDao = new ProductDao();
    List<Product> products = productDao.getAllProducts();
%>

<!-- Product Card Start -->
<div class="container mt-4">
    <div class="row">
        <% for (Product product : products) { %>
            <div class="col-md-4">
                <div class="card card-custom">
                    <img src="<%= product.getImageUrl() %>" class="card-img-top" alt="Product Image" height="610px">
                    <div class="card-body">
                        <h5 class="card-title"><%= product.getProductName() %></h5>
                        <p class="card-text">&#x20B9; <%= product.getPrice() %></p>
                        <div class="d-flex justify-content-center">
                            <a href="#" class="btn btn-outline-danger btn-custom">
                                <i class="fas fa-heart"></i>
                            </a>
                             <a href="AddToCart.jsp?productId=<%= product.getId() %>&quantity=1" class="btn btn-outline-primary btn-custom">
                                <i class="fas fa-shopping-cart"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</div>
