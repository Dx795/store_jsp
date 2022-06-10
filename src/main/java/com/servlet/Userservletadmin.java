package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.bean.Address;
import com.bean.User;

import com.daofactory.DaoFactory;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UsersServlet
 */
@WebServlet("/adminUserservlet")
public class Userservletadmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public Userservletadmin() {
		// TODO Auto-generated constructor stub
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		this.doPost(request, response);
	}

	@SuppressWarnings("unused")
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		User user1 = new User();
		String msg = "";
		boolean result = false;
		int id=0;
		String path = "error.jsp";
		String action = request.getParameter("action");
		
		if(action.equals("userinsert"))
		{
			String username = request.getParameter("adminusername");
			String password = request.getParameter("adminpassword");
			String phone=request.getParameter("userphone");
			String address=request.getParameter("useraddress");
			user1 = new User(username, password, phone);
			try {
				result = DaoFactory.getUserDAOInstance().userinsert(user1);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		path = "userManagement.jsp";											
		}	
		else if(action.equals("userdelete")){
				id=Integer.parseInt(request.getParameter("uid"));
				try {
					System.out.println(id);
					result=DaoFactory.getUserDAOInstance().userdelete(id);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
			path="userManagement.jsp";
			}else if(action.equals("uptade")){
				id=Integer.parseInt(request.getParameter("uid"));
				try {
					user1=DaoFactory.getUserDAOInstance().getByname(id);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				path="userInsert.jsp";
				request.setAttribute("xiugai", "xiugai");
				request.setAttribute("user1", user1);
			}else if(action.equals("uptadeSJ")){
				
				id=Integer.parseInt(request.getParameter("id"));
				String username=request.getParameter("username");
				String password=request.getParameter("password");
				String phone=request.getParameter("phone");
				String address=request.getParameter("address");
				int level=Integer.parseInt(request.getParameter("level"));
				
				user1.setId(id);
				user1.setUsername(username);
				user1.setLevel(level);
				user1.setAddress(address);
				user1.setPassword(password);
			    user1.setPhone(phone);
				try {
					result=DaoFactory.getUserDAOInstance().update(user1);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				if(result)
				path="userManagement.jsp";
			}else if(action.equals("deleteAll")){
				String ids[]=request.getParameterValues("all");
				 int i=0;
				 String condition="";
				 for(i=0;i<ids.length;i++){
					 condition+=ids[i];
				 if(i!=ids.length-1) condition+=",";
				 }
				 
				try {
					result=DaoFactory.getUserDAOInstance().deleteAll(condition);
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(result==true)
				path="userManagement.jsp";
			}
		
		
			 
		
		
		request.getRequestDispatcher(path).forward(request, response);
	}
}
