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
        <title>各节点新增、修改</title>
        <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
        <link rel="stylesheet" href="<%=path%>/css/module/module.css">
    </head>
    <body class="layui-card-body">
        <form class="layui-form" id="form1">
            <input type="hidden" id="nlevel" name="nlevel" />
            <input type="hidden" id="vparentcode" name="vparentcode" />
            <input type="hidden" id="flag" name="flag" />
            <input type="hidden" id="url" name="url" />

            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <button class="layui-btn layui-btn-xs layui-btn-normal" lay-submit lay-filter="ok" id="entry">确定</button>
                    <button type="button" class="layui-btn layui-btn-xs layui-btn-normal" id="cancel">取消</button>
                </div>
            </div>
            <div class="layui-form-item text">
                <label class="layui-form-label required">编码</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="vcode" name="vcode" lay-verify="required" placeholder="请输入编码" autocomplete="off">
                </div>
            </div>
            <div class="layui-form-item text">
                <label class="layui-form-label">名称</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="vtitle" name="vtitle" lay-verify="required" placeholder="请输入名称" autocomplete="off">
                </div>
            </div>
            <%--<div class="layui-form-item text">
                <label class="layui-form-label">父节点</label>
                <div class="layui-input-inline">
                    <select name="vparentcode" lay-search>
                        <option value="">请选择父节点</option>
                        <c:forEach var="module" items="${moduleInfo}">
                            <optgroup label="----------------------------------">
                                <option value="${module.vcode}">${module.nlevel}—${module.vtitle}</option>
                                <c:forEach var="m" items="${module.moduleList}">
                                    <option value="${m.vcode}">${m.nlevel}—${m.vtitle}</option>
                                </c:forEach>
                            </optgroup>
                        </c:forEach>
                    </select>
                </div>
            </div>--%>
            <div class="layui-form-item text url">
                <label class="layui-form-label">url链接</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="vurl" name="vurl" placeholder="请输入url" autocomplete="off">
                </div>
            </div>
        </form>

        <script src="<%=path%>/js/jquery-3.4.1.min.js"></script>
        <script src="<%=path%>/layui/layui.js"></script>
        <script>
            var index = parent.layer.getFrameIndex(window.name);
            layui.use('form', function(){
                var form = layui.form;

                //监听提交
                form.on('submit(ok)', function(data){
                    $.ajax({
                        url:'<%=path%>/'+$("#url").val(),
                        type:'post',
                        data:data.field,
                        beforeSend:function () {
                            this.layerIndex = layer.load(0, { shade: [0.5, '#393D49'] });
                        },
                        success:function(data){
                            if (data == 1) {
                                layer.msg("编码重复，请重新输入",{icon: 5,time: 1000});
                                $("#vcode").focus();
                                return;
                            } else if (data == 'success'){
                                layer.msg("保存成功", {
                                    icon: 6,//成功的表情
                                    time: 1000
                                }, function(){
                                    parent.location.reload();
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

            //取消按钮
            $("#cancel").click(function(){
                parent.layer.close(index);
            });
        </script>
    </body>
</html>