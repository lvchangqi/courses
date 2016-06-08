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
	<form class="container" style="margin: 18% 20% 0 0">
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
	<div class="container" style="margin: 0 20% 0 0">
	<form action="${pageContext.request.contextPath}/design/updatefile" method="POST" enctype="multipart/form-data">
		<input type="file" id="file" name="file" r style="display: none;"/>
		<input type="hidden" name="studentid" value="${user.studentid}"/>
		<dl class="col-md-8 dl-horizontal">
			<dt style="font-size: 19px; margin-top: 3px;">
				<label for="file">上传模版:</label>
			</dt>
			<dd class="form-group  horizontal">
				<input type="text" readonly="readonly" name="fileName"
					class="form-control" placeholder="文件名(自动生成)(支持zip/rar格式文件)" />
			</dd>
		</dl>
		</form>
		<div class="col-md-4 horizontal">
			<label for="file"  class="btn btn-info">
				选择模版
			</label>
			<button class="btn btn-primary btn-one" >上传</button>
			<button class="btn btn-default btn-two" >取消</button>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		$('#file').change(function(){
			var type = $(this).val().split(".")
			switch (type[type.length-1].toLowerCase()) {
			case 'zip':break;
			case 'rar':break;
			default:
				alert("文件格式不正确");
				return false
			}
			$('input[name="fileName"]').val($(this).val())
			
		})
		
		$('.btn-one').click(function(){
			if(!$('input[name="fileName"]').val()){
				alert('请先选择需要上传的文件')
			}else {
				$('form:last').submit()
				alert("模版上传成功")
			}
			
		})
		$('.btn-two').click(function(){
			$("#file").removeAttr('src')
			$('input[name="fileName"]').val('')
		})
		
		
		$('form:first').submit(function() {
			$.post('${pageContext.request.contextPath}/admin/notice', {
				notice : $('#notice').val(),
				name : '${user.promiss}'
			}, function(data) {
				if (data) {
					parent.notice()
					alert("公告发布成功")
				}
			})
			return false
		})
	})
</script>
</html>