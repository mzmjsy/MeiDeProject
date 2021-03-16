<%@ page language="java" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head></head>
  
  <body>
  	 <script type="text/javascript">
	  /*   var _left = 0;
	    var _top = 0;
	    var options = new Array();
	    options.push('toolbar=no,scrollbars=no,menubar=no,location=no,resizable=yes');
	    options.push(',width=');
	    options.push(window.screen.width);
	    options.push(',height=');
	    options.push(750);
	    options.push(',left=');
	    options.push(_left);
	    options.push(',top=');
	    options.push(_top); */
	    
	  //  window.open('view/login.jsp', '', options.join(''));
	    window.location.href='view/system/login.jsp';
	  /*   self.opener = null; 
	    self.open('','_self'); 
	    self.close(); */
	   </script>
  </body>
</html>
