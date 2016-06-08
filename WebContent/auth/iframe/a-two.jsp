<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../../css/bootstrap.min.css" />
<link rel="stylesheet" href="../../css/public.css" />
<script type="text/javascript" src="../../js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<title>用户管理</title>
<style type="text/css">
	.btn{
		border-radius: 0;	
	}
	#all{
		padding: 7px;
	}
	.over{
		height: 100%;
		width: 100%;
		background-color: rgba(0,0,0,.5);
		position: absolute;
		top:0;
		left: 0;
		display: none;
	}
	.over .content{
		width: 200px;
		height: 70px;
		margin: 10% auto;
		background-color: #ffffff;
		padding-right: 10px;
	}
	.over .content select{
		width: 100px;
		margin: 30px 10px 30px 20px;
	}
</style>
</head>
<body>
	<table class="table table-condensed table-hover">
		<caption style="padding: 10px 0;">
			<button class="btn btn-primary active btn-switch" role="student">学&nbsp;&nbsp;&nbsp;&nbsp;生</button>
			<button class="btn btn-primary btn-switch" role="teacher">教&nbsp;&nbsp;&nbsp;&nbsp;师</button>
			<button class="btn btn-danger btn-xs btn-deleteAll">删除所选</button>
		</caption>
		<thead>
			<tr class="bg-info">
				<th><button id="all" class="btn btn-default btn-xs"></button>全选/反选</th>
				<th>用户名</th>
				<th>真实姓名</th>
				<th>学号/工号</th>
				<th>QQ号码</th>
				<th>电话号码</th>
				<th class="student">作品下载</th>
				<th class="student">指导老师</th>
				<th class="teacher">下载表格</th>
				<th>删除用户</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	<div class="over">
		<div class="content">
			<span style="float: right; font-size: 18px; cursor: pointer;">&times;</span>
			<select name="changeT"></select>
			<button class="btn btn-primary btn-xs btn-t">确认</button>
		</div>
	</div>
</body>
<script type="text/javascript">
	var basePath = '${pageContext.request.contextPath}'
	$(function() {
		var sid = ''
		$('.over .content span').click(function(){
			$('.over').css('display','none')
		})
		$('tbody').on('click','.btn-t',function(){
			sid = $(this).parents().siblings('th').eq(3).text()
			$('.over').css('display','block')
			$.getJSON(basePath+'/user/selectAll',{role:'teacher'},function(data){
				if(data)
					for(var i =0;i<data.length;i++){
						$('<option value="'+data[i].promiss+'">'+data[i].promiss+'</option>').appendTo('select')
					}
			})
		})
		$('.over .content button').click(function(){
			$.post(basePath+'/admin/changeT',{tname:$('select').val(),studentid:sid},function(data){
				window.location.reload(true)
			})
		})
		
		//==遮罩层==//
		var role = 'student'
		getUsers(role)
		$('.student').css('display','table-cell')
		$('.teacher').css('display','none')
		
		$('.btn-switch').click(function(){
			$(this).addClass('active').siblings().removeClass('active')
			$('tbody').children().remove()
			role = $(this).attr('role')
			getUsers(role)
			if(role =='student'){
				$('.teacher').css('display','none')
				$('.student').css('display','table-cell')
			} else {
				$('.teacher').css('display','table-cell')
				$('.student').css('display','none')
			}
		})
		
		$('body').on('click','.btn-deleteAll,.btn-delete',function(){
			if(confirm("确认删除吗?")){
				var box = $('input[name="users"]')
				var check = new Array()
				
				if(!check.length){
					check.push($(this).attr('data-id'))
				}
				
				box.each(function(i,v){
					if($(v).is(':checked')){
						check.push(v.value)
					}
				})
				$.post(basePath+"/admin/delete",{people:JSON.stringify(check)},function(data){
					if(data){
						$('.active').click()
					}
				})
			}
        })
		
		$('#all').click(function(){
			$('input[name="users"]').click()
		})
		
				
		function getUsers(role) {
			$.get(basePath+'/user/selectAll',{role:role},function(data){
				for(var i=0;i<data.length;i++){
					var btn = '<button class="btn btn-danger btn-xs btn-delete" data-id="'+data[i].studentid+'">删除</button>'
					var down = '<a href="'+basePath+'/design/download/'+data[i].studentid+'" class="btn btn-xs btn-primary">下载</a>'
					var t = '<th>'+down+'</th>'
					if(role =='student'){
						if(data[i].tname){
							t = '<th><button class="btn btn-default btn-xs btn-t">'+data[i].tname+'</button></th>'
						} else {
							t = '<th>无</th>'
						}
						if(!data[i].hasUp){
							down = '还未上传'
						}
						
					} else if(!data[i].teacher){
						t = '<th>还未上传</th>'
					}
					var row = '<tr>'+ '<th><input type="checkbox" name="users" value="'+data[i].studentid+'"/></th>' + '<th>'+data[i].username+'</th>' + '<th>'+data[i].promiss+'</th>' + '<th>'+data[i].studentid+'</th>'
					+ '<th>'+data[i].qq+'</th>' + '<th>'+data[i].phone+'</th>'+'<th class="dw">'+down+'</th>' + t + '<th>'+btn+'</th>' + '</tr>'
					
					$('tbody').append(row)
					
					if(role =='teacher'){
						$('.dw').remove()
					}
				}
			})
		}
	})
</script>
</html>