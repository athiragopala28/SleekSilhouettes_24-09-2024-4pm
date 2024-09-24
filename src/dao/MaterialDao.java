package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.MaterialBean;
import dbconnection.DBConnection;

public class MaterialDao {

	// Get a database connection
	private Connection getConnection() throws SQLException {
		return DBConnection.getConnection();
	}

	public boolean addMaterial(MaterialBean material) throws SQLException {
		String query = "INSERT INTO materials (material_name, material_type, description) VALUES (?, ?, ?)";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, material.getName());
			stmt.setString(2, material.getType());
			stmt.setString(3, material.getDescription());

			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		}
	}

	// Retrieve all materials
	public List<MaterialBean> getAllMaterials() {
		String query = "SELECT * FROM materials";
		List<MaterialBean> materials = new ArrayList<>();
		try (Connection conn = getConnection();
				PreparedStatement stmt = conn.prepareStatement(query);
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				MaterialBean material = new MaterialBean();
				material.setMaterialId(rs.getInt("id"));
				material.setName(rs.getString("material_name"));
				material.setType(rs.getString("material_type"));
				material.setDescription(rs.getString("description"));
				materials.add(material);
			}

		} catch (SQLException e) {
			System.err.println("SQL Exception in getAllMaterials: " + e.getMessage());
			e.printStackTrace();
		}
		return materials;
	}

	// Retrieve a material by its ID
	public MaterialBean getMaterialById(int id) {
		String query = "SELECT * FROM materials WHERE id = ?";
		MaterialBean material = null;
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setInt(1, id);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					material = new MaterialBean();
					material.setMaterialId(rs.getInt("id"));
					material.setName(rs.getString("material_name"));
					material.setType(rs.getString("material_type"));
					material.setDescription(rs.getString("description"));
				}
			}

		} catch (SQLException e) {
			System.err.println("SQL Exception in getMaterialById: " + e.getMessage());
			e.printStackTrace();
		}
		return material;
	}

	// Update an existing material
	public boolean updateMaterial(MaterialBean material) {
		String query = "UPDATE materials SET material_name = ?, material_type = ?, description = ? WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setString(1, material.getName());
			stmt.setString(2, material.getType());
			stmt.setString(3, material.getDescription());
			stmt.setInt(4, material.getMaterialId());

			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;

		} catch (SQLException e) {
			System.err.println("SQL Exception in updateMaterial: " + e.getMessage());
			e.printStackTrace();
		}
		return false;
	}

	// Delete a material by ID
	public boolean deleteMaterial(int id) throws SQLException {
		String query = "DELETE FROM materials WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setInt(1, id);
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;

		} catch (SQLException e) {
			System.err.println("SQL Exception in deleteMaterial: " + e.getMessage());
			e.printStackTrace();
			throw e;
		}
	}

	// Search materials by name or type
	public List<MaterialBean> searchMaterials(String query) {
		String sql = "SELECT * FROM materials WHERE material_name LIKE ? OR material_type LIKE ?";
		List<MaterialBean> materials = new ArrayList<>();
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, "%" + query + "%");
			stmt.setString(2, "%" + query + "%");
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					MaterialBean material = new MaterialBean();
					material.setMaterialId(rs.getInt("id"));
					material.setName(rs.getString("material_name"));
					material.setType(rs.getString("material_type"));
					material.setDescription(rs.getString("description"));
					materials.add(material);
				}
			}
		} catch (SQLException e) {
			System.err.println("SQL Exception in searchMaterials: " + e.getMessage());
			e.printStackTrace();
		}
		return materials;
	}
}
