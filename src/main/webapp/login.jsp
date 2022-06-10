<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%request.setCharacterEncoding("UTF-8"); %>
<meta charset="UTF-8">
<title>登录</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/login.css" />
</head>
<body>
	<!-------------------login-------------------------->
	<div class="login">
		<form action="UserServlet?action=login" method="post">
			<h1>
				<a href="index.jsp"><img src="img/temp/logo.png"></a>
			</h1>
			<p></p>

			<p>
				<input type="text" style="width: 250px; height: 40px"
					name="username" value="" placeholder="用户名">
			</p>
			<p>
				<input type="password" style="width: 250px; height: 40px" name="password"
					value="" placeholder="密码">
			</p>
			<p>
				<input type="submit"  name="" value="登  录">
			</p>
			<p class="txt">
				<a class="" href="reg.jsp">免费注册</a><a href="forget.jsp">忘记密码？</a><a href="adminlogin.jsp">管理员登陆</a>
			</p>
		</form>
	</div>

</body>
</html>
