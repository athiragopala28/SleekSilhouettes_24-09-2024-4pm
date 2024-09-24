package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.FavoriteItemBean;
import dbconnection.DBConnection;

public class FavoriteDAO {

	// Add a favorite item for a user
	public boolean addFavorite(int userId, int productId) {
		String sql = "INSERT INTO favorite_items (user_id, product_id) VALUES (?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, userId);
			pstmt.setInt(2, productId);
			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Remove a favorite item for a user
	public boolean removeFavorite(int userId, int productId) {
		String sql = "DELETE FROM favorite_items WHERE user_id = ? AND product_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, productId);
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Get a list of favorite product IDs for a user
	public List<Integer> getFavoriteProductIds(int userId) {
		List<Integer> productIds = new ArrayList<>();
		String query = "SELECT product_id FROM favorite_items WHERE user_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setInt(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					productIds.add(rs.getInt("product_id"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return productIds;
	}

	// Get a list of favorite items for a user
	public List<FavoriteItemBean> getFavoriteItems(int userId) {
		List<FavoriteItemBean> favoriteItems = new ArrayList<>();
		String query = "SELECT f.favorite_id, f.user_id, f.product_id, p.product_name, p.collection_name, p.description, p.price_from, p.price_to, p.image1, p.image2, p.image3 "
				+ "FROM favorite_items f " + "JOIN products p ON f.product_id = p.product_id " + "WHERE f.user_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setInt(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					FavoriteItemBean item = new FavoriteItemBean();
					item.setFavoriteId(rs.getInt("favorite_id"));
					item.setUserId(rs.getInt("user_id"));
					item.setProductId(rs.getInt("product_id"));
					item.setProductName(rs.getString("product_name"));
					item.setCollectionName(rs.getString("collection_name"));
					item.setDescription(rs.getString("description"));
					item.setPriceFrom(rs.getInt("price_from"));
					item.setPriceTo(rs.getInt("price_to"));
					item.setImage1(rs.getString("image1"));
					item.setImage2(rs.getString("image2"));
					item.setImage3(rs.getString("image3"));
					favoriteItems.add(item);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return favoriteItems;
	}
}
