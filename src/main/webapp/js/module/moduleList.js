var insTb;

layui.config({
    base: path+'/layui/module/'
}).extend({
    treeTable: 'treeTable/treeTable'
}).use(['layer', 'treeTable', 'table'], function () {
    let $ = layui.jquery;
    let layer = layui.layer;
    let treeTable = layui.treeTable;
    let data = moduleInfo;

    // 渲染表格
    insTb = treeTable.render({
        elem: '#treeTable',
        data: data,
        tree: {
            iconIndex: 2
        },
        toolbar: '#treeTableToolbar',
        cols: [
            {type: 'numbers'},
            /*{type: 'checkbox'},*/
            {field: 'code', title: '编码', width: 160},
            {field: 'title', title: '名称', width: 220, edit: "text"},
            {field: 'level', title: '目录级别', width: 90, align: 'right'},
            {field: 'parentCode', title: '父节点', width: 130},
            {field: 'url', title: 'url链接', width: 220, edit: "text"},
            /*{
                field: 'createTime', title: '创建时间', templet: function (d) {
                    return util.toDateString(d.createTime);
                }, width: 160
            },*/
            {align: 'center', toolbar: '#treeTableToolbar', title: '操作', width: 220}
        ],
        style: 'margin-top:0;width:100%'
    });

    treeTable.on('tool(treeTable)', function (obj) {
        let event = obj.event;
        let data = obj.data;
        let dt = {};
        dt['vcode'] = data.code;

        if ('add' == event) {
            if (3 === data.level) {
                layer.msg("三级节点下不可新增数据",{icon: 5});
            } else {
                dt['level'] = data.level;
                openAdd('新增' + (2 === data.level ? '三' : '二') +'级节点信息',dt);
            }
        } else if ("edit" == event) {
            dt['vtitle'] = data.title;
            dt['vurl'] = data.url;
            dt['flag'] = "edit";
            updateOrDelete(dt,"修改");
        } else if ("del" == event) {
            layer.confirm('真的删除该节点及其子节点吗?', function(){
                dt['flag'] = "delete";
                updateOrDelete(dt,"删除");
            });
        }
    });

    /*$('#btnExpand').click(function () {
        insTb.expand('2');
    });

    $('#btnFold').click(function () {
        insTb.fold('2');
    });*/
});

// 全部展开
$('#btnExpandAll').click(function () {
    insTb.expandAll();
});

// 全部折叠
$('#btnFoldAll').click(function () {
    insTb.foldAll();
});

//搜索
$('#btnSearch').click(function () {
    let keywords = $('#edtSearch').val();
    if (keywords) {
        insTb.filterData(keywords);
    } else {
        insTb.clearFilter();
    }
});

//清除搜索
$('#btnClearSearch').click(function () {
    insTb.clearFilter();
});

//上方新增根节点
$("#add").click(function(){
    let data = {};
    data["level"] = 0;
    openAdd('新增根节点信息',data);
})

//打开新增页面
function openAdd(name,data) {
    layui.layer.open({
        title: name,
        type: 2,
        content: path+'/module/moduleEdit.do',
        area: ['40%','60%'],
        /*maxmin: true,*/   //最大化、最小化
        success : function(layero, index){
            let body = layui.layer.getChildFrame('body', index);
            body.find("#nlevel").val(data['level'] + 1);
            body.find("#vparentcode").val(data['vcode']);

            if (2 != data['level']) {
                body.find(".url").css("display","none");
            }

            /*
            对打开的窗口右上角叉号的提示
            setTimeout(function(){
                layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
                    tips: 3
                });
            },500)*/
        }
    });
}

//刷新
$("#refresh").click(function(){
    location.reload();
});

//保存修改或删除提交
function updateOrDelete(dt,tip) {
    $.ajax({
        url:path+'/module/saveModuleInfo.do',
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
                    if ('delete' == dt['flag']) {
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