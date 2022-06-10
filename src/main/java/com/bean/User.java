package com.bean;

public class User {
	private int id;
	private String username;
	private String nicheng;
	private String password;
	private Double balance;
	private String phone;
	private String address;
	private int level;
	private String create_time;
	private String head_sculpture;
	private String birthday;
	private String sex;
	public User(int id, String username, String nicheng, String password, Double balance, String phone, String address,
			int level, String create_time, String head_sculpture, String birthday, String sex) {
		this.id = id;
		this.username = username;
		this.nicheng = nicheng;
		this.password = password;
		this.balance = balance;
		this.phone = phone;
		this.address = address;
		this.level = level;
		this.create_time = create_time;
		this.head_sculpture = head_sculpture;
		this.birthday = birthday;
		this.sex = sex;
	}
	
	public User(String username,String password,String phone) {
		this.username=username;
		this.password=password;
		this.phone=phone;
		// TODO Auto-generated constructor stub
	}
	public User() {}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNicheng() {
		return nicheng;
	}
	public void setNicheng(String nicheng) {
		this.nicheng = nicheng;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Double getBalance() {
		return balance;
	}
	public void setBalance(Double balance) {
		this.balance = balance;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getHead_sculpture() {
		return head_sculpture;
	}
	public void setHead_sculpture(String head_sculpture) {
		this.head_sculpture = head_sculpture;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	
}
	
	