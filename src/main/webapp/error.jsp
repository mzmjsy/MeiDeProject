<%@ page language="java" pageEncoding="UTF-8"%>
<%    
	String path = request.getContextPath();
	int status_code = -1;   
	String exception_info = null;   
	Exception theException = null;   
	status_code = ((Integer) request.getAttribute("javax.servlet.error.status_code"));   
	exception_info = (String) request.getAttribute("javax.servlet.error.message");   
	theException = (Exception) request.getAttribute("javax.servlet.error.exception_type");   
	if(status_code==404){
		response.sendRedirect(path+"/view/error/error404.jsp");   //跳转404错误的jsp
	}
	if(status_code==500){
		response.sendRedirect(path+"/view/error/error500.jsp");    //跳转500错误的jsp
	}
%>
