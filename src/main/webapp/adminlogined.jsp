<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
if (session.getAttribute("adminName") == null || session.getAttribute("adminName").equals("")) {
	out.println("<script type='text/javascript'>  alert('开启此页面,请用管理员账户登录！'); location.href='adminlogin.jsp'; </script>");
} else {
}
%>
