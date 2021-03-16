<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>各应该功能列表</title>
        <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
        <link rel="stylesheet" href="<%=path%>/layui/demo.css">
        <link rel="stylesheet" href="<%=path%>/css/module/module.css">
    </head>
    <body class="page-no-scroll">
        <div class="page-wrapper">
            <fieldset class="layui-elem-field layui-field-title">
                <legend>各应用管理</legend>
            </fieldset>
            <div class="layui-btn-container">
                <button id="btnExpandAll" class="layui-btn layui-btn-sm layui-btn-primary">
                    <i class="layui-icon">&#xe668;</i>展开全部
                </button>
                <button id="btnFoldAll" class="layui-btn layui-btn-sm layui-btn-primary">
                    <i class="layui-icon">&#xe66b;</i>折叠全部
                </button>
                <%--<button id="btnExpand" class="layui-btn layui-btn-sm layui-btn-primary">
                    <i class="layui-icon">&#xe625;</i>展开2
                </button>
                <button id="btnFold" class="layui-btn layui-btn-sm layui-btn-primary">
                    <i class="layui-icon">&#xe623;</i>折叠2
                </button>--%>
            </div>
            <input class="layui-input" id="edtSearch" placeholder="输入关键字" />
            <div class="layui-btn-container">
                <button id="btnSearch" class="layui-btn layui-btn-sm layui-btn-primary">
                    <i class="layui-icon">&#xe615;</i>搜索
                </button>
                <button id="btnClearSearch" class="layui-btn layui-btn-sm layui-btn-primary">
                    <i class="layui-icon">&#x1006;</i>清除搜索
                </button>
            </div>
            <div class="layui-btn-container demoTable">
                <button class="layui-btn layui-btn-sm" lay-event="add_lay" id="add"><i class="layui-icon">&#xe654;</i>新增</button>
                <button class="layui-btn layui-btn-sm" lay-event="refresh_lay" id="refresh"><i class="layui-icon">&#xe666;</i>刷新</button>
            </div>
            <table id="treeTable"></table>
        </div>

        <!-- 表格操作列 -->
        <script type="text/html" id="treeTableToolbar">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add"><i class="layui-icon">&#xe654;</i>新增</a>
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit"><i class="layui-icon">&#xe642;</i>修改</a>
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
        </script>
        <script type="text/javascript">
            var path = '<%=request.getContextPath()%>';
            var moduleInfo = ${moduleInfo};
        </script>
        <script src="<%=path%>/js/jquery-3.4.1.min.js"></script>
        <script src="<%=path%>/layui/layui.js"></script>
        <script src="<%=path%>/js/module/moduleList.js"></script>
    </body>
</html>