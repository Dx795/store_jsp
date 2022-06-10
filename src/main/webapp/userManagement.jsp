<%@include file="adminlogined.jsp" %>
<%@page import="com.daofactory.DaoFactory"%>
<%@page import="com.bean.Category"%>
<%@page import="com.util.Pagination"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%@include file="adminlogined.jsp" %>
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
function deleteuser(id){
	if(confirm("你确定要删除该记录吗？")==true)
		window.location="adminUserservlet?action=userdelete&uid="+id;
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
		ArrayList<User> user=new ArrayList<User>();	
		String keyword=request.getParameter("keyword");
		request.setAttribute("keyword", keyword);	
		System.out.print(keyword);
		if(keyword==null)
			user=DaoFactory.getUserDAOInstance().getAll();
		else
			user=DaoFactory.getUserDAOInstance().getByname(keyword);
		
		//定义变量
		
		
		request.setAttribute("user", user);
%>
<body>
<%@include file="adminHead.jsp" %>
<div class="container clearfix">
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="adminIndex.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">用户管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="userManagement.jsp" method="post">
                    <table class="search-tab">
                        <tr>
                            <th width="120">  <a href="#"><i class="icon-font"></i>快速检索</a> </th>
                            <td><input class="common-text" placeholder="用户关键字" name="keyword" value="${requestScope.keyword}" id="" type="text"></td>
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
                        <a href="userInsert.jsp"><i class="icon-font"></i>新增用户</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                        <a id="batchDel" href="#"><i class="icon-font"></i>
                        <input type="checkbox" id="selAll" onclick="selectAll();" />&nbsp;全选 &nbsp;
						<input type="checkbox" id="inverse" onclick="notSelectAll();" />&nbsp;反选</a> 
                        <input class="btn btn-primary" type="submit" formaction="adminUserservlet?action=deleteAll" value="批量删除" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a id="updateOrd" href="javascript:void(0)"><i class="icon-font"></i>更新排序</a>
                    </div>
                </div>
                <div class="result-content">
               
                
                    <table class="result-tab" width=1000px">
                        <tr>
                            <th width="10px"></th>
                            <th style="text-align: center;" width="70px">用户名</th>
                            <th style="text-align: center;" width="100px">用户密码</th>
                            <th style="text-align: center;" width="100px">用户余额</th>
                            <th style="text-align: center;" width="100px">用户电话</th>
                            <th style="text-align: center;" width="100px">用户地址</th>
                            <th style="text-align: center;" width="100px">用户等级</th>
                             <th style="text-align: center;" width="100px">操作</th>
                        </tr>
                        
                        <c:forEach items="${user}" var="user">
	                        <tr>
	                        	<td>
	                        		<input type="checkbox" value="${user.id}"  name="all" id="checkAll"  onclick="setSelectAll();"/>
	                        	</td>
								<td style="text-align: center;">${user.username}</td>
								<td style="text-align: center;">${user.password}</td>
								<td style="text-align: center;">${user.balance}</td>
								<td style="text-align: center;">${user.phone}</td>
								<td style="text-align: center;">${user.address}</td>
								<td style="text-align: center;">${user.level}</td>
								<td style="text-align: center;">
	                                <a class="link-update" href="adminUserservlet?action=uptade&uid=${user.id}" >修改</a>                      
	                                <a class="link-del" href="javascript:void(0);" onclick="deleteuser(${user.id})">删除</a>
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