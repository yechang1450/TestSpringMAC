<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../sources/layui/css/layui.css                                        " media="all">
    <script src="../sources/layui/layui.js"></script>
    <script type="text/javascript" src="../sources/js/jquery.js"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<div class="demoTable">
    搜索区域ID：
    <div class="layui-inline">
        <input class="layui-input" name="areaId" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<body style="">
<form class="layui-form" action="" id="addForm" style="display:none">
    <div class="layui-form-item">
        <label class="layui-form-label">区域id</label>
        <div class="layui-input-block">
            <input type="text" id="areaId" required lay-verify="required" placeholder="请输入区域ID" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">灯光状态</label>
        <div class="layui-input-inline">
            <input id="seatLightStatus" required lay-verify="required" placeholder="请输入灯光状态" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">包月状态</label>
        <div class="layui-input-inline">
            <input type="text" id="vipStatus" required lay-verify="required" placeholder="请输入包月状态" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">使用状态</label>
        <div class="layui-input-inline">
            <input type="text" id="state" required lay-verify="required" placeholder="请输入可用状态" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="adds()">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<table class="layui-hide" id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button type="button" class="layui-btn layui-btn-sm" id="add" lay-event="add">添加</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script src="../sources/layui/layui.js" charset="utf-8"></script>
<script type="text/html" id="switchTpl">
    <input type="checkbox" name="{{d.seatLightStatus}}" value="{{d.id}}" lay-skin="switch" lay-text="开|关" lay-filter="sexDemo" {{ d.seatLightStatus == 'true' ? 'checked' : '' }}>
</script>
<script>
    layui.use('table', function () {
        var table = layui.table, form = layui.form;
        var pagecount;
        page();
        function page() {
            jQuery.ajax({
                url: 'seat/selectCount',
                dataType: 'json',
                type: 'get',
                async: false,
                success: function (data) {
                    pagecount = data.count;
                    // console.log(pagecount);
                }
            });
        }
        table.render({
            elem: '#test'
            , url: 'seat/findSeatList' //改成我们使用的servlet
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
                    , {field: 'seatLightStatus', title: '灯光调控', width: 150, align: 'center', unresize: true, sort: true, templet: '#switchTpl'}
                    , {field: 'areaId', title: '区域id', width: 150, edit: 'text', align: 'center', unresize: true, sort: true}
                    , {field: 'vipStatus', title: '包月状态', width: 170, align: 'center', unresize: true, sort: true}
                    , {field: 'state', title: '座位状态', width: 150, edit: 'text', align: 'center', unresize: true, sort: true}
                    , {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120, align: 'center'}
                ]
            ]
            , id: 'testReload'
            , page: true
            , limit: 10
            , response: {
                statusName: 'status'
                , dataName: 'rows'
            }
            , parseData: function (res) {
                //console.log(res);
                return {
                    "status": res[0].status,
                    "message": res[1].message,
                    "count": pagecount,
                    "rows": res[3].rows.item
                };
            }
        });
        //监听包月状态
        form.on('switch(sexDemo)', function () {
            var id = this.value;
            var seatLightStatus = this.name;
            $.ajax({
                type: "get",
                url: "seat/updateSeatLightStatus",
                data: {
                    "id": id,
                    "seatLightStatus": seatLightStatus
                },
                cache: false,
                async: true,
                success: function () {
                    layer.msg('修改成功', {icon: 1, offset: "t", time: 999});
                },
                error: function () {
                    layer.msg('修改失败', {icon: 2, offset: "t", time: 999});
                }
            });
        });
        var $ = layui.$, active = {
            reload: function () {
                var demoReload = $('#demoReload');
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
                        areaId: demoReload.val()//adminName的value
                    }
                }, 'data');
            }
        };
        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch (obj.event) {
                case 'add':
                    layer_index = layer.open({
                        type: 1,  //可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                        title: "添加房间", //数组第二项可以写任意css样式；如果你不想显示标题栏，你可以title: false
                        area: ['400px', '400px'], //所打开页面大小
                        content: $("#addForm"), //内容
                        cancel: function () {
                            layer.close(layer_index);
                            $("#addForm")[0].reset();
                        }
                    });
                    break;
            }
        });
        //让添加框弹出来
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            // console.log(obj);
            var upid = data.id;
            console.log(upid);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                        type: "get",
                        url: "seat/deleteById",
                        data: {"id": upid},
                        cache: false,
                        async: true,
                        success: function (data, textStatus, jqXHR) {
                            //alert(data);
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            //alert(typeof(errorThrown));
                        }
                    });
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                var url = "seat/update";
                $.ajax({
                    type: "get",
                    url: url,
                    data: data,
                    cache: false,
                    async: true,
                    success: function (data, textStatus, jqXHR) {
                        //alert(data);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        //alert(typeof(errorThrown));
                    }
                });
            }
        });
    });
    function adds() {
        var data = {
            "id": $("#id").val(),
            "seatLightStatus": $("#seatLightStatus").val(),
            "areaId": $("#areaId").val(),
            "vipStatus": $("#vipStatus").val(),
            "state": $("#state").val()
        };
        $.ajax({
            type: "get",
            url: "seat/insert",
            data: data,
            cache: false,
            async: true,
            success: function (data, textStatus, jqXHR) {
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                //alert(typeof(errorThrown));
            }
        });
    };
</script>
</body>
</html>