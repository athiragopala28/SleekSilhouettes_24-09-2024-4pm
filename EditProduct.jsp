<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDao"%>
<%@ page import="dao.CollectionDao"%>
<%@ page import="bean.Product"%>
<%@ page import="bean.Collection"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Edit Product</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Edit Product</h2>
        <%
            HttpSession httpsession = request.getSession(false);
            if (httpsession != null) {
                String userEmail = (String) httpsession.getAttribute("email");
                if (userEmail != null) {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    ProductDao productDao = new ProductDao();
                    Product product = productDao.getProductById(productId);

                    if (product != null) {
                        // Fetch collections from the database
                        CollectionDao collectionDao = new CollectionDao();
                        List<Collection> collections = collectionDao.getAllCollections();
        %>
        <form action="UpdateProduct.jsp" method="post">
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <div class="mb-3">
                <label for="productName" class="form-label">Product Name</label>
                <input type="text" class="form-control" id="productName" name="productName" value="<%= product.getProductName() %>" required>
            </div>
            <div class="mb-3">
                <label for="collection" class="form-label">Select Collection</label>
                <select class="form-select" id="collection" name="collection" required>
                    <% 
                        for (Collection collection : collections) {
                            out.print("<option value=\"" + collection.getId() + "\" " +
                                (collection.getCollectionName().equals(product.getCollectionName()) ? "selected" : "") + ">" +
                                collection.getCollectionName() + "</option>");
                        }
                    %>
                </select>
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Price</label>
                <input type="text" class="form-control" id="price" name="price" value="<%= product.getPrice() %>" required>
            </div>
            <div class="mb-3">
                <label for="imageUrl" class="form-label">Product Image URL</label>
                <input type="url" class="form-control" id="imageUrl" name="imageUrl" value="<%= product.getImageUrl() %>" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="6" required><%= product.getDescription() %></textarea>
            </div>
             <button type="submit" class="btn btn-primary">Save Changes</button>
            <button type="button" class="btn btn-secondary" onclick="window.location.href='viewProduct.jsp'">Cancel</button>
 
            
        </form>
        <% 
                    } else { 
        %>
        <p class="text-center">Product not found.</p>
        <% 
                    } 
                } else { 
        %>
        <p class="text-center">You must be logged in to edit products.</p>
        <% 
                } 
            } else { 
        %>
        <p class="text-center">Session expired. Please log in again.</p>
        <% 
            } 
        %>
    </div>
</body>
</html>