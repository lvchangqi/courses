<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>跳转</title>
		<style type="text/css">
			.container{
				width: 400px;
				height: 200px;
				border: 1px solid #198FEA;
				margin: 190px auto;
				text-align: center;
			}
			.container .container_font{
				margin: 50px auto 0 auto;
			}
			.container .container_font span{
				line-height: 90px;
				font-size: 20px;
			}
			a{
				color:#FF0000;
				font-size: 20px;
			}
			#a{
				color: red;
			}
		</style>
	</head>

	<body>
		<div class="container">
			<div class="container_font">
				<span>恭喜您注册成功,<span id="a">3</span>秒后为您跳转到主页<span id="b"></span></span>
			</div>
			<a href="../login.jsp">若没有反应请点击这里...</a>
		</div>
	</body>
	<script type="text/javascript">
		var i = 2;
		var time = setInterval(function(){
			document.getElementById('a').innerHTML = i--;
			if(i==-1){
				window.location.href = "../login.jsp";
				clearInterval(time);
			}
		},1000);
		window.history.forward(1); 
	</script>

</html>