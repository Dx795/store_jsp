<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>login</title>
        <link rel="stylesheet" href="css/login_style.css" type="text/css">
        <%request.setCharacterEncoding("UTF-8"); %>
    </head>
    <body>
        <form action="AdminServlet?&type=login">
        <div class="table">
            <div class="div-body"  >
                <div class="panel-login" style="height: 370px;">
                    <div class="panel-login-left">
 		            <p style="margin-top: 50px;margin-bottom: 50px;"><a href="index.html">后台管理</a></p>
                        <img src="img/zh-touxiang-2.jpg" class="login-img" />
                       
                    </div>
                    <div class="panel-login-right" >
                        <div class="input-type-login">
                            <p>用户登录</p>
                            <input type="text" placeholder="用户名" name="adminName" class="text-style input" >
                            <input type="password" placeholder="密码" name="adminPassword" class="text-style input">
                            <input type="submit" value="登录" class="button-style input">
                        </div>
                    </div>
                </div>

            </div>
        </div>
        
        </form>
    </body>
</html>