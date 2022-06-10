package com.bean;

public class Address {
	private int aid;
	private int id;
	private String addressee;
	private String addressee_phone;
	private String receiving_address;
	
	
	
	public Address(int aid, int id,String addressee,String addressee_phone,String receiving_address) {
		this.aid=aid;
		this.id=id;		
		this.addressee=addressee;
		this.addressee_phone=addressee_phone;
		this.receiving_address=receiving_address;
		// TODO Auto-generated constructor stub
	}
	public Address() {}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAddressee() {
		return addressee;
	}
	public void setAddressee(String addressee) {
		this.addressee = addressee;
	}
	public String getAddressee_phone() {
		return addressee_phone;
	}
	public void setAddressee_phone(String addressee_phone) {
		this.addressee_phone = addressee_phone;
	}
	public String getReceiving_address() {
		return receiving_address;
	}
	public void setReceiving_address(String receiving_address) {
		this.receiving_address = receiving_address;
	}
	
	

}
