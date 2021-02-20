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
    </div>
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
                url: 'chargeRecord/selectCount',
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
            ,url:'http://localhost:8080/chargeRecord/findUserRecord'
            ,toolbar: '#toolbarDemo'
            ,cols: [[
                {type:'radio'}
                ,{field:'id', width:150, title: 'ID', sort: true}
                ,{field:'userName', width:150, title: '用户名'}
                ,{field:'amount', width:150, title: '充值金额', sort: true}
                ,{field:'amount_time', width:300, title: '充值记录'}
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
                    "count":pagecount,
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
            var checkStatus = table.checkStatus(obj.config.id); //获取选中行状态
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;  //获取选中行数据
                    layer.alert(JSON.stringify(data));
                    break;
            };
        });
    });
</script>

</body>
</html>