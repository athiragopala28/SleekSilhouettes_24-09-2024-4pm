package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import bean.User;
import bean.UserProfileBean;
import dbconnection.DBConnection;

public class UserDao {

	 public void insertUser(User user) throws SQLException {
	        String query = "INSERT INTO users (name, phone, email, password, created_at) VALUES (?, ?, ?, ?, Now())";

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(query)) {

	            statement.setString(1, user.getName());
	            statement.setString(2, user.getPhone());
	            statement.setString(3, user.getEmail());
	            statement.setString(4, user.getPassword());
	            statement.executeUpdate();
	        }
	    }
	
	 
	 
	   public User getUserByEmail(String email) throws SQLException {
	        String query = "SELECT * FROM users WHERE email = ?";
	        User user = null;

	        try (Connection connection = DBConnection.getConnection();
	             PreparedStatement statement = connection.prepareStatement(query)) {

	            statement.setString(1, email);
	            ResultSet resultSet = statement.executeQuery();

	            if (resultSet.next()) {
	                user = new User();
	                user.setName(resultSet.getString("name"));
	                user.setPhone(resultSet.getString("phone"));
	                user.setEmail(resultSet.getString("email"));
	                user.setPassword(resultSet.getString("password"));
	            }
	        }

	        return user;
	    }
	   public List<User> getAllUsers() throws SQLException {
		    String query = "SELECT * FROM users";
		    List<User> users = new ArrayList<>();

		    try (Connection connection = DBConnection.getConnection();
		         PreparedStatement statement = connection.prepareStatement(query);
		         ResultSet resultSet = statement.executeQuery()) {

		        while (resultSet.next()) {
		            User user = new User();
		            user.setUsersId(resultSet.getInt("users_id"));
		            user.setName(resultSet.getString("name"));
		            user.setPhone(resultSet.getString("phone"));
		            user.setEmail(resultSet.getString("email"));
		            user.setPassword(resultSet.getString("password"));
		            users.add(user);
		        }
		    }
		    return users;
		
	   }
	   public int getUserCount() throws SQLException {
	        String query = "SELECT COUNT(*) AS count FROM users";
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

