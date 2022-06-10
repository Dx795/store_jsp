<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/login.css" />
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/function.js"></script>


<style>
.reg p .error {
	display: inline-block;
	border: 1px solid #ff855a;
	background-color: #ffe8e0;
	height: 25px;
	line-height: 25px;
	padding: 0px 10px;
	margin-left: 10px;
}
</style>
</head>
<body>
	<!-------------------reg-------------------------->

	<div class="reg">
		<form action="UserServlet?action=insert" method="post"
			onsubmit="return checkForm(this)">
			<h1>
				<a href="index.jsp"><img src="img/temp/logo.png"></a>
			</h1>
			<h1
				style="padding:0px; magin: 0px; font-size: 20px; background: #ffffff; text-align: center; line-height: 30px; line-width:10px;color: #000000">用户注册</h1>
			<p>
				<input type="text" name="userName" value=""
					onfocus="FocusItem(this)" onblur="CheckItem(this)"
					placeholder="请输入用户名"><span></span>
			</p>

			<p>
				<input type="password" name="passWord" size="10" value=""
					onfocus="FocusItem(this)" onblur="CheckItem(this)"
					placeholder="请输入密码"><span></span>
			</p>
			<p>
				<input type="password" name="rePassWord" value=""
					onfocus="FocusItem(this)" onblur="CheckItem(this)"
					placeholder="请输确认密码"><span></span>
			</p>
			<p>
				<input type="text" name="phone" value="" placeholder="请输入手机号码"><span></span>
			</p>
			<p>
				<input class="code" type="text" name="veryCode" value=""
					onfocus="FocusItem(this)" onblur="CheckItem(this)"
					placeholder="验证码"> <img height="25" src="getcode"
					alt="看不清，换一张" onclick="change(this)"><span></span>
			</p>
			<p>
				<input type="submit" name="" value="注册">
			</p>
			<p></p>
			<p class="txtL txt">
				完成此注册，即表明您同意了我们的<a href="#"> <使用条款和隐私策略></a>
			</p>
			<p class="txt">
				<a href="login.jsp" ><span></span>已有账号登录</a>
			</p>
	
		</form>
	</div>
</body>
</html>