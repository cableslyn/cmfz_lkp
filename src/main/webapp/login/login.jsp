<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<head>
    <title>登陆</title>
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/form-elements.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="shortcut icon" href="assets/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">
    <script src="assets/js/jquery-2.2.1.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.backstretch.min.js"></script>
    <script src="assets/js/scripts.js"></script>
    <script src="assets/js/jquery.validate.min.js"></script>
    <script>

        $(function () {
            $("#captchaImage").click(function () {
                $("#captchaImage").prop("src", "${pageContext.request.contextPath}/code/getCode?time=" + new Date().getTime());
            });
        });

        $(function () {
            $("#loginButtonId").click(function () {
                var username = $("#form-username").val();
                var password = $("#form-password").val();
                var code = $("#form-code").val();
                if (username&&password&&code){
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin/login",
                        type: "POST",data: $("#loginForm").serialize(),

                        dataType: "json",
                        success: function (data) {
                            if (data.status){
                                location.href = "${pageContext.request.contextPath}/back/main.jsp"
                            }else{
                                alert(data.message)
                            }

                        }
                    });
                }else{
                    alert("内容不能为空");
                }

            })
        })

        function save() {
            clear();
            $("#mm").modal("show");
        }

        // 点击获取验证码操作
        function smsBtn() {
            var phone = $("#phonenumber").val();
            if (phone == null||phone ==""){
                alert("请输入手机号");
                return false;
            }else{
                let count = 60;
                const countDown = setInterval(() => {
                    if (count === 0) {
                        $('.smsBtn').text('重新发送').removeAttr('disabled');
                        $('.smsBtn').css({
                            background: '#47bfff',
                            color: '#fff',
                        });
                        clearInterval(countDown);
                    } else {
                        $('.smsBtn').attr('disabled', true);
                        $('.smsBtn').css({
                            background: '#d8d8d8',
                            color: '#707070',
                        });
                        $('.smsBtn').text(count + '秒后重新获取');
                    }
                    count--;
                }, 1000);
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/sendMessage",
                type: "POST",
                data: {"phone":phone},
                dataType: "json",
                success: function (data) {
                }
            });
        };
        function regist() {

            console.log($("#registform").serialize());
            $.ajax({
                type:"post",
                url:"${pageContext.request.contextPath}/admin/regist",
                data: $("#registform").serialize(),
                dataType:"JSON",
                success:function(result){
                    if (result.status){
                        alert("注册成功");
                    }else{
                        alert(result.message);
                        return false;
                    }
                }
            });
            clear();
        }

        function clear(){
            var username = $("#admin-username").val("");
            var username = $("#admin-nickname").val("");
            var password = $("#admin-password").val("");
            var nickname = $("#admin-nickname").val("");
            var phone = $("#phonenumber").val("");
            var sms = $("#smsNumber").val("").removeClass();

        }

        function checkPhone(){
            var phone = document.getElementById('phonenumber').value;
            if(!(/^1[34578]\d{9}$/.test(phone))){
                alert("手机号码输入有误，请核实");
                return false;
            }
        }
    </script>
    <style>
        .row{
            margin-left: 65px;
        }
        .page-header {
            padding-left: 20px;
            padding-bottom: 0px;
            margin: 30px 0 0px;
            border-bottom: 0px solid #eee;
        }
        body {
            text-align: left;
        }
        h1, h2 {
            margin-top: 10px;
            font-size: 42px;
            font-weight: 100;
            color:#555555;
            line-height: 50px;
        }
        .form-top-left {
            float: left;
            width: 75%;
            padding-top: 15px;
        }
        .form-top {
            overflow: hidden;
            padding: 0 15px 0px 15px;
            background: #fff;
            -moz-border-radius: 4px 4px 0 0;
            -webkit-border-radius: 4px 4px 0 0;
            border-radius: 4px 4px 0 0;
            text-align: left;
        }
        .form-bottom {
            padding: 25px 25px 20px 25px;
            background: #eee;
            -moz-border-radius: 0 0 4px 4px;
            -webkit-border-radius: 0 0 4px 4px;
            border-radius: 0 0 4px 4px;
            text-align: left;
        }

        .form-horizontal .form-group {
            margin-right: -15px;
            margin-left: -150px;
        }
    </style>
</head>

<body>
<div class="page-header">
    <h1 style="color:whitesmoke"><b>持明法洲<small style="color: #f7f7f7">&nbsp;Chi Ming Fa Zhou</small></b></h1>
</div>
<!-- Top content -->
<div class="container">
    <div>
        <span style="text-align: center;"><h1 style="color: white"><b>登&nbsp;&nbsp;&nbsp;陆</b></h1></span>
    </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top" style="width: 450px">
                        <div class="form-top-left">
                            <h3>Login>></h3>
                            <p>Enter your username and password to logon:</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-key"></i>
                        </div>
                    </div>
                    <div class="form-bottom" style="width: 450px">
                        <form role="form" action="" method="post"
                              class="login-form" id="loginForm">
                            <span>${requestScope.message}</span>
                            <span id="msgDiv"></span>
                            <div class="form-group">
                                <label class="sr-only" for="form-username">Username</label>
                                <div class="input-group">
                                    <div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
                                <input type="text" name="username" placeholder="请输入用户名..."
                                       class="form-username form-control" id="form-username" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">Password</label>
                                <div class="input-group">
                                    <div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
                                <input type="password" name="password" placeholder="请输入密码..."
                                       minlength="2" class="form-password form-control" id="form-password" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-addon"><span class="glyphicon glyphicon-exclamation-sign"></span></div>
                                <input style="width: 245px; height: 50px;border:3px solid #ddd;border-radius: 4px;" type="test" name="code" placeholder="请输入验证码..." id="form-code" required>

                                <img id="captchaImage" style="height: 48px;padding-left: 5px" class="captchaImage"
                                     src="${pageContext.request.contextPath}/code/getCode">
                                </div>
                            </div>
                            <input type="button" style="width: 200px;border:1px solid #9d9d9d;border-radius: 4px;" id="loginButtonId" value="登录>>">&nbsp;<input type="button" style="width: 200px;border:1px solid #9d9d9d;border-radius: 4px;" id="regsitButtonId" onclick="save()" value="注册>>">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


<!--构建模态框-->
<div class="modal fade" id="mm" data-backdrop="static" data-keyboard="false" data-show="true">
    <div class="modal-dialog ">
        <div class="modal-content">
            <!--头-->
            <div class="modal-header">
                <button class="close" data-dismiss="modal"> <span>&times;</span></button>
                <div class="modal-title"><h3>注册用户信息</h3></div>
            </div>

            <!--身体-->
            <div class="modal-body">

                <!--row-->
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <form action="" class="form-horizontal" method="post" id="registform">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户名:</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="username" id="admin-username">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">密码:</label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" name="password" id="admin-password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">昵称:</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="nickname" id="admin-nickname">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">手机号:</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="phonenumber" onchange="checkPhone()">
                                </div>

                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">验证码:</label>
                                <div class="col-sm-5">
                                    <input type="text"  class="form-control"  name="sms" id="smsNumber">
                                </div>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button class="btn btn-default smsBtn"  type="button" onclick="smsBtn()">获取验证码</button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
            <!--脚-->
            <div class="modal-footer">
                <button class="btn btn-danger" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary" onclick="regist()" data-dismiss="modal">提交</button>
            </div>

        </div>
    </div>
</div>

</body>

</html>
