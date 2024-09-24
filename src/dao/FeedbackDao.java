package dao;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSet;

import bean.FeedbackBean;
import dbconnection.DBConnection;
public class FeedbackDao {


	    // Method to insert feedback
	    public boolean insertFeedback(FeedbackBean feedback) {
	        boolean result = false;
	        String query = "INSERT INTO customer_feedback (email, comments, created_at) VALUES (?, ?, NOW())";

	        try (Connection conn = DBConnection.getConnection();
	             PreparedStatement stmt = (PreparedStatement) conn.prepareStatement(query)) {

	            stmt.setString(1, feedback.getEmail());
	            stmt.setString(2, feedback.getComments());
	            int rowsInserted = stmt.executeUpdate();
	            result = (rowsInserted > 0);

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return result;
	    }

	    // Optional: You might want to add additional methods to interact with feedback data
	    public List<FeedbackBean> getAllFeedback() {
	        List<FeedbackBean> feedbackList = new ArrayList<>();
	        String query = "SELECT * FROM customer_feedback";

	        try (Connection conn = DBConnection.getConnection();
	             PreparedStatement stmt = (PreparedStatement) conn.prepareStatement(query);
	             ResultSet rs = (ResultSet) stmt.executeQuery()) {
	        	 while (rs.next()) {
	                 FeedbackBean feedback = new FeedbackBean();
	                 feedback.setFeedbackId(rs.getInt("feedback_id"));
	                 feedback.setEmail(rs.getString("email"));
	                 feedback.setComments(rs.getString("comments"));
	                 feedback.setCreatedAt(rs.getTimestamp("created_at"));
	                 feedbackList.add(feedback);
	             
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return feedbackList;
	    }

}