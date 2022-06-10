package com.dao;

import java.util.ArrayList;

import com.bean.Category;

public interface CategoryDAO {
	public boolean add(Category category) throws Exception; //添加		
	public boolean update(Category category) throws Exception; //更新
	public boolean delete(int cid) throws  Exception;//删除
	public boolean deleteAll(String condition) throws  Exception;//删除批量
	public Category getById(int cid) throws Exception;//根据id获取
	public Category getByName(String name) throws Exception;//根据id获取
	public ArrayList<Category> getAll() throws Exception; //查询所有
}
