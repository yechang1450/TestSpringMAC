<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link rel="icon" href="sources/ico/favicon.ico">
    <link rel="stylesheet" href="sources/css/1450Style.css" type="text/css">
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <script src="sources/js/Cookie.js" type="text/javascript"></script>
    <link rel="stylesheet" href="sources/layui/css/layui.css" media="all">
    <script src="sources/layui/layui.js"></script>
</head>
<body class="body_bg" onload="login() ,checkLoginCookie1()">
<div id="All"></div>
</body>
<script>
    ///////登录////登录//////登录//////登录///登录///登录////登录///////登录/////
    function LoginByAcc() {
        var adminName = $("#adminName").val();
        var password = $("#password").val();
        if (adminName.length < 1 || adminName == "") {
            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">tip! Account Can Not Be Empty!<br/></div>';
            $("#return").empty().append(html);
            setTimeout("loginbutton()", 999);
        } else if (password.length < 1 || adminName == "") {
            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">tip! Password Can Not Be Empty!<br/></div>';
            $("#return").empty().append(html);
            setTimeout("loginbutton()", 999);
        }
        $.ajax({
            type: "get",
            url: "login/selectByName",
            data: {"adminName": $("#adminName").val()},
            cache: false,
            async: false,
            success: function (data) {
                if (data == "0") {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">tip! Account Can Not Found!</div>';
                    $("#return").empty().append(html);
                    setTimeout("loginbutton()", 999);
                } else if (data.status == "0") {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">AccountStatus Dimission!</div>';
                    $("#return").empty().append(html);
                    setTimeout("loginbutton()", 999);
                } else {
                    if (data.password == password) {
                        ////登录成功//////登录成功/////////登录成功//////登录成功//////登录成功//////登录成功//////登录成功///////
                        setCookie("adminName", adminName, 30);
                        setCookie("status", data.status, 30);
                        sessionStorage.setItem("adminName", "" + getCookie('adminName') + "");
                        location.reload();
                    } else {
                        var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">tip! Password Error!</div>';
                        $("#return").empty().append(html);
                        setTimeout("loginbutton()", 999);
                    }
                }
            },
            error: function () {
                var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                html += 'Error! ';
                html += '</div>';
                $("#return").empty().append(html);
                setTimeout("loginbutton()", 999);
            }
        });
    }

    /////修改密码/////修改密码////修改密码/////修改密码//////修改密码//////修改密码//////
    function UpdatePwd() {
        var adminName = $("#adminName").val();
        var password = $("#password").val();
        var confirmPassword = $("#confirmPassword").val();
        var phone = $("#phone").val();
        $.ajax({
            type: "get",
            url: "login/selectByName",
            data: {"adminName": $("#adminName").val()},
            cache: false,
            async: false,
            success: function (data) {
                if (adminName.length <= 3 || adminName == "") {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                    html += 'Account Error';
                    html += '</div>';
                    $("#return").empty().append(html);
                    setTimeout("ChangePwdButton()", 999);
                } else if (phone.length != 11 || phone == "") {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                    html += 'TelNumber Error';
                    html += '</div>';
                    $("#return").empty().append(html);
                    setTimeout("ChangePwdButton()", 999);
                } else if (password.length <= 5 || password == "") {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                    html += 'Password Error';
                    html += '</div>';
                    $("#return").empty().append(html);
                    setTimeout("ChangePwdButton()", 999);
                } else if (password != confirmPassword) {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                    html += 'confirmPassword is not same as Password';
                    html += '</div>';
                    $("#return").empty().append(html);
                    setTimeout("ChangePwdButton()", 999);
                } else if (phone != data.phone) {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                    html += 'TelNumber Error !';
                    html += '</div>';
                    $("#return").empty().append(html);
                    setTimeout("ChangePwdButton()", 999);
                } else if (phone == data.phone) {
                    var data = {
                        "adminName": $("#adminName").val(),
                        "password": $("#password").val()
                    };
                    $.ajax({
                        type: "get",
                        url: "login/updatePwd",
                        cache: false,
                        data: data,
                        async: false,
                        success: function () {
                            ///////密码修改成功/////////密码修改成功/////////密码修改成功/////////密码修改成功///
                            setCookie("adminName", adminName, 30);
                            setCookie("status", data.status, 30);
                            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                            html += 'Success! Auto loading...';
                            html += '</div>';
                            $("#return").empty().append(html);
                            setTimeout(refresh(), 3000);
                        },
                        error: function () {
                            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                            html += 'Error! ';
                            html += '</div>';
                            $("#return").empty().append(html);
                            setTimeout("ChangePwdButton()", 999);
                        }
                    });
                }
            },
            error: function () {
                var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                html += 'Error! ';
                html += '</div>';
                $("#return").empty().append(html);
                setTimeout("ChangePwdButton()", 999);
            }
        });
    }

    ////////注册///////////注册///////////注册///////////注册///////////注册////////
    function SignUp() {
        var adminName = $("#adminName").val();
        var password = $("#password").val();
        var confirmPassword = $("#confirmPassword").val();
        var sex = $("input[name='sex']:checked").val();
        var phone = $("#phone").val();
        var address = $("#address").val();
        if (adminName.length == 0 || password.length == 0 || confirmPassword.length == 0 || sex.length == 0 || phone.length == 0 || address.length == 0) {
            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
            html += 'Empty!';
            html += '</div>';
            $("#return").empty().append(html);
            setTimeout("signUpbutton()", 999);
        } else if (password != confirmPassword) {
            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
            html += 'password is not as same as confirmPassword!';
            html += '</div>';
            $("#return").empty().append(html);
            setTimeout("signUpbutton()", 999);
        } else {
            $.ajax({
                type: "get",
                url: "login/selectByName",
                cache: false,
                data: {"adminName": $("#adminName").val()},
                async: false,
                success: function (data) {
                    if (data == "0") {
                        $.ajax({
                            type: "get",
                            url: "login/selectByTel",
                            cache: false,
                            data: {"phone": phone},
                            async: false,
                            success: function (data) {
                                if (data == "0") {
                                    $.ajax({
                                        type: "get",
                                        url: "login/insert",
                                        data: {
                                            "adminName": adminName,
                                            "password": password,
                                            "sex": sex,
                                            "phone": phone,
                                            "address": address,
                                            "status": 1
                                        },
                                        cache: false,
                                        async: true,
                                        success: function () {
                                            //////注册成功////////注册成功///////注册成功//////注册成功//////注册成功///////注册成功//////
                                            setCookie("adminName", adminName, 30);
                                            setCookie("status", data.status, 30);
                                            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                                            html += 'Success! Auto loading...';
                                            html += '</div>';
                                            $("#return").empty().append(html);
                                            setTimeout(refresh(), 3000);
                                        },
                                        error: function () {
                                            var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                                            html += 'Error!';
                                            html += '</div>';
                                            $("#return").empty().append(html);
                                            setTimeout("signUpbutton()", 999);
                                        }
                                    });
                                } else {
                                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                                    html += 'TelNumber had been Signed Up!';
                                    html += '</div>';
                                    $("#return").empty().append(html);
                                    setTimeout("signUpbutton()", 999);
                                }
                            },
                            error: function () {
                                var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                                html += 'Error! ';
                                html += '</div>';
                                $("#return").empty().append(html);
                                setTimeout("signUpbutton()", 999);
                            }
                        });
                    } else {
                        var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                        html += 'Account had been Signed Up!';
                        html += '</div>';
                        $("#return").empty().append(html);
                        setTimeout("signUpbutton()", 999);
                    }
                },
                error: function () {
                    var html = '<div style="font-size:18px;text-align:center;color:#66a3ff;">';
                    html += 'Error! ';
                    html += '</div>';
                    $("#return").empty().append(html);
                    setTimeout("signUpbutton()", 999);
                }
            });
        }
    }

    function login() {
        var html = '<div class="signupdiv">';
        html += '<input class="signup" type="button"  value="SignUp" onclick="SignUpArea()"/>';
        html += '</div>';
        html += '<div id="main">';
        html += '<div class="whole">';
        html += '<div class="title">Please Login</div>';
        html += '<div class="input_tit">Your Account</div>';
        html += '<div class="input_box">';
        html += '<input class="input_self" type="text" name="username" id="adminName"  value="" />';
        html += '</div>';
        html += '<div class="blank_30"></div>';
        html += '<div class="input_tit">Password</div>';
        html += '<div class="input_box">';
        html += '<input class="input_self" type="password" name="password" id="password" value="" />';
        html += '</div>';
        html += '<div class="finish_box" id="return">';
        html += '<input class="finish_btn" type="button" value="Login" onclick="LoginByAcc()"/>';
        html += '</div>';
        html += '</div>';
        html += '<div style="width:30%;margin-left:35%;">';
        html += '<input class="adminlogin" type="button" value="Change Password" onclick="ChangePwdArea()"/>';
        html += '</div>';
        html += '</div>';
        $("#All").empty().append(html);
    }

    function ChangePwdArea() {
        var html = '';
        html += '<div class="signupdiv">';
        html += '<input class="signup" type="button"  value="SignUp" onclick="SignUpArea()"/>';
        html += '</div>';
        html += '<div id="main">';
        html += '<div class="whole">';
        html += '<div>';
        html += '<input class="adminlogin" type="button" value="Back to Login" onclick="login()"/>';
        html += '</div>';
        html += '<div class="title">Change Password</div>';
        html += '<div class="input_tit">Your Account</div>';
        html += '<div class="input_box">';
        html += '<input class="input_self" type="text" name="adminName" id="adminName"  value="" />';
        html += '</div>';
        html += '<div class="input_tit">New Password</div>';
        html += '<div class="input_box">';
        html += '<input class="input_self" type="password" name="password" id="password" value="" />';
        html += '</div>';
        html += '<div class="input_tit">Confirm Password</div>';
        html += '<div class="input_box">';
        html += '<input class="input_self" type="password" name="confirmPassword" id="confirmPassword" value="" />';
        html += '</div>';
        html += '<div class="input_tit">Your telNumber</div>';
        html += '<div class="input_box">';
        html += '<input class="input_self" type="text" name="phone" id="phone" value="" />';
        html += '</div>';
        html += '<div class="finish_box" id="return">';
        html += '<input class="finish_btn" type="button" value="Change" onclick="UpdatePwd()"/>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        $("#All").empty().append(html);
    }

    function SignUpArea() {
        var html = '<div class="signupdiv">';
        html += '<input class="signup" type="button"  value="Login" onclick="login()"/>';
        html += '</div>';
        html += '<div id="main">';
        html += '<div class="whole">';
        html += '<div class="title">SignUp</div>';
        html += '<div class="input_tit">Your Account</div>';
        html += '<div class="input_box">';
        html += '<input class="input_self" type="text" name="adminName" id="adminName"  value="" />';
        html += '</div>';
        html += '<div class="input_tit">Password</div>';
        html += '<div class="input_box" >';
        html += '<input class="input_self" type="password" name="password" id="password"  value="" />';
        html += '</div>';
        html += '<div class="input_tit">ConfirmPassword</div>';
        html += '<div class="input_box" >';
        html += '<input class="input_self" type="password" name="confirmPassword" id="confirmPassword"  value="" />';
        html += '</div>';
        html += '<div class="input_tit">Your Sex</div>';
        html += '<div style="text-align: center">';
        html += '<label><input type="radio" name="sex" value="女" checked="checked">女</label>';
        html += '<label><input type="radio" name="sex" value="男" />男</label>';
        html += '</div>';
        html += '<div class="input_tit">Your Phone</div>';
        html += '<div class="input_box" >';
        html += '<input class="input_self" type="text" name="phone" id="phone"  value="" />';
        html += '</div>';
        html += '<div class="input_tit">Your Address</div>';
        html += '<div class="input_box" >';
        html += '<input class="input_self" type="text" name="address" id="address"  value="" />';
        html += '</div>';
        html += '<div class="finish_box" id="return">';
        html += '<input class="finish_btn" type="button" value="SignUp" onclick="SignUp()"/>';
        html += '</div>';
        html += '</div>';
        html += '</div>';
        $("#All").empty().append(html);
    }

    function loginbutton() {
        var html = '<div class="finish_box" id="return" style="width:100%;margin-left:0;">';
        html += '<input class="finish_btn" type="button" value="Login" onclick="LoginByAcc()"/>';
        html += '</div>';
        $("#return").empty().append(html);
    }

    function signUpbutton() {
        var html = '<div class="finish_box" id="return" style="width:100%;margin-left:0;">';
        html += '<input class="finish_btn" type="button" value="SignUp" onclick="SignUp()"/>';
        html += '</div>';
        $("#return").empty().append(html);
    }

    function ChangePwdButton() {
        var html = '<div class="finish_box" id="return" style="width:100%;margin-left:0;">';
        html += '<input class="finish_btn" type="button" value="Change" onclick="ChangePwdArea()"/>';
        html += '</div>';
        $("#return").empty().append(html);
    }

    function refresh() {
        location.reload();
    }
</script>
</html>
