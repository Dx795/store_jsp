<%@include file="adminlogined.jsp" %>
<%@page import="com.daofactory.DaoFactory"%>
<%@page import="com.bean.Category"%>
<%@page import="com.util.Pagination"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.bean.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<script language="javascript"> 

//选中全选按钮，下面的checkbox全部选中 
var selAll = document.getElementById("selAll"); 
function selectAll() 
{ 
  var obj = document.getElementsByName("all"); 
  if(document.getElementById("selAll").checked == false) 
  { 
	  for(var i=0; i<obj.length; i++) 
	  { 
	    obj[i].checked=false; 
	    Console.log(obj[i].checked)
	  } 
  }else 
  { 
	  for(var i=0; i<obj.length; i++) 
	  {   
	    obj[i].checked=true; 
	  } 
  } 

} 

//当选中所有的时候，全选按钮会勾上 
function setSelectAll() 
{ 
var obj=document.getElementsByName("all"); 
var count = obj.length; 
var selectCount = 0; 

for(var i = 0; i < count; i++) 
{ 
if(obj[i].checked == true) 
{ 
selectCount++; 
} 
} 
if(count == selectCount) 
{ 
document.all.selAll.checked = true; 
} 
else 
{ 
document.all.selAll.checked = false; 
} 
} 

//反选按钮 
function notSelectAll() { 
var checkboxs=document.getElementsByName("all"); 
for (var i=0;i<checkboxs.length;i++) { 
  var e=checkboxs[i]; 
  e.checked=!e.checked; 
  setSelectAll(); 
} 
} 

function deletegood(id){
	if(confirm("你确定要删除该记录吗？")==true)
		window.location="GoodsServlet?type=delete&gid="+id;
}
</script>



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
<head>
    <meta charset="UTF-8"/>
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
</head>
<%	
		
request.setCharacterEncoding("UTF-8");
		//定义变量
		ArrayList<Goods> goods=new ArrayList<Goods>();
		ArrayList<Category> categories=new ArrayList<Category>();
			
		//启动页面 查询有没有关键字和类别的值 
		//关键字无的话 执行getall方法 有的话根据name的like查找 
		//有类别的话 得两个条件一起查询
		//关键字
		String keyword=request.getParameter("keyword");
		request.setAttribute("keyword", keyword);	
		//类别 如果没值 就默认查全部
		String SelectCategorie=request.getParameter("SelectCategorie");
		request.setAttribute("SelectCategorie", SelectCategorie);	

		
		//类别
		if(SelectCategorie==null||SelectCategorie.equals("全部"))
		{
			//关键字
			if(keyword==null)
				goods=DaoFactory.getGoodsDaoInstance().getAll();
			else
				goods=DaoFactory.getGoodsDaoInstance().getByName(keyword);
		}
		else
		{
			System.out.print(SelectCategorie+"????????????????????????");
			int cid=((Category)DaoFactory.getCategoryDaoInstance().getByName(SelectCategorie)).getCid();
			if(keyword==null||keyword.equals(""))
			{
				goods=DaoFactory.getGoodsDaoInstance().getbyCid(cid);
			}
			else
				goods=DaoFactory.getGoodsDaoInstance().getbyCidAndName(cid, keyword);
		}
		

		
		
		
		//头部的分类框赋值 也让good表中的cid根据分类表给分类名
		categories=DaoFactory.getCategoryDaoInstance().getAll();
		
		request.setAttribute("categories", categories);
		
		if(goods!=null)
		//根据cid赋类别名字
		for (int i = 0; i < goods.size(); i++) {
			for (int j = 0; j < categories.size(); j++) {
				if(goods.get(i).getCid()==categories.get(j).getCid())
					goods.get(i).setCidname(categories.get(j).getCname());
			}}
			
	
		
		//分页逻辑开始
		int resultconts=0,totalPages=0,curPages=0;ArrayList<Goods> goodslist=new ArrayList<Goods>();
		if(goods!=null){
		Pagination m_pages = new Pagination();
		 curPages = m_pages.curPages(m_pages.strPage(request, "page"));//获取当前页码
		m_pages.setRows(5);//设置每页显示5条
		 resultconts = goods.size();//取得总的数据数
		 totalPages = m_pages.getPages(resultconts);//取出总页数
		 goodslist= m_pages.getPageSet(goods, curPages);//获取指针的结果集参数是(结果集，页数)
		}
		//分页逻辑结束
		
		//设置显示的对象集合
		request.setAttribute("goodslist", goodslist);
		//底部页码的传值
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("curPages", curPages);
		int a=resultconts%5;
		request.setAttribute("tiaoshu", a);
%>
<body>
<%@include file="adminHead.jsp" %>
<div class="container clearfix">
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="adminIndex.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">作品管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="goodsManagement.jsp" method="post">
                    <table class="search-tab">
                        <tr>
                            <th width="120">选择分类:</th>
                            <td>
                                <select name="SelectCategorie" id="fenleiSelect" >
                                    <option value="全部">全部</option>
                                     <c:forEach items="${categories}" var="categorie">
					                        <option value="${categorie.cname}">${categorie.cname}</option>
									</c:forEach>	
                                </select>
                            </td>
                            <th width="70">关键字:</th>
                            <td><input class="common-text" placeholder="关键字" name="keyword" value="${requestScope.keyword}" id="" type="text"></td>
                            <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="GoodsServlet?type=insertGood"><i class="icon-font"></i>新增作品</a>&nbsp;&nbsp;&nbsp;&nbsp;
                       
                        
                        
                        <a id="batchDel" href="GoodsServlet?type=deleteAll"><i class="icon-font"></i>
                        <input type="checkbox" id="selAll" onclick="selectAll();" />&nbsp;全选 &nbsp;
						<input type="checkbox" id="inverse" onclick="notSelectAll();" />&nbsp;反选</a> 
                        <input class="btn btn-primary" type="submit" formaction="GoodsServlet?type=deleteAll" value="批量删除" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a id="updateOrd" href="javascript:void(0)"><i class="icon-font"></i>更新排序</a>
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width=1200px">
                        <tr>
                            <th width="10px"></th>
                            <th style="text-align: center;" width="70px">商品ID</th>
                            <th style="text-align: center;" width="100px">商品名</th>
                            <th style="text-align: center;" width="70px">售价</th>
                            <th style="text-align: center;" width="70px">进货价</th>
                            <th style="text-align: center;" width="70px">库存</th>
                            <th style="text-align: center;" width="70px">图片</th>
                            <th style="text-align: center;" width="100px">类别</th>
                            <th style="text-align: center;" width="70px">好评分数</th>
                            <th style="text-align: center;" width="70px">销量</th>
                             <th style="text-align: center;" width="100px">操作</th>
                        </tr>
                        
                        
                        <c:forEach items="${goodslist}" var="good">
	                        <tr>
	                        	<td>
	                        		<input type="checkbox" value="${good.gid}"  name="all" id="checkAll"  onclick="setSelectAll();"/>
	                        	</td>
	                        	<td style="text-align: center;">${good.gid}</td>
								<td style="text-align: center;">${good.gname}</td>
								<td style="text-align: center;">${good.price}元</td>
								<td style="text-align: center;">${good.inPrice}元</td>       
								<td style="text-align: center;">${good.stock}件</td>           
								<td style="text-align: center;"> <img style="width: 80px;height: 80px;" src="${good.picture}"></td>          
								<td style="text-align: center;">${good.cidname}</td>           
								<td style="text-align: center;">${good.highPraise}分</td>   
								<td style="text-align: center;">${good.sales}件</td>                          
	                            <td style="text-align: center;">
	                            
	                                <a class="link-update" href="GoodsServlet?type=viewbygidadmin&gid=${good.gid}&quanxian=admin">修改</a>                      
	                                <a class="link-del" href="javascript:void(0);" onclick="deletegood(${good.gid})">删除</a>
	                            </td>
	                        </tr>
					</c:forEach>	

                    </table>
                    <!--分页显示按钮-->
                    <%if(resultconts>=5) {%>
			<div style="align-content: center; margin:0 auto; width:260px; height: 40px;padding-top: 30px;">
					<a href="goodsManagement.jsp?page=1" class="fenye">首页</a> <%
								 if (curPages > 1) {
								 %><a class="fenye" href="goodsManagement.jsp?page=<%=curPages - 1%>">上一页</a> <%
								 }
								 %> <%
								 if (curPages < totalPages) {
								 %><a class="fenye" href="goodsManagement.jsp?page=<%=curPages + 1%>">下一页</a> <%
								 }
								 %> <a class="fenye" href="goodsManagement.jsp?page=<%=totalPages%>">末页</a> 
			</div>
			<%} %>
					 <!--条数-->						
                    <div class="list-page">  
                    <%if (curPages ==totalPages) {%>
								${tiaoshu}<%}else{ %>
                    5 
                    <% }%>条 ${curPages} / ${totalPages} 页
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!--/main-->
</div>
</body>
</html>