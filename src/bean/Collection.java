package bean;
public class Collection {
    private int id;
    private String collectionName;
    private java.sql.Timestamp createdAt;
    

    // Default constructor
    public Collection() {
    }

    // Parameterized constructor
    public Collection(int id, String collectionName, java.sql.Timestamp createdAt) {
        this.id = id;
        this.collectionName = collectionName;
        this.createdAt = createdAt;
    }

    // Getter and Setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for collectionName
    public String getCollectionName() {
        return collectionName;
    }

    public void setCollectionName(String collectionName) {
        this.collectionName = collectionName;
    }

    // Getter and Setter for createdAt
    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Optional: Override toString() for easy debugging and logging
    @Override
    public String toString() {
        return "Collection [id=" + id + ", collectionName=" + collectionName + ", createdAt=" + createdAt + "]";
    }

	public static void collection_id(int i) {
		// TODO Auto-generated method stub
		
	}

	public static void collection_name(String string) {
		// TODO Auto-generated method stub
		
	}
}
