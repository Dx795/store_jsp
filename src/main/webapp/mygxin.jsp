<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*,com.bean.*,com.daofactory.DaoFactory,com.util.*"%>
<!DOCTYPE html>
<hyml>
	<head lang="en">
		<meta charset="utf-8" />
		<title>个人信息</title>
		<link rel="stylesheet" type="text/css" href="css/public.css"/>
		<link rel="stylesheet" type="text/css" href="css/mygxin.css" />
	</head>
	<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("username");
	User user=DaoFactory.getUserDaoInstance().selectbyname(name);
	request.setAttribute("user", user);
	
	//显示类别查询
	ArrayList<Category> categories=DaoFactory.getCategoryDaoInstance().getAll();
	request.setAttribute("categories", categories);
	%>
		<%@include file="head.jsp" %>
		<!------------------------------idea------------------------------>
		<div class="address mt" style="margin-top: 0px !important;" id="add">
			<div class="wrapper clearfix">
				<a href="index.jsp" class="fl">首页</a>
				<span>/</span>
				<a href="mygxin.jsp" class="on">个人中心</a>
			</div>
		</div>
		
		<!------------------------------Bott------------------------------>
		<div class="Bott">
			<div class="wrapper clearfix">
				<div class="zuo fl">
					<h3>
						<a href="#"><img src="img/tx.png"/></a>
						<p class="clearfix"><span class="fl">欢迎：${user.getUsername()}</span><span class="fr">[登出]</span></p>
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
							<li  class="on"><a href="mygxin.jsp">我的中心</a></li>
							<li><a href="address.jsp">地址管理</a></li>
						</ul>
						<h4>账户管理</h4>
						<ul>
							<li><a href="mygrxx.jsp">个人信息</a></li>
							<li><a href="remima.jsp">修改密码</a></li>
						</ul>
					</div>
				</div>
				<div class="you fl">
					<div class="tx clearfix">
						<div class="fl clearfix">
							<a href="#" class="fl"><img src="img/tx.png"/></a>
							<p class="fl"><span>${user.getUsername()}</span><a href="mygrxx.jsp">修改个人信息></a></p>
						</div>
						<div class="fr">绑定手机号：${user.getPhone()}</div>
					</div>
					<div class="bott">
						<div class="clearfix">
							<a href="#" class="fl"><img src="img/gxin1.jpg"/></a>
							<p class="fl"><span>待支付的订单：<strong>0</strong></span>
								<a href="myorder.jsp">查看待支付订单></a>
							</p>
						</div>
						<div class="clearfix">
							<a href="#" class="fl"><img src="img/gxin2.jpg"/></a>
							<p class="fl"><span>待收货的订单：<strong>0</strong></span>
								<a href="myorder.jsp">查看待收货订单></a>
							</p>
						</div>
						<div class="clearfix">
							<a href="#" class="fl"><img src="img/gxin3.jpg"/></a>
							<p class="fl"><span>待评价的订单：<strong>0</strong></span>
								<a href="myprod.jsp">查看待评价订单></a>
							</p>
						</div>
						<div class="clearfix">
							<a href="#" class="fl"><img src="img/gxin4.jpg"/></a>
							<p class="fl"><span>喜欢的商品：<strong>0</strong></span>
								<a href="#">查看喜欢的商品></a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		
		<!--返回顶部-->
		<div class="gotop">
			<a href="cart.jsp">
			<dl>
				<dt><img src="img/gt1.png"/></dt>
				<dd>去购<br />物车</dd>
			</dl>
			</a>
			<a href="#" class="dh">
			<dl>
				<dt><img src="img/gt2.png"/></dt>
				<dd>联系<br />客服</dd>
			</dl>
			</a>
			<a href="mygxin.jsp">
			<dl>
				<dt><img src="img/gt3.png"/></dt>
				<dd>个人<br />中心</dd>
			</dl>
			</a>
			<a href="#" class="toptop" style="display: none">
			<dl>
				<dt><img src="img/gt4.png"/></dt>
				<dd>返回<br />顶部</dd>
			</dl>
			</a>
			<p>400-800-8200</p>
		</div>
		<div class="footer">
			<div class="top">
				<div class="wrapper">
					<div class="clearfix">
						<a href="#2" class="fl"><img src="img/foot1.png"/></a>
						<span class="fl">7天无理由退货</span>
					</div>
					<div class="clearfix">
						<a href="#2" class="fl"><img src="img/foot2.png"/></a>
						<span class="fl">15天免费换货</span>
					</div>
					<div class="clearfix">
						<a href="#2" class="fl"><img src="img/foot3.png"/></a>
						<span class="fl">满599包邮</span>
					</div>
					<div class="clearfix">
						<a href="#2" class="fl"><img src="img/foot4.png"/></a>
						<span class="fl">手机特色服务</span>
					</div>
				</div>
			</div>
			<p class="dibu">最家家居&copy;2013-2017公司版权所有 京ICP备080100-44备0000111000号<br />
			违法和不良信息举报电话：400-800-8200，本网站所列数据，除特殊说明，所有数据均出自我司实验室测试</p>
		</div>
		<script src="js/jquery-1.12.4.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/user.js" type="text/javascript" charset="utf-8"></script>
		
	</body>
</html>
