<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*,com.bean.*,com.daofactory.DaoFactory" %>

<%
request.setCharacterEncoding("UTF-8");
		//caregoryServlet后台传值cid过来
		String cid=request.getParameter("cid");
		int ncid=Integer.parseInt(cid);
		
		//商品的显示根据cid去查
		ArrayList<Goods> goods=(ArrayList)DaoFactory.getGoodsDaoInstance().getbyCid(ncid);
		request.setAttribute("goods", goods);
		
		//头部下面有个显示点击的类别，根据cid到类别表去查 获取的类别名字赋值给41行的代码 显示出来
		Category categorie=(Category)DaoFactory.getCategoryDaoInstance().getById(ncid);
		request.setAttribute("categorie", categorie);
		
		//这里是显示头部的类别用的 在head.jsp中用到
		ArrayList<Category> categories=DaoFactory.getCategoryDaoInstance().getAll();
		request.setAttribute("categories", categories);
%>
<!DOCTYPE html>
<html>
	<head lang="en">
		<meta charset="utf-8" />
		<title>商品类别详情</title>
		<link rel="stylesheet" type="text/css" href="css/public.css"/>
		<link rel="stylesheet" type="text/css" href="css/proList.css"/>
	</head>
	<body>
		<%@include file="head.jsp" %>
		<!------------------------------banner------------------------------>
		<div class="banner">
			<a href="#"><img src="img/temp/banner1.jpg"/></a>
		</div>
		<!-----------------address------------------------------->
		<div class="address">
			<div class="wrapper clearfix">
				<a href="index.jsp">首页</a>
				<span>/</span>
				<a href="#" class="on">${categorie.cname}</a>
			</div>
		</div>
		<!-------------------current---------------------->
		<div class="current">
			<div class="wrapper clearfix">
				<h3 class="fl">${categorie.cname}</h3> 
				<div class="fr choice">
					<p class="default">排序方式</p>
					<ul class="select">
						<li>新品上市</li>
						<li>销量从高到低</li>
						<li>销量从低到高</li>
						<li>价格从高到低</li>
						<li>价格从低到高</li>
					</ul>
				</div>
			</div>
		</div>
		<!----------------商品proList------------------------->
		
		<ul class="proList wrapper clearfix">
			<c:forEach items="${goods}" var="good">
				<li>
						<a href="GoodsServlet?type=viewbygid&gid=${good.gid}&cid=${good.cid}">
							<dl>
								<dt><img src="${good.picture}"></dt>
								<dd>${good.gname}</dd>
								<dd>￥${good.price}</dd>
							</dl>
						</a>
				</li>
			</c:forEach>
		</ul>
		<!--侧边---返回顶部-->
		<div class="gotop">
			<a href="cart.jsp">
			<dl class="goCart">
				<dt><img src="img/gt1.png"/></dt>
				<dd>去购<br />物车</dd>
				<span>1</span>
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
			<a href="#" class="toptop" style="display: none;">
			<dl>
				<dt><img src="img/gt4.png"/></dt>
				<dd>返回<br />顶部</dd>
			</dl>
			</a>
			<p>400-800-8200</p>
		</div>
		<div class="msk"></div>
		<!--footer-->
		<%@include file="footer.jsp" %>
		<script src="js/jquery-1.12.4.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/nav.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/pro.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/cart.js" type="text/javascript" charset="utf-8"></script>
	</body>
</html>
