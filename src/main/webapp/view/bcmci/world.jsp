<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>index</title>
    <script type="text/javascript" src="<%=path%>/screens/screen1/js/jquery.js"></script>
    <link rel="stylesheet" href="<%=path%>/screens/screen1/css/world.css">
</head>
<script>
    $(window).load(function(){
        $(".loading").fadeOut()
    })

    /****/
    $(document).ready(function(){
        var whei=$(window).width()
        $("html").css({fontSize:whei/20})
        $(window).resize(function(){
            var whei=$(window).width()
            $("html").css({fontSize:whei/20})
        });
    });
</script>
<script type="text/javascript" src="<%=path%>/screens/screen1/js/echarts.min.js"></script>
<body>
<div class="loading">
    <div class="loadbox"> <img src="<%=path%>/screens/screen1/picture/loading.gif"> 页面加载中... </div>
</div>
<div class="head">
    <h1>玫德集团产品外销情况</h1>
    <div class="weather"><%--<img src="<%=path%>/screens/screen1/picture/weather.png"><span>多云转小雨</span>--%><span id="showTime"></span></div>

    <script>
        var t = null;
        t = setTimeout(time,1000);//開始运行
        function time() {
            clearTimeout(t);//清除定时器
            dt = new Date();
            var y=dt.getFullYear();
            var mt=dt.getMonth()+1;
            var day=dt.getDate();
            var h=dt.getHours();//获取时
            var m=dt.getMinutes();//获取分
            var s=dt.getSeconds();//获取秒
            document.getElementById("showTime").innerHTML = y+"年"+mt+"月"+day+"日   "+h+"时"+m+"分"+s+"秒";
            t = setTimeout(time,1000); //设定定时器，循环运行
        }
    </script>


</div>
<div class="mainbox">
    <ul class="clearfix">
        <li>
            <div class="bar">
                <div class="barbox">
                    <ul class="clearfix">
                        <li class="pulll_left counter">12581189</li>
                        <li class="pulll_left counter">3912410</li>
                    </ul>
                </div>
                <div class="barbox2">
                    <ul class="clearfix">
                        <li class="pulll_left">2018年总收入情况 </li>
                        <li class="pulll_left">2018年总支出情况</li>
                    </ul>
                </div>
            </div>
            <div class="map">
                <div class="map4" id="map_1"></div>
            </div>
        </li>
    </ul>
</div>
<div class="back"></div>


<script type="text/javascript" src="<%=path%>/screens/screen1/js/world.js"></script>
<script type="text/javascript" src="<%=path%>/screens/screen1/js/world_echarts.js"></script>
</body>
</html>
