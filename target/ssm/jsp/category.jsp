<html><head>
    <meta charset="utf-8">
    <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../sources/layui/css/layui.css" media="all">
    <script src="../sources/layui/layui.js"></script>
    <script type="text/javascript" src="../sources/js/jquery.js"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body style="">
<form class="layui-form" action="" id="addForm" style="display:none">
    <div class="layui-form-item">
        <label class="layui-form-label">类别名字</label>
        <div class="layui-input-inline">
            <input type="text" id="categoryName" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">类别状态</label>
        <div class="layui-input-inline">
            <input type="text" id="categoryStatus" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">权限</label>
        <div class="layui-input-inline">
            <input type="text" id="admin" required lay-verify="required" placeholder="权限" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="adds()">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<div class="demoTable">
    搜索用户名：
    <div class="layui-inline">
        <input class="layui-input" name="categoryName" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
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
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="categoryStatus" value="{{d.id}}" title="在职" lay-filter="lockDemo" {{ d.categoryStatus == '在售中' ? 'checked' : '' }}>
</script>
<script>
    layui.use('table', function(){
        var table = layui.table
            ,form = layui.form;
        var pagecount;
        page();
        function page() {
            jQuery.ajax({
                url: 'category/selectCount',
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
            ,url:'http://localhost:8080/category/findCategoryList' //改成我们使用的servlet
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
                ,{field:'categoryName', title:'类别名称', width:150, edit: 'text'}
                ,{field:'categoryStatus', title:'类别状态', width:150, templet: '#checkboxTpl'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]
            ]
            ,id: 'testReload'
            ,page: true
            ,limit:10
            ,response:{
                statusName: 'status'
                ,dataName: 'rows'
            }
            ,parseData: function(res){
                //console.log(res);
                return {
                    "status": res[0].status,
                    "message":res[1].message,
                    "count": pagecount,
                    "rows": res[3].rows.item
                };
            }
        });
        form.on('checkbox(lockDemo)', function(){
            var id = this.value;
            var categoryStatus = this.checked;
            $.ajax({
                type: "get",
                url: "category/updateCategoryStatus",
                data: {
                    "id": id,
                    "categoryStatus":categoryStatus
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
                        categoryName: demoReload.val()
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
                    break;
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    console.log(data[0].id);
                    findById(data[0].id);
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
        //让添加框弹出来
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj);
            var upid = data.id;
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        type: "get",
                        url: "http://localhost:8080/category/deleteCategoryById",
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
                var url = "http://localhost:8080/category/updateCategory";
                $.ajax({
                    type: "get",
                    url: url,
                    data: data,
                    cache: false,
                    async : true,
                    success: function (data,textStatus, jqXHR) {
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
            "categoryName":$("#categoryName").val(),
            "categoryStatus":$("#categoryStatus").val(),
            "admin":$("#admin").val()
        };
        $.ajax({
            type: "get",
            url: "http://localhost:8080/category/addCategory",
            data: data,
            cache: false,
            async : true,
            success: function (data,textStatus, jqXHR) {},
            error:function (XMLHttpRequest, textStatus, errorThrown) {
                //alert(typeof(errorThrown));
            }
        });
    }
</script>
</body>
</html>
