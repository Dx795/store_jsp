package com.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.bean.Goods;
import com.bean.User;
import com.dao.UserDAO;

import com.util.DB;

public class UserDAOImpl implements UserDAO {
	private String usersql = "";
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Connection conn = null;

	private ArrayList<User> users = new ArrayList<User>();
	private User user;
//寤虹珛杩炴帴
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
//鎶婄粨鏋滈泦鏀惧埌rs
	public ArrayList<User> getByRs(ResultSet rs) {
		try {
			if (rs == null || !rs.next())
				return null;
			users.clear();
			do {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setNicheng(rs.getString("nicheng"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setBalance(rs.getDouble("balance"));
				user.setPhone(rs.getString("phone"));
				user.setAddress(rs.getString("address"));
				user.setLevel(rs.getInt("level"));
				user.setCreate_time(rs.getString("create_time"));
				user.setHead_sculpture(rs.getString("head_sculpture"));
				user.setBirthday(rs.getString("birthday"));
				user.setSex(rs.getString("sex"));
				users.add(user);
			} while (rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return users;
	}
//鐧诲綍
	public Boolean login(String username, String password) throws SQLException {
		getConn();
		usersql = "select * from user where username=? and password=?";
		try {
			pstmt = conn.prepareStatement(usersql);
			System.out.println(username);
			System.out.println(password);
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
//鍏抽棴杩炴帴
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
//娣诲姞鐢ㄦ埛
	@Override
	public Boolean insert(User user) {
		getConn();
		usersql = "insert into user(username,password,phone) values(?,?,?)";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getPhone());
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
   //鏍规嵁鐢ㄦ埛鍚嶆煡鎵剧敤鎴�
	@Override
	public User selectbyname(String username) throws Exception {
		getConn();
		usersql = "select * from user where username=?";
		try {
			pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return getByRs(rs).get(0);

	}
	//閫氳繃鐢ㄦ埛鍚嶄慨鏀圭敤鎴蜂釜浜轰俊鎭�
	@Override
	public boolean updateuser(User user) throws Exception{
		getConn();
		usersql = "update user set nicheng=?,phone=?,sex=?,address=?,birthday=? where username=?";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, user.getNicheng());
			pstmt.setString(2, user.getPhone());
			pstmt.setString(3, user.getSex());
			pstmt.setString(4, user.getAddress());
			pstmt.setString(5, user.getBirthday());
			pstmt.setString(6, user.getUsername());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			return true;}
		else {
			return false;}
	}
	//淇敼瀵嗙爜
	@Override
	public boolean updatepassword(String username,String password) {
		getConn();
		usersql = "update user set password=? where username=?";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, password);
			pstmt.setString(2,username);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0)
			return true;
		else
			return false;
	}
	@Override//鑾峰彇鍏ㄩ儴
	public ArrayList<User> getAll() throws Exception {
			getConn();
			usersql="select * from user";
			try {
				pstmt =  getConn().prepareStatement(usersql);
				rs=pstmt.executeQuery();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return getByRs(rs);
		}
	@Override//鏍规嵁鐢ㄦ埛ID鍘绘煡璇�
	public User getByname(int id) throws Exception {
			getConn();
			usersql="select * from user where id=?";
			try {
				pstmt=conn.prepareStatement(usersql);
				pstmt.setInt(1, id);
				rs=pstmt.executeQuery();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return getByRs(rs).get(0);
		}
	@Override
	public boolean userdelete(int id) throws Exception {
		getConn();
		usersql="delete from user where id=?";
		int result=0;
		try {
			pstmt=getConn().prepareStatement(usersql);	
			pstmt.setInt(1,id);
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
	@Override
	public int selectbyusername(int id) throws Exception {
		getConn();
		int count = 0;
		usersql = "select count(*) from user where id=?";
		try {
			pstmt = conn.prepareStatement(usersql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			 while(rs.next()) {
				 count = rs.getInt(0);
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;

	}
	@Override
	public Boolean userinsert(User user) throws Exception {
		getConn();
		usersql = "insert into user(username,password,phone,address) values(?,?,?,?)";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getPhone());
			pstmt.setString(4, user.getAddress());
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
	@Override
	public ArrayList<User> getByname(String name) throws Exception {
			getConn();
			if(name==null)
			{
				name="";
			}
			String sql="select * from user where username like '%"+name+"%'";
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
			} catch (Exception e) {
				System.out.println("用户表按名查找失败");
			}
			return getByRs(rs);
		
	}
	@Override
	public boolean update(User user) throws Exception {
		getConn();
		usersql = "update user set username=?,password=?,phone=?,address=?,level=? where id=?";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(usersql);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getPhone());
			pstmt.setString(4, user.getAddress());
			pstmt.setInt(5, user.getLevel());
			pstmt.setInt(6, user.getId());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0) {
			return true;}
		else {
			return false;}
	}
	@Override
	public boolean deleteAll(String condition) throws Exception {
			getConn();
			String sql="delete from user where id  in("+condition+")";//定义插入SQL语句
			int result = 0;
			try {
				pstmt = getConn().prepareStatement(sql);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			if (result > 0)
				return true;
			else
				return false;
		
	}
			
}
