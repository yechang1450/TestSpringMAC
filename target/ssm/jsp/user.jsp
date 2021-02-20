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
<body>
<div class="demoTable">
    搜索用户名：
    <div class="layui-inline">
        <input class="layui-input" name="userName" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<form class="layui-form" action="" id="addForm" style="display:none">
    <div class="layui-form-item" style="margin-top: 5%">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-inline">
            <input type="text" id="userName" required lay-verify="required" placeholder="请输入用户名" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-inline">
            <input type="text" id="userPhone" required lay-verify="required" placeholder="请输入手机号" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户状态</label>
        <div class="layui-input-inline">
            <input type="text" id="userStatus" required lay-verify="required" placeholder="用户状态" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">座位</label>
        <div class="layui-input-inline">
            <input type="text" id="seatName" required lay-verify="required" placeholder="座位" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">座位状态</label>
        <div class="layui-input-inline">
            <input type="text" id="seatStatus" required lay-verify="required" placeholder="座位状态" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">账户状态</label>
        <div class="layui-input-inline">
            <input type="text" id="accStatus" required lay-verify="required" placeholder="账户状态" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">余额</label>
        <div class="layui-input-inline">
            <input type="text" id="balance" required lay-verify="required" placeholder="余额" autocomplete="off"
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
    <input type="checkbox" name="{{d.accStatus}}" value="{{d.id}}" lay-skin="switch" lay-text="包月|包时" lay-filter="sexDemo" {{ d.accStatus == 'true' ? 'checked' : '' }}>
</script>
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="userStatus" value="{{d.id}}" title="自习中" lay-filter="lockDemo" {{ d.userStatus == 'true' ? 'checked' : '' }}>
</script>
<script>
    layui.use('table', function () {
        var table = layui.table
            ,form = layui.form;
        var pagecount;
        page();
        function page() {
            jQuery.ajax({
                url: 'user/selectCount',
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
            , url: 'user/selectAll' //改成我们使用的servlet
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
                    // , {field: 'id', title: 'ID', width: 70, fixed: 'left', unresize: true, sort: true, align: 'center'}
                    , {field: 'userName', title: '用户名', width: 150, edit: 'text', align: 'center', unresize: true, sort: true}
                    , {field: 'userPhone', title: '手机号', width: 150, edit: 'text', align: 'center', unresize: true, sort: true}
                    , {field: 'userStatus', title: '自习状态', width: 170, align: 'center', unresize: true, sort: true, templet: '#checkboxTpl'}
                    , {field: 'seatName', title: '座位', width: 150, edit: 'text', align: 'center', unresize: true, sort: true}
                    , {field: 'accStatus', title: '账户状态', width: 150, align: 'center', unresize: true, sort: true, templet: '#switchTpl'}
                    , {field: 'balance', title: '余额', width: 150, edit: 'text', align: 'center', unresize: true, sort: true}
                    , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120, align: 'center'}
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
        //监听账户状态
        form.on('switch(sexDemo)', function(){
            var id = this.value;
            var accStatus = this.name;
            console.log(id);
            console.log(accStatus);
            $.ajax({
                type: "get",
                url: "user/updateAccStatus",
                data: {
                    "id": id,
                    "accStatus":accStatus
                },
                cache: false,
                async: true,
                success: function () {
                    layer.msg('修改成功', { icon: 1, offset: "t", time:2000 });
                },
                error: function () {
                    layer.msg('修改失败', { icon: 2, offset: "t", time:2000 });
                }
            });
        });
        //监听自习状态
        form.on('checkbox(lockDemo)', function(){
            var id = this.value;
            var userStatus = this.checked;
            $.ajax({
                type: "get",
                url: "user/updateUserStatus",
                data: {
                    "id": id,
                    "userStatus":userStatus
                },
                cache: false,
                async: true,
                success: function () {
                    layer.msg('修改成功', { icon: 1, offset: "t", time:2000 });
                },
                error: function () {
                    layer.msg('修改失败', { icon: 2, offset: "t", time:2000 });
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
                        userName: demoReload.val()//adminName的value
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
                    add();
                    break;
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选')
                    break;
            };
        });
        function add() {
            //让添加框弹出来
            layer_index = layer.open({
                type: 1,  //可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                title: "添加房间", //数组第二项可以写任意css样式；如果你不想显示标题栏，你可以title: false
                area: ['400px', '500px'], //所打开页面大小
                content: $("#addForm"), //内容
                cancel: function () {
                    layer.close(layer_index);
                    $("#addForm")[0].reset();
                }
            });
        }
        //让添加框弹出来
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            // console.log(obj);
            var id = data.id;
            //console.log(id);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                        type: "get",
                        url: "user/deleteById",
                        data: {"id": id},
                        cache: false,
                        async: true,
                        success: function () {
                            layer.msg("删除成功", { icon: 1, offset: "auto", time:2000 });
                        },
                        error: function () {
                            layer.msg("删除失败", { icon: 2, offset: "auto", time:2000 });
                        }
                    });
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                $.ajax({
                    type: "get",
                    url: "user/update",
                    data: data,
                    cache: false,
                    async: true,
                    success: function () {
                        layer.msg("更新成功", { icon: 1, offset: "auto", time:2000 });
                    },
                    error: function () {
                        layer.msg("更新失败", { icon: 2, offset: "auto", time:2000 });
                    }
                });
            }
        });
    });
    function adds() {
        var data = {
            "userName": $("#userName").val(),
            "userPhone": $("#userPhone").val(),
            "userStatus": $("#userStatus").val(),
            "seatName": $("#seatName").val(),
            "accStatus": $("#accStatus").val(),
            "balance": $("#balance").val()
        };
        $.ajax({
            type: "get",
            url: "user/insert",
            data: data,
            cache: false,
            async: true,
            success: function () {
                layer.msg("添加成功", { icon: 1, offset: "auto", time:2000 });
            },
            error: function () {
                layer.msg("添加失败", { icon: 2, offset: "auto", time:2000 });
            }
        });
    }
</script>
</body>
</html>