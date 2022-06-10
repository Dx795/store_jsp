<%@page import="com.bean.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.daofactory.DaoFactory"%>
<%@page import="com.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%
//显示类别查询


		ArrayList<Category> categories=DaoFactory.getCategoryDaoInstance().getAll();
		request.setAttribute("categories", categories);
		
		String name=(String)session.getAttribute("username");
		User user=new User();
		if(name!=null)
		{
			user=DaoFactory.getUserDaoInstance().selectbyname(name);
			request.setAttribute("user", user);
		}
		else
			System.out.print("");
%>
<html>
<head lang="en">
<meta charset="utf-8" />
<title>个人信息</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/mygrxx.css" />
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/function.js"></script>
</head>
<body>
	<!------------------------------head------------------------------>
	<%@include file="head.jsp" %>
	<!------------------------------idea------------------------------>
	<div class="address mt" style="margin-top: 0px !important;">
		<div class="wrapper clearfix">
			<a href="index.jsp" class="fl">首页</a> <span>/</span> <a
				href="mygxin.jsp" class="on">个人信息</a>
		</div>
	</div>

	<!------------------------------Bott------------------------------>
	<div class="Bott" >
		<div class="wrapper clearfix" >
			<div class="zuo fl">
				<h3>
					<a href="#"><img src="img/tx.png" /></a>
					<p class="clearfix">
						<span class="fl">用户名:${user.username}</span><span class="fr">[登出]</span>
					</p>
				</h3>
				<div>
					<h4>我的交易</h4>
					<ul>
						<li><a href="cart.jsp">我的购物车</a></li>
						<li><a href="myorderq.jsp">我的订单</a></li>
						<li><a href="myprod.jsp">评价晒单</a></li>
					</ul>
					<h4>个人中心</h4>
					<ul>
						<li><a href="mygxin.jsp">我的中心</a></li>
						<li><a href="address.jsp">地址管理</a></li>
					</ul>
					<h4>账户管理</h4>
					<ul>
						<li><a href="mygrxx.jsp">个人信息</a></li>
						<li class="on"><a href="remima.jsp">修改密码</a></li>
					</ul>
				</div>
			</div>
			<div class="you fl">
				<h2>修改密码</h2>
				<form action="UserServlet?action=repassword&username=${user.username}" method="post" class="remima">
					<p>
						<span>原密码：</span><input type="password"  name="oldpassword "/>
					</p>
					<p class="op">输入原密码</p>
					<p>
						<span>新密码：</span><input name="newpassword" type="password" />
					</p>
					<p class="op">3-16 个字符，需使用字母、数字或符号组合</p>
					<p>
						<span>重复新密码：</span><input type="password" name="renewpassword" />
					</p>
					<p class="op">请再次输入密码</p>
					<input class="op" style=margin-left:150px type="text" name="veryCode" value=""
					onfocus="FocusItem(this)" onblur="CheckItem(this)"
					placeholder="验证码"> <img height="25" src="getcode"
					alt="看不清，换一张" onclick="change(this)"><span></span>
					<p class="op">按右图输入验证码，不区分大小写</p>
					<input type="submit" value="提交" />
				</form>
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
			违法和不良信息举报电话：400-800-8200，本网站所列数据，除特殊说明，所有数据均出自我司实验室测试
		</p>
	</div>
	<script src="js/jquery-1.12.4.min.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/user.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>
