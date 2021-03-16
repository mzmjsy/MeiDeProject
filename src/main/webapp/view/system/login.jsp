<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>IMS前台管理系统</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="<%=path%>/css/system/login.css">
    </head>
    <body leftmargin="0" onload="changeImg()" style="background-color:#6495ED;">
        <div class="main_bar" style="background-image: url('<%=path%>/image/login.jpg')">
            <div id="login_form">
                <form action="<%=path%>/login/loginIn.do" method="post" onsubmit="return check()">
                    <div id="form_widget">
                        <br><span class="text_name">账&nbsp;&nbsp;&nbsp;号</span>
                        <input type="text" placeholder="请输入账号" required lay-verify="required" id="box_name" name="username" class="txt" value="${account.username}" />
                        <br><span class="text_name">密&nbsp;&nbsp;&nbsp;码</span>
                        <input type="password" placeholder="请输入密码" required lay-verify="required" id="box_pass" name="password" class="txt" value="${account.password}" />
                        <br><span class="text_name">验证码</span>
                        <input type="text" id="code" name="code" placeholder="验证码" required lay-verify="required" onfocus="$('#search_pass_link').text('')" /><span id="vcode" title="看不清，换一张"></span>
                        <div id="search_pass_link">
                            ${info}
                            <%--<a href="#">忘记密码？</a>--%>
                        </div>
                        <input type="submit" value="登录" class="btn" onmouseover="this.style.backgroundColor='#FF8D00'" onmouseout="this.style.backgroundColor='#FC5628'">
                        <br>
                        <p class="message">还没有账户? <a href="<%=path%>/login/register.do">立刻创建</a></p>
                    </div>
                </form>
            </div>
        </div>
        <script src="<%=path%>/js/jquery-3.4.1.min.js"></script>
        <script src="<%=path%>/layui/layui.js"></script>
        <script src="<%=path%>/js/system/login.js"></script>
    </body>
</html>