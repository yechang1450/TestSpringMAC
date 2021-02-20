<html><head>
    <meta charset="utf-8">
    <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../sources/layui/css/layui.css                                        " media="all">
    <script src="../sources/layui/layui.js"></script>
    <script type="text/javascript" src="../sources/js/jquery.js"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body style="">
<div class="demoTable">
    搜索类别：
    <div class="layui-inline">
        <input class="layui-input" name="categoryId" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>
<form class="layui-form" action="" id="addForm" style="display:none">

    <div class="layui-form-item">
        <label class="layui-form-label">类别id</label>
        <div class="layui-input-inline">
            <input type="password" id="categoryId" required lay-verify="required" placeholder="请输入类别名字" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品id</label>
        <div class="layui-input-inline">
            <input type="text" id="goodsId" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品名字</label>
        <div class="layui-input-inline">
            <input type="text" id="goodsName" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品单价</label>
        <div class="layui-input-inline">
            <input type="text" id="goodsPrice" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品库存</label>
        <div class="layui-input-inline">
            <input type="text" id="goodsStock" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品状态</label>
        <div class="layui-input-inline">
            <input type="text" id="goodsStatus" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商品描述</label>
        <div class="layui-input-inline">
            <input type="text" id="describe" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
<%--    <div class="layui-form-item">--%>
<%--        <label class="layui-form-label">删除状态</label>--%>
<%--        <div class="layui-input-inline">--%>
<%--            <input type="text" id="deleteStatus" required lay-verify="required" placeholder="手机号" autocomplete="off" class="layui-input">--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="adds()">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>





<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="goodsStatus" value="{{d.id}}" title="可售" lay-filter="lockDemo" {{ d.goodsStatus == 'true' ? 'checked' : '' }}>
</script>




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



<script>






layui.use('table', function(){


        var table = layui.table
            ,form = layui.form;
        var pagecount;
        page();
        function page(){
            jQuery.ajax({
                url: 'goods/selectCount',
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
            ,url:'http://localhost:8080/goods/findGoodsList' //改成我们使用的servlet
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
                ,{field:'categoryId', title:'类别id', width:150, edit: 'text'}
                ,{field:'goodsId', title:'商品id', width:150, edit: 'text'}
                ,{field:'goodsName', title:'商品名字', width:120, edit: 'text'}
                ,{field:'goodsPrice', title:'商品价格', width:120, edit: 'text'}
                ,{field:'goodsStock', title:'商品库存', width:120, edit: 'text'}
                ,{field:'goodsStatus', title:'商品状态', width:110,templet: '#checkboxTpl', unresize: true}
                ,{field:'describe', title:'商品描述', width:120, edit: 'text'}
               // ,{field:'deleteStatus', title:'删除状态', width:120, edit: 'text'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:120}


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
                console.log(res)
                return {
                    "status": res[0].status,
                    "message":res[1].message,
                    "count": pagecount,
                    "rows": res[3].rows.item
                };
            }
        });
    //监听包月状态
    // form.on('switch(sexDemo)', function(){
    //     var id = this.value;
    //     var sex = this.name;
    //     $.ajax({
    //         type: "get",
    //         url: "login/updateSex",
    //         data: {
    //             "id": id,
    //             "sex":sex
    //         },
    //         cache: false,
    //         async: true,
    //         success: function () {
    //             layer.msg('修改成功', { icon: 1, offset: "t", time:2000 });
    //         },
    //         error: function () {
    //             layer.msg('修改失败', { icon: 2, offset: "t", time:2000 });
    //         }
    //     });
    // });
    //监听自习状态
    //监听自习状态
    form.on('checkbox(lockDemo)', function(){
        var id = this.value;
        var goodsStatus = this.checked;
        $.ajax({
            type: "get",
            url: "goods/updateStatus",
            data: {
                "id": id,
                "goodsStatus":goodsStatus
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
                        categoryId: demoReload.val()//的value 传达
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
            var upid = data.id;
            console.log(upid);
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){

                    $.ajax({
                        type: "get",
                        url: "http://localhost:8080/goods/deleteGoodsById",
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
                var url = "http://localhost:8080/goods/updateGoods";
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

    function adds(){
        var data={

            //"id":$("#pwd").val(),
            "categoryId":$("#categoryId").val(),
            "goodsId":$("#goodsId").val(),
            "goodsName":$("#goodsName").val(),
            "goodsPrice":$("#goodsPrice").val(),
            "goodsStock":$("#goodsStock").val(),
            "goodsStatus":$("#goodsStatus").val(),
            "describe":$("#describe").val(),
            "deleteStatus":$("#deleteStatus").val(),
        };
        var url = "http://localhost:8080/goods/addGoods";

        $.ajax({
            type: "get",
            url: url,
            data: data,
            cache: false,
            async : true,
            success: function (data,textStatus, jqXHR)
            {

            },
            error:function (XMLHttpRequest, textStatus, errorThrown) {
                //alert(typeof(errorThrown));
            }
        });
        form.on('checkbox(lockDemo)', function(obj){
            layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
        });

    };



</script>
</body>
</html>
