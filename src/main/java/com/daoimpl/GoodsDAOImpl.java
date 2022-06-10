package com.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import com.bean.Goods;
import com.dao.GoodsDAO;
import com.util.DB;



public class GoodsDAOImpl implements GoodsDAO {
	
	private String sql="";
	private PreparedStatement pstmt;
	private ResultSet rs;
	private ArrayList <Goods> goods=new ArrayList<Goods>();	
	private Goods good;
	private Connection conn=null;
	
	//获得连接
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
	//将结果集放在list里面
	public ArrayList<Goods> getByRs(ResultSet rs) {
		System.out.println("来到rs");
		try {
			if (rs == null || !rs.next())
			{
				System.out.println("11111");
				return null;
				
			}
				
			goods.clear();
			do {
				good = new Goods();
				good.setGid(rs.getInt("gid"));
				good.setGname(rs.getString("gname"));
				good.setPrice(rs.getDouble("price"));
				good.setInPrice(rs.getDouble("inPrice"));
				good.setIntroduction(rs.getString("introduction"));
				good.setStock(rs.getInt("stock"));
				good.setPicture(rs.getString("picture"));
				good.setCid(rs.getInt("cid"));
				good.setHighPraise(rs.getDouble("highPraise"));
				good.setSales(rs.getInt("sales"));
				good.setXqPicture(rs.getString("xqPicture"));
				good.setZsPicture(rs.getString("zsPicture"));
				goods.add(good);
			} while (rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("rs失败");
		} finally {
			close();
		}
		System.out.println("结束rs");
		System.out.println(goods.get(0).getPicture());
		return goods;
	}
	
	//添加商品
	@Override
	public boolean add(Goods goods) throws Exception {
		getConn();
		sql="insert into goods(gname,price,inPrice,introduction,stock,picture,cid) value(?,?,?,?,?,?,?)";
		int result=0;
		try {
			pstmt=getConn().prepareStatement(sql);
			pstmt.setString(1,goods.getGname());
			pstmt.setDouble(2,goods.getPrice());
			pstmt.setDouble(3,goods.getInPrice());
			pstmt.setString(4,goods.getIntroduction());
			pstmt.setInt(5,goods.getStock());
			pstmt.setString(6,goods.getPicture());
			pstmt.setInt(7,goods.getCid());
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

	//修改
	@Override
	public boolean update(Goods goods) throws Exception {
		sql="update  goods set gname=?,price=?,inPrice=?,introduction=?,stock=?,picture=?,cid=?,highPraise=?,sales=? where gid=?";
		int result=0;
		try {
			pstmt=getConn().prepareStatement(sql);
			pstmt.setString(1,goods.getGname());
			pstmt.setDouble(2,goods.getPrice());
			pstmt.setDouble(3,goods.getInPrice());
			pstmt.setString(4,goods.getIntroduction());
			pstmt.setInt(5,goods.getStock());
			pstmt.setString(6,goods.getPicture());
			pstmt.setInt(7,goods.getCid());
			pstmt.setDouble(8,goods.getHighPraise());
			pstmt.setInt(9,goods.getSales());
			pstmt.setInt(10,goods.getGid());
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

	//根据id删除
	@Override
	public boolean delete(int gid) throws Exception {
		getConn();
		sql="delete from  goods  where gid=?";
		int result=0;
		try {
			pstmt=getConn().prepareStatement(sql);	
			pstmt.setInt(1,gid);
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

	//根据id查找记录
	@Override
	public Goods getById(int gid) throws Exception {
		getConn();
		sql="select * from goods where gid =?";
		System.out.println("getById"+gid);
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, gid);
			rs=pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println("getId失败");
			throw e;
		}		
		return getByRs(rs).get(0);
	}

	//根据名字查找记录
	@Override
	public  ArrayList<Goods> getByName(String gname) throws Exception {
		System.out.println("启动");
		getConn();
		if(gname==null)
		{
			gname="";
		}
		String sql="select * from goods where gname like '%"+gname+"%'";
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			System.out.println("按名查找失败");
		}
		return getByRs(rs);
	}

	//获取全部
	public ArrayList<Goods> getAll() throws Exception {
		getConn();
		sql="select * from goods";
		try {
			pstmt =  getConn().prepareStatement(sql);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(getConn());
		System.out.println("getall成功");
		return getByRs(rs);
	}
	@Override
	public ArrayList<Goods> getbyCid(int cid) throws Exception {
		getConn();
		sql="select * from goods where cid=?";
		try {
			pstmt =  getConn().prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getByRs(rs);
	}
	//根据cid查询销量前三条记录
	@Override
	public ArrayList<Goods> pxgetbyCidQsan(int cid) throws Exception {
		getConn();
		sql="select * from goods where cid=? ORDER BY sales DESC LIMIT 3";
		try {
			pstmt =  getConn().prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getByRs(rs);
	}
	@Override
	public ArrayList<Goods> pxgetbyCidSalesidianwu(int cid) throws Exception {
		getConn();
		sql="select * from goods where cid=? AND highPraise>=4.8 ORDER BY highPraise DESC";
		try {
			pstmt =  getConn().prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getByRs(rs);
	}
	
	//根据cid和名字查询所有记录
	@Override
	public ArrayList<Goods> getbyCidAndName(int cid, String name) throws Exception {
		getConn();
		if(name==null)
		{
			name="";
		}
		String sql="select * from goods where gname like '%"+name+"%' and cid=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs=pstmt.executeQuery();
		} catch (Exception e) {
			System.out.println("按名查找失败");
		}
	
		return getByRs(rs);
	}
	
	//批量删除
	@Override
	public boolean deleteAll(String condition) {
		getConn();
		String sql="delete from goods where gid  in("+condition+")";//定义插入SQL语句
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
	@Override
	public ArrayList<Goods> getGidbyCondition(String condition) throws Exception {
		getConn();
		String sql="select * from goods where gid in("+condition+")";//定义插入SQL语句
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
	public boolean deletebycid(String conditionbyCid) throws Exception {
		getConn();
		String sql="delete from goods where cid in("+conditionbyCid+")";//定义插入SQL语句
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
	@Override
	public boolean deletebycid(int cid) throws Exception {
		getConn();
		String sql="delete from goods where cid =?";//定义插入SQL语句
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1, cid);
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
	public boolean updateStore(int gid, int num) throws Exception {
		// TODO Auto-generated method stub
		sql = "update goods set stock = stock-? where gid =?";
		int result = 0;
		try {
			pstmt = getConn().prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.setInt(2,gid);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result > 0)
			return true;
		else
			return false;
	}
	

}
