layui.use('element', function() {
    var $ = layui.jquery;
    var element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

    $('.layui-nav-item').click(function(){
        $(this).siblings('li').attr('class','layui-nav-item');
    })

    //触发事件
    var active = {
        //在这里给active绑定几项事件，后面可通过active调用这些事件
        tabAdd: function(url,id,name) {
            //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
            //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
            element.tabAdd('demo', {
                title: name,
                area: ['100%', '100%'],
                content: '<iframe data-frameid="'+id+'" scrolling="auto" frameborder="0" src="'+url+'" style="width:100%;height:100%;"></iframe>',
                id: id //规定好的id
            })
            CustomRightClick(id); //给tab绑定右击事件
            FrameWH();  //计算ifram层的大小
        },
        tabChange: function(id) {
            //切换到指定Tab项
            element.tabChange('demo', id); //根据传入的id传入到指定的tab项
        },
        tabDelete: function (id) {
            element.tabDelete("demo", id);//删除
        },
        tabDeleteAll: function (ids) {//删除所有
            $.each(ids, function (i,item) {
                element.tabDelete("demo", item); //ids是一个数组，里面存放了多个id，调用tabDelete方法分别删除
            })
        }
    };

    //当点击有site-demo-active属性的标签时，即左侧菜单栏中内容 ，触发点击事件
    $('.site-demo-active').on('click', function() {
        var dataid = $(this);

        //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
        if ($(".layui-tab-title li[lay-id]").length <= 0) {
            //如果比零小，则直接打开新的tab项
            active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
        } else {
            //否则判断该tab项是否以及存在

            var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
            $.each($(".layui-tab-title li[lay-id]"), function () {
                //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                    isData = true;
                }
            })
            if (isData == false) {
                //标志为false 新增一个tab项
                active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
            }
        }
        //最后不管是否新增tab，最后都转到要打开的选项页面上
        active.tabChange(dataid.attr("data-id"));
    });

    function CustomRightClick(id) {
        //取消右键  rightmenu属性开始是隐藏的 ，当右击的时候显示，左击的时候隐藏
        $('.layui-tab-title li').on('contextmenu', function () { return false; })
        $('.layui-tab-title,.layui-tab-title li').click(function () {
            $('.rightmenu').hide();
        });
        //桌面点击右击
        $('.layui-tab-title li').on('contextmenu', function (e) {
            var popupmenu = $(".rightmenu");
            popupmenu.find("li").attr("data-id",id); //在右键菜单中的标签绑定id属性

            //判断右侧菜单的位置
            l = ($(document).width() - e.clientX) < popupmenu.width() ? (e.clientX - popupmenu.width()) : e.clientX;
            t = ($(document).height() - e.clientY) < popupmenu.height() ? (e.clientY - popupmenu.height()) : e.clientY;
            popupmenu.css({ left: l, top: t }).show(); //进行绝对定位
            //alert("右键菜单")
            return false;
        });
    }

    $(".rightmenu li").click(function () {
        //右键菜单中的选项被点击之后，判断type的类型，决定关闭所有还是关闭当前。
        if ($(this).attr("data-type") == "closethis") {
            //如果关闭当前，即根据显示右键菜单时所绑定的id，执行tabDelete
            active.tabDelete($(this).attr("data-id"))
        } else if ($(this).attr("data-type") == "closeall") {
            var tabtitle = $(".layui-tab-title li");
            var ids = new Array();
            $.each(tabtitle, function (i) {
                ids[i] = $(this).attr("lay-id");
            })
            //如果关闭所有 ，即将所有的lay-id放进数组，执行tabDeleteAll
            active.tabDeleteAll(ids);
        }

        $('.rightmenu').hide(); //最后再隐藏右键菜单
    })

    $(".layui-tab-title").bind("mousemove",function(){
        $('.rightmenu').hide();
    });

    function FrameWH() {
        var h = $(window).height() -41 - 60 -30;
        $("iframe").css("height",h+"px");
    }

    $(window).resize(function () {
        FrameWH();
    })
});

var isShow = true;  //定义一个标志位
function suofang() {
    //选择出所有的span，并判断是不是hidden
    $('.layui-nav-item span').each(function(){
        if($(this).is(':hidden')){
            $(this).show();
        }else{
            $(this).hide();
        }
    });
    //判断isshow的状态
    if(isShow){
        $('.layui-side.layui-bg-black').width(60); //设置宽度
        $('.kit-side-fold i img').css('margin-left', '9%');  //修改图标的位置
        //将footer和body的宽度修改
        $('.layui-body').css('left', 60+'px');
        $('.layui-footer').css('left', 60+'px');
        //将二级导航栏隐藏
        $('dd span').each(function(){
            $(this).hide();
        });
        $(".layui-tab").css("margin-left","60px");
        $(".layui-logo").hide();
        $(".suo").css("left", "60px");
        $("#LAY_app_flexible").removeClass("layui-icon-shrink-right");
        $("#LAY_app_flexible").addClass("layui-icon-spread-left");
        //修改标志位
        isShow =false;
    } else {
        $('.layui-side.layui-bg-black').width(200);
        $('.kit-side-fold i img').css('margin-left', '40%');
        $('.layui-body').css('left', 200+'px');
        $('.layui-footer').css('left', 200+'px');
        $('dd span').each(function(){
            $(this).show();
        });
        $(".layui-tab").css("margin-left","200px");
        $(".layui-logo").show();
        $(".suo").css("left", "200px");
        $("#LAY_app_flexible").removeClass("layui-icon-spread-left");
        $("#LAY_app_flexible").addClass("layui-icon-shrink-right");
        isShow =true;
    }
}

//全屏
function entryFullScreen() {
    var docE = document.documentElement;
    if (docE.requestFullScreen) {
        docE.requestFullScreen();
    } else if (docE.mozRequestFullScreen) {
        docE.mozRequestFullScreen();
    } else if (docE.webkitRequestFullScreen) {
        docE.webkitRequestFullScreen();
    }
    $("#quan").addClass("layui-nav-item layui-icon layui-icon-screen-restore");
}

//进入全屏
function enterfullscreen() {
    $("#fullscreen").html("退出全屏");
    var docElm = document.documentElement;
    //W3C
    if(docElm.requestFullscreen) {
        docElm.requestFullscreen();
    }
    //FireFox
    else if(docElm.mozRequestFullScreen) {
        docElm.mozRequestFullScreen();
    }
    //Chrome等
    else if(docElm.webkitRequestFullScreen) {
        docElm.webkitRequestFullScreen();
    }
    //IE11
    else if(elem.msRequestFullscreen) {
        elem.msRequestFullscreen();
    }

    $("#fullscreen").addClass("layui-icon-screen-restore");
    suofang();
}

//退出全屏
function exitfullscreen() {
    $("#fullscreen").html("切换全屏");
    $("#fullscreen").removeClass("layui-icon-screen-restore");
    $("#fullscreen").addClass("layui-icon-screen-full");
    if(document.exitFullscreen) {
        document.exitFullscreen();
    } else if(document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
    } else if(document.webkitCancelFullScreen) {
        document.webkitCancelFullScreen();
    } else if(document.msExitFullscreen) {
        document.msExitFullscreen();
    }
    suofang();
}

var a = 0;
$('#fullscreen').on('click', function() {
    a++;
    a % 2 == 1 ? enterfullscreen() : exitfullscreen();
})