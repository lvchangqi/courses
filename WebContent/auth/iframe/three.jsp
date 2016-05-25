<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="../../css/bootstrap.min.css" />
<link rel="stylesheet" href="../../css/style.css" />
<script type="text/javascript" src="../../js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<title>文档及源码上传</title>
</head>
<body>
	
<div class="panel panel-success" style="margin-top: 20px;">
  <div class="panel-heading">
    <h3 class="panel-title">基于AT89芯片的距离可调报警系统</h3>
  </div>
  <div class="panel-body" style="padding: 40px">
    	基于AT89芯片的距离可调报警系统<a href="${pageContext.request.contextPath}/design/download/2014116020312">下载</a>
    	<hr>
    	<span class="other">备注:可用于汽车倒车报警</span>
  </div>
  <div class="panel-footer ">
  	<button class="btn btn-primary btn-block" data-toggle="modal" data-target="#myModal">文档及源码上传</button>
  </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <!-- TODO: -->
        <form class="modal-body" action="${pageContext.request.contextPath}/design/updatefile" method="POST" enctype="multipart/form-data">
			<input type="file" name="file" id="file" style="display: none;" required="required"/>
			<input type="hidden" name="studentid" value="${user.studentid}"/>
			<input type="text" readonly="readonly" class="form-control" value="文件名(自动生成)"/>
			<label for="file" class="img-thumbnail" style="display: block; height: 180px; margin-top: 8px;">
				<span class="icon-upload con" style="position: absolute;top:35%;left:44%;font-size: 40px;"></span>
				<span style="position: absolute;bottom:47%;left:42%;"class="con">点击上传</span>
				<span style="position: absolute;bottom:40%;left:39%;"class="con">(zip/rar格式)</span>
				<img src="" width="100%" height="100%"  style="display: none;" id="imgface"/>
			</label>
				<input type="submit" value="确定上传" class="btn btn-block btn-primary"/>
				<input type="reset"  value="取消"  data-dismiss="modal" class="btn btn-block btn-default"/>
		</form>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">
	$('#file').change(function(){
		var objUrl = '<%=basePath%>' + "img/yasuo.ico"
		var type = $(this).val().split(".")
		switch (type[type.length-1].toLowerCase()) {
		case 'zip':break;
		case 'rar':break;
		default:
			alert("文件格式不正确");
			return false
		}
		$('input[type="text"]').val($(this).val())
		
		$('.con').css('z-index','-1');
		$("#imgface").attr("src", objUrl).css('display','block');
	})
	$('input[type="reset"]').click(function(){
		$("#file").removeAttr('src')
		$('.con').css('z-index','1');
		$("#imgface").attr("src", "").css('display','none');
		$('input[type="text"]').val('');
	})
</script>
</html>