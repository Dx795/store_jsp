<%@page import="com.bean.Cart"%>
<%@page import="com.bean.Order"%>
<%@page import="com.bean.User"%>
<%@page import="com.daofactory.DaoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bean.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>后台管理</title>
    
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
		<link rel="stylesheet" type="text/css" href="css/mygxin.css" />
		<script type="text/javascript" src="../js/public.js"></script>
</head>
<%

request.setCharacterEncoding("UTF-8");
	ArrayList<Goods>  goods =DaoFactory.getGoodsDaoInstance().getAll();
	request.setAttribute("goodsize", goods.size());
	
	ArrayList<User>  users =DaoFactory.getUserDAOInstance().getAll();
	request.setAttribute("usersize", users.size());
	
	ArrayList<Order>  orders =DaoFactory.getOrderDaoInstance().getAll();
	request.setAttribute("orders", orders.size());
	
	double zhongshu=0.0;
	if(orders!=null)
	for(int i=0;i<orders.size();i++)
	{	
		zhongshu+=((DaoFactory.getCartDaoInstance().getByAdminId(orders.get(i).getScid())).getPrice())*((DaoFactory.getCartDaoInstance().getByAdminId(orders.get(i).getScid())).getNum());
	}
	request.setAttribute("zhongshu", zhongshu);
%>
<body>
	<%@include file="adminHead.jsp" %>
<div class="container clearfix">

    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font">&#xe06b;</i><span>欢迎来到牛逼商城~~~~~</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-title">
                <h1>快捷操作</h1>
            </div>
            <div class="result-content">
                <div class="short-wrap">
                    <a href="goodInsert.jsp"><i class="icon-font">&#xe001;</i>新增商品</a>
                    <a href="userInsert.jsp"><i class="icon-font">&#xe005;</i>新增用户</a>
                    <a href="categoryManagement.jsp"><i class="icon-font">&#xe048;</i>新增分类</a>
                    <a href="orderManagement.jsp"><i class="icon-font">&#xe041;</i>查看订单</a>
                </div>
            </div>
        </div>
        <div class="result-wrap">
            <div class="result-title">
                <h1>系统统计信息</h1>
                
            
            
            <div class="you fl" style="width: 1000px;padding-bottom: 50px;">
							<div class="clearfix fl" style="width: 250px;margin-top: 30px;margin-left: 100px;  padding: 30px;;border: 1px solid #f5f5f5;border-radius: 5%;box-shadow: 5px 5px 10px 5px #e8e8e8">
								<a href="#" class="fl"><img src="img/人数.png" width="100px;"/></a><br>
								<p class="fl" style="margin-left: 20px;"><span>总计用户数：<strong style="color: red;">${usersize}</strong></p>
							</div>
							<div class="clearfix fl" style="width: 250px;margin-top: 30px;margin-left: 100px;  padding: 30px;;border: 1px solid #f5f5f5;border-radius: 5%;box-shadow: 5px 5px 10px 5px #e8e8e8">
								<a href="#" class="fl"><img src="img/订.png" width="100px;"/></a><br>
								<p class="fl" style="margin-left: 20px;"><span>已交易订单数：<strong style="color: red;">${orders}</strong>
								</p>
							</div>
							<div class="clearfix fl" style="width: 250px;margin-top: 30px;margin-left: 100px;  padding: 30px;;border: 1px solid #f5f5f5;border-radius: 5%;box-shadow: 5px 5px 10px 5px #e8e8e8">
								<a href="#" class="fl"><img src="img/商品.png" width="100px;"/></a><br>
								<p class="fl" style="margin-left: 20px;"><span>销售商品数：<strong style="color: red;">${goodsize}</strong>
								</p>
							</div>
							<div class="clearfix fl" style="width: 250px;margin-top: 30px;margin-left: 100px;  padding: 30px;;border: 1px solid #f5f5f5;border-radius: 5%;box-shadow: 5px 5px 10px 5px #e8e8e8">
								<a href="#" class="fl"><img src="img/收益.png" width="100px;"/></a><br>
								<p class="fl" style="margin-left: 15px;"><span>目前营业额：<strong style="color: red;">${zhongshu}</strong>
								</p>
							
            </div>
       
            </div>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>