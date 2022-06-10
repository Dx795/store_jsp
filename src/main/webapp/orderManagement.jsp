<%@include file="adminlogined.jsp" %>
<%@page import="com.bean.Order"%>
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
function deleteorder(id){
	if(confirm("你确定要删除该记录吗？")==true)
		window.location="OrderServlet?action=delete&oid="+id+"&scid=shuju";
}
</script>

<head>
    <meta charset="UTF-8"/>
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
</head>
<%	
request.setCharacterEncoding("UTF-8");
		//定义变量
		ArrayList<Order> orders=new ArrayList<Order>();

		String keyword=request.getParameter("keyword");
		request.setAttribute("keyword", keyword);	
		
		if(keyword==null)
			orders=DaoFactory.getOrderDaoInstance().getAll();
		else
			orders=DaoFactory.getOrderDaoInstance().getByName(keyword);	


		request.setAttribute("orders", orders);
%>
<body>
<%@include file="adminHead.jsp" %>
<div class="container clearfix">
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="adminIndex.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">订单管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="orderManagement.jsp" method="post">
                    <table class="search-tab">
                        <tr>
                            <th width="150">订单快速查询 ：  </th>
                            <td><input class="common-text" placeholder="关键字" name="cname" type="text"></td>
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
                        <a id="batchDel" href="#"><i class="icon-font"></i>
                        <input type="checkbox" id="selAll" onclick="selectAll();" />&nbsp;全选 &nbsp;
						<input type="checkbox" id="inverse" onclick="notSelectAll();" />&nbsp;反选</a> 
                        <input class="btn btn-primary" type="submit" formaction="OrderServlet?action=deleteAll&scid=shuju" value="批量删除" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </div>
                <div class="result-content">
                    <table class="result-tab" width=1000px;">
                        <tr>
                            <th width="10px"></th>
                            <th style="text-align: center;" width="70px">订单编号</th>
                            <th style="text-align: center;" width="100px">收货人</th>
                             <th style="text-align: center;" width="100px">收货地址</th>
                             <th style="text-align: center;" width="100px">下单时间</th>
                             <th style="text-align: center;" width="100px">电话</th>
                             <th style="text-align: center;" width="100px">状态</th>
                            <th style="text-align: center;" width="50px">操作</th>
                        </tr>
                        
                        
                        <c:forEach items="${orders}" var="orders">
	                        <tr>
	                        	<td>
	                        		<input type="checkbox" value="${orders.oid}"  name="all" id="checkAll"  onclick="setSelectAll();"/>
	                        	</td>
	                        	<td style="text-align: center; width: 50px;">${orders.oid}</td>
								<td style="text-align: center;">${orders.consignee}</td>
								<td style="text-align: center;">${orders.address}</td>
								<td style="text-align: center;">${orders.createtime}</td>
								<td style="text-align: center;">${orders.phone}</td>
								<c:choose>
									<c:when test="${orders.statue==-1}">
										<td style="text-align: center;">已完成</td>
									</c:when>
									<c:when test="${orders.statue==0}">
										<td style="text-align: center;">待支付</td>
									</c:when>
									<c:when test="${orders.statue==1}">
										<td style="text-align: center;">待发货</td>
									</c:when>		
										<c:when test="${orders.statue==2}">
										<td style="text-align: center;">待收货</td>
									</c:when>
								</c:choose>					
								<td style="text-align: center;">   
								 <c:choose>
									<c:when test="${orders.statue==1}">
										<a class="link-del" href="OrderServlet?action=updateZT&oid=${orders.oid}&scid=shuju">点击发货</a>    
									</c:when>		
								</c:choose>		             
	                                <a class="link-del" href="javascript:void(0);" onclick="deleteorder(${orders.oid})">退款</a>
	                            </td>
	                        </tr>
					</c:forEach>	
                    </table>    

                </div>
            </form>
            	             
            
        </div>
    </div>
    <!--/main-->
</div>

</body>
</html>