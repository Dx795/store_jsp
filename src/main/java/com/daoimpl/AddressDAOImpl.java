package com.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

import com.bean.Address;
import com.bean.Category;
import com.bean.User;
import com.dao.AddressDAO;
import com.util.DB;

public class AddressDAOImpl implements AddressDAO {
	private String sql = "";
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Connection conn = null;public AddressDAOImpl() {
		// TODO Auto-generated constructor stub
	}
	private ArrayList<Address> addressq = new ArrayList<Address>();
	private Address address;
	
	private Connection getConn() {
		try {
			if ((conn == null) || conn.isClosed()) {
				DB db = new DB();
				conn = db.getConn();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	//关闭连接
		public void close() {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				rs = null;
				pstmt = null;
				conn = null;
			}
		}
	
	@Override
	public ArrayList<Address> getByRs(ResultSet rs) {
			try {
				if (rs == null || !rs.next())
					return null;
				addressq.clear();
				do {
					address = new Address();
					address.setAid(rs.getInt("aid"));
					address.setId(rs.getInt("id"));
					address.setAddressee(rs.getString("addressee"));
					address.setAddressee_phone(rs.getString("addressee_phone"));
					address.setReceiving_address(rs.getString("receiving_address"));
					addressq.add(address);
				} while (rs.next());
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return addressq;
		}
//添加地址
	@Override
	public Boolean addressadd(Address address) {
	getConn();
		sql = "insert into address(id,addressee,addressee_phone,receiving_address) values(?,?,?,?)";
			int result = 0;
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, address.getId());
				pstmt.setString(2, address.getAddressee());
				pstmt.setString(3, address.getAddressee_phone());
				pstmt.setString(4, address.getReceiving_address());
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			if (result > 0)
				return true;
			else
				return false;
		}
//删除地址
	@Override
	public boolean addressdelete(int aid) throws Exception {
			getConn();
			sql="delete from address where aid=?";
			int result=0;
			try {
				pstmt=getConn().prepareStatement(sql);	
				pstmt.setInt(1,aid);
				result=pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			if (result>0) {
				return true;
			}
			else
			{
				return false;
			}
		}
//更改地址
	@Override
	public boolean updateAddress(Address address) {
			sql = "update address set addressee=?,addressee_phone=?,receiving_address=? where aid=?";
			int result = 0;
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, address.getAddressee());
				pstmt.setString(2, address.getAddressee_phone());
				pstmt.setString(3, address.getReceiving_address());
				pstmt.setInt(4, address.getAid());
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (result > 0)
				return true;
			else
				return false;
		}
	//查询这个ID的所有信息
	@Override
	public ArrayList<Address> getAll(int id) throws Exception {
			getConn();
			sql="select * from address where id=?";
			try {
				pstmt =  getConn().prepareStatement(sql);
				rs=pstmt.executeQuery();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return getByRs(rs);
		}
	@Override
	public ArrayList<Address> selectbyid(int id) throws Exception {
			getConn();
			sql = "select * from address where id=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return getByRs(rs);

		}
	
	
	
	

}
