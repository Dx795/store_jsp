<%@page import="com.bean.Goods"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%
	request.setCharacterEncoding("UTF-8");
	//显示类别查询
	ArrayList<Category> categories = DaoFactory.getCategoryDaoInstance().getAll();
	request.setAttribute("categories", categories);
%>
<html>
<head>
<meta charset="UTF-8">
<title>详情页</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/proList.css" />
<script>
		function shopAdd(id, url, action, cid) {
			
			var stock = $("[id='stock']").text();
			var count = $("[id='count']").text();
			
			//var count = document.getElementById("count").innerHTML;
			
			if (parseInt(count)> parseInt(stock)) {

				//将商品的id,数量,和图片的路径传入;
				alert("库存不足，添加购物车失败!");
			} else {
				location.href = 'CartServlet?gid=' + id + '&count=' + count
						+ '&url=' + url + '&action=' + action + '&cid=' + cid;
			}

		}
	</script>
</head>
<body>
	<!------------------------------head------------------------------>
	<%@include file="head.jsp"%>


	<!-----------------头部address------------------------------->
	<div class="address">
		<div class="wrapper clearfix">
			<a href="index.html">首页</a> <span>/</span> <a href="flowerDer.html">装饰摆件</a>
			<span>/</span> <a href="#" class="on">${good.gname}</a>
		</div>
	</div>
	<!-----------------------小详情Detail------------------------------>
	<div class="detCon">
		<div class="proDet wrapper">
			<div class="proCon clearfix">
				<div class="proImg fl">
					<img class="det" src="${good.picture}" />
					<div class="smallImg clearfix">

						<!---------------小展示图片------------------------------------->
						<c:forEach items="${zsimg}" var="zsimg" begin="0" step="1" end="3">
							<img src="${zsimg}" data-src="${zsimg}">
						</c:forEach>
					</div>
				</div>

				<div class="fr intro">
					<div class="title">
						<h4>${good.gname}</h4>
						<p>${good.introduction}</p>
						<span>￥${good.price}</span>
					</div>
					<div class="proIntro">
						<p>颜色分类</p>
						<!---------------详情图片------------------------------------->
						<div class="smallImg clearfix categ">
							<c:forEach items="${img}" var="img">
								<p class="fl on">
									<img src="${img}" alt="白瓷花瓶+20支快乐花" data-src="${img}">
								</p>
							</c:forEach>


						</div>
						<p>
							数量&nbsp;&nbsp;库存<span id="stock">${good.stock}</span>件
						</p>
						<div class="num clearfix">
							<img class="fl sub" src="img/temp/sub.jpg"> <span
								id="count" class="fl" contentEditable="true">1</span> <img
								class="fl add" src="img/temp/add.jpg">
							<p class="please fl">请选择商品属性!</p>
						</div>
					</div>
					<div class="btns clearfix">
						<a onclick="shopAdd(${good.gid },'buy','add',${good.cid })"><p class="buy fl">立即购买</p></a> 
						<a onclick="shopAdd(${good.gid },'add','add',${good.cid })"><p class="cart fr">加入购物车</p></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	

	<!-----------------------大详情图------------------------------>
	<div class="introMsg wrapper clearfix">
		<div class="msgL fl" style="width: 0px;">
			<div class="msgTit clearfix"
				style="position: absolute; width: 910px;">
				<a class="on">商品详情</a> <a style="position: relative; left: 5%;">所有评价</a>
			</div>
			<br> <br> <br> <br>
			<div class="msgAll" style="width: 910px;">

				<div class="msgImgs">
					<c:forEach items="${zsimg}" var="zsimg">
						<img style="width: 850px; height: 800px;" src="${zsimg}">
					</c:forEach>
				</div>

				<div class="eva" style="width: 900px;">
					<!-----------------------评论------------------------------>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per01.jpg">
						<div class="perR fl">
							<p>馨***呀</p>
							<p>不好意思评价晚了，产品很好，价格比玻璃品便宜，没有我担心的杂色，发货快，包装好，全5分</p>
							<div class="clearfix">
								<p>
									<img src="img/temp/eva01.jpg">
								</p>
								<p>
									<img src="img/temp/eva02.jpg">
								</p>
								<p>
									<img src="img/temp/eva03.jpg">
								</p>
								<p>
									<img src="img/temp/eva04.jpg">
								</p>
								<p>
									<img src="img/temp/eva05.jpg">
								</p>
							</div>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per02.jpg">
						<div class="perR fl">
							<p>么***周</p>
							<p>花瓶超级棒，我看图以为是光面的，收货发现是磨砂，但感觉也超有质感，很喜欢。磨砂上面还有点纹路，不过觉得挺自然的，不影响美观。包装也很好，绝对不会磕碎碰坏，好评！</p>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per01.jpg">
						<div class="perR fl">
							<p>馨***呀</p>
							<p>不好意思评价晚了，产品很好，价格比玻璃品便宜，没有我担心的杂色，发货快，包装好，全5分</p>
							<div class="clearfix">
								<p>
									<img src="img/temp/eva01.jpg">
								</p>
								<p>
									<img src="img/temp/eva02.jpg">
								</p>
								<p>
									<img src="img/temp/eva03.jpg">
								</p>
								<p>
									<img src="img/temp/eva04.jpg">
								</p>
								<p>
									<img src="img/temp/eva05.jpg">
								</p>
							</div>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per02.jpg">
						<div class="perR fl">
							<p>么***周</p>
							<p>花瓶超级棒，我看图以为是光面的，收货发现是磨砂，但感觉也超有质感，很喜欢。磨砂上面还有点纹路，不过觉得挺自然的，不影响美观。包装也很好，绝对不会磕碎碰坏，好评！</p>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per01.jpg">
						<div class="perR fl">
							<p>馨***呀</p>
							<p>不好意思评价晚了，产品很好，价格比玻璃品便宜，没有我担心的杂色，发货快，包装好，全5分</p>
							<div class="clearfix">
								<p>
									<img src="img/temp/eva01.jpg">
								</p>
								<p>
									<img src="img/temp/eva02.jpg">
								</p>
								<p>
									<img src="img/temp/eva03.jpg">
								</p>
								<p>
									<img src="img/temp/eva04.jpg">
								</p>
								<p>
									<img src="img/temp/eva05.jpg">
								</p>
							</div>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per02.jpg">
						<div class="perR fl">
							<p>么***周</p>
							<p>花瓶超级棒，我看图以为是光面的，收货发现是磨砂，但感觉也超有质感，很喜欢。磨砂上面还有点纹路，不过觉得挺自然的，不影响美观。包装也很好，绝对不会磕碎碰坏，好评！</p>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per01.jpg">
						<div class="perR fl">
							<p>馨***呀</p>
							<p>不好意思评价晚了，产品很好，价格比玻璃品便宜，没有我担心的杂色，发货快，包装好，全5分</p>
							<div class="clearfix">
								<p>
									<img src="img/temp/eva01.jpg">
								</p>
								<p>
									<img src="img/temp/eva02.jpg">
								</p>
								<p>
									<img src="img/temp/eva03.jpg">
								</p>
								<p>
									<img src="img/temp/eva04.jpg">
								</p>
								<p>
									<img src="img/temp/eva05.jpg">
								</p>
							</div>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per02.jpg">
						<div class="perR fl">
							<p>么***周</p>
							<p>花瓶超级棒，我看图以为是光面的，收货发现是磨砂，但感觉也超有质感，很喜欢。磨砂上面还有点纹路，不过觉得挺自然的，不影响美观。包装也很好，绝对不会磕碎碰坏，好评！</p>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per01.jpg">
						<div class="perR fl">
							<p>馨***呀</p>
							<p>不好意思评价晚了，产品很好，价格比玻璃品便宜，没有我担心的杂色，发货快，包装好，全5分</p>
							<div class="clearfix">
								<p>
									<img src="img/temp/eva01.jpg">
								</p>
								<p>
									<img src="img/temp/eva02.jpg">
								</p>
								<p>
									<img src="img/temp/eva03.jpg">
								</p>
								<p>
									<img src="img/temp/eva04.jpg">
								</p>
								<p>
									<img src="img/temp/eva05.jpg">
								</p>
							</div>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
					<div class="per clearfix">
						<img class="fl" src="img/temp/per02.jpg">
						<div class="perR fl">
							<p>么***周</p>
							<p>花瓶超级棒，我看图以为是光面的，收货发现是磨砂，但感觉也超有质感，很喜欢。磨砂上面还有点纹路，不过觉得挺自然的，不影响美观。包装也很好，绝对不会磕碎碰坏，好评！</p>
							<p>
								<span>2016年12月27日08:31</span><span>颜色分类：大中小三件套（不含花）</span>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="msgR fr" style="width: 250px; align-content: center;">
			<h4>为你推荐</h4>

			<div class="seeList">
				<c:forEach items="${tuijianGoods}" var="tuijianGood">
					<a href="#">
						<dl>
							<dt>
								<img style="width: 161px; height: 243px;"
									src="${tuijianGood.picture}">
							</dt>
							<dd>${tuijianGood.gname}</dd>
							<dd>￥${tuijianGood.price}</dd>
						</dl>
					</a>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="like">
		<h4>猜你喜欢</h4>
		<div class="bottom">
			<div class="hd">
				<span class="prev"><img src="img/temp/prev.png"></span> <span
					class="next"><img src="img/temp/next.png"></span>
			</div>

			<div class="imgCon bd">
				<div class="likeList clearfix">
					<div>
						<c:forEach items="${cainixihGoods}" var="cainixihGood">
							<a
								href="GoodsServlet?type=viewbygid&gid=${cainixihGood.gid}&cid=${cainixihGood.cid}">
								<dl>
									<dt>
										<img src="${cainixihGood.picture}">
									</dt>
									<dd>${cainixihGood.gname}</dd>
									<dd>￥${cainixihGood.price}</dd>
								</dl>
							</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--返回顶部-->
	<div class="gotop">
		<a href="cart.jsp">
			<dl class="goCart">
				<dt>
					<img src="img/gt1.png" />
				</dt>
				<dd>
					去购<br />物车
				</dd>
				<span>1</span>
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
	<div class="msk"></div>
	<!--底部-->
	<%@include file="footer.jsp"%>
	<script src="js/jquery-1.12.4.min.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="js/jquery.SuperSlide.2.1.1.js" type="text/javascript"
		charset="utf-8"></script>
	<script src="js/public.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/nav.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/pro.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/cart.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		jQuery(".bottom").slide({
			titCell : ".hd ul",
			mainCell : ".bd .likeList",
			autoPage : true,
			autoPlay : false,
			effect : "leftLoop",
			autoPlay : true,
			vis : 1
		});
	</script>
</body>
</html>
