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
<title>发布公告</title>
</head>
<body>
	<form class="container" style="margin: 20% 20% 0 0">
		<dl class="col-md-11 dl-horizontal">
			<dt style="font-size: 19px; margin-top: 3px;">
				<label for="notice">公告:</label>
			</dt>
			<dd class="form-group  form-horizontal">
				<input type="text" id="notice" required="required"
					class="form-control" placeholder="请输入公告内容(限60字以内)" maxlength="60" />
			</dd>
		</dl>
		<div class="col-md-1">
			<button class="btn btn-primary">发布公告</button>
		</div>
	</form>
</body>
<script type="text/javascript">
	$(function() {
		$('form').submit(function() {
			$.post('${pageContext.request.contextPath}/admin/notice', {
				notice : $('#notice').val(),
				name : '${user.promiss}'
			}, function(data) {
				if (data) {
					alert("公告发布成功")
				}
			})
			return false
		})
	})
</script>
</html>