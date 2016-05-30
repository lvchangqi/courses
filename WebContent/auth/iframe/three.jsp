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
	
	$.get('${pageContext.request.contextPath}/design/selectOne/${user.studentid}',function(data){
	
		if(data) {
			var panel =  '<div class="panel panel-success" style="margin-top: 20px;">'+
			  '<div class="panel-heading">'+
			    '<h3 class="panel-title">'+data.title+'</h3>'+
			  '</div>'+
			  '<div class="panel-body" style="padding: 40px">'+
			    	'<span class="content">说明:'+data.content+'</span>'+
			    	'<hr>'+
			    	'<span class="other">备注:'+data.other+'</span>'+
			  '</div>'+
			  '<div class="panel-footer ">'+
			  	'<button class="btn btn-primary btn-block disabled" data-toggle="modal" data-target="#myModal">文档及源码上传</button>'+
			  '</div>'+
			'</div>'
			
			$(panel).appendTo('body')
			
			if(!data.tname){
				$('.btn:last').tooltip({
					'title' : '请等待老师审核,通过后方可上传',
					'placement': 'bottom',
					'container': 'body',
					'trigger' : 'click'
				})
				$('.btn:last').tooltip('show')
			}else if(data.tname == 'false'){
				$('.btn:last').removeClass('disabled')
			}else if(data.tname == 'true'){
				$('.btn:last').text('文件已上传,请等待老师查看与反馈')
			}
		} else {
			var collapse = '<button class="btn btn-primary btn-block disabled" style="font-weight:700;font-size:17px;letter-spacing:0.3em;border-radius:0" disabled>你还没有选择课题</button>'
				$(collapse).appendTo('body').animate({
					marginTop: '240px'
				},1300)
		}
	})
				
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