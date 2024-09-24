<%@ page import="bean.FavoriteItemBean" %>
<%@ page import="dao.FavoriteDAO" %>
<%@ page import="bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>


<%
    // Retrieve the current user object (replace with actual user retrieval logic)
    HttpSession httpsession = request.getSession();
    User user = (User) httpsession.getAttribute("user"); // Retrieve user from session
    if (user == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
        return;
    }

    int userId = user.getUsersId(); // Get user ID

    // Create an instance of FavoriteDAO
    FavoriteDAO favoriteDAO = new FavoriteDAO();

    // Get the list of favorite items for the current user
    List<FavoriteItemBean> favoriteItems = favoriteDAO.getFavoriteItems(userId);

    // Check if the list is not empty
    if (favoriteItems != null && !favoriteItems.isEmpty()) {
%>
    <div class="container mt-4">
        <h2 class="mb-4">Your Favorite Items</h2>
        <div class="row">
            <% for (FavoriteItemBean item : favoriteItems) { %>
                <div class="col-md-4 mb-4">
                    <div class="card shadow-sm">
                        <img src="<%= item.getImage1() %>" class="card-img-top"
                             alt="<%= item.getProductName() %> Image"
                             style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title"><%= item.getProductName() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted"><%= item.getCollectionName() %></h6>
                            <p class="card-text"><%= item.getDescription() %></p>
                            <p class="card-text">
                                Price Range: ₹<%= item.getPriceFrom() %> - ₹<%= item.getPriceTo() %>
                            </p>
                            <!-- Form to remove the item from favorites -->
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
