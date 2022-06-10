package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

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
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public UserServlet() {
		// TODO Auto-generated constructor stub
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		this.doPost(request, response);
	}

	@SuppressWarnings("unused")
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		User user = new User();
		String msg = "";
		boolean result = false;
		int id = 0;
		String path = "error.jsp";
		String action = request.getParameter("action");
		if (request.getParameter("id") != null)
			id = Integer.parseInt(request.getParameter("id"));
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			user=DaoFactory.getUserDaoInstance().selectbyname(username);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		//request.getSession().setAttribute("username", username);
		if (action.equals("login")) {
			try {
//				System.out.println(username);
//				System.out.println(password);
				result = DaoFactory.getUserDaoInstance().login(username, password);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (result) {
//				System.out.println("登陆成功");
				
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("user", user);
				path = "index.jsp";

			} else {

				path = "login.jsp";
			}

		}

		if (action.equals("insert")) {
			username = request.getParameter("userName");
			password = request.getParameter("passWord");
			String phone = request.getParameter("phone");
			user = new User(username, password, phone);
			try {
				result = DaoFactory.getUserDaoInstance().insert(user);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if (result) {

				path = "login.jsp";
			} else {
				path = "reg.jsp";
			}
		}
		if (action.equals("updateuser")) {
			String nusername = request.getParameter("username");
			String nicheng = request.getParameter("nicheng");
			String phone = request.getParameter("phone");
			String sex = request.getParameter("sex");
			String address = request.getParameter("address");
			String birthday = request.getParameter("birthday");
			user.setNicheng(nicheng);
			user.setPhone(phone);
			user.setSex(sex);
			user.setAddress(address);
			user.setBirthday(birthday);			
			user.setUsername(nusername);
			try {
				result = DaoFactory.getUserDaoInstance().updateuser(user);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			path = "mygrxx.jsp";

		}
		if (action.equals("repassword")) {
			String password1 = request.getParameter("newpassword");
//			System.out.println(password1);
//			System.out.println(username);
			try {
				result = DaoFactory.getUserDaoInstance().updatepassword(username, password1);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			path = "mygxin.jsp";
		}

		request.getRequestDispatcher(path).forward(request, response);
	}
}
