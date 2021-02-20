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
    搜索ID：
    <div class="layui-inline">
        <input class="layui-input" name="userId" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>

<form class="layui-form" action="" id="addForm" style="display:none">
    <div class="layui-form-item">
        <label class="layui-form-label">用户id</label>
        <div class="layui-input-block">
            <input type="text" id="userId" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">座位位置</label>
        <div class="layui-input-inline">
            <input type="text" id="seatId" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">选购商品</label>
        <div class="layui-input-inline">
            <input type="text" id="goods" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">选购数量</label>
        <div class="layui-input-inline">
            <input type="text" id="number" required lay-verify="required" placeholder="权限" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">总价</label>
        <div class="layui-input-inline">
            <input type="text" id="totleMoney" required lay-verify="required" placeholder="权限" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">订单状态</label>
        <div class="layui-input-inline">
            <input type="text" id="orderStatus" required lay-verify="required" placeholder="权限" autocomplete="off" class="layui-input">
        </div>
    </div>    <div class="layui-form-item">
    <label class="layui-form-label">订单时间</label>
    <div class="layui-input-inline">
        <input type="text" id="orderTime" required lay-verify="required" placeholder="权限" autocomplete="off" class="layui-input">
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

    <%--<a class="layui-btn layui-btn-xs" lay-event="select">查询</a>--%>
<%--    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>--%>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="updateTotleMoney">自动更新价格</a>--%>
</script>


<script src="../sources/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->


<%--<script type="text/html" id="switchTpl">--%>
    <%--<input type="checkbox" name="{{d.orderStatus}}" value="{{d.id}}" lay-skin="switch" lay-text="0|1" lay-filter="sexDemo" {{ d.orderStatus == 'true' ? 'checked' : '' }}>--%>
<%--</script>--%>

<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="orderStatus" value="{{d.id}}" title="已送达" lay-filter="lockDemo" {{ d.orderStatus == '已送达' ? 'checked' : '' }}>
</script>

<script>
    //设定开始时间
    layui.use('laydate',function () {
        var laydate=layui.laydate;
        laydate.render({
            elem:'#startTime',
            type:'datetime'
        });
    });

    //设定结束时间
    layui.use('laydate',function () {
        var laydate=layui.laydate;
        laydate.render({
            elem:'#endTime',
            type:'datetime'
        });
    });

    layui.use('table', function(){
        var table = layui.table
    ,form = layui.form;
        var pagecount;
        page();
        function page(){
            jQuery.ajax({
                url: 'order/selectCount',
                dataType: 'json',
                type: 'get',
                async:false,
                success: function(data) {
                    pagecount = data.count;
                    // console.log(pagecount);
                }
            });

        }

        //监听包月状态
        form.on('switch(sexDemo)', function(){
            var id = this.value;
            var sex = this.name;
            $.ajax({
                type: "get",
                url: "http://localhost:8080/order/updateByOrderStatus",
                data: {
                    "id": id,
                    "sex":sex
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
            var orderStatus = this.checked;
            console.log(id);
            console.log(orderStatus);
            $.ajax({
                type: "get",
                url: "order/updateByOrderStatus",
                data: {
                    "id": id,
                    "orderStatus":orderStatus
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


        // 回显的代码
        table.render({
            elem: '#test'
            ,url:'http://localhost:8080/order/selectOrderList' //改成我们使用的servlet
            ,method:"get"
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [
                [
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:70, fixed: 'left', unresize: true, sort: true}
                ,{field:'userId', title:'用户id', width:150, edit: 'text'}
                ,{field:'seatId', title:'座位位置', width:150, edit: 'text'}
                ,{field:'goods', title:'选购商品', width:150, edit: 'text'}
                ,{field:'number', title:'选购数量', width:150, edit: 'text'}
                ,{field:'totleMoney', title:'总价', width:150, edit: 'text'}
                ,{field:'orderStatus', title:'订单状态', width:150, templet: '#checkboxTpl'}

                ,{field:'orderTime', title:'订单时间', width:150, edit: 'text'}

                 ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:300}
                ]
            ]
            ,id: 'testReload'
            ,page: true
            ,limit: 10

            ,response:{
                statusName: 'status'
                ,dataName: 'rows'
            }
            ,parseData: function(res){
                console.log(res)
                return {
                    "status": res[0].status,
                    "message":res[1].message,
                    "count": pagecount,
                    "rows": res[3].rows.item
                };
            }
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
                        userId: demoReload.val()// userId 的value
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
            };
        });
        function add(){
            //让添加框弹出来
            layer_index= layer.open(
                {

                    type: 1,  //可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                    title: "添加房间", //数组第二项可以写任意css样式；如果你不想显示标题栏，你可以title: false
                    area: ['400px', '400px'], //所打开页面大小
                    content:$("#addForm"), //内容
                    cancel: function(){


                        layer.close(layer_index);
                        $("#addForm")[0].reset();
                    }

                });
        }
        //让添加框弹出来
        table.on('tool(test)', function(obj){
            var data = obj.data;
            console.log(obj)
            var upid = data.id;
            console.log(upid);
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){

                    $.ajax(
                        {
                            type: "get",
                            url: "http://localhost:8080/order/deleteById",
                            data: {"id":upid},
                            cache: false,
                            async : true,
                            success: function (data,textStatus, jqXHR)
                            {
                                //alert(data);
                            },
                            error:function (XMLHttpRequest, textStatus, errorThrown) {
                                //alert(typeof(errorThrown));
                            }
                        });
                    obj.del();
                    layer.close(index);
                });
            }
            else if(obj.event === 'edit'){
                var url = "http://localhost:8080/order/update";
                $.ajax(
                    {
                        type: "get",
                        url: url,
                        data: data,
                        cache: false,
                        async : true,
                        success: function (data,textStatus, jqXHR)
                        {
                            //alert(data);
                        },
                        error:function (XMLHttpRequest, textStatus, errorThrown) {
                            //alert(typeof(errorThrown));
                        }
                    });
            }
            else if(obj.event === 'select'){
                var url = "http://localhost:8080/order/selcetbyId";
                $.ajax(
                    {
                        type: "get",
                        url: url,
                        data: data,
                        cache: false,
                        async : true,
                        dataType: "JSON",
                        success: function (data,textStatus, jqXHR)
                        {
                            console.log(data);
                            console.log(data[3]);
                            console.log(data[3].rows.item[0].goods);

                            var goods=data[3].rows.item[0].goods;



                            $.ajax(
                                {
                                    type: "get",
                                    url: url,
                                    data: {"goods":goods},
                                    cache: false,
                                    async : true,
                                    dataType: "JSON",
                                    success: function (data,textStatus, jqXHR)
                                    {
                                        console.log(data);
                                        console.log(data[3]);
                                        console.log(data[3].rows.item[0].goods);

                                        var goods=data[3].rows.item[0].goods;

                                        select()
                                        //alert(data);
                                    },
                                    error:function (XMLHttpRequest, textStatus, errorThrown) {
                                        //alert(typeof(errorThrown));
                                    }
                                });
                        },
                        error:function (XMLHttpRequest, textStatus, errorThrown) {
                            //alert(typeof(errorThrown));
                        }
                    });
            }
            else if(obj.event === 'updateTotleMoney'){
                var url = "http://localhost:8080/order/updateTotleMoney";
                $.ajax(
                    {
                        type: "get",
                        url: url,
                        data: data,
                        cache: false,
                        async : true,
                        success: function (data,textStatus, jqXHR)
                        {
                            //alert(data);
                        },
                        error:function (XMLHttpRequest, textStatus, errorThrown) {
                            //alert(typeof(errorThrown));
                        }
                    });
            }


        });

    });

    function adds(){
        var data={

            "userId":$("#userId").val(),
            "seatId":$("#seatId").val(),
            "goods":$("#goods").val(),
            "number":$("#number").val(),
            "totleMoney":$("#totleMoney").val(),
            "orderStatus":$("#orderStatus").val(),
            "sex":$("input[name='sex']:checked").val(),
            "orderTime":$("#orderTime").val()

        };
        console.log("Json字符串",JSON.stringify(data))
        window.alert(data);
        console.log(data);

        var url = "http://localhost:8080/order/insert";

        $.ajax({
            type: "post",
            url: url,
            data: data,
            // dataType:'json',
            // contentType : 'application/json',
            cache: false,
            async : false,
            success: function (data,textStatus, jqXHR)
            {
                window.alert(date);
            },
            error:function (XMLHttpRequest, textStatus, errorThrown) {
                alert(typeof(errorThrown));
            }
        });

        alert("haohaoxuexi")
    };



    // table.on('toolbar(test)', function(obj){
    //     var checkStatus = table.checkStatus(obj.config.id);
    //     switch(obj.event){
    //         case 'add':
    //             add();
    //             break;
    //         case 'getCheckData':
    //             var data = checkStatus.data;
    //             layer.alert(JSON.stringify(data));
    //             break;
    //         case 'getCheckLength':
    //             var data = checkStatus.data;
    //             layer.msg('选中了：'+ data.length + ' 个');
    //             break;
    //         case 'isAll':
    //             layer.msg(checkStatus.isAll ? '全选': '未全选')
    //             break;
    //     };
    // });



</script>
</body>
</html>