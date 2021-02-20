<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
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
<body style="">
  <form class="layui-form" action="" id="addForm" style="display:none">
 <div class="layui-form-item">
   <label class="layui-form-label">灯光状态</label>
   <div class="layui-input-block">
     <input type="text" id="acc" required  lay-verify="required" placeholder="请输入区域ID" autocomplete="off" class="layui-input">
   </div>
 </div>
 <div class="layui-form-item">
   <label class="layui-form-label">小时价格</label>
   <div class="layui-input-inline">
     <input type="password" id="seatLightStatus" required lay-verify="required" placeholder="请输入灯光状态" autocomplete="off" class="layui-input">
   </div>
 </div>
 <div class="layui-form-item">
   <label class="layui-form-label">月价格</label>
   <div class="layui-input-inline">
     <input type="text" id="areaId" required lay-verify="required" placeholder="请输入包月状态" autocomplete="off" class="layui-input">
   </div>
 </div>
 <div class="layui-form-item">
   <label class="layui-form-label">区域状态</label>
   <div class="layui-input-inline">
     <input type="text" id="vipStatus" required lay-verify="required" placeholder="请输入可用状态" autocomplete="off" class="layui-input">
   </div>
 </div>
      <div class="layui-form-item">
          <label class="layui-form-label">删除状态</label>
          <div class="layui-input-inline">
              <input type="text" id="deleteStatus" required lay-verify="required" placeholder="请输入可用状态" autocomplete="off" class="layui-input">
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
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 --> 
 
<script>

layui.use('table', function(){
 
 
  var table = layui.table;

  var pagecount;
  page();
  function page(){
      $.ajax({
          url: 'area/selectCount',
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
    ,url:'/area/selectall' //改成我们使用的servlet
    ,method:"get"
    ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
    ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
      title: '提示'
      ,layEvent: 'LAYTABLE_TIPS'
      ,icon: 'layui-icon-tips'
    }]
    ,title: '用户数据表'
    ,cols: [[
      {type: 'checkbox', fixed: 'left'}
      ,{field:'id', title:'ID', width:70, fixed: 'left', unresize: true, sort: true}
      ,{field:'areaLightStatus', title:'灯光状态', width:150, edit: 'text'}
      ,{field:'areaPrice_hour', title:'小时价格', width:150, edit: 'text'}
      ,{field:'areaPrice_month', title:'月价格', width:150, edit: 'text'}
      ,{field:'areaStatus', title:'区域状态', width:150, edit: 'text'}
      ,{field:'deleteStatus', title:'删除状态', width:150, edit: 'text'}
      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:120}
    ]]
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
		        "count":pagecount,
		        "rows": res[3].rows.item  
		    };
  	}
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
    upid = data.id;
    console.log(upid);
    if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
         
  		 $.ajax({
  		        type: "get", 
  		        url: "http://localhost:8080/area/deleteById",
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
    	var url = "http://localhost:8080/area/updateByPrimaryKey";
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
		"id":$("#id").val(),
    	"seatLightStatus":$("#seatLightStatus").val(),
    	"areaPrice_hour":$("#areaPrice_hour").val(),
    	"areaPrice_month":$("#areaPrice_month").val(),
    	"areaStatus":$("#areaStatus").val(),
        "deleteStatus":$("#deleteStatus").val()
    	      };
    	      var url = "http://localhost:8080/area/insert";
    	     
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
    	  		
    	      
	};



</script>
</body>
</html>