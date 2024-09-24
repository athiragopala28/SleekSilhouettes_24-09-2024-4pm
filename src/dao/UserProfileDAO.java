package dao;

import bean.UserProfileBean;
import dbconnection.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserProfileDAO {

	// Method to retrieve a user profile by email
	public UserProfileBean getUserByEmail(String email) {
		UserProfileBean userProfile = null;

		// First, try to retrieve the user from the profiles table
		userProfile = getUserFromProfilesTable(email);

		// If user is not found in profiles table, try retrieving from users table
		if (userProfile == null) {
			userProfile = getUserFromUsersTable(email);
		}

		return userProfile;
	}

	// Method to retrieve a user from the profiles table
	private UserProfileBean getUserFromProfilesTable(String email) {
		UserProfileBean userProfile = null;
		String query = "SELECT * FROM profile WHERE email = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, email);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					userProfile = new UserProfileBean();
					userProfile.setEmail(rs.getString("email"));
					userProfile.setFullName(rs.getString("name"));
					userProfile.setPhone(rs.getString("phone"));
					userProfile.setAddress(rs.getString("address"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userProfile;
	}

	// Method to retrieve a user from the users table
	private UserProfileBean getUserFromUsersTable(String email) {
		UserProfileBean userProfile = null;
		String query = "SELECT * FROM users WHERE email = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, email);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					userProfile = new UserProfileBean();
					userProfile.setEmail(rs.getString("email"));
					userProfile.setFullName(rs.getString("name"));
					userProfile.setPhone(rs.getString("phone"));
					// Address may not be available in the users table, set it to null or a default
					// value
					userProfile.setAddress(null);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userProfile;
	}

	public boolean emailExists(String email) {
		boolean exists = false;
		String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, email);

			try (ResultSet resultSet = statement.executeQuery()) {
				if (resultSet.next() && resultSet.getInt(1) > 0) {
					exists = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return exists;
	}

	public boolean insertOrUpdateUserProfile(UserProfileBean userProfile) {
		boolean isInsertedOrUpdated = false;
		String checkQuery = "SELECT COUNT(*) FROM profile WHERE email = ?";
		String insertQuery = "INSERT INTO profile (email, name, phone, address) VALUES (?, ?, ?, ?)";
		String updateQuery = "UPDATE profile SET name = ?, phone = ?, address = ? WHERE email = ?";

		try (Connection conn = DBConnection.getConnection()) {

			// Check if the user profile already exists
			try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
				checkStmt.setString(1, userProfile.getEmail());
				try (ResultSet rs = checkStmt.executeQuery()) {
					if (rs.next() && rs.getInt(1) > 0) {
						// User exists, update the profile
						try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
							updateStmt.setString(1, userProfile.getFullName());
							updateStmt.setString(2, userProfile.getPhone());
							updateStmt.setString(3, userProfile.getAddress());
							updateStmt.setString(4, userProfile.getEmail());

							int rowsAffected = updateStmt.executeUpdate();
							isInsertedOrUpdated = rowsAffected > 0;
						}
					} else {
						// User does not exist, insert a new profile
						try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
							insertStmt.setString(1, userProfile.getEmail());
							insertStmt.setString(2, userProfile.getFullName());
							insertStmt.setString(3, userProfile.getPhone());
							insertStmt.setString(4, userProfile.getAddress());

							int rowsAffected = insertStmt.executeUpdate();
							isInsertedOrUpdated = rowsAffected > 0;
						}
					}
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isInsertedOrUpdated;
	}

	public boolean updatePassword(String email, String hashedPassword) {
		boolean isUpdated = false;
		String updateQuery = "UPDATE users SET password = ? WHERE email = ?";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
			pstmt.setString(1, hashedPassword);
			pstmt.setString(2, email);

			int rowsAffected = pstmt.executeUpdate();
			isUpdated = rowsAffected > 0; // Returns true if the update was successful
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return isUpdated;
	}
}
