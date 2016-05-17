<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>one</title>
		<link rel="stylesheet" href="../../css/bootstrap.min.css" />
		<link rel="stylesheet" href="../../css/public.css" />
		<script type="text/javascript" src="../../js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
		<style>
			.container {
				margin-top: 80px;
			}
			
			form {
				border-top: 1px solid gray;
			}
			
			dl {
				margin-top: 40px;
			}
			
			dl dt,
			dl dd {
				font-size: 20px;
			}
			#btn-group{
				display: none;
			}
		</style>
	</head>

	<body>
		<div class="container jumbotron">
			<div class="row">
				<div class="col-md-6 col-md-push-2 text-right" style="margin-bottom: 5px;">
					<button type="button" class="btn btn-primary" id="btn-change">修改</button>
					<div id="btn-group">
						<button type="button" class="btn btn-primary" id="btn-sure">确定</button>
						<button type="button" class="btn btn-default" id="btn-return">返回</button>
					</div>
				</div>
			</div>
			<div class="row">
				<form  action="${pageContext.request.contextPath}/user/update" class="col-md-6 col-md-push-2" method="post">
					<dl class="dl-horizontal">
						<dt>用户名:</dt>
						<dd>${user.username}</dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>学号/工号:</dt>
						<dd>${user.studentid}</dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>电话号码:</dt>
						<dd class="to-ipt" role="tel">${user.phone}</dd>
					</dl>
					<dl class="dl-horizontal">
						<div class="form-inline">
							<dt>QQ:</dt>
							<dd class="to-ipt" role="qq">${user.qq}</dd>
						</div>
					</dl>
					<dl class="dl-horizontal">
						<dt>工作室指导老师:</dt>
						<dd class="to-ipt" role="teacher">${user.teacher}</dd>
					</dl>
				</form>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	console.log('${user}')
		var tel = '<input type="text" name="phone" class="form-control" />'
		var qq = '<input type="text" name="qq" class="form-control" />'
		var teacher = '<input type="text" name="teacher" class="form-control" placeholder="若未参加工作室,此处不填写" />'
		$('#btn-change').click(function(){
			$(this).css('display','none').siblings().css('display','block')
			
			
			$('dd[role="tel"]').html(tel)
			$('input[name="phone"]').val('${user.phone}')
			
			$('dd[role="qq"]').html(qq)
			$('input[name="qq"]').val('${user.qq}')
			
			$('dd[role="teacher"]').html(teacher)
			if('${user.teacher}' != '无'){
				$('input[name="teacher"]').val('${user.teacher}')
			}
		})
		$('#btn-return').click(function(){
			$(this).parent().css('display','none').siblings().css('display','inline')
			$('dd[role="tel"]').html('${user.username}')
			$('dd[role="qq"]').html('${user.qq}')
			$('dd[role="teacher"]').html('${user.teacher}')
		})
		$('#btn-sure').click(function(){
			$.ajax({
				url: '${pageContext.request.contextPath}/user/update',
				data: $('form').serialize(),
				type: 'post',
				dataType: "text",
				success: function(data){
					if(data) window.location.reload(true)
				},
				error: function(){
					alert("连接超时,请稍后重试")
				}
			})
		})
	</script>
</html>