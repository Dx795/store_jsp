<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*,com.bean.*,com.daofactory.DaoFactory,com.util.*" %>
<style type="text/css">
 .fenye{
 background-color: white;
			color: #000000;
			padding: 10px;
			text-decoration: none;
			font-size: 16px;
			box-shadow: #666 0px 0px 6px;
 }
 .fenye:hover{
			background-color: #AAAAAA;
		}
</style>
<%
request.setCharacterEncoding("UTF-8");

		ArrayList<Goods> goods=(ArrayList)DaoFactory.getGoodsDaoInstance().getAll();
		request.setAttribute("goods", goods);
		
		//显示类别查询
		ArrayList<Category> categories=DaoFactory.getCategoryDaoInstance().getAll();
		request.setAttribute("categories", categories);
		
		
		//分页逻辑开始
		Pagination m_pages = new Pagination();
		int curPages = m_pages.curPages(m_pages.strPage(request, "page"));//获取当前页码
		m_pages.setRows(8);//设置每页显示8条
		int resultconts = goods.size();//取得总的数据数
		int totalPages = m_pages.getPages(resultconts);//取出总页数
		ArrayList<Goods> goodslist = m_pages.getPageSet(goods, curPages);//获取指针的结果集参数是(结果集，页数)
		request.setAttribute("goodslist", goodslist);
		//分页逻辑结束
		
%>
<!DOCTYPE html>
<html>
	<head lang="en">
		<meta charset="utf-8" />
		<title>最家</title>
		<link rel="stylesheet" type="text/css" href="css/public.css"/>
		<link rel="stylesheet" type="text/css" href="css/index.css" />
	</head>
	<body>
	<!-------------------------头部--------------------------->
		<%@include file="head.jsp" %>
		<!-------------------------banner--------------------------->
		<div class="block_home_slider">
			<div id="home_slider" class="flexslider">
				<ul class="slides">
					<li>
						<div class="slide">
							<img src="img/banner2.jpg"/>
						</div>
					</li>
					<li>
						<div class="slide">
							<img src="img/banner1.jpg"/>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
		<!------------------------------thImg------------------------------>
		<div class="thImg">
			<div class="clearfix">
				<a href="vase_proList.jsp"><img src="img/i1.jpg"/></a>
				<a href="proList.jsp"><img src="img/i2.jpg"/></a>
				<a href="#2"><img src="img/i3.jpg"/></a>
			</div>
		</div>	
		<!------------------------------people------------------------------>
		<div class="people">
			<div class="wrapper">
				<h2><img src="img/ih3.jpg"/></h2>
				<div class="pList clearfix tran "  >
					<c:forEach items="${goodslist}" var="good">
						<div  style="float: left; width: 287.5px; ">
							<a href="GoodsServlet?type=viewbygid&gid=${good.gid}&cid=${good.cid}" >
								<dl style="padding-left: 25px;">
									<dt>
										<span class="abl"></span>
											<img src="${good.picture}" />
										<span class="abr"></span>
									</dt>
									<dd>${good.gname}</dd>
									<dd><span>￥${good.price}</span></dd>
								</dl>
							</a>
						</div>	
					</c:forEach>			
				</div>
			</div>
		</div>
		<!--分页显示按钮-->
			<div style="align-content: center; margin:0 auto; width:252px; height: 40px;padding-top: 30px;">
					<a href="index.jsp?page=1" class="fenye">首页</a> <%
								 if (curPages > 1) {
								 %><a class="fenye" href="index.jsp?page=<%=curPages - 1%>">上一页</a> <%
								 }
								 %> <%
								 if (curPages < totalPages) {
								 %><a class="fenye" href="index.jsp?page=<%=curPages + 1%>">下一页</a> <%
								 }
								 %> <a class="fenye" href="index.jsp?page=<%=totalPages%>">末页</a> 
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
		
		<!-------------------login-------------------------->
		<!--底部-->
		<%@include file="footer.jsp" %>
		
		<script src="js/jquery-1.12.4.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/nav.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/jquery.flexslider-min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			$(function() {
				$('#home_slider').flexslider({
					animation: 'slide',
					controlNav: true,
					directionNav: true,
					animationLoop: true,
					slideshow: true,
					slideshowSpeed:2000,
					useCSS: false
				});

			});
		</script>
		
		
	</body>
</html>
