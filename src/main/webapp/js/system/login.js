var vcode;//声明一个变量用于存储生成的验证码
document.getElementById("vcode").onclick=changeImg;
function changeImg(){
    var arrays = new Array(
        '1','2','3','4','5','6','7','8','9','0','a','b','c','d','e','f','g','h','i','j',
        'k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F',
        'G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
    );
    vcode='';//重新初始化验证码
    //alert(arrays.length);
    //随机从数组中获取四个元素组成验证码
    for(var i=0;i<4;i++){
        //随机获取一个数组的下标
        var r=parseInt(Math.random()*arrays.length);
        vcode+=arrays[r];
    }
    //alert(code);
    document.getElementById('vcode').innerHTML = vcode;//将验证码写入指定区域
}

//效验验证码(表单被提交时触发)
function check(){
    //获取用户输入的验证码
    var input_code = $("#code").val();

    if (input_code.toLowerCase() == vcode.toLowerCase()) {
        //验证码正确(表单提交)
        return true;
    }

    $("#search_pass_link").text('请输入正确的验证码!');

    //验证码不正确,表单不允许提交
    return false;
}