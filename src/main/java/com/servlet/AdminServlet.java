package com.servlet;

import java.io.IOException;

import com.bean.Admin;
import com.daofactory.DaoFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public AdminServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean result=false;
		String path="error.jsp";
		int adminId=0;
		String type=request.getParameter("type");
		String adminName=request.getParameter("adminName");
		String adminPassword=request.getParameter("adminPassword");
			try {
				result=DaoFactory.getAdminDaoInstance().login(adminName, adminPassword);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(result)
			{
				path="adminIndex.jsp";
				request.getSession().setAttribute("adminName", adminName);
			}
			
			else 
				path="adminlogin.jsp";
			
		
		request.getRequestDispatcher(path).forward(request, response);
	}
}
