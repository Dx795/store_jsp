package com.dao;

import java.util.ArrayList;


import com.bean.Cart;


public interface CartDao {
	public boolean add(Cart cart) throws Exception; //添加		
	public boolean update(Cart cart) throws Exception; //更新
	public boolean delete(int gid) throws  Exception;//删除
	public Cart getById(int scid) throws Exception;//根据id获取
	public ArrayList<Cart> getByName(String name) throws Exception;//根据名字获取
	public ArrayList<Cart> getAll(int mid) throws Exception; //查询所有
	public ArrayList<Cart> getByMid(int mid)throws Exception;
	public Cart getExsistGood(int mid, int gid)throws Exception;// 通过用户mip和购物车的商品gid来查找是否存在已添加商品的记录
	public boolean updateNum(int scid, int newNum)throws Exception;//根据购物车id和新的数量来更新数量
	public void deleteCart(int scid);//根据购物车id删除商品
	public Cart getCartShop(int parseInt);
	public void modifyValid(int i);//修改购物车中的商品状态
	public ArrayList<Cart> getScidbyCondition(String condition) throws Exception; //根据传过来的gid集合 去查数据
	
	public Cart getByAdminId(int scid) throws Exception;//根据id获取
	public Cart getCartShop1(int parseInt);
}
