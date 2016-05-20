<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="css/bootstrap.min.css" />
		<link rel="stylesheet" href="css/public.css" />
		<link rel="stylesheet" href="css/login.css" />
		<link rel="stylesheet" href="css/style.css" />
		<link rel="stylesheet" href="css/animation.css" />
		<title>登录</title>
		<style type="text/css">
			div[role="alert"] {
				position: absolute;
				top: 30%;
				left: 38%;
				display: none;
				z-index: 999;      
			}
		</style>
	</head>

	<body onkeypress="if(event.keyCode == 13) return false">
		<div class="jumbotron main-banner"></div>
		<div class="main-over">
			<nav class="navbar navbar-default navbar-fixed-top navbar-inverse main-nav">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false">
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				    </button>
					<a href="./login.jsp" class="navbar-brand main-logo" style="color:#FFFFFF; margin-left: 47.5%; font-size: 30px;" id="logo">课程(毕业)设计网上自动双选系统</a>
				</div>
				<div class="container">
					<div class="collapse navbar-collapse" id="navbar-collapse">
						<ul class="nav navbar-nav  navbar-right">
							<li><a href="./login.jsp" role="login">登录</a></li>
							<li><a href="./submit.jsp" role="submit">注册</a></li>
							<li class="active"><a href="./found.jsp" role="found">找回密码</a></li>
							<li><a href="tencent://message/?uin=675812074&Menu=yes" role="2" id="about">关于</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!--头结束-->
		<div class="alert alert-success alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<strong>恭喜您,密码找回成功!</strong> 正在为您跳转登录界面.
		</div>
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-md-push-4" role="form" id="login" style="margin-top: 5.1%;">
						<div class="form-group text-center title">
							<div class="preloading">
								<span>找回密码</span>
							</div>
							<div class="loading icon-spinner6"></div>
						</div>
						<div class="form-group text-center">
							<label for="username">用户名:</label>
							<input type="text" name="username" id="username" placeholder="用户名" required="required" class="form-control" />
						</div>
						<div class="form-group text-center">
							<label for="studentid">学&nbsp;&nbsp;&nbsp;&nbsp;号:</label>
							<input type="text" name="studentid" id="studentid" placeholder="学号" required="required" class="form-control" />
						</div>
						<div class="form-group text-center">
							<label for="password">新密码:</label>
							<input type="password" name="password" id="password" placeholder="新密码" required="required" class="form-control" />
						</div>
						<div class="form-group text-center">
							<label for="repassword">确认新密码:</label>
							<input type="password" name="repassword" id="repassword" placeholder="确认新密码" required="required" class="form-control" />
						</div>
						<div class="form-group text-center" style="margin-bottom: 0;">
							<label for="password">验证码:</label>
						</div>
						<div class="form-group form-inline" style="margin-top: 0;">
							<input type="text" name="check" id="check" placeholder="邮箱中的验证码" required="required" class="form-control" style="width: 68%"/>
							<button id="send" class="btn btn-default" disabled>发送验证码</button>
						</div>

						<div class=" btn-groups text-center">
							<button class="btn btn-block isbtn">
								<span class="icon-checkmark"></span>
							</button>
							<span class="icon-locked unbtn"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/commons/cookie.js" ></script>
	<script type="text/javascript" src="js/found.js" ></script>
	<script type="text/javascript">
		var basePath = "${pageContext.request.contextPath}"
	</script>

</html>