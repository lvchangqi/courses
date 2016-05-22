<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>document</title>
<link rel="stylesheet" href="../../css/style.css" />
<link rel="stylesheet" type="text/css"
	href="../../css/bootstrap.min.css" />
<script src="../../js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../js/holder.min.js"></script>
</head>

<body class="container" style="margin-top: 20px;">
	<div class="row"></div>
</body>
<script>
	var basePath ='${pageContext.request.contextPath}'	
		
	$.getJSON(basePath+"/user/res",{role: 'teacher'},function(data){
		for(var i=0;i<data.length;i++){
			var img = ''
			if(data[i].imgpath){
				img = data[i].imgpath
			} else {
				img = 'http://localhost:8080/courses/images/placeholder.jpg'
			}
			var panel = '<div class="col-md-3">'
				+ '<div class="thumbnail">'
				+ '<img src="'+img+'" alt="..." style="width: 229px;height: 177px;">'
				+ '<div class="caption">' + '<h3 class="text-center">'+data[i].promiss+'</h3>'
				+ '<p class="text-center">QQ:'+data[i].qq+'<br/>'
				+ '电话:'+data[i].phone+'</p>'
				+ '<p><a href="./t-two.jsp?realname='+escape(data[i].promiss)+'" class="btn btn-primary btn-block">查看选题</a></p>'
				+ '</div>' + '</div>' + '</div>'
				
				$(panel).appendTo('.row')
		}
		console.log(data.length)
	})
</script>

</html>