package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Product;
import dbconnection.DBConnection;

public class ProductDao {

	public boolean insertProduct(Product product) {
		String query = "INSERT INTO products (product_name, collection_id, collection_name, price, image_url, description) VALUES (?, ?, ?, ?, ?, ?)";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setString(1, product.getProductName());
			statement.setInt(2, product.getCollectionId());

			// Fetch collection name based on collection_id
			String collectionName = getCollectionNameById(product.getCollectionId());
			if (collectionName == null) {
				throw new SQLException("Collection name not found for ID: " + product.getCollectionId());
			}
			statement.setString(3, collectionName);

			statement.setInt(4, product.getPrice());
			statement.setString(5, product.getImageUrl());
			statement.setString(6, product.getDescription());

			int rowsAffected = statement.executeUpdate();
			return rowsAffected > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	private String getCollectionNameById(int collectionId) {
		String query = "SELECT collection_name FROM collections WHERE collections_Id = ?";
		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, collectionId);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				return resultSet.getString("collection_name");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Product> getAllProducts() {
		String query = "SELECT * FROM products";
		List<Product> products = new ArrayList<>();

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query);
				ResultSet resultSet = statement.executeQuery()) {

			while (resultSet.next()) {
				Product product = new Product();
				product.setId(resultSet.getInt("id"));

				product.setProductName(resultSet.getString("product_name"));
				product.setCollectionId(resultSet.getInt("collection_id"));
				product.setCollectionName(resultSet.getString("collection_name"));
				product.setPrice(resultSet.getInt("price"));
				product.setImageUrl(resultSet.getString("image_url"));
				product.setDescription(resultSet.getString("description"));

				products.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return products;
	}

	public Product getProductById(int productId) {
		String query = "SELECT * FROM products WHERE id = ?";
		Product product = null;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, productId);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				// Create a Product object from the result set
				product = new Product();
				product.setId(resultSet.getInt("id"));
				product.setProductName(resultSet.getString("product_name"));
				product.setCollectionId(resultSet.getInt("collection_id"));
				product.setCollectionName(resultSet.getString("collection_name"));
				product.setPrice(resultSet.getInt("price"));
				product.setImageUrl(resultSet.getString("image_url"));
				product.setDescription(resultSet.getString("description"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return product;
	}

	public boolean updateProduct(int productId, String productName, String collection, double price, String imageUrl,
			String description) {
		String query = "UPDATE products SET product_name = ?, collection_name = ?, price = ?, image_url = ?, description = ? WHERE id = ?";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setString(1, productName);
			statement.setString(2, collection);
			statement.setDouble(3, price);
			statement.setString(4, imageUrl);
			statement.setString(5, description);
			statement.setInt(6, productId);

			int rowsAffected = statement.executeUpdate();
			return rowsAffected > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	// Method to delete a product by its ID
	public boolean deleteProduct(int productId) {
		String query = "DELETE FROM products WHERE id = ?";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, productId);

			int rowsAffected = statement.executeUpdate();
			return rowsAffected > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	// Method to get the count of products
	public int getProductCount() throws SQLException {
		String query = "SELECT COUNT(*) FROM products";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement statement = conn.prepareStatement(query);
				ResultSet resultSet = statement.executeQuery()) {
			if (resultSet.next()) {
				return resultSet.getInt(1);
			}
		}
		return 0;
	}
}