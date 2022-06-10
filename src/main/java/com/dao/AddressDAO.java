package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.bean.Address;
import com.bean.Category;
import com.bean.User;

public interface AddressDAO {

	public ArrayList<Address> getByRs(ResultSet rs);
	public Boolean addressadd(Address address);
	public boolean addressdelete(int aid) throws Exception ;
	public boolean updateAddress(Address address);
	public ArrayList<Address> getAll(int id) throws Exception;
	public ArrayList<Address> selectbyid(int id) throws Exception;

	

}
