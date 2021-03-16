<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>用户基本信息修改</title>
        <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
    </head>
    <body class="layui-card-body">
        <form class="layui-form" id="form1">
            <input type="hidden" id="id" name="id" value="${account.id}">
            <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="username" name="username" readonly="readonly" value="${account.username}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">昵称</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="nickname" name="nickname" lay-verify="required" placeholder="请输入昵称" autocomplete="off" value="${account.nickname}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="sex" value="M" title="男" checked="">
                    <input type="radio" name="sex" value="F" title="女">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-inline">
                    <input type="text" name="birthday" id="birthday" lay-verify="date" placeholder="YYYY-MM-DD" autocomplete="off" class="layui-input" value="${account.birthday}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机号</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="telephone" name="telephone" lay-verify="required" placeholder="请输入名称" autocomplete="off" value="${account.telephone}">
                </div>
                <label class="layui-form-label" style="margin-left:90px;">邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="email" name="email" lay-verify="required" placeholder="请输入名称" autocomplete="off" value="${account.email}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">家庭地址</label>
                <div class="layui-input-inline">
                    <select name="province" id="province" lay-verify="required" lay-search lay-filter="province">
                        <option value="${account.province}"><c:choose><c:when test="${null == account.province}">省份</c:when><c:otherwise>${account.province}</c:otherwise></c:choose></option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="city" id="city" lay-verify="required" lay-search lay-filter="city">
                        <option value="${account.city}"><c:choose><c:when test="${null == account.city}">地级市</c:when><c:otherwise>${account.city}</c:otherwise></c:choose></option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="district" id="district" lay-verify="required" lay-search>
                        <option value="${account.district}"><c:choose><c:when test="${null == account.district}">县/区</c:when><c:otherwise>${account.district}</c:otherwise></c:choose></option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入内容" name="remark" id="remark" class="layui-textarea">${account.remark}</textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="upAcc">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>

        <script src="<%=path%>/js/jquery-3.4.1.min.js"></script>
        <script src="<%=path%>/layui/layui.js"></script>
        <script type="text/javascript" src="<%=path%>/js/common/area.js"></script>
        <script>
            layui.use(['form', 'laydate'], function(){
                var $ = layui.$;
                var form = layui.form;
                var laydate = layui.laydate;

                //日期
                laydate.render({
                    elem: '#birthday'
                });

                //监听提交
                form.on('submit(upAcc)', function(data){
                    $.ajax({
                        url:'<%=path%>/login/saveUpdateAccount.do',
                        type:'post',
                        data:{"data":JSON.stringify(data.field)},
                        beforeSend:function () {
                            this.layerIndex = layer.load(0, { shade: [0.5, '#393D49'] });
                        },
                        success:function(data){
                            if (data == 1) {
                                layer.msg("昵称已存在，请重新输入",{icon: 5,time: 1000});
                                $("#nickname").focus();
                                return;
                            } else if (data == 'success'){
                                layer.msg("保存成功", {
                                    icon: 6,//成功的表情
                                    time: 1000
                                },function(){
                                    location.reload();
                                });
                            } else if (data == 'error') {
                                layer.msg("保存时报错，请检查",{icon: 5,time: 1000});
                                return;
                            }
                        },
                        complete: function () {
                            layer.close(this.layerIndex);
                        },
                    })
                    return false;
                });
            });
        </script>
    </body>
</html>