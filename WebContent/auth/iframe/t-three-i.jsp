<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../../css/bootstrap.min.css" />
<link rel="stylesheet" href="../../css/public.css" />
<link rel="stylesheet" href="../../css/style.css" />
<script type="text/javascript" src="../../js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../js/holder.min.js"></script>
<title>Document</title>
</head>
<body style="margin-top: 20px;">
	<div class="col-md-12 text-right">
		<a class="btn btn-primary " href="${pageContext.request.contextPath}/admin/export/${user.studentid}">导出Excel表格</a>
		<button class="btn btn-default btn-import" data-toggle="modal" data-target="#myModal">上传Excel表格</button>
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
				<span style="position: absolute;bottom:40%;left:42%;"class="con">(xls格式)</span>
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
	var basePath = '${pageContext.request.contextPath}'
	var collapse =  '<table class="table table-condensed table-hover">'
			+ '<thead>' + '<tr class="bg-success">' + '<th>姓名</th>'
			+ '<th>学号</th>' +'<th>学院名称</th>' + '<th>专业名称</th>'+'<th>班级</th>'
			+ '<th>课题名</th>' + '<th>QQ号码</th>' + '<th>电话号码</th>' + '<th>课程设计下载</th>' 
			+ '</tr>'
			+ '</thead>' + '<tbody></tbody>' + '</table>' 
	
			$(function() {
				var name = '${user.promiss}'
				$.post(basePath +'/design/getAll',{tname:name},function(data){
					if(data.length==0){
						collapse = '<button class="btn btn-primary btn-block disabled" style="font-weight:700;font-size:17px;letter-spacing:0.3em;border-radius:0" disabled>暂无学生选择课题</button>'
						$(collapse).prependTo('body').animate({
							marginTop: '240px'
						},1300)
					}else{
						var hr13 = '<tr class="hr13">'+
							'<td colspan="11" align="center" style="font-weight: 900;background-color:#F5F5F5;">13级</td>'+
					 		'</tr>'
						var hr14 = '<tr class="hr14">'+
							'<td colspan="11" align="center" style="font-weight: 900;background-color:#F5F5F5;">14级</td>'+
							'</tr>'
						$(collapse).prependTo('body')
						$(hr13).prependTo('tbody')
						$(hr14).prependTo('tbody')
						$.post(basePath+'/user/title',{tname:'${user.promiss}'},function(data){
							if(data.length != 0){
								for(var i = 0;i<data.length;i++){
									var download = '<a href="'+basePath+'/design/download/'+data[i].studentid+'" class="btn btn-xs btn-primary">下载</a>'
									if(data[i].agree != "true"){
										download = '暂未上传文件'
									}
									if(!data[i].ctitle){
										data[i].ctitle = data[i].title
									}
									var row ='<tr><td>'+data[i].promiss+'</td><td>'+data[i].studentid+'</td><td>'+data[i].college+'</td><td>'+data[i].major+'</td><td>'+data[i].classes+'</td><td>'+data[i].ctitle+'</td><td>'+data[i].qq+'</td><td>'+data[i].phone+'</td><td>'+download+'</td></tr>'
									if(data[i].studentid.toString().substring(2,4)=="14"){
										$('.hr14').after(row)
									} else {
										$('.hr13').after(row)
									}
								}
							} else {
								$('tbody').append('<tr><td colspan="9" class="text-center">暂时无人选择您的课题</td><tr>')
							}
						})
					}
				})
				
				$('#file').change(function(){
					var objUrl = basePath + "/img/excel.ico"
					var type = $(this).val().split(".")
					switch (type[type.length-1].toLowerCase()) {
					case 'xls':break;
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
			})
</script>
</html>