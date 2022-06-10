package com.daofactory;

import com.dao.*;
import com.daoimpl.*;

public class DaoFactory {
	public static GoodsDAO getGoodsDaoInstance()   
	{   
		return new GoodsDAOImpl() ;   
	}  
	public static CategoryDAO getCategoryDaoInstance()   
	{   
		return new CategoryDAOImpl() ;   
	}  
	
	public static OrderDao getOrderDaoInstance()   
	{   
		return new OrderDaoImpl() ;   
	}  
 
	public static CartDao getCartDaoInstance()   
	{   
		return new CartDaoImpl() ;   
	}  
	public static UserDAO getUserDaoInstance()   
	{   
		return new UserDAOImpl() ;   
	}

 
	public static UserDAO getUserDAOInstance()   
	{   
		return new UserDAOImpl() ;   
	}   

	public static AddressDAO getAddressDaoInstance() {
		// TODO Auto-generated method stub
		return new AddressDAOImpl();
	} 
	public static AdminDAO getAdminDaoInstance()   
	{   
		return new AdminDAPImpl() ;   
	}   
}
