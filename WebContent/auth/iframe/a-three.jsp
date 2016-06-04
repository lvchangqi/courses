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
				<th>删除用户</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</body>
<script type="text/javascript">
	var basePath = '${pageContext.request.contextPath}'
	$(function() {
		var role = 'student'
		getUsers(role)
						
		$('.btn-switch').click(function(){
			$(this).addClass('active').siblings().removeClass('active')
			$('tbody').children().remove()
			role = $(this).attr('role')
			getUsers(role)
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
					
					var row = '<tr>'+ '<th><input type="checkbox" name="users" value="'+data[i].studentid+'"/></th>' + '<th>'+data[i].username+'</th>' + '<th>'+data[i].promiss+'</th>' + '<th>'+data[i].studentid+'</th>'
					+ '<th>'+data[i].qq+'</th>' + '<th>'+data[i].phone+'</th>' + '<th>'+btn+'</th>' + '</tr>'
					
					$('tbody').append(row)
				}
			})
		}
	})
</script>
</html>