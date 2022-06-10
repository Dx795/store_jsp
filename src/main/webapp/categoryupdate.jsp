
<%@include file="adminlogined.jsp" %><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
    <%request.setCharacterEncoding("UTF-8"); %>
</head>
<body>
<%@include file="adminHead.jsp" %>
<div class="container clearfix">
    <!--/sidebar-->
    <div class="main-wrap">
        <div class="crumb-wrap">
            <div class="crumb-list"><i class="icon-font"></i><a href="/jscss/admin/design/">首页</a><span class="crumb-step">&gt;</span><a class="crumb-name" href="/jscss/admin/design/">类别管理</a><span class="crumb-step">&gt;</span><span>类别修改</span></div>
        </div>
        <div class="result-wrap">
            <div class="result-content">
            
                <form action="CategoryServlet?type=uptadeSj&cid=${category.cid}" method="post" >
                    <table class="insert-tab" width="100%">
                        <tbody>
                      	  <tr>
                                <th><i class="require-red">*</i>商品ID：</th>
                                <td>
                                    <input class="common-text required" id="title" name="cid" size="50"  type="text" value="${category.cid}"  disabled>
                                </td>
                            </tr>
                        
                        <tr>
                                <th><i class="require-red">*</i>商品名：</th>
                                <td>
                                    <input class="common-text required" id="title" name="cname" size="50"  type="text" value="${category.cname}">
                                </td>
                            </tr>
                             <tr>
                                <th></th>
                                <td>
                                    <input class="btn btn-primary btn6 mr10" value="修改" type="submit">
                                    <input class="btn btn6" onClick="history.go(-1)" value="返回" type="button">
                                </td>
                            </tr>
                        </tbody></table>
                </form>
            </div>
        </div>

    </div>
    <!--/main-->
</div>
</body>
</html>