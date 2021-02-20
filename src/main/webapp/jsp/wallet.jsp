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
<table class="layui-hide" id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">充值</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script src="../sources/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

<script>
    layui.use('table', function(){
        var table = layui.table;
        var pagecount;
        page();
        function page() {
            jQuery.ajax({
                url: 'wallet/selectCount',
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
            ,url:'http://localhost:8080/wallet/findUserCharge'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户钱包'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
                ,{field:'userName', title:'用户名', width:120, edit: 'text'}
                ,{field:'charge', title:'余额', width:150, edit: 'text', templet: function(res){
                        return '<em>'+ res.charge +'</em>'
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            , id: 'testReload'
            ,page: true
            , limit: 5
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
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });

        //监听行工具事件
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
            layer_index= layer.open({

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
            upid = data.id;
            console.log(upid);
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){

                    $.ajax({
                        type: "get",
                        url: "http://localhost:8080/wallet/deleteId",
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
                var url = "http://localhost:8080/wallet/updateCharge";
                $.ajax({
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
</script>

</body>
</html>