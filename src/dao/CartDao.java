package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.CartBean;
import dbconnection.DBConnection;



	public class CartDao {

	    private Connection getConnection() throws SQLException {
	        return DBConnection.getConnection();
	    }

	    // Add item to cart
	    public boolean addToCart(CartBean cartItem) {
	        String query = "INSERT INTO cart (user_email, product_name, quantity, amount) VALUES (?, ?, ?, ?)";
	        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
	            stmt.setString(1, cartItem.getUserEmail());
	            stmt.setString(2, cartItem.getProductName());
	            stmt.setInt(3, cartItem.getQuantity());
	            stmt.setDouble(4, cartItem.getAmount());
	            int rowsAffected = stmt.executeUpdate();
	            return rowsAffected > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	    // Retrieve all items in the cart for a user
	    public List<CartBean> getCartItems(String userEmail) {
	        String query = "SELECT * FROM cart WHERE user_email = ?";
	        List<CartBean> cartItems = new ArrayList<>();
	        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
	            stmt.setString(1, userEmail);
	            try (ResultSet rs = stmt.executeQuery()) {
	                while (rs.next()) {
	                    CartBean cartItem = new CartBean();
	                    cartItem.setCartId(rs.getInt("cart_id"));
	                    cartItem.setUserEmail(rs.getString("user_email"));
	                    cartItem.setProductName(rs.getString("product_name"));
	                    cartItem.setQuantity(rs.getInt("quantity"));
	                    cartItem.setAmount(rs.getDouble("amount"));
	                    cartItem.setAddedDate(rs.getTimestamp("added_date"));
	                    cartItems.add(cartItem);
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return cartItems;
	    }

	    public boolean removeCartItem(String userEmail, String productName) {
	        String query = "DELETE FROM cart WHERE user_email = ? AND product_name = ?";

	        try (Connection conn = getConnection();
	        		PreparedStatement pstmt = conn.prepareStatement(query)) {
	            pstmt.setString(1, userEmail);
	            pstmt.setString(2, productName);
	            return pstmt.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	    public List<CartBean> getCartItemsByUserEmail(String userEmail) {
	        List<CartBean> cartItems = new ArrayList<>();
	        String query = "SELECT product_name, quantity, amount FROM cart WHERE user_email = ?";

	        try (Connection conn = getConnection();
	        		PreparedStatement pstmt = conn.prepareStatement(query)) {
	            pstmt.setString(1, userEmail);
	            ResultSet rs = pstmt.executeQuery();

	            while (rs.next()) {
	                CartBean cartItem = new CartBean();
	                cartItem.setProductName(rs.getString("product_name"));
	                cartItem.setQuantity(rs.getInt("quantity"));
	                cartItem.setAmount(rs.getDouble("amount"));
	                cartItems.add(cartItem);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return cartItems;
	    }
	    public CartBean getCartItemByUserEmailAndProductName(String userEmail, String productName) {
	        CartBean cartItem = null;
	        String query = "SELECT quantity, amount FROM cart WHERE user_email = ? AND product_name = ?";

	        try (Connection conn = getConnection();
	        		PreparedStatement pstmt = conn.prepareStatement(query)) {
	            pstmt.setString(1, userEmail);
	            pstmt.setString(2, productName);
	            ResultSet rs = pstmt.executeQuery();

	            if (rs.next()) {
	                cartItem = new CartBean();
	                cartItem.setQuantity(rs.getInt("quantity"));
	                cartItem.setAmount(rs.getDouble("amount")); // Use double
	                cartItem.setProductName(productName);
	                cartItem.setUserEmail(userEmail);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return cartItem;
	    }
	    
	    public boolean updateCartItem(CartBean cartItem) {
	        String query = "UPDATE cart SET quantity = ?, amount = ? WHERE user_email = ? AND product_name = ?";

	        try (Connection conn = getConnection();
	        		PreparedStatement pstmt = conn.prepareStatement(query)) {
	            pstmt.setInt(1, cartItem.getQuantity());
	            pstmt.setDouble(2, cartItem.getAmount());
	            pstmt.setString(3, cartItem.getUserEmail());
	            pstmt.setString(4, cartItem.getProductName());
	            return pstmt.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    public boolean clearCart(String userEmail) {
	        String query = "DELETE FROM cart WHERE userEmail = ?";

	        try (Connection conn = getConnection();
	        		PreparedStatement pstmt = conn.prepareStatement(query)) {
	            pstmt.setString(1, userEmail);
	            int rowsAffected = pstmt.executeUpdate();
	            return rowsAffected > 0; // Returns true if rows were deleted
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false; // Return false if an error occurs
	        }
	    }


	}


