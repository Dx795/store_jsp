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

import com.daofactory.DaoFactory;
import com.bean.Address;
import com.bean.Cart;
import com.bean.Goods;
import com.bean.Order;
import com.bean.User;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderServlet() {
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
		Order order = new Order();
		Goods good = new Goods();
		Cart cart = new Cart();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		boolean result = false;
		int id = 0;
		String oid =request.getParameter("oid");
		System.out.println(oid);
		String action = request.getParameter("action");
		String scid = request.getParameter("scid");
		Address address = (Address) session.getAttribute("address");
		if (scid.equals("")) {
			response.sendRedirect("cart.jsp");
		} else {
			if (action.equals("addorder")) {
				String scids[] = scid.split(",");
				ArrayList<Cart> list = new ArrayList<Cart>();
				ArrayList<Address> addlist = new ArrayList<Address>();
				double totalPrice = 0;
				
				for (int i = 0; i < scids.length; i++) {
					cart = DaoFactory.getCartDaoInstance().getCartShop(Integer.parseInt(scids[i]));
					totalPrice += cart.price * cart.getNum();
					list.add(cart);
					DaoFactory.getCartDaoInstance().modifyValid(Integer.parseInt(scids[i]));
					SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
					Date date = new Date();
					order.setCreatetime(simpleDateFormat.format(date));
					order.setScid(Integer.parseInt(scids[i]));
					order.setGid(cart.gid);
					order.setConsignee(user.getUsername());
					order.setImg(cart.img);
					order.setMid(user.getId());
					order.setPhone("188888888");
					order.setStatue(0);
					order.setAddress("厦门理工学院");
					order.setRemarks("很不错");
					try {
						//添加订单
						DaoFactory.getOrderDaoInstance().add(order);
						//修改库存
						DaoFactory.getGoodsDaoInstance().updateStore(cart.gid,cart.getNum());
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				try {
					addlist = DaoFactory.getAddressDaoInstance().selectbyid(user.getId());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.setAttribute("address",addlist);
				request.setAttribute("cartshoplist", list);
				request.setAttribute("totalPrice", totalPrice);
				request.setAttribute("scid", scid);
				request.getRequestDispatcher("order.jsp").forward(request, response);
			} else if (action.equals("pay")) {
				String scids[] = scid.split(",");
				for (int i = 0; i < scids.length; i++) {
					try {
						result = DaoFactory.getOrderDaoInstance().updatestatue(Integer.parseInt(scids[i]));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				response.sendRedirect("ok.jsp");
			}else if(action.equals("viewbyid")){
				try {
					order=DaoFactory.getOrderDaoInstance().getById(Integer.parseInt(oid));
					cart =DaoFactory.getCartDaoInstance().getById(order.getScid());
					good =DaoFactory.getGoodsDaoInstance().getById(cart.gid);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				request.setAttribute("order", order);
				request.setAttribute("cart", cart);
				request.setAttribute("good", good);
				request.getRequestDispatcher("orderxq.jsp").forward(request, response);
			}else if (action.equals("receive")) {
				
					try {
						result = DaoFactory.getOrderDaoInstance().updatestatuereceive(Integer.parseInt(scid));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				
				response.sendRedirect("myorder.jsp");
			}else if (action.equals("updateOrder")) {
			response.sendRedirect("myorder.jsp");
		}
			else if(action.equals("delete")){
				 int ooid  =Integer.parseInt(request.getParameter("oid"));
				 try {
					result=DaoFactory.getOrderDaoInstance().deleteOrder(ooid);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				 if (result) 
					 request.getRequestDispatcher("orderManagement.jsp").forward(request, response);
				
			}else if(action.equals("updateZT")){
				 int ooid  =Integer.parseInt(request.getParameter("oid"));
				 try {
					 int  sscid=DaoFactory.getOrderDaoInstance().getById(ooid).getScid();
					result=DaoFactory.getOrderDaoInstance().updatesend(sscid);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				 if (result) 
					 request.getRequestDispatcher("orderManagement.jsp").forward(request, response);
				
			}else if(action.equals("deleteAll")){
				String ids[]=request.getParameterValues("all");
				 int i=0;
				 String condition="";
				 for(i=0;i<ids.length;i++){
					 condition+=ids[i];
				 if(i!=ids.length-1) condition+=",";
				 }
				 
				try {
					result=DaoFactory.getOrderDaoInstance().deleteAll(condition);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(result==true)
					request.getRequestDispatcher("orderManagement.jsp").forward(request, response);
			}
			
		}

//		if(action.equals("viewbyunpaid")){
//			try {
//				//order=DaoFactory.getOrderDaoInstance().viewbyunpaid();
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			request.setAttribute("order", order);
//			}
	}

}
