<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>玫德集团欢迎您</title>
        <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
        <link rel="stylesheet" href="<%=path%>/layui/css/modules/layui-icon-extend/iconfont.css">
        <link rel="stylesheet" href="<%=path%>/css/system/main.css">
    </head>
    <body class="layui-layout-body">
        <div class="layui-layout layui-layout-admin">
            <div class="layui-header">
                <div class="layui-logo"><img src="<%=path%>/image/error/logo.jpg" /></div>
                <ul class="layui-nav layui-layout-left suo">
                    <li class="layui-nav-item layadmin-flexible" lay-unselect="">
                        <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩" onclick="suofang()">
                            <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="" class="layui-icon layui-icon-console">
                            控制台
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="" class="layui-icon layui-icon-cart">
                            商品管理
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="" class="layui-icon layui-icon-user">
                            用户
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;" class="layui-icon layui-icon-menu-fill">
                            其它系统
                        </a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a class="iconfont layui-icon-email" href="">
                                    邮件管理
                                </a>
                            </dd>
                            <dd>
                                <a class="iconfont layui-icon-xiaoxi" href="">
                                    消息管理
                                </a>
                            </dd>
                            <dd>
                                <a class="layui-icon layui-icon-auz" href="">
                                    授权管理
                                </a>
                            </dd>
                        </dl>
                    </li>
                </ul>
                <ul class="layui-nav layui-layout-right"><%--layui-icon-screen-restore  layui-icon layui-icon-screen-full--%>
                    <li class="layui-nav-item">
                        <a type="button" id="fullscreen" class="btn btn-default visible-lg visible-md layui-icon layui-icon-screen-full">
                            切换全屏
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;" class="layui-icon layui-icon-username">
                            <%--<img src="http://t.cn/RCzsdCq" class="layui-nav-img">--%>
                            ${user.nickname}
                        </a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:;" class="site-demo-active" data-id="upInfo" data-title="基本资料修改" data-type="tabAdd" data-url="<%=path%>/login/updateAccount.do?flag=info&id=${user.id}">基本资料</a></dd>
                            <dd><a href="javascript:;" class="site-demo-active" data-id="upPass" data-title="安全密码修改" data-type="tabAdd" data-url="<%=path%>/login/updateAccount.do?flag=password&id=${user.id}">安全设置</a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="<%=path%>/login/loginIn.do" class="layui-icon layui-icon-close">
                            退出
                        </a>
                    </li>
                </ul>
            </div>

            <div class="layui-side layui-bg-black">
                <div class="layui-side-scroll">
                    <ul class="layui-nav layui-nav-tree" lay-filter="test">
                        <c:forEach var="module" items="${listModule}">
                            <li class="layui-nav-item">
                                <a class="" href="javascript:;">
                                    <i class="fa fa-user-circle-o fa-lg layui-icon
                                        <c:choose>
                                            <c:when test="${'0001' == module.vcode}">
                                                layui-icon-read
                                            </c:when>
                                            <c:when test="${'0002' == module.vcode}">
                                                layui-icon-video
                                            </c:when>
                                            <c:when test="${'0003' == module.vcode}">
                                                layui-icon-headset
                                            </c:when>
                                            <c:when test="${'0004' == module.vcode}">
                                                layui-icon-website
                                            </c:when>
                                            <c:when test="${'0005' == module.vcode}">
                                                layui-icon-set
                                            </c:when>
                                            <c:otherwise>
                                                layui-icon-app
                                            </c:otherwise>
                                        </c:choose>
                                    "></i>
                                    <span >${module.vtitle}</span>
                                </a>
                                <dl class="layui-nav-child">
                                    <c:forEach var="m1" items="${module.moduleList}">
                                        <dd>
                                            <a href="javascript:;"><span style="margin-left: 20px;">${m1.vtitle}</span></a>
                                            <dl class="layui-nav-child">
                                                <c:forEach var="m2" items="${m1.moduleList}">
                                                    <dd>
                                                        <a href="javascript:;" class="site-demo-active" data-id="${m2.nid}" data-title="${m2.vtitle}" data-type="tabAdd" data-url="<%=path%>/${m2.vurl}">
                                                            <span style="margin-left: 40px;">${m2.vtitle}</span>
                                                        </a>
                                                    </dd>
                                                </c:forEach>
                                            </dl>
                                        </dd>
                                    </c:forEach>
                                </dl>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div class="layui-tab" lay-filter="demo" lay-allowclose="true">
                <!-- 内容主体区域 -->
                <ul class="layui-tab-title"></ul>
                <ul class="rightmenu">
                    <li data-type="closethis" class="layui-btn layui-btn-primary layui-btn-xs">关闭当前</li>
                    <br/>
                    <li data-type="closeall" class="layui-btn layui-btn-primary layui-btn-xs" style="margin-top:5px;">关闭所有</li>
                </ul>
                <div class="layui-tab-content"></div>
            </div>

            <%--<div class="layui-footer">
                <!-- 底部固定区域 -->
                © layui.com - 底部固定区域
            </div>--%>
        </div>
        <script src="<%=path%>/layui/layui.js"></script>
        <script src="<%=path%>/js/jquery-3.4.1.min.js"></script>
        <script src="<%=path%>/js/system/main.js"></script>
    </body>
</html>