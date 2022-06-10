package com.dao;

import java.util.ArrayList;
import com.bean.Goods;


public interface GoodsDAO {
	public boolean add(Goods goods) throws Exception; //添加		
	public boolean update(Goods goods) throws Exception; //更新
	public boolean delete(int gid) throws  Exception;//删除
	public boolean deletebycid(String conditionBycid) throws  Exception;//根据类别删除
	public boolean deletebycid(int cid) throws  Exception;//根据类别删除
	public boolean deleteAll(String condition) throws Exception;//批量删除
	public Goods getById(int gid) throws Exception;//根据id获取
	public ArrayList<Goods> getByName(String name) throws Exception;//根据名字获取
	public ArrayList<Goods> getAll() throws Exception; //查询所有
	public ArrayList<Goods> getbyCid(int cid) throws Exception; //根据类别查询所有
	public ArrayList<Goods> getbyCidAndName(int cid,String name) throws Exception; //根据类别和名字查询所有
	public ArrayList<Goods> pxgetbyCidQsan(int cid) throws Exception; //根据cid类别查询销量前3
	public ArrayList<Goods> pxgetbyCidSalesidianwu(int cid) throws Exception; //根据cid类别查询五星好评4.5以上的
	
	public ArrayList<Goods> getGidbyCondition(String condition) throws Exception; //根据传过来的gid集合 去查数据
	public boolean updateStore(int gid, int num) throws Exception;//更新商品库存
}
