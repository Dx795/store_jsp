package com.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;



import com.bean.Cart;
import com.dao.*;
import com.util.*;
public class CartDaoImpl implements CartDao {
	private String sql = "";
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ArrayList<Cart> carts = new ArrayList<Cart>();
	private Cart cart;
	private Connection conn = null;

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
	public ArrayList<Cart> getByRs(ResultSet rs) {
		try {
			if (rs == null || !rs.next())
				return null;
			carts.clear();
			do {
				cart = new Cart();
				cart.setScid(rs.getInt("scid"));
				cart.setImg(rs.getString("img"));
				cart.setGname(rs.getString("gname"));
				cart.setPrice(rs.getDouble("price"));
				cart.setNum(rs.getInt("num"));
				cart.setStock(rs.getInt("stock"));
				cart.setGid(rs.getInt("gid"));
				cart.setMid(rs.getInt("gid"));
				cart.setValid(rs.getInt("gid"));
				carts.add(cart);
			} while (rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return carts;
	}
	
	//�ر�����
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
	public boolean add(Cart cart) throws Exception {

		sql = "insert into shopcart(img,gname,price,num,stock,gid,mid,valid) values(?,?,?,?,?,?,?,?)";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setString(1, cart.getImg());
			pstmt.setString(2, cart.getGname());
			pstmt.setDouble(3, cart.getPrice());
			pstmt.setInt(4, cart.getNum());
			pstmt.setFloat(5, cart.getStock());
			pstmt.setInt(6, cart.getGid());
			pstmt.setInt(7, cart.getMid());
			pstmt.setInt(8, cart.getValid());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (result > 0)
			return true;
		else
			return false;
	}

	@Override
	public boolean update(Cart Cart) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(int gid) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Cart> getByMid(int mid) throws Exception {
		// TODO Auto-generated method stub
		sql = "select * from shopcart where mid=? and valid=1 order by scid desc";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, mid);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return getByRs(rs);
	}

	@Override
	public ArrayList<Cart> getByName(String name) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Cart> getAll(int mid) throws Exception {
		sql = "select * from shopcart where mid=?";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, mid);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return getByRs(rs);
	}
	@Override
	public Cart getById(int scid) throws Exception {
		// TODO Auto-generated method stub
		sql = "select * from shopcart where scid=?";
		pstmt = getConn().prepareStatement(sql);
		pstmt.setInt(1, scid);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			cart = new Cart(
					rs.getInt("scid"),
					rs.getString("img"),
					rs.getString("gname"),
					rs.getDouble("price"),
					rs.getInt("num"),
					rs.getInt("stock"),
					rs.getInt("gid"),
					rs.getInt("gid"),
					rs.getInt("gid")
					);
		}
		return cart;
	}
	@Override
	public Cart getExsistGood(int mid, int gid) throws Exception {
		// TODO Auto-generated method stub
		Cart exsistGood = null;
		sql = "select * from shopcart where mid=? and gid=? and valid=1 order by scid desc";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, mid);
			pstmt.setInt(2, gid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				exsistGood = new Cart(
						rs.getInt("scid"),
						rs.getString("img"),
						rs.getString("gname"),
						rs.getDouble("price"),
						rs.getInt("num"),
						rs.getInt("stock"),
						rs.getInt("gid"),
						rs.getInt("gid"),
						rs.getInt("gid")
						);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return exsistGood;
	}
	@Override
	public boolean updateNum(int scid, int newNum) throws Exception {
		//根据购物车id和新的数量来更新数量
		sql = "update shopcart set num = ? where scid = ?";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, newNum);
			pstmt.setInt(2, scid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0)
			return true;
		else
			return false;
	}
	@Override
	public void deleteCart(int scid) {
		// TODO Auto-generated method stub
		sql = "delete from shopcart where scid = ?";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, scid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public Cart getCartShop1(int scid) {
		// TODO Auto-generated method stub
				Cart exsistGood = null;
				sql = "select * from shopcart where scid=? and valid=0 order by scid desc";
				try {
					pstmt = getConn().prepareStatement(sql);
					pstmt.setInt(1, scid);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						exsistGood = new Cart(
								rs.getInt("scid"),
								rs.getString("img"),
								rs.getString("gname"),
								rs.getDouble("price"),
								rs.getInt("num"),
								rs.getInt("stock"),
								rs.getInt("gid"),
								rs.getInt("mid"),
								rs.getInt("valid")
								);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return exsistGood;
	}
	@Override
	public Cart getCartShop(int scid) {
		// TODO Auto-generated method stub
		Cart exsistGood = null;
		sql = "select * from shopcart where scid=? and valid=1 order by scid desc";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, scid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				exsistGood = new Cart(
						rs.getInt("scid"),
						rs.getString("img"),
						rs.getString("gname"),
						rs.getDouble("price"),
						rs.getInt("num"),
						rs.getInt("stock"),
						rs.getInt("gid"),
						rs.getInt("mid"),
						rs.getInt("valid")
						);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return exsistGood;
	}
	@Override
	public void modifyValid(int scid) {
		// TODO Auto-generated method stub
		sql = "update shopcart set valid=0 where scid =?";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, scid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public ArrayList<Cart> getScidbyCondition(String condition) throws Exception {
		// TODO Auto-generated method stub
		getConn();
		String sql="select * from shopcart where scid in("+condition+")";//定义插入SQL语句
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return getByRs(rs);
	}
	@Override
	public Cart getByAdminId(int scid) throws Exception {
		getConn();
		sql="select * from shopcart where scid =?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, scid);
			rs=pstmt.executeQuery();
		} catch (SQLException e) {
			throw e;
		}		
		return getByRs(rs).get(0);
	}
	
}
	


