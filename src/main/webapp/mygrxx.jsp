<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page import="com.bean.Category"%>
	    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.daofactory.DaoFactory"%>
<%@page import="com.bean.User"%>

<!DOCTYPE html>
<%
//显示类别查询

//显示类别查询
	ArrayList<Category> categories=DaoFactory.getCategoryDaoInstance().getAll();
	request.setAttribute("categories", categories);
		request.setCharacterEncoding("UTF-8");
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
		<link rel="stylesheet" type="text/css" href="css/public.css"/>
		<link rel="stylesheet" type="text/css" href="css/mygrxx.css" />
		    <script type="text/javascript">
    function viewImage(file){
        var preview = document.getElementById('preview');
        if(file.files && file.files[0]){
            //火狐下
            preview.style.display = "block";
            preview.style.width = "250px";
            preview.src = window.URL.createObjectURL(file.files[0]);
        }else{
            //ie下，使用滤镜
            file.select();
            var imgSrc = document.selection.createRange().text;
            var localImagId = document.getElementById("localImag"); 
            //必须设置初始大小 
            localImagId.style.width = "250px"; 

            try{ 
            localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
            locem("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc; 
            }catch(e){ 
            alert("您上传的图片格式不正确，请重新选择!"); 
            return false; 
            } 
            preview.style.display = 'none'; 
            document.selection.empty(); 
            } 
            return true; 
    }
    </script>
	</head>
	<body>
	
		<!------------------------------head------------------------------>
<%@include file="head.jsp" %>
		<!------------------------------idea------------------------------>
		<div class="address mt" style="margin-top: 0px !important;">
			<div class="wrapper clearfix">
				<a href="index.jsp" class="fl">首页</a>
				<span>/</span>
				<a href="mygxin.jsp" class="on">个人信息</a>
			</div>
		</div>
		
		<!------------------------------Bott------------------------------>
		<div class="Bott">
			<div class="wrapper clearfix">
				<div class="zuo fl">
					<h3>
						<a href="#"><img src="img/tx.png"/></a>
						<p class="clearfix"><span class="fl"></span>ID:${user.username}<span class="fr">[登出]</span></p>
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
							<li  class="on"><a href="mygrxx.jsp">个人信息</a></li>
							<li><a href="remima.jsp">修改密码</a></li>
						</ul>
					</div>
				</div>
				<div class="you fl">
					<h2>个人信息</h2>
					<div class="gxin">
						<div class="tx"><a href="#"><img src="img/tx.png"/><p id="avatar">修改头像</p></a></div>
						<div class="xx">
							<h3 class="clearfix"><strong class="fl">基础资料</strong><a href="#" class="fr" id="edit1">编辑</a></h3>
						
							<div>昵称：${user.nicheng}</div>
							<div>用户名：${user.username}</div>
							<div>余额：${user.balance}</div>
							<div>性别：${user.sex}</div>
							<div>生日：${user.birthday}</div>
							<div>电话：${user.phone}</div>
							<div>地址：${user.address}</div>
				
							<h3>高级设置</h3>
							<!--<div><span class="fl">银行卡</span><a href="#" class="fr">管理</a></div>-->
							<div><span class="fl">账号地区：中国</span><a href="#" class="fr" id="edit2">修改</a></div>
						</div>
					</div>			
				</div>
			</div>
		</div>
		<div class="mask"></div>
		<!--编辑弹框-->
		<div class="bj">
			<div class="clearfix"><a href="#" class="fr gb"><img src="img/icon4.png"/></a></div>
			<h3>编辑基础资料</h3>
			<form action="UserServlet?action=updateuser&username=${user.username}" method="post">
				<p><label>昵称：</label><input type="text" name="nicheng" value="${user.nicheng}" /></p>
				<p><label>电话：</label><input type="text" name="phone" value="${user.phone}" /></p>
				<p>
					<label>性别：</label>
					<span><input type="radio" name="sex" value="男"/>男</span>
					<span><input type="radio" name="sex" value="女"/>女</span>
				
				</p>
				<p><label>地址：</label><input type="text" name="address" value="${user.address}" /></p>
				<p><label>生日：</label><input type="text" name="birthday" value="${user.birthday}" /></p>
				<div class="bc">
					<input type="submit" value="保存"  />
					<input type="button" value="取消" />
				</div>
			</form>
		</div>
		<!--高级设置修改-->
		<div class="xg">
			<div class="clearfix"><a href="#" class="fr gb"><img src="img/icon4.png"/></a></div>
			<h3>切换账号地区</h3>
			<form action="#" method="get">
				<p><label>姓名：</label><input type="text"  value="六六六" /></p>
				<div class="bc">
					<input type="button" value="保存" />
					<input type="button" value="取消" />
				</div>
			</form>
		</div>
		<!--修改头像-->
		<div class="avatar">
			<div class="clearfix"><a href="#" class="fr gb"><img src="img/icon4.png"/></a></div>
			<h3>修改头像</h3>
			<form action="UserServlet?action=updatepicture&username=${user.username}" method="post">
                  <img id="preview" src="picture">
                  <input type="file" name="picture" onchange="viewImage(this)">
				<p>jpg或png，大小不超过2M</p>
				<input type="submit" value="提交" />
			</form>
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
		<!--footer-->
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
			<p class="dibu">牛逼商城&copy;2013-2017公司版权所有 京ICP备080100-44备0000111000号<br />
			违法和不良信息举报电话：400-800-8200，本网站所列数据，除特殊说明，所有数据均出自我司实验室测试</p>
		</div>
		<script src="js/jquery-1.12.4.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/user.js" type="text/javascript" charset="utf-8"></script>
	</body>
</html>
    