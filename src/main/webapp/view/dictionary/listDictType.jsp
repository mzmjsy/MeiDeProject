<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>数据字典类型列表</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
        <link rel="stylesheet" href="<%=path%>/css/common/page.css">
        <style>
            #dictTypeId {
                display: inline-block;
                width: 140px;
                height: 30px;
                line-height: 30px;
                padding: 0 5px;
                margin-right: 5px;
            }
        </style>
    </head>
    <body style="margin-left: 10px">
    <div class="demoTable">
        <form class="layui-form" id="form1" method="post">
            <div class="layui-inline">
                <input class="layui-input" name="dictTypeId" id="dictTypeId" autocomplete="off" placeholder="输入编码/名称" value="${dictionary.dictTypeId}">
            </div>
            <button class="layui-btn layui-btn-sm" data-type="reload" lay-filter="search"><i class="layui-icon">&#xe615;</i>搜索</button>
        </form>
    </div>
        <table class="layui-hide" id="dictTypeTable" lay-filter="dictTypeTable"></table>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-xs" lay-event="add" id="add"><i class="layui-icon">&#xe654;</i>新增</button>
                <button class="layui-btn layui-btn-xs" lay-event="del" id="del"><i class="layui-icon">&#xe640;</i>批量删除</button>
            </div>
        </script>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon">&#xe642;</i>修改</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
        </script>
        <script src="<%=path%>/js/jquery-3.4.1.min.js"></script>
        <script src="<%=path%>/layui/layui.js"></script>
        <script>
            layui.use('table', function(){
                var table = layui.table;
                var layer = layui.layer;
                var data = ${listDictType};

                table.render({
                    elem: '#dictTypeTable',
                    data:data,
                    toolbar:'#toolbarDemo',
                    cols: [[
                        {type: 'checkbox', fixed: 'left'},
                        {field:'dictTypeId', width:300, title: '编码', sort: true},
                        {field:'dictTypeName', width:300, title: '名称', edit: "text"},
                        {fixed: 'right', title:'操作', toolbar: '#barDemo', width:150, align: 'center'}
                    ]],
                    id: 'testReload',
                    height:'550px',
                    page: true,
                    limits: [20,40,60,80,100,120]
                });

                //头工具栏事件
                table.on('toolbar(dictTypeTable)', function(obj){
                    var checkStatus = table.checkStatus(obj.config.id);
                    switch(obj.event){
                        case 'add':
                            layer.open({
                                title: '新增数据字典类型',
                                type: 2,
                                content: '<%=path%>/dictionary/addDictType.do',
                                area: ['40%','50%'],
                                /*maxmin: true,   //最大化、最小化*/
                                success : function(layero, index){
                                    //对打开的窗口右上角叉号的提示
                                    /*setTimeout(function(){
                                        layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
                                            tips: 3
                                        });
                                    },500)*/
                                }
                            });
                            break;
                        case 'del':
                            let data = checkStatus.data;
                            let dt = {};
                            dt['flag'] = 'bulkDel';
                            dt['content'] = JSON.stringify(data);

                            if (0 == data.length) {
                                layer.msg("请选择要删除的数据！");
                            } else {
                                layer.confirm('真的批量删除选中的数据吗?', function(){
                                    updateOrDelete(dt,"批量删除");
                                });
                            }
                            break;
                    };
                });

                //行工具事件
                table.on('tool(dictTypeTable)', function (obj) {
                    let event = obj.event;
                    let data = obj.data;
                    let dt = {};
                    dt['dictTypeId'] = data.dictTypeId;

                    if ("edit" == event) {
                        dt['dictTypeName'] = data.dictTypeName;
                        dt['flag'] = "edit";
                        updateOrDelete(dt,"修改");
                    } else if ("del" == event) {
                        layer.confirm('真的删除该数据字典类型吗?', function(){
                            dt['flag'] = "delete";
                            updateOrDelete(dt,"删除");
                        });
                    }
                });
            });

            //保存修改或删除提交
            function updateOrDelete(dt,tip) {
                $.ajax({
                    url:'<%=path%>/dictionary/saveDictType.do',
                    type:'post',
                    data:dt,
                    beforeSend:function () {
                        this.layerIndex = layer.load(0, { shade: [0.5, '#393D49'] });
                    },
                    success:function(data){
                        if (data == 'success'){
                            layer.msg(tip + "成功", {
                                icon: 6,//成功的表情
                                time: 1000
                            }, function(){
                                if ('delete' == dt['flag'] || 'bulkDel' == dt['flag']) {
                                    location.reload();
                                }
                            });
                        } else if (data == 'error') {
                            layer.msg(tip + "时报错，请检查",{icon: 5,time: 1000});
                            return;
                        }
                    },
                    complete: function () {
                        layer.close(this.layerIndex);
                    }
                })
            }
        </script>
    </body>
</html>