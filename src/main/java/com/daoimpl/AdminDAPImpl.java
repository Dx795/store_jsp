package com.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.bean.Admin;
import com.dao.AdminDAO;
import com.util.DB;

public class AdminDAPImpl implements AdminDAO {

	private String sql="";
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ArrayList <Admin> admins=new ArrayList<Admin>();	
	private Admin admin;
	private Connection conn=null;
	public Connection getConn() {
		try {
			if ((conn==null)||conn.isClosed()) {
				DB db=new DB();
				conn=db.getConn();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;		
	}
	public ArrayList<Admin> getByRs(ResultSet rs) {
		try {
			if (rs == null || !rs.next())
			{
				System.out.println("rskong   11111");
				return null;			
			}				
			admins.clear();
			do {
				admin = new Admin();
				admin.setAdminId(rs.getInt("adminId"));
				admin.setAdminName(rs.getString("adminName"));
				admin.setAdminPassword(rs.getString("adminPassword"));
				admins.add(admin);
			} while (rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("rs ß∞‹");
		} finally {
			close();
		}
		return admins;
	}
	//πÿ±’¡¨Ω”
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
	public Boolean login(String username, String password) throws Exception {

			getConn();
			sql = "select * from admin where adminName=? and adminPassword=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, username);
				pstmt.setString(2, password);
				rs = pstmt.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			if (rs.next())
				return true;
			else
				return false;

		
	}

}
