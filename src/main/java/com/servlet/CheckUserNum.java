package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class CheckUserNum
 */
@WebServlet("/checkusernum")
public class CheckUserNum extends HttpServlet {
	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String num = request.getParameter("num");
		
		 HttpSession session = request.getSession();
		 
		 String sysCode= (String)session.getAttribute("code");
		 
		 
	
			 
		 PrintWriter out = response.getWriter();
		if(sysCode.equals(num) ){
			out.print("true");
		}else{
			out.print("false");
		}
				
			
		out.close();
		 
		   
	}



}
