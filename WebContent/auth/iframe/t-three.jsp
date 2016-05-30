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
						$(collapse).appendTo('body').animate({
							marginTop: '240px'
						},1300)
					}else{
						for (var i = 0; i < data.length; i++) {
							$(collapse).appendTo('body')
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
			})
</script>
</html>