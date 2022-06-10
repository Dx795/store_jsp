package com.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.bean.Address;

import com.daofactory.DaoFactory;

/**
 * Servlet implementation class AddressServlet
 */
@WebServlet("/AddressServlet")
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddressServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		Address address = new Address();
		String msg = "";
		boolean result = false;
		int id = 0;
		int aid=0;
		String path = "error.jsp";
		String action = request.getParameter("action");
		request.getSession().setAttribute("id", id);

	
		id = Integer.parseInt(request.getParameter("id"));

		String addressee = request.getParameter("addressee");
		String addressee_phone = request.getParameter("addressee_phone");
		String receiving_address = request.getParameter("receiving_address");
		String scid = request.getParameter("scid");
		
		if(action.equals("addressadd"))
		{
			addressee = request.getParameter("addressee");
			addressee_phone = request.getParameter("addressee_phone");
			receiving_address = request.getParameter("receiving_address");
			System.out.println(id);
			System.out.println(addressee);
			address = new Address(aid, id, addressee, addressee_phone, receiving_address);
			try {
				result = DaoFactory.getAddressDaoInstance().addressadd(address);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			
				path = "address.jsp";
				request.getRequestDispatcher(path).forward(request, response);
			}
		
		if (action.equals("addressupdate")) {
			{
				address.setAddressee(addressee);
				address.setAddressee_phone(addressee_phone);
				address.setReceiving_address(receiving_address);
				try {
					result = DaoFactory.getAddressDaoInstance().updateAddress(address);

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if (result) {

					path = "address.jsp";
				} else
					path = "address.jsp";
				request.getSession().setAttribute("address", address);
				request.getRequestDispatcher(path).forward(request, response);
			}}
		 if(action.equals("addressdelete")){
			try {
				result=DaoFactory.getAddressDaoInstance().addressdelete(aid);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
		path="address.jsp";
		request.getRequestDispatcher(path).forward(request, response);
		}
		 if(action.equals("sset")) {
			 System.out.println(addressee+addressee_phone+receiving_address);
			 String scids[] = scid.split(",");
			 for (int i = 0; i < scids.length; i++) {
				 DaoFactory.getOrderDaoInstance().updateorder(Integer.parseInt(scids[i]),addressee, addressee_phone, receiving_address);
			}
//			 response.sendRedirect("order.jsp?scid=338&action=addorder");
			 
		 }
		
		 

	}
}
	
