package com.dao;

import java.util.ArrayList;
import java.util.List;

import com.bean.Order;

public interface OrderDao {
	public boolean add(Order order) throws Exception;
	public boolean update(Order order) throws Exception;
	public boolean updatestatue(int scid) throws Exception;
	public Order getById(int oid) throws Exception;
	public ArrayList<Order> getByName(String condition) throws Exception;
	public ArrayList<Order> getAll(int mid) throws Exception;
	public boolean deleteOrder(int oid) throws Exception;//单删除
	public ArrayList<Order> getAll() throws Exception;//查询所有订单
	public boolean deleteAll(String condition) throws Exception;//带条件删除
	public ArrayList<Order> viewbyunpaid() throws Exception;
	public boolean updatestatuereceive(int scid);//更改订单状态为收货
	public ArrayList<Order> getAllByStatue(int statue) throws Exception;//根据状态查询所有收货订单
	public boolean updatesend(int scid);//更改订单状态待发货
	
	public void updateorder(int scid, String addressee, String addressee_phone, String receiving_address);
}