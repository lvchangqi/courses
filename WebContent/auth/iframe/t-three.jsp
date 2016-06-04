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
		<button class="btn btn-primary btn-export">导出Excel表格</button>
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
	var basePath = '${pageContext.request.contextPath}'
	var collapse = '<div class="panel panel-default panel-info">'
			+ '<div class="panel-heading">'
			+ '<h4 class="panel-title">'
			+ '<a data-toggle="collapse" href="#collapseOne"><strong></strong><span class="caret"></span></a>'
			+ '</h4>'
			+ ' </div>'
			+ '<div id="collapseOne" class="panel-collapse collapse">'
			+ '<div class="panel-body">'
			+ '<table class="table table-condensed table-hover">'
			+ '<thead>' + '<tr class="bg-success">' + '<th>姓名</th>'
			+ '<th>学号</th>' + '<th>QQ号码</th>' + '<th>电话号码</th>' + '<th>课程设计下载</th>' 
			+ '</tr>'
			+ '</thead>' + '<tbody></tbody>' + '</table>' + '</div>' + '</div>'
			+ '</div>'
	
			$(function() {
				var name = '${user.promiss}'
				$.post(basePath +'/design/getAll',{tname:name},function(data){
					if(data.length==0){
						collapse = '<button class="btn btn-primary btn-block disabled" style="font-weight:700;font-size:17px;letter-spacing:0.3em;border-radius:0" disabled>暂无学生选择课题</button>'
						$(collapse).prependTo('body').animate({
							marginTop: '240px'
						},1300)
					}else{
						for (var i = 0; i < data.length; i++) {
							$(collapse).prependTo('body')
						}
						for (var i = 0; i < data.length; i++) {
							var depend = "collapse" + i
							$('a[data-toggle="collapse"]').eq(i).attr('href', '#' + depend)
							$('strong').eq(i).html(data[i].title+'<small>(已有'+(8-data[i].counter)+'人选择)</small>')
							$('.collapse').eq(i).attr('id', depend)
						}
					}
				})
				
				$('body').on('click','a',function(){
					var body = $(this).parent().parent().siblings('.collapse')
					var open = body.hasClass('in')
					var title = $(this).text().split('(')[0]
					
					if(!open){
						$.getJSON(basePath+'/user/title',{title:title},function(data){
							body.find('tbody').children().remove()
							if(data.length > 0){
								for(var i = 0;i<data.length;i++){
									var download = '<a href="'+basePath+'/design/download/'+data[i].studentid+'" class="btn btn-xs btn-primary">下载</a>'
									if(data[i].agree != "true"){
										download = '暂未上传文件'
									}
									body.find('tbody').append('<tr><td>'+data[i].promiss+'</td><td>'+data[i].studentid+'</td><td>'+data[i].qq+'</td><td>'+data[i].phone+'</td><td>'+download+'</td></tr>')
								}
							} else {
								body.find('tbody').append('<tr><td colspan="5" class="text-center">暂时无人选择此课题</td><tr>')
							}
						})
					}
				})
				
				$('.btn-export').click(function(){
					$.get(basePath+"/admin/export/${user.studentid}")
					alert("表格已经导入您E盘的根目录")
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