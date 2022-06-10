package com.dao;

import com.bean.Admin;

public interface AdminDAO {
	public Boolean login(String username,String password) throws Exception;
}
