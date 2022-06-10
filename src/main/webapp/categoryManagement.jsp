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
function deletecategory(id){
	if(confirm("你确定要删除该记录吗？")==true)
		window.location="CategoryServlet?type=delete&cid="+id;
}

function updatecategory(id){
	if(confirm("你确定要修改该记录吗，会连同商品一起更改哦！！"+newname)==true)
		{
			var newname= document.getElementById(''+id+'leibie')
			var uname = document.querySelector('#'+id+'leibie');
			console.log(uname+newname);    //[object HTMLInputElement]


		window.location="CategoryServlet?type=update&cid="+id+"&newname="+newname;
		}
		
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
		ArrayList<Category> categories=new ArrayList<Category>();
	
		
		categories=DaoFactory.getCategoryDaoInstance().getAll();
		request.setAttribute("categories", categories);
%>
<body>
<%@include file="adminHead.jsp" %>
<div class="container clearfix">
    <!--/sidebar-->
    <div class="main-wrap">

        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="adminIndex.jsp">首页</a><span class="crumb-step">&gt;</span><span class="crumb-name">分类管理</span></div>
        </div>
        <div class="search-wrap">
            <div class="search-content">
                <form action="CategoryServlet?type=insert" method="post">
                    <table class="search-tab">
                        <tr>
                            <th width="50">  </th>
                            <th width="70">类别名:</th>
                            <td><input class="common-text" placeholder="关键字" name="cname" type="text"></td>
                            <td><input class="btn btn-primary btn2" name="sub" value="新增" type="submit"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="result-wrap">
            <form name="myform" id="myform" method="post">
                <div class="result-title">
                    <div class="result-list">
                        <a href="categoryInsert.jsp"><i class="icon-font"></i>新增类别</a>&nbsp;&nbsp;&nbsp;&nbsp; 
                        <a id="batchDel" href="GoodsServlet?type=deleteAll"><i class="icon-font"></i>
                        <input type="checkbox" id="selAll" onclick="selectAll();" />&nbsp;全选 &nbsp;
						<input type="checkbox" id="inverse" onclick="notSelectAll();" />&nbsp;反选</a> 
                        <input class="btn btn-primary" type="submit" formaction="CategoryServlet?type=deleteAll" value="批量删除" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a id="updateOrd" href="javascript:void(0)"><i class="icon-font"></i>更新排序</a>
                    </div>
                </div>
                <div class="result-content">
               
                
                    <table class="result-tab" width=500px">
                        <tr>
                            <th width="10px"></th>
                            <th style="text-align: center;" width="70px">类别ID</th>
                            <th style="text-align: center;" width="100px">类别名</th>
                            <th style="text-align: center;" width="100px">操作</th>
                        </tr>
                        
                        
                        <c:forEach items="${categories}" var="categorie">
	                        <tr>
	                        	<td>
	                        		<input type="checkbox" value="${categorie.cid}"  name="all" id="checkAll"  onclick="setSelectAll();"/>
	                        	</td>
	                        	<td style="text-align: center; width: 50px;">${categorie.cid}</td>
								<td style="text-align: center;">${categorie.cname}</td>
								<td style="text-align: center;">
	                                <a class="link-update" href="CategoryServlet?type=update&cid=${categorie.cid}" >修改</a>                      
	                                <a class="link-del" href="javascript:void(0);" onclick="deletecategory(${categorie.cid})">删除</a>
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
	<div style="width: 300px; height: 300ox; background-color: black; position: absolute;top: 30px;left: 50px;z-index: 200;">
	    			
	   						 </div>
</body>
</html>