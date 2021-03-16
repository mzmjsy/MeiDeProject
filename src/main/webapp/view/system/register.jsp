<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>IMS前台管理系统</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
        <link rel="stylesheet" href="<%=path%>/css/system/login.css">
    </head>
    <body leftmargin="0" style="background-color:#6495ED;">
        <div class="main_bar" style="background-image: url('<%=path%>/image/login.jpg')">
            <div id="login_form">
                <form class="layui-form" action="<%=path%>/login/saveAccount.do" method="post">
                    <div class="form_div">
                        <div class="layui-form-item">
                            <label class="layui-form-label">账号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" lay-verify="required" lay-reqtext="账号不能为空" autocomplete="off" placeholder="请输入账号" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">密码</label>
                            <div class="layui-input-inline">
                                <input type="password" name="password" lay-verify="required" lay-reqtext="密码不能为空" placeholder="请输入密码" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">手机</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="telephone" lay-verify="required|phone" lay-reqtext="手机号不能为空" placeholder="请输入手机号" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">邮箱</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="email" lay-verify="email" lay-reqtext="邮箱不能为空" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">滑动验证</label>
                            <div class="layui-input-block slider">
                                <div id="slider"></div>
                            </div>
                        </div>
                        <input type="submit" value="提交" class="layui-btn btn" lay-submit="" lay-filter="sub" onmouseover="this.style.backgroundColor='#FF8D00'" onmouseout="this.style.backgroundColor='#FC5628'">
                    </div>
                </form>
            </div>
        </div>
        <script src="<%=path%>/js/jquery-3.4.1.min.js"></script>
        <script src="<%=path%>/layui/layui.js"></script>
        <script type="text/javascript">
            layui.config({
                base: '<%=path%>/layui/sliderVerify/'
            }).use(['sliderVerify', 'jquery', 'form', 'layedit', 'laydate'], function() {
                var sliderVerify = layui.sliderVerify,
                    form = layui.form;
                var slider = sliderVerify.render({
                    elem: '#slider',
                    isAutoVerify:true,//关闭自动验证
                    /*bg : 'layui-bg-red',//自定义背景样式名*/
                    text : '滑动',
                    onOk: function(){//当验证通过回调
                        layer.msg("滑块验证通过");
                    }
                })

                //监听提交
                form.on('submit(sub)', function(data) {
                    if(slider.isOk()){//用于表单验证是否已经滑动成功
                        var data = JSON.stringify(data.field);

                        $.ajax({
                            url:'<%=path%>/login/saveAccount.do',
                            type:'post',
                            data:{"data":data},
                            beforeSend:function () {
                                this.layerIndex = layer.load(0, { shade: [0.5, '#393D49'] });
                            },
                            success:function(data){
                                if (data == 'success'){
                                    layer.msg("注册成功，将跳转到登录页面", {
                                        icon: 6,//成功的表情
                                        time: 2000
                                    }, function(){
                                        window.location.href = "<%=path%>/login/loginIn.do";
                                    });
                                } else if (data == 'error') {
                                    layer.msg("注册时报错，请检查",{icon: 5,time: 1000});
                                    return;
                                } else if ("1" == data) {
                                    layer.msg("用户名已存在，请重新输入", {
                                        icon: 5,
                                        time: 1500
                                    }, function(){
                                        location.reload();
                                    });
                                }
                            },
                            complete: function () {
                                layer.close(this.layerIndex);
                            }
                        })
                    } else {
                        layer.msg("请先通过滑块验证");
                    }
                    return false;
                });
            })
        </script>
    </body>
</html>