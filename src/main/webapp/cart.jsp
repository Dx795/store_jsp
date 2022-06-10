<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="logined.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*,com.bean.*,com.daofactory.DaoFactory,com.util.*"%>
<style type="text/css">
.aaa:hover {
	color: red;
}
</style>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="utf-8" />
<title>cart</title>

<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/proList.css" />
<link rel="stylesheet" type="text/css" href="css/alterpages.css" />
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
		User user = (User) session.getAttribute("user");
		int mid = user.getId();
		System.out.print(mid+"1111111111111111111111111111111111");
		request.setCharacterEncoding("utf-8");
		
		ArrayList<Cart> carts = (ArrayList) DaoFactory.getCartDaoInstance().getByMid(mid);
		
		int curPages = 0;
		int resultconts = 0;//取得总的数据数
		int totalPages = 0;
		List<Cart> cartlist = null;
		//分页逻辑开始
		if(carts != null){
			ArrayList<Goods> goods = DaoFactory.getGoodsDaoInstance().getAll();
			for (int i = 0; i < carts.size(); i++) {
				for (int j = 0; j < goods.size(); j++) {
					if (carts.get(i).getGid() == goods.get(j).getGid())
						carts.get(i).setCid(goods.get(j).getCid());
						//orders.get(i).setIntroduction(goods.get(j).getIntroduction());
				}
			}
			Pagination m_pages = new Pagination();
			curPages = m_pages.curPages(m_pages.strPage(request, "page"));//获取当前页码
			m_pages.setRows(4);//设置每页显示3条
			 resultconts = carts.size();//取得总的数据数
			 totalPages = m_pages.getPages(resultconts);//取出总页数
			cartlist = m_pages.getPageSet(carts, curPages);//获取指针的结果集参数是(结果集，页数)
			//分页逻辑结束
			
		}
		request.setAttribute("carts", cartlist);

		//这里是显示头部的类别用的 在head.jsp中用到
		ArrayList<Category> categories = DaoFactory.getCategoryDaoInstance().getAll();
		request.setAttribute("categories", categories);
	%>
	<!--------------------------------------cart--------------------->
	<%@include file="head.jsp"%>

	<div class="cart mt" style="margin-top: 0px !important;">
		<!-----------------site------------------->
		<div class="site">
			<p class=" wrapper clearfix">
				<span class="fl">购物车</span> <img class="top"
					src="img/temp/cartTop01.png"> <a href="index.jsp" class="fr">继续购物&gt;</a>
			</p>
		</div>
		<!-----------------table------------------->
		<div class="table wrapper">
			<div class="tr">
				<div>商品</div>
				<div>单价</div>
				<div>数量</div>
				<div>小计</div>
				<div>操作</div>
			</div>
			<c:forEach var="cart" items="${carts}">
			
				<div class="th">
					<div class="pro clearfix">
						<label class="fl"> <input type="checkbox" name="ck"
							value="${cart.scid}" /> <span></span>
						</label> <a class="fl" href="#">
							<dl class="clearfix">
								<dt class="fl">
									<a href="GoodsServlet?type=viewbygid&gid=${cart.gid}&cid=${cart.cid}"><img width="120" height="120" src="${cart.img}"></a>
								</dt>
								<dd class="fl">
									<p>${cart.gname}</p>

								</dd>
							</dl>
						</a>
					</div>
					<div class="price">￥${cart.price}</div>
					<div class="number">
						<p class="num clearfix">
							<img class="fl sub" src="img/temp/sub.jpg"> <span
								datasrc="${cart.scid}" class="fl">${cart.num}</span> <img
								class="fl add" src="img/temp/add.jpg">
						</p>
					</div>
					<div class="price sAll">￥${cart.price*cart.num}</div>
					<div class="price">
						<a class="del" datasrc="${cart.scid}" href="#2">删除</a>
					</div>
				</div>
			</c:forEach>

			<div class="goOn">
				空空如也~<a href="index.jsp">去逛逛</a>
			</div>
			<div class="tr clearfix">
				<label class="fl"> <input class="checkAll" type="checkbox" />
					<span></span>
				</label>
				<p class="fl">
					<a href="#">全选</a> <a href="javascript:toorder('deleteall')"
						class="del">删除</a>
				<div style="text-align: center;">
					<a class="aaa" href="cart.jsp?page=1">首页</a>
					<%
						if (curPages > 1) {
					%>
					<a class="aaa" href="cart.jsp?page=<%=curPages - 1%>">上一页</a>
					<%
						}
					%>
					<%
						if (curPages < totalPages) {
					%>
					<a class="aaa" href="cart.jsp?page=<%=curPages + 1%>">下一页</a>
					<%
						}
					%>
					<a class="aaa" href="cart.jsp?page=<%=totalPages%>">末页</a>
				</div>
				<script>
					function changBkColor(obj) {
						obj.onmouseover = function() {
							this.className = "over";
						};//鼠标悬停事件
						obj.onmouseout = function() {
							this.className = "out";
						};//鼠标离开事件
						obj.onmousedown = function() {
							this.className = "down";
						};//鼠标点击时触发事件
					}
				</script>
				</p>
				<p class="fr">
					<span>共<small id="sl">0</small>件商品
					</span> <span>合计:&nbsp;<small id="all">￥0.00</small></span> <a
						href="javascript:toorder('buy')" class="count">结算</a>
				</p>
			</div>
		</div>
	</div>
	<script>
		function toorder(action) {
			var str = "";

			$("input[name='ck']:checked").each(function(index, item) {
				if ($("input[name='ck']:checked").length - 1 == index) {
					str += $(this).val();
				} else {
					str += $(this).val() + ",";
				}

			});
			if (action == 'deleteall') {
				location.href = "CartServlet?scid=" + str + "&action=" + action;
			} else {
				location.href = "OrderServlet?scid=" + str+"&action=addorder";
			}

		}
	</script>
	<div class="mask"></div>
	<div class="tipDel">
		<p>确定要删除该商品吗？</p>
		<p class="clearfix">
			<a class="fl cer" href="#">确定</a> <a class="fr cancel" href="#">取消</a>
		</p>
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
	<script src="js/cart.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>
