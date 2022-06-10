package com.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.bean.Address;
import com.bean.Cart;
import com.bean.User;
import com.daofactory.DaoFactory;

/**
 * Servlet implementation class OrderUpdate
 */
@WebServlet("/OrderUpdate")
public class OrderUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  
		String scid = request.getParameter("scid");
		String action  = request.getParameter("action");
		String addressee = request.getParameter("addressee");
		String addressee_phone = request.getParameter("addressee_phone");
		String receiving_address = request.getParameter("receiving_address");
		HttpSession session = request.getSession();
		Cart cart = new Cart();
		User user = (User) session.getAttribute("user");
		double totalPrice = 0;
		 if(action.equals("sset")) {
			 System.out.println(addressee+addressee_phone+receiving_address);
			 String scids[] = scid.split(",");
			 for (int i = 0; i < scids.length; i++) {
				 DaoFactory.getOrderDaoInstance().updateorder(Integer.parseInt(scids[i]),addressee, addressee_phone, receiving_address);
			}
		
			 
			 
			 
				ArrayList<Cart> list = new ArrayList<Cart>();
				
				ArrayList<Address> addlist = new ArrayList<Address>();
				
				for (int i = 0; i < scids.length; i++) {
					cart = DaoFactory.getCartDaoInstance().getCartShop1(Integer.parseInt(scids[i]));
					totalPrice += cart.price * cart.getNum();
					list.add(cart);
				}
				try {
					addlist = DaoFactory.getAddressDaoInstance().selectbyid(user.getId());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.setAttribute("totalPrice",totalPrice);
				request.setAttribute("address",addlist);
				request.setAttribute("cartshoplist", list);
				request.setAttribute("scid", scid);
				request.getRequestDispatcher("order.jsp").forward(request, response); 
			 
			 
		 }
	}

}
