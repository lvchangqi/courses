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
		<div class="container">
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
				<form action="" class="col-md-6 col-md-push-2">
					<dl class="dl-horizontal">
						<dt>用户名:</dt>
						<dd>吕长奇</dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>学号/工号:</dt>
						<dd>2014116020312</dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>电话号码:</dt>
						<dd class="to-ipt" role="tel">18772290532</dd>
					</dl>
					<dl class="dl-horizontal">
						<div class="form-inline">
							<dt>QQ:</dt>
							<dd class="to-ipt" role="qq">675812074</dd>
						</div>
					</dl>
					<dl class="dl-horizontal">
						<dt>工作室指导老师:</dt>
						<dd>无</dd>
					</dl>
				</form>
			</div>
		</div>
	</body>
	<script type="text/javascript">
		var tel = '<input type="text" name="tel" class="form-control" />'
		var qq = '<input type="text" name="qq" class="form-control" />'
		$('#btn-change').click(function(){
			$(this).css('display','none').siblings().css('display','block')
			
			var val = ''
			val = $('dd[role="tel"]').text()
			$('dd[role="tel"]').html(tel)
			$('input[name="tel"]').val(val)
			
			val = $('dd[role="qq"]').text()
			$('dd[role="qq"]').html(qq)
			$('input[name="qq"]').val(val)
		})
		$('#btn-return').click(function(){
			$(this).parent().css('display','none').siblings().css('display','inline')
		})
	</script>
</html>