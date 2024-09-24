package bean;

import java.sql.Timestamp;

public class FeedbackBean {
	private int feedbackId; // Changed to camelCase
	private String email;
	private String comments;
	private Timestamp createdAt; // Changed to camelCase

	public FeedbackBean() {
		super();
	}

	public FeedbackBean(int feedbackId, String email, String comments, Timestamp createdAt) {
		super();
		this.feedbackId = feedbackId;
		this.email = email;
		this.comments = comments;
		this.createdAt = createdAt;
	}

	public int getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(int feedbackId) {
		this.feedbackId = feedbackId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "FeedbackBean [feedbackId=" + feedbackId + ", email=" + email + ", comments=" + comments + ", createdAt="
				+ createdAt + "]";
	}
}
