<%@page import="dao.UserProfileDAO"%>
<%@page import="dao.UserDao"%>
<%@page import="bean.FavoriteItemBean"%>
<%@page import="java.util.List, dao.FavoriteDAO"%>
<%@page import="bean.User"%>
<%@page import="dao.ProductDao"%>

<%
    // Retrieve the current user object (replace with actual user retrieval logic)
    User user = new User(); // Replace with actual user retrieval logic
    FavoriteDAO favoriteDAO = new FavoriteDAO();

    // Ensure that the user is properly initialized and has a valid user ID
    int userId = user.getUsersId(); // Adjust if necessary to properly get the user ID

    // Get the list of favorite items for the current user
    List<FavoriteItemBean> favoriteItems = favoriteDAO.getFavoriteItems(userId); // Use userId to pass the actual user ID

    // Check if the list is not empty
    if (favoriteItems != null && !favoriteItems.isEmpty()) {
%>
    <div class="container mt-4">
        <h2 class="mb-4">Your Favorite Items</h2>
        <div class="row">
            <% for (FavoriteItemBean item : favoriteItems) { %>
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <img src="<%= item.getImage1() %>" class="card-img-top" alt="<%= item.getProductName() %> Image" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title"><%= item.getProductName() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted"><%= item.getCollectionName() %></h6>
                            <p class="card-text"><%= item.getDescription() %></p>
                            <p class="card-text">Price Range: ₹<%= item.getPriceFrom() %> - ₹<%= item.getPriceTo() %></p>
                            <!-- Optionally, you could add a button to remove the item from favorites -->
                            <form action="removeFavorite" method="post">
                                <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                                <button type="submit" class="btn btn-danger">Remove from Favorites</button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
<%
    } else {
        out.println("<div class='alert alert-warning'>You have no favorite items yet.</div>");
    }
%>
