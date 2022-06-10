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
            
                <form action="GoodsServlet?type=uptade" method="post" id="myform" name="myform" enctype="multipart/form-data">
                    <table class="insert-tab" width="100%">
                        <tbody>
                      	  <tr>
                                <th><i class="require-red">*</i>商品ID：</th>
                                <td>
                                    <input class="common-text required" id="title" name="gid" size="50"  type="text" value="${good.gid}"  >
                                </td>
                            </tr>
                        
                        <tr>
                                <th><i class="require-red">*</i>商品名：</th>
                                <td>
                                    <input class="common-text required" id="title" name="gname" size="50"  type="text" value="${good.gname}">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>销售价：</th>
                                <td>
                                    <input class="common-text required" id="title" name="price" size="50"  type="text" value="${good.price}">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>进货价：</th>
                                <td>
                                    <input class="common-text required" id="title" name="inPrice" size="50" type="text" value="${good.inPrice}">
                                </td>
                            </tr>
                              <tr>
                                <th><i class="require-red">*</i>库存：</th>
                                <td>
                                    <input class="common-text required" id="title" name="stock" size="50" type="text" value="${good.stock}">
                                </td>
                            </tr>
                        <tr>
                            <th width="120"><i class="require-red">*</i>类别：</th>
                            <td >
                                <select name="cid" id="catid" class="required" style="width: 150px !important;">
                                    <option value="${good.cid}" >${good.cidname}</option>
                                     <c:forEach items="${categories}" var="categorie" >
										<option value="${categorie.cid}" >${categorie.cname}</option>
									</c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                                <th><i class="require-red">*</i>五星好评数：</th>
                                <td>
                                    <input class="common-text required" id="title" name="highPraise" size="50" type="text" value="${good.highPraise}">
                                </td>
                            </tr>
                            <tr>
                                <th><i class="require-red">*</i>销量：</th>
                                <td>
                                    <input class="common-text required" id="title" name="sales" size="50" type="text" value="${good.sales}">
                                </td>
                            </tr>
                             <tr>
                                <th><i class="require-red">*</i>主图：</th>
                                <td>
                                <img width="250px" id="preview" src="${good.picture}">
                                <input type="file" name="picture" onchange="viewImage(this)"></td>
                            </tr>             
                            <tr>
                                <th>介绍内容：</th>
                                <td><textarea name="introduction" class="common-textarea" id="content" cols="30" style="width: 70%;" rows="5" >${good.introduction}</textarea></td>
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