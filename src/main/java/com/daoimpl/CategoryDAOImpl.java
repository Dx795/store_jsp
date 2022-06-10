package com.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.bean.Category;
import com.dao.CategoryDAO;
import com.util.DB;

public class CategoryDAOImpl implements CategoryDAO {
	private String sql="";
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ArrayList <Category> categories=new ArrayList<Category>();	
	private Category category;
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
	public ArrayList<Category> getByRs(ResultSet rs) {
		System.out.println("����rs");
		try {
			if (rs == null || !rs.next())
			{
				System.out.println("11111");
				return null;
				
			}
				
			categories.clear();
			do {
				category = new Category();
				category.setCid(rs.getInt("cid"));
				category.setCname(rs.getString("cname"));
				categories.add(category);
			} while (rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("rsʧ��");
		} finally {
			close();
		}
		return categories;
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
	public CategoryDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	
	@Override
	public boolean add(Category category) throws Exception {
		getConn();
		sql="insert into category(cname) value(?)";
		int result=0;
		try {
			pstmt=getConn().prepareStatement(sql);
			pstmt.setString(1,category.getCname());
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
	public boolean update(Category category) throws Exception {
		sql="update  category set cname=? where cid=?";
		int result=0;
		try {
			pstmt=getConn().prepareStatement(sql);
			pstmt.setString(1,category.getCname());
			pstmt.setInt(2,category.getCid());
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
	public boolean delete(int cid) throws Exception {
		getConn();
		sql="delete from  category  where cid=?";
		int result=0;
		try {
			pstmt=getConn().prepareStatement(sql);	
			pstmt.setInt(1,cid);
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
	public Category getById(int cid) throws Exception {
		getConn();
		sql="select * from category where cid =?";
		System.out.println("getById"+cid);
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs=pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println("getcIdʧ��");
			throw e;
		}		
		return getByRs(rs).get(0);
	}

	@Override
	public ArrayList<Category> getAll() throws Exception {
		getConn();
		sql="select * from category";
		try {
			pstmt =  getConn().prepareStatement(sql);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(getConn());
		System.out.println("getall�ɹ�");
		return getByRs(rs);
	}
	@Override
	public Category getByName(String name) throws Exception {
		getConn();
		sql="select * from category where cname =?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs=pstmt.executeQuery();
		} catch (SQLException e) {
			throw e;
		}		
		return getByRs(rs).get(0);
	}
	@Override
	public boolean deleteAll(String condition) throws Exception {
		getConn();
		String sql="delete from category where cid  in("+condition+")";//�������SQL���
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
