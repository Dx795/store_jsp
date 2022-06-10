package com.bean;

public class Cart {
	public int scid;
	public String img;
	public String gname;
	public double price;
	public int num;
	public int stock;
	public int gid;
	public int mid;
	public int valid;
	public int cid;
	public Cart() {
		super();
	}
	
	public Cart( String img, String gname, double price, int num, int stock, int gid, int mid, int valid) {
		super();
		this.img = img;
		this.gname = gname;
		this.price = price;
		this.num = num;
		this.stock = stock;
		this.gid = gid;
		this.mid = mid;
		this.valid = valid;
	}
	
	public Cart(int scid, String img, String gname, double price, int num, int stock, int gid, int mid, int valid) {
		super();
		this.scid = scid;
		this.img = img;
		this.gname = gname;
		this.price = price;
		this.num = num;
		this.stock = stock;
		this.gid = gid;
		this.mid = mid;
		this.valid = valid;
	}

	public int getScid() {
		return scid;
	}

	public void setScid(int scid) {
		this.scid = scid;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getGname() {
		return gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getGid() {
		return gid;
	}

	public void setGid(int gid) {
		this.gid = gid;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public int getValid() {
		return valid;
	}

	public void setValid(int valid) {
		this.valid = valid;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}
	
}
