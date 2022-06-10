package com.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DB;

import com.bean.Order;
import com.dao.OrderDao;

public class OrderDaoImpl implements OrderDao {
	private String sql = "";
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ArrayList<Order> orders = new ArrayList<Order>();
	private Order order;
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
	public boolean add(Order order) throws Exception {
		// TODO Auto-generated method stub
//		private int oid;//订单号
//		private int mid;//用户号
//		private String img;//图片
//		private String createtime;//订单创建时间
//		private String consignee;//收货人姓名
//		private String address;//收货人地址
//		private String phone;//电话
//		private String remarks;//备注
//		private int statue;
		sql = "insert into order1(scid,gid,mid,img,createtime,consignee,address,phone,remarks,statue) values(?,?,?,?,?,?,?,?,?,?)";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, order.getScid());
			pstmt.setInt(2, order.getGid());
			pstmt.setInt(3, order.getMid());
			pstmt.setString(4, order.getImg());
			pstmt.setString(5, order.getCreatetime());
			pstmt.setString(6, order.getConsignee());
			pstmt.setString(7, order.getAddress());
			pstmt.setString(8, order.getPhone());
			pstmt.setString(9, order.getRemarks());
			pstmt.setInt(10, order.getStatue());
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
	public boolean update(Order order) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updatestatue(int scid) throws Exception {
		// TODO Auto-generated method stub
		sql = "update order1 set statue =1 where scid =?";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, scid);

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
	public Order getById(int oid) throws Exception {
		// TODO Auto-generated method stub
		getConn();
		sql = "select * from order1 where oid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, oid);
			rs = pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return getByRs(rs).get(0);
	}

	public ArrayList<Order> getByRs(ResultSet rs) {
		try {
			if (rs == null || !rs.next())
				return null;
			orders.clear();
			do {
				order = new Order();
				order.setOid(rs.getInt("oid"));
				order.setScid(rs.getInt("scid"));
				order.setGid(rs.getInt("gid"));
				order.setMid(rs.getInt("mid"));
				order.setImg(rs.getString("img"));
				order.setCreatetime(rs.getString("createtime"));
				order.setConsignee(rs.getString("consignee"));
				order.setAddress(rs.getString("address"));
				order.setPhone(rs.getString("phone"));
				order.setRemarks(rs.getString("remarks"));
				order.setStatue(rs.getInt("statue"));
				orders.add(order);
			} while (rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return orders;
	}

	public ArrayList<Order> getAll(int mid) {
		sql = "select * from order1 where mid=? order by oid desc";
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
	public ArrayList<Order> viewbyunpaid() throws Exception {
		// TODO Auto-generated method stub
		sql = "select * from order1";
		try {
			pstmt = getConn().prepareStatement(sql);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return getByRs(rs);
	}

	@Override
	public ArrayList getByName(String condition) throws Exception {
		// TODO Auto-generated method stubgetConn();
		getConn();
		if (condition == null)
			condition = "";
		try {
			CallableStatement cs = conn.prepareCall("{call getByNameProc(?)}");
			cs.setString(1, condition);
			rs = cs.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return getByRs(rs);
	}
	
	@Override
	public boolean updatestatuereceive(int scid) {
		// TODO Auto-generated method stub
		sql = "update order1 set statue =-1 where scid =?";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, scid);

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
	public boolean deleteAll(String condition) throws Exception {
		// TODO 根据条件删除订单
		sql = "delete from order1 where oid  in(" + condition + ")";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			// pstmt.setString(1, condition);
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

	@Override
	public boolean deleteOrder(int oid) throws Exception {
		sql = "delete from order1 where oid=?";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, oid);
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

	@Override
	public ArrayList<Order> getAll() throws Exception {
		// TODO Auto-generated method stub
		sql = "select * from order1";
		try {
			pstmt = getConn().prepareStatement(sql);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return getByRs(rs);
	}

	@Override
	public ArrayList<Order> getAllByStatue(int statue) throws Exception {
		// TODO Auto-generated method stub
		sql = "select * from order1 where statue =?";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, statue);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return getByRs(rs);
	}
	@Override
	public boolean updatesend(int scid) {
		// TODO Auto-generated method stub
		sql = "update order1 set statue =2 where scid =?";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, scid);

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
	public void updateorder(int scid, String addressee, String addressee_phone, String receiving_address) {
		// TODO Auto-generated method stub
		sql = "update order1 set consignee=?,phone=?,address=? where scid =?";
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setString(1, addressee);
			pstmt.setString(2, addressee_phone);
			pstmt.setString(3, receiving_address);
			pstmt.setInt(4, scid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
