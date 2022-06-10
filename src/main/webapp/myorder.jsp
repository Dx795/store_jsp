<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="logined.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.util.*,com.bean.*,com.daofactory.*"%>

<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="utf-8" />
<title>最家</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/myorder.css" />
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<Category> categories=DaoFactory.getCategoryDaoInstance().getAll();
	request.setAttribute("categories", categories);
	
		User user = (User) session.getAttribute("user");
		ArrayList<Order> orders = DaoFactory.getOrderDaoInstance().getAll(user.getId());
		//String strGid = " ";
		//String strScid = " ";
		
		//for (int i = 0; i < orders.size(); i++) {
			//strGid +=  orders.get(i).getGid();
			//strScid += orders.get(i).getScid();

			//if (i != orders.size() - 1) {
				//strGid +=",";
				//strScid +=",";
			//}
		//}
		//System.out.println(strGid);
		//System.out.println(strScid);
		ArrayList<Goods> goods = DaoFactory.getGoodsDaoInstance().getAll();
		ArrayList<Cart> cart = DaoFactory.getCartDaoInstance().getAll(user.getId());
		for (int i = 0; i < orders.size(); i++) {
			for (int j = 0; j < goods.size(); j++) {
				if (orders.get(i).getGid() == goods.get(j).getGid())
					orders.get(i).setGname(goods.get(j).getGname());
					//orders.get(i).setIntroduction(goods.get(j).getIntroduction());
			}
		}
		for (int i = 0; i < orders.size(); i++) {
			for (int j = 0; j < cart.size(); j++) {
				if (orders.get(i).getScid() == cart.get(j).getScid())
					orders.get(i).setPrice(cart.get(j).getPrice());
					orders.get(i).setNum(cart.get(j).getNum());
			}
		}
		request.setAttribute("orders", orders);
		//分页逻辑开始
		Pagination m_pages = new Pagination();
		int curPages = m_pages.curPages(m_pages.strPage(request, "page"));//获取当前页码
		m_pages.setRows(4);//设置每页显示3条
		int resultconts = orders.size();//取得总的数据数
		int totalPages = m_pages.getPages(resultconts);//取出总页数
		orders = m_pages.getPageSet(orders, curPages);//获取指针的结果集参数是(结果集，页数)
		request.setAttribute("orders", orders);
		request.setAttribute("resultconts", resultconts);
		//分页逻辑结束
	%>
	<!------------------------------head------------------------------>
	<%@include file="head.jsp" %>
	<!------------------------------idea------------------------------>
	<div class="address mt" style="margin-top: 0px !important;">
		<div class="wrapper clearfix">
			<a href="#" class="fl">首页</a> <span>/</span> <a href="mygxin.jsp">个人中心</a>
			<span>/</span> <a href="myorderq.jsp" class="on">我的订单</a>
		</div>
	</div>

	<!------------------------------Bott------------------------------>
	<div class="Bott">
		<div class="wrapper clearfix" >
			<div class="zuo fl">
				<h3>
					<a href="#"><img src="img/tx.png" /></a>
					<p class="clearfix">
					<p class="clearfix"><span class="fl">欢迎：${user.getUsername()}</span><span class="fr">[登出]</span></p>
						<!-- <span class="fl">${user.username}</span><span class="fr">[退出登录]</span> -->
					</p>
				</h3>
				<div>
					<h4>我的交易</h4>
					<ul>
						<li><a href="cart.jsp">我的购物车</a></li>
						<li><a href="myorder.jsp">我的订单</a></li>
						<li><a href="myprod.jsp">评价晒单</a></li>
					</ul>
					<h4>个人中心</h4>
					<ul>
						<li><a href="mygxin.jsp">我的中心</a></li>
						<li><a href="address.jsp">地址管理</a></li>
					</ul>
					<h4>账户管理</h4>
					<ul>
						<li class="on"><a href="mygrxx.jsp">个人信息</a></li>
						<li><a href="remima.jsp">修改密码</a></li>
					</ul>
				</div>
			</div>
			<div class="you fl">
				<div class="my clearfix">
					<h2 class="fl">我的订单</h2>
					<a href="#" class="fl">请谨防钓鱼链接或诈骗电话，了解更多&gt;</a>
				</div>


				<div class="dlist clearfix">
					<ul class="fl clearfix" id="wa">
						<li class="on"><a href="#2">全部有效订单</a><a>(${resultconts})</a></li>
						<li><a href="#">待支付</a></li>
						<li><a href="#">待发货</a></li>
						<li><a href="#">待收货</a></li>
						<li><a href="#">已完成</a></li>
					</ul>
					<form action="myorder.jsp" method="post" class="fr clearfix">
						<input type="text" name="" id="" value="${requestScope.keyword}"
							placeholder="请输入商品名称、订单号" /> <input type="button" name="" id=""
							value="" />
					</form>
				</div>

				<c:forEach items="${orders}" var="order">
					<div class="dkuang">
						<c:set var="statue" scope="session" value="${order.statue}" />
						<c:choose>
							<c:when test="${order.statue==-1}">
								<p class="one">已完成</p>
							</c:when>
							<c:when test="${order.statue==0}">
								<p class="one" style="color: #a10000;">待支付</p>
							</c:when>
							<c:when test="${order.statue==1}">
								<p class="one" style="color: #a10000;">待发货</p>
							</c:when>
							<c:when test="${order.statue==2}">
								<p class="one" style="color: #a10000;">待收货</p>
							</c:when>
						</c:choose>
						<div class="word clearfix">
							<ul class="fl clearfix">
								<li>${order.createtime}</li>
								<li>${order.consignee}</li>
								<li>${order.oid}</li>
								<li>在线支付</li>
							</ul>
							<p class="fr">
								订单金额：<span>${order.num * order.price}</span>元
							</p>
						</div>
						<div class="shohou clearfix">
							<a href="#" class="fl"><img src="${order.img}" /></a>
							<p class="fl">
								<a href="#">${order.gname}</a><a href="#">¥${order.price}×${order.num}</a>
							</p>
							<c:choose>
								<c:when test="${order.statue==-1}">
									<p class="fr">
										<a href="#">已收货</a> <a
											href="OrderServlet?action=viewbyid&oid=${order.oid}&scid=${order.scid}">订单详情</a>
									</p>
								</c:when>
								<c:when test="${order.statue==0}">
									<p class="fr">
										<a href="OrderServlet?scid=${order.scid}&action=pay" style="background: #A10000; color: #fff;">立即支付</a>
										<a
											href="OrderServlet?action=viewbyid&oid=${order.oid}&scid=${order.scid}">订单详情</a>
									</p>
								</c:when>
								<c:when test="${order.statue==1}">
									<p class="fr">
										<a  style="background: #A10000; color: #fff;">等待发货</a>
										<a href="OrderServlet?action=viewbyid&oid=${order.oid}&scid=${order.scid}">订单详情</a>
									</p>
								</c:when>
								<c:when test="${order.statue==2}">
									<p class="fr">
										<a href="OrderServlet?scid=${order.scid}&action=receive" style="background: #A10000; color: #fff;">确认收货</a>
										<a
											href="OrderServlet?action=viewbyid&oid=${order.oid}&scid=${order.scid}">订单详情</a>
									</p>
								</c:when>
							</c:choose>
						</div>
					</div>
				</c:forEach>



				<a class="aaa" href="myorder.jsp?page=1">首页</a>
				<%
					if (curPages > 1) {
				%>
				<a class="aaa" href="myorder.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a class="aaa" href="myorder.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%>
				<a class="aaa" href="myorder.jsp?page=<%=totalPages%>">末页</a>

			</div>
		</div>
	</div>
	<!--返回顶部-->
	<div class="gotop">
		<a href="cart.jsp">
			<dl>
				<dt>
					<img src="img/gt1.png" />
				</dt>
				<dd>
					去购<br />物车
				</dd>
			</dl>
		</a> <a href="#" class="dh">
			<dl>
				<dt>
					<img src="img/gt2.png" />
				</dt>
				<dd>
					联系<br />客服
				</dd>
			</dl>
		</a> <a href="mygxin.jsp">
			<dl>
				<dt>
					<img src="img/gt3.png" />
				</dt>
				<dd>
					个人<br />中心
				</dd>
			</dl>
		</a> <a href="#" class="toptop" style="display: none">
			<dl>
				<dt>
					<img src="img/gt4.png" />
				</dt>
				<dd>
					返回<br />顶部
				</dd>
			</dl>
		</a>
		<p>400-800-8200</p>
	</div>
	<!--footer-->
	<div class="footer">
		<div class="top">
			<div class="wrapper">
				<div class="clearfix">
					<a href="#2" class="fl"><img src="img/foot1.png" /></a> <span
						class="fl">7天无理由退货</span>
				</div>
				<div class="clearfix">
					<a href="#2" class="fl"><img src="img/foot2.png" /></a> <span
						class="fl">15天免费换货</span>
				</div>
				<div class="clearfix">
					<a href="#2" class="fl"><img src="img/foot3.png" /></a> <span
						class="fl">满599包邮</span>
				</div>
				<div class="clearfix">
					<a href="#2" class="fl"><img src="img/foot4.png" /></a> <span
						class="fl">手机特色服务</span>
				</div>
			</div>
		</div>
		<p class="dibu">
			最家家居&copy;2013-2017公司版权所有 京ICP备080100-44备0000111000号<br />
			违法和不良信息举报电话：188-0130-1238，本网站所列数据，除特殊说明，所有数据均出自我司实验室测试
		</p>
	</div>
	<script src="js/jquery-1.12.4.min.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/user.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>
