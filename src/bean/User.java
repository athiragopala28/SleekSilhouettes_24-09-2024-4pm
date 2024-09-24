package bean;

import java.sql.Timestamp;

public class User {

    private int usersId;
    private String name;
    private String phone;
    private String email;
    private String password;
    private String address;
	public int getUsersId() {
		return usersId;
	}
	public void setUsersId(int usersId) {
		this.usersId = usersId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "User [usersId=" + usersId + ", name=" + name + ", phone=" + phone + ", email=" + email + ", password="
				+ password + ", address=" + address + ", getUsersId()=" + getUsersId() + ", getName()=" + getName()
				+ ", getPhone()=" + getPhone() + ", getEmail()=" + getEmail() + ", getPassword()=" + getPassword()
				+ ", getAddress()=" + getAddress() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
	
}
    