package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.bean.Cart;
import  com.bean.Goods;
import com.bean.User;
import  com.daofactory.DaoFactory;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartServlet() {
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
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		 HttpSession session = request.getSession();
		 User user=(User)session.getAttribute("user");
		 if(user!=null ) {
			 	Cart cart = new Cart();
				boolean result = false;
				int mid = user.getId();
				System.out.println(mid);
				String action = request.getParameter("action");
				String scid = request.getParameter("scid");
				String count = request.getParameter("count");
				String gid = request.getParameter("gid");
				String cid = request.getParameter("cid");
				String url = request.getParameter("url");
				System.out.println(action+count+url);
				if (action.equals("add")) {
					
					// 通过用户mip和购物车的商品gid来查找是否存在已添加商品的记录
					Cart exsistGood = null;
					try {
						exsistGood = DaoFactory.getCartDaoInstance().getExsistGood(mid, Integer.parseInt(gid));
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
							if (exsistGood != null) {
								int oldNum = exsistGood.getNum();
								int newNum = oldNum + Integer.parseInt(count);
								// 如果数量大于5，限制购买
								if (newNum >= 5) {
									newNum = 5;
								}
							try {
								boolean result1= DaoFactory.getCartDaoInstance().updateNum(exsistGood.getScid(), newNum);
									if (result1 == true) {
										System.out.println("更新成功 ");
									} else {
										System.out.println("更新失败");
									}
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							if (url.equals("add")) {
								response.sendRedirect("GoodsServlet?type=viewbygid&gid=" + gid + "&cid=" + cid);
							} else {
								response.sendRedirect("cart.jsp");
							}
						}else {
							try {
								Goods good = DaoFactory.getGoodsDaoInstance().getById(Integer.parseInt(gid));
								cart = new Cart(good.getPicture(), good.getGname(), good.getPrice(), Integer.parseInt(count), good.getStock(), Integer.parseInt(gid), mid,1);
								result = DaoFactory.getCartDaoInstance().add(cart);
								if (result == true) {
									if (url.equals("add")) {
										response.sendRedirect("GoodsServlet?type=viewbygid&gid=" + gid + "&cid=" + cid);
									} else {
										response.sendRedirect("cart.jsp");
									}
				
								} else {
									PrintWriter out = response.getWriter();
									out.write("<script>");
									out.write("alert('添加购物车失败')");
									out.write("location.href='flowerDer.jsp'");
									out.write("</script>");
									return;
								}
									
							} catch (Exception e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
			}else if (action.equals("update")) {
				try {
					DaoFactory.getCartDaoInstance().updateNum(Integer.parseInt(scid),Integer.parseInt(count));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else if (action.equals("delete")) {
					DaoFactory.getCartDaoInstance().deleteCart(Integer.parseInt(scid));
			}else if (action.equals("deleteall")) {
				if (scid.equals("")) {//判断传过来的值是否为空字符串
					response.sendRedirect("cart.jsp");
				}else {
					String scids[] = scid.split(",");
					for (int i = 0; i < scids.length; i++) {
						DaoFactory.getCartDaoInstance().deleteCart(Integer.parseInt(scids[i]));
					}
					response.sendRedirect("cart.jsp");
				}
			}
		 }else {
			 PrintWriter out = response.getWriter();
				
				out.write("<script>");
				out.write("alert('登录后，再购买')");
				out.write("location.href='login.jsp'");
				out.write("</script>");
				out.close();
		}
		
		// else if(){
////			try {
////				ArrayList<Cart> carts = DaoFactory.getCartDaoInstance().getByMid(mid);
////				request.setAttribute("carts", carts);
////				request.getRequestDispatcher("cart.jsp").forward(request, response);
////			} catch (Exception e) {
////				// TODO Auto-generated catch block
////				e.printStackTrace();
////			}
//		}

	}

}
