package com.servlet;

import java.io.IOException;
import java.util.ArrayList;

import com.bean.Category;
import com.bean.Goods;
import com.daofactory.DaoFactory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public CategoryServlet() {
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Category category=new Category();
		String msg="";
		boolean result=false;
		int cid=1;
		String path="error.jsp";
		ArrayList<Goods> goods=new ArrayList<Goods>();
		String type=request.getParameter("type");
		if(request.getParameter("cid")!=null)
			cid=Integer.parseInt(request.getParameter("cid"));
		
		if(type.equals("viewbycid")){
			request.setAttribute("cid", cid);
			path="flowerDer.jsp";
			System.out.println(cid+"    CategorySerblet.java 41");
		}
		else if(type.equals("insert")){
			 String cname=request.getParameter("cname");
			 category.setCname(cname);
			try {
				result=DaoFactory.getCategoryDaoInstance().add(category);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (result) 
			path="categoryManagement.jsp";
			
		}
		//��ɾ��
		else if(type.equals("delete")){
			   cid=Integer.parseInt(request.getParameter("cid"));
			  
			try {
				result=DaoFactory.getCategoryDaoInstance().delete(cid);
				DaoFactory.getGoodsDaoInstance().deletebycid(cid);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (result) 
			path="categoryManagement.jsp";
		}
		//��ɾ��
		else if(type.equals("deleteAll")){
			boolean result2=false;
			String ids[]=request.getParameterValues("all");
			 int i=0;
			 String condition="";
			 for(i=0;i<ids.length;i++){
				 condition+=ids[i];
			 if(i!=ids.length-1) condition+=",";
			 }
			 
			try {
				result=DaoFactory.getCategoryDaoInstance().deleteAll(condition);
				result2=DaoFactory.getGoodsDaoInstance().deletebycid(condition);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(result==true)
			path="categoryManagement.jsp";
		}else if (type.equals("update")) {
			cid=Integer.parseInt(request.getParameter("cid"));
			try {
				category=DaoFactory.getCategoryDaoInstance().getById(cid);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			request.setAttribute("category", category);
			path="categoryupdate.jsp";
		}
		else if (type.equals("uptadeSj")) {
			cid=Integer.parseInt(request.getParameter("cid"));
			String cname=request.getParameter("cname");
			category.setCid(cid);
			category.setCname(cname);
			
			try {
				result=DaoFactory.getCategoryDaoInstance().update(category);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(result)
			path="categoryManagement.jsp";
		}
		
		
		request.getRequestDispatcher(path).forward(request, response);
	}

}
