<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../sources/layui/css/layui.css" media="all">
    <script src="../sources/layui/layui.js"></script>
    <script type="text/javascript" src="../sources/js/jquery.js"></script>
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body style="">
<div class="demoTable">
    搜索用户名：
    <div class="layui-inline">
        <input class="layui-input" name="adminName" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<form class="layui-form" action="" id="addForm" style="display:none">
    <div class="layui-form-item" style="margin-top: 10%">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-inline">
            <input type="text" id="adminName" required lay-verify="required" placeholder="请输入用户名" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-inline">
            <input type="password" id="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            <label><input type="radio" name="sex" value="男" />男</label>
            <label><input type="radio" name="sex" value="女" checked="checked"/>女</label>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机</label>
        <div class="layui-input-inline">
            <input type="text" id="phone" required lay-verify="required" placeholder="手机" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-inline">
            <input type="text" id="address" required lay-verify="required" placeholder="地址" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="adds()">提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<table class="layui-hide" id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button type="button" class="layui-btn layui-btn-sm" id="add" lay-event="add">添加</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">更新</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="../sources/layui/layui.js" charset="utf-8"></script>
<script type="text/html" id="switchTpl">
    <input type="checkbox" name="{{d.sex}}" value="{{d.id}}" lay-skin="switch" lay-text="女|男" lay-filter="sexDemo" {{ d.sex == '女' ? 'checked' : '' }}>
</script>
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="status" value="{{d.id}}" title="在职" lay-filter="lockDemo" {{ d.status == 'true' ? 'checked' : '' }}>
</script>
<script>
    layui.use('table', function () {
        var table = layui.table
        ,form = layui.form;
        var pagecount;
        page();
        function page() {
            jQuery.ajax({
                url: 'login/selectCount',
                dataType: 'json',
                type: 'get',
                async:false,
                success: function(data) {
                    pagecount = data.count;
                    // console.log(pagecount);
                }
            });
        }
        table.render({
            elem: '#test'
            , url: 'login/selectAll' //改成我们使用的servlet
            , method: "get"
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [
                [
                    {type: 'checkbox', fixed: 'left'}
                    , {field: 'adminName', title: '用户名', width: 150, edit: 'text', sort: true, align: 'center',fixed: 'left', unresize: true}
                    , {field: 'password', title: '密码', width: 150, edit: 'text', align: 'center', unresize: true}
                    , {field: 'sex', title: '性别', width: 80, sort: true, align: 'center', unresize: true, templet: '#switchTpl'}
                    , {field: 'phone', title: '手机号', width: 150, edit: 'text', unresize: true, sort: true, align: 'center'}
                    , {field: 'address', title: '地址', width: 250, edit: 'text', align: 'center'}
                    , {field: 'status', title: '在职状态', width: 150, sort: true, unresize: true, align: 'center', templet: '#checkboxTpl'}
                    , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120, unresize: true, align: 'center',fixed: 'right'}
                ]
            ]
            , id: 'testReload'
            , page: true
            , limit: 12
            , response: {
                statusName: 'status'
                , dataName: 'rows'
            }
            , parseData: function (res) {
                // console.log(res);
                return {
                    "status": res[0].status,
                    "message": res[1].message,
                    "count": pagecount,
                    "rows": res[3].rows.item
                };
            }
        });
        //监听性别
        form.on('switch(sexDemo)', function(){
            var id = this.value;
            var sex = this.name;
            $.ajax({
                type: "get",
                url: "login/updateSex",
                data: {
                    "id": id,
                    "sex":sex
                },
                cache: false,
                async: true,
                success: function () {
                    layer.msg('修改成功', { icon: 1, offset: "t", time:999 });
                },
                error: function () {
                    layer.msg('修改失败', { icon: 2, offset: "t", time:999 });
                }
            });
        });
        //监听在职状态
        form.on('checkbox(lockDemo)', function(){
            var id = this.value;
            var status = this.checked;
            $.ajax({
                type: "get",
                url: "login/updateStatus",
                data: {
                    "id": id,
                    "status":status
                },
                cache: false,
                async: true,
                success: function () {
                    layer.msg('修改成功', { icon: 1, offset: "t", time:999 });
                },
                error: function () {
                    layer.msg('修改失败', { icon: 2, offset: "t", time:999 });
                }
            });
        });
        var $ = layui.$, active = {
            reload: function(){
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        adminName: demoReload.val()//adminName的value
                    }
                }, 'data');
            }
        };
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    //让添加框弹出来
                    layer_index = layer.open({
                        type: 1,  //可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        title: "添加房间", //数组第二项可以写任意css样式；如果你不想显示标题栏，你可以title: false
                        area: ['400px', '450px'], //所打开页面大小
                        content: $("#addForm"), //内容
                        cancel: function () {
                            layer.close(layer_index);
                            $("#addForm")[0].reset();
                        }
                    });
                    break;
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));//layui弹窗
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选')
                    break;
            }
        });
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            var id = data.id;
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                        type: "get",
                        url: "login/deleteById",
                        data: {"id": id},
                        cache: false,
                        async: true,
                        success: function () {
                            layer.msg("删除成功", { icon: 1, offset: "t", time:999 });
                        },
                        error: function () {
                            layer.msg("删除失败", { icon: 2, offset: "t", time:999 });
                        }
                    });
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                $.ajax({
                    type: "get",
                    url: "login/update",
                    data: data,
                    cache: false,
                    async: true,
                    success: function () {
                        layer.msg("更新成功", { icon: 1, offset: "t", time:999 });
                    },
                    error: function () {
                        layer.msg("更新失败", { icon: 2, offset: "t", time:999 });
                    }
                });
            }
        });
    });
    function adds() {
        var adminName = $("#adminName").val();
        var password = $("#password").val();
        var phone = $("#phone").val();
        var address = $("#address").val();
        if(adminName.length==0||password.length==0||phone.length==0||address.length==0){
            layer.msg("关键项为空", { icon: 2, offset: "t", time:999 });
        }else{
            $.ajax({
                type: "get",
                url: "login/insert",
                data: {
                    "adminName":adminName,
                    "password":password,
                    "sex":$("input[name='sex']:checked").val(),
                    "phone":phone,
                    "address":address,
                    "status":1
                },
                cache: false,
                async: true,
                success: function () {layer.msg("更新成功", { icon: 1, offset: "t", time:999 });},
                error: function () {layer.msg("更新失败", { icon: 2, offset: "t", time:999 });}
            });
        }
    }
</script>
</body>
</html>