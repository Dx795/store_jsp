package com.dao;

import java.util.ArrayList;
import com.bean.User;


public interface UserDAO {
	public Boolean login(String username,String password) throws Exception;
	public User selectbyname(String username) throws Exception; 
	public Boolean insert(User user);//娣诲姞鐢ㄦ埛
	public boolean updateuser(User user) throws Exception;
	public boolean updatepassword(String username,String password);
	public ArrayList<User> getAll() throws Exception; 
	public User getByname(int id) throws Exception;
	public boolean userdelete(int id) throws Exception;
	public int selectbyusername(int id) throws Exception;
	public Boolean userinsert(User user) throws Exception; 
	public ArrayList<User> getByname(String name) throws Exception;
	
	public boolean update(User user) throws Exception;
	public boolean deleteAll(String condition)  throws Exception;
}
