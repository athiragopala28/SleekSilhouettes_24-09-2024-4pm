package dao;

import java.sql.*;
import bean.ContactBean;
import dbconnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.MaterialBean;
import dbconnection.DBConnection;


public class ContactDao {


    // Insert a new contact into the database
    public boolean saveContact(ContactBean contact) {
        String query = "INSERT INTO contact (name, email, message, created_at) VALUES (?, ?, ?, NOW())";
        boolean isSuccess = false;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, contact.getName());
            statement.setString(2, contact.getEmail());
            statement.setString(3, contact.getMessage());
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    // Additional methods like getContactByEmail and getAllContacts can be here...

	// Method to get a contact message by its ID (if needed)
	public ContactBean getContactById(int contactId) throws SQLException {
		String query = "SELECT * FROM contact WHERE contact_id = ?";
		ContactBean contact = null;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {

			statement.setInt(1, contactId);
			ResultSet resultSet = statement.executeQuery();

			if (resultSet.next()) {
				contact = new ContactBean();
				contact.setId(resultSet.getInt("contact_id"));
				contact.setName(resultSet.getString("name"));
				contact.setEmail(resultSet.getString("email"));
				contact.setMessage(resultSet.getString("message"));
				contact.setCreatedAt(resultSet.getTimestamp("created_at"));
			}
		}

		return contact;
	}

	// Method to get all contact messages (if needed)
	public List<ContactBean> getAllContacts() throws SQLException {
		String query = "SELECT * FROM contact";
		List<ContactBean> contacts = new ArrayList<>();

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query);
				ResultSet resultSet = statement.executeQuery()) {

			while (resultSet.next()) {
				ContactBean contact = new ContactBean();
				contact.setId(resultSet.getInt("contact_id"));
				contact.setName(resultSet.getString("name"));
				contact.setEmail(resultSet.getString("email"));
				contact.setMessage(resultSet.getString("message"));
				contact.setCreatedAt(resultSet.getTimestamp("created_at"));
				contacts.add(contact);
			}
		}

		return contacts;
	}

	// Method to get the count of contact messages (if needed)
	public int getContactCount() throws SQLException {
		String query = "SELECT COUNT(*) AS count FROM contact";
		int count = 0;

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement statement = connection.prepareStatement(query);
				ResultSet resultSet = statement.executeQuery()) {

			if (resultSet.next()) {
				count = resultSet.getInt("count");
			}
		}

		return count;
	}
}
