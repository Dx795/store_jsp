<%@include file="adminlogined.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
    <script type="text/javascript">
    function viewImage(file){
        var preview = document.getElementById('preview');
        if(file.files && file.files[0]){
            //火狐下
            preview.style.display = "block";
            preview.style.width = "250px";
            preview.src = window.URL.createObjectURL(file.files[0]);
        }else{
            //ie下，使用滤镜
            file.select();
            var imgSrc = document.selection.createRange().text;
            var localImagId = document.getElementById("localImag"); 
            //必须设置初始大小 
            localImagId.style.width = "250px"; 

            try{ 
            localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
            locem("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc; 
            }catch(e){ 
            alert("您上传的图片格式不正确，请重新选择!"); 
            return false; 
            } 
            preview.style.display = 'none'; 
            document.selection.empty(); 
            } 
            return true; 
    }
    </script>
</head>
<%request.setCharacterEncoding("UTF-8"); %>
<body>
<%@include file="adminHead.jsp" %>
<div class="container clearfix">
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="/jscss/admin/design/">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="/jscss/admin/design/">作品管理</a><span class="crumb-step">&gt;</span><span>新增作品</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">
            <%
            	String tiaozhuan= (String)request.getAttribute("xiugai");
            	if(tiaozhuan==null){
            %>
                <form action="adminUserservlet?action=userinsert" method="post">
                    <table class="insert-tab" width="100%">
                        <tbody>
                        <tr>
                                <th><i class="require-red">*</i>用户名：</th>
                                <td>
                                    <input class="common-text required" id="title" name="adminusername" size="50"  type="text">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>用户密码：</th>
                                <td>
                                    <input class="common-text required" id="title" name="adminpassword" size="50"  type="text">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>用户电话：</th>
                                <td>
                                    <input class="common-text required" id="title" name="userphone" size="50" type="text">
                                </td>
                            </tr>
                              <tr>
                                <th><i class="require-red">*</i>用户地址：</th>
                                <td>
                                    <input class="common-text required" id="title" name="useraddress" size="50" type="text">
                                </td>
                            </tr>
                                <th></th>
                                <td>
                                    <input class="btn btn-primary btn6 mr10" value="添加" type="submit">
                                    <input class="btn btn6" onClick="history.go(-1)" value="返回" type="button">
                                </td>
                            </tr>
                        </tbody></table>
                </form>
                <%} else{%>
		               	<form action="adminUserservlet?action=uptadeSJ" method="post">
		                    <table class="insert-tab" width="100%">
		                        <tbody>
		                         <tr>
		                                <th><i class="require-red">*</i>用户ID：</th>
		                                <td>
		                                    <input class="common-text required" id="title" name="id" size="50"  type="text" value="${user1.id}">
		                                </td>
		                            </tr>
		                        <tr>
		                                <th><i class="require-red">*</i>用户名：</th>
		                                <td>
		                                    <input class="common-text required" id="title" name="username" size="50"  type="text" value="${user1.username}">
		                                </td>
		                            </tr>
		                            <tr>
		                                <th><i class="require-red">*</i>用户密码：</th>
		                                <td>
		                                    <input class="common-text required" id="title" name="password" size="50"  type="text" value="${user1.password}">
		                                </td>
		                            </tr>
		                            <tr>
		                                <th><i class="require-red">*</i>用户电话：</th>
		                                <td>
		                                    <input class="common-text required" id="title" name="phone" size="50" type="text" value="${user1.phone}">
		                                </td>
		                            </tr>
		                              <tr>
		                                <th><i class="require-red">*</i>用户地址：</th>
		                                <td>
		                                    <input class="common-text required" id="title" name="address" size="50" type="text" value="${user1.address}">
		                                </td>
		                            </tr>
		                              <tr>
		                                <th><i class="require-red">*</i>等级：</th>
		                                <td>
		                                    <input class="common-text required" id="title" name="level" size="50" type="text" value="${user1.level}">
		                                </td>
		                            </tr>
		                                <th></th>
		                                <td>
		                                    <input class="btn btn-primary btn6 mr10" value="修改" type="submit">
		                                    <input class="btn btn6" onClick="history.go(-1)" value="返回" type="button" >
		                                </td>
		                            </tr>
		                        </tbody></table>
		                </form>
                <%} %>
            </div>
        </div>

    </div>
    <!--/main-->
</div>
</body>
</html>