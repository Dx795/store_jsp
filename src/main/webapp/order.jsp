<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="logined.jsp"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="utf-8" />
<title>order</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/proList.css" />
<link rel="stylesheet" type="text/css" href="css/mygxin.css" />
</head>
<%
request.setCharacterEncoding("UTF-8");
	//这里是显示头部的类别用的 在head.jsp中用到
	ArrayList<Category> categories = DaoFactory.getCategoryDaoInstance().getAll();
	request.setAttribute("categories", categories);
	User user = (User) session.getAttribute("user");
	String scid = (String) request.getAttribute("scid");
	ArrayList<Address> addresses = (ArrayList) request.getAttribute("address");
%>

<body>
	<!---------------------------------------头部------------------>
	<%@include file="head.jsp"%>
	<div class="order cart mt">
		<!-----------------site------------------->
		<div class="site">
			<p class="wrapper clearfix">
				<span class="fl">订单确认</span> <img class="top"
					src="img/temp/cartTop02.png">
			</p>
		</div>
		<!-----------------orderCon------------------->
		<div class="orderCon wrapper clearfix">
			<div class="orderL fl">
				<!--------h3---------------->
				<h3>
					收件信息<a href="address.jsp" class="fr">新增地址</a>
				</h3>
				<!--------address---------------->
				<div class="addres clearfix">

					<div class="addre fl on">
						<div class="tit clearfix">
							<p class="fl">
								张三1 <span class="default">[默认地址]</span>
							</p>
							<p class="fr">
								<a href="#">删除</a> <span>|</span> <a href="#" class="edit">编辑</a>
							</p>
						</div>
						<div class="addCon">
							<p>河北省&nbsp;唐山市&nbsp;路北区&nbsp;大学生公寓村</p>
							<p>15732570937</p>
						</div>
					</div>
					<c:forEach var="address" items="${address}">
							<div class="addre fl">
								<div class="tit clearfix">
									<p class="fl">${address.addressee}</p>
									<p class="fr">
										<!-- <a href="AddressServlet?action=set&scid=addressee=${address.addressee}&addressee_phone=${address.addressee_phone}&receiving_address=${address.receiving_address}"  -->
										<a href="OrderUpdate?action=sset&scid=${scid}&addressee=${address.addressee}&addressee_phone=${address.addressee_phone}&receiving_address=${address.receiving_address}"class="setDefault">设为默认</a> <span>|</span> <a
											href="#">删除</a> <span>|</span> <a href="#" class="edit">编辑</a>
									</p>
								</div>
								<div class="addCon">
									<p>${address.addressee_phone}</p>
									<p>${address.receiving_address}</p>
								</div>
							</div>
					</c:forEach>
				</div>
				<h3>支付方式</h3>
				<!--------way---------------->
				<div class="way clearfix">
					<img class="on" src="img/temp/way01.jpg"> <img
						src="img/temp/way02.jpg"> <img src="img/temp/way03.jpg">
					<img src="img/temp/way04.jpg">
				</div>
				<h3>选择快递</h3>
				<!--------dis---------------->
				<div class="dis clearfix">
					<span class="on">顺风快递</span> <span>百世汇通</span> <span>圆通快递</span> <span>中通快递</span>
				</div>
			</div>
			<div class="orderR fr">
				<div class="msg">
					<h3>
						订单内容<a href="cart.jsp" class="fr">返回购物车</a>
					</h3>
					<!--------ul---------------->
					<c:forEach var="cartshoplist" items="${requestScope.cartshoplist}">


						<ul class="clearfix">

							<li class="fl"><img width="100" height="100"
								src="${cartshoplist.img}"></li>
							<li class="fl"><p>${cartshoplist.gname}</p>
								<p>颜色分类：烟灰色玻璃瓶</p>
								<p>数量：${cartshoplist.num}</p></li>
							<li class="fr">￥${cartshoplist.price * cartshoplist.num}</li>
						</ul>
					</c:forEach>
				</div>
				<!--------tips---------------->
				<div class="tips">
					<p>
						<span class="fl">商品金额：</span><span class="fr">￥${totalPrice}</span>
					</p>
					<p>
						<span class="fl">优惠金额：</span><span class="fr">￥0.00</span>
					</p>
					<p>
						<span class="fl">运费：</span><span class="fr">免运费</span>
					</p>
				</div>
				<!--------tips count---------------->
				<div class="count tips">
					<p>
						<span class="fl">合计：</span><span class="fr">￥${requestScope.totalPrice}</span>
					</p>
				</div>
				<!--<input type="button" name="" value=""> -->
				<a href="OrderServlet?scid=${scid}&action=pay" class="pay">去支付</a>
			</div>
		</div>
	</div>
	<!--编辑弹框-->
	<!--遮罩-->
	<div class="mask"></div>
	<div class="adddz editAddre">
		<form action="#" method="get">
			<input type="text" placeholder="姓名" class="on" /> <input type="text"
				placeholder="手机号" />
			<div class="city">
				<select name="">
					<option value="省份/自治区">省份/自治区</option>
				</select> <select>
					<option value="城市/地区">城市/地区</option>
				</select> <select>
					<option value="区/县">区/县</option>
				</select> <select>
					<option value="配送区域">配送区域</option>
				</select>
			</div>
			<textarea name="" rows="" cols="" placeholder="详细地址"></textarea>
			<input type="text" placeholder="邮政编码" />
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
		</a> <a href="#" class="toptop" style="display: none;">
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
	<!--底部-->
	<%@include file="footer.jsp"%>
	<script src="js/jquery-1.12.4.min.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/pro.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/user.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>
