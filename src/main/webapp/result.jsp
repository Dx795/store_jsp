<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="2;main.jsp">
<title>结果信息</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<h1>${requestScope.msg}</h1>
</body>
</html>