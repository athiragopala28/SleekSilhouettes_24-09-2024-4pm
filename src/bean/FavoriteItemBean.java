package bean;

public class FavoriteItemBean {
	private int favoriteId;
	private int userId;
	private int productId;
	private String userEmail;
	private String productName;
	private String collectionName;
	private String description;
	private int priceFrom;
	private int priceTo;
	private String image1;
	private String image2;
	private String image3;

	public FavoriteItemBean() {
		super();
	}

	public FavoriteItemBean(int favoriteId, int userId, int productId, String userEmail, String productName,
			String collectionName, String description, int priceFrom, int priceTo, String image1, String image2,
			String image3) {
		super();
		this.favoriteId = favoriteId;
		this.userId = userId;
		this.productId = productId;
		this.userEmail = userEmail;
		this.productName = productName;
		this.collectionName = collectionName;
		this.description = description;
		this.priceFrom = priceFrom;
		this.priceTo = priceTo;
		this.image1 = image1;
		this.image2 = image2;
		this.image3 = image3;
	}

	@Override
	public String toString() {
		return "FavoriteItemBean [favoriteId=" + favoriteId + ", userId=" + userId + ", productId=" + productId
				+ ", userEmail=" + userEmail + ", productName=" + productName + ", collectionName=" + collectionName
				+ ", description=" + description + ", priceFrom=" + priceFrom + ", priceTo=" + priceTo + ", image1="
				+ image1 + ", image2=" + image2 + ", image3=" + image3 + "]";
	}

	public int getFavoriteId() {
		return favoriteId;
	}

	public void setFavoriteId(int favoriteId) {
		this.favoriteId = favoriteId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getCollectionName() {
		return collectionName;
	}

	public void setCollectionName(String collectionName) {
		this.collectionName = collectionName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPriceFrom() {
		return priceFrom;
	}

	public void setPriceFrom(int priceFrom) {
		this.priceFrom = priceFrom;
	}

	public int getPriceTo() {
		return priceTo;
	}

	public void setPriceTo(int priceTo) {
		this.priceTo = priceTo;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}
}
