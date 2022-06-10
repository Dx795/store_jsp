<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="java.util.*,com.bean.*,com.daofactory.DaoFactory,com.util.*"%>
<%@ include file="logined.jsp"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("UTF-8");
ArrayList<Category> categories=DaoFactory.getCategoryDaoInstance().getAll();
request.setAttribute("categories", categories);

	//显示类别查询
	User user = (User) session.getAttribute("user");
	ArrayList <Address> addresses = DaoFactory.getAddressDaoInstance().selectbyid(user.getId());
	request.setAttribute("addresses", addresses);
%>


<html>
<head lang="en">
<meta charset="utf-8" />
<title>最家</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/mygxin.css" />
</head>
<body>
	<!------------------------------head------------------------------>
<%@include file="head.jsp" %>
	<!------------------------------idea------------------------------>
	<div class="address mt" style="margin-top: 0px !important;">
		<div class="wrapper clearfix">
			<a href="index.jsp" class="fl">首页</a> <span>/</span> <a
				href="mygxin.jsp">个人中心</a> <span>/</span> <a href="address.jsp"
				class="on">地址管理</a>
		</div>
	</div>

	<!------------------------------Bott------------------------------>
	<div class="Bott">
		<div class="wrapper clearfix">
			<div class="zuo fl">
				<h3>
					<a href="#"><img src="img/tx.png" /></a>
					<p class="clearfix">
						<span class="fl">${user.username}</span><span class="fr">[登出]</span>
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
						<li class="on"><a href="address.jsp">地址管理</a></li>
					</ul>
					<h4>账户管理</h4>
					<ul>
						<li><a href="mygrxx.jsp">个人信息</a></li>
						<li><a href="remima.jsp">修改密码</a></li>
					</ul>
				</div>
			</div>
			<div class="you fl">
				<h2>收货地址</h2>
				<div class="add">
					<div>
						<a href="#2" id="addxad"><img src="img/jia.png" /></a> <span>添加新地址</span>

					</div>
					
						<div id="dizhi">
							<p>${user.nicheng}</p>
							<p>${address.addressee_phone}</p>
							<p>${address.receiving_address}</p>
						</div>
				</div>
			</div>
		</div>
	</div>
	<!--编辑弹框-->
	<!--遮罩-->
	<div class="mask"></div>
	<div class="adddz">
		<form action="AddressServlet?action=addressadd&id=${user.id}"
			method="post">
			<input type="text" name="addressee" placeholder="收件人姓名" class="on" />
			<input type="text" name="addressee_phone" placeholder="收件人手机号" />

			
			<textarea name="receiving_address" rows="" cols="" placeholder="详细地址"></textarea>

			<div class="bc">
				<input type="submit" value="保存" /> <input type="button" value="取消" />
			</div>
		</form>
	</div>
	<div class="readd">
		<form action="#" method="get">
			<input type="text" class="on" value="六六六" /> <input type="text"
				value="157****0022" />
			<div class="city">
				<select name="">
					<option value="省份/自治区">河北省</option>
				</select> <select>
					<option value="城市/地区">唐山市</option>
				</select> <select>
					<option value="区/县">路北区</option>
				</select> <select>
					<option value="配送区域">火炬路</option>
				</select>
			</div>
			<textarea name="" rows="" cols="" placeholder="详细地址">高新产业园</textarea>
			<input type="text" placeholder="邮政编码" value="063000" />
			<div class="bc">
				<input type="button" value="保存" /> <input type="button" value="取消" />
			</div>
		</form>
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
			牛逼商城&copy;2013-2017公司版权所有 京ICP备080100-44备0000111000号<br />
			违法和不良信息举报电话：400-800-8200，本网站所列数据，除特殊说明，所有数据均出自我司实验室测试
		</p>
	</div>
	<script src="js/jquery-1.12.4.min.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/user.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>
