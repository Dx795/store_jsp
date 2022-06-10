<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="topbar-wrap black"  >
    <div class="topbar-inner clearfix">
        <div class="topbar-logo-wrap clearfix" >
            <ul class="navbar-list clearfix">
                <li><a class="on" href="index.html">首页</a></li>
                <li><a href="#" target="_blank">网站首页</a></li>
            </ul>
        </div>
        <div class="top-info-wrap">
            <ul class="top-info-list clearfix">
                <li><a href="#">管理员</a></li>
                <li><a href="#">修改密码</a></li>
                <li><a href="login.jsp">退出</a></li>
            </ul>
        </div>
    </div>
</div>
    <div class="sidebar-wrap">
        <div class="sidebar-title">
            <h1>菜单</h1>
        </div>
        <div class="sidebar-content">
            <ul class="sidebar-list">
                <li>
                    <a href="#"><i class="icon-font">&#xe003;</i>常用操作</a>
                    <ul class="sub-menu">
                        <li><a href="userManagement.jsp"><i class="icon-font">&#xe008;</i>用户管理</a></li>
                        <li><a href="goodsManagement.jsp"><i class="icon-font">&#xe005;</i>商品管理</a></li>
                        <li><a href="categoryManagement.jsp"><i class="icon-font">&#xe006;</i>分类管理</a></li>
                        <li><a href="orderManagement.jsp"><i class="icon-font">&#xe004;</i>订单管理</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>

</body>
</html>