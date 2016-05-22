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
					<a href="./login.jsp" class="navbar-brand main-logo" style="color:#FFFFFF;  font-size: 25px;" id="logo">课程(毕业)设计网上自动双选系统</a>
				</div>
				<div class="container">
					<div class="collapse navbar-collapse" id="navbar-collapse">
						<ul class="nav navbar-nav  navbar-right">
							<li class="active"><a href="./login.jsp" role="login">登录</a></li>
							<li><a href="./submit.jsp" role="submit">注册</a></li>
							<li><a href="./found.jsp" role="found">找回密码</a></li>
							<li><a href="tencent://message/?uin=675812074&Menu=yes" role="2" id="about">关于</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!--头结束-->
			
			<div class="container">
				<div class="row">
					<form class="col-md-4 col-md-push-4" role="form" id="login">
						<div class="form-group text-center title">
							<div class="preloading">
								<span>登录</span>
							</div>
							<div class="loading icon-spinner6"></div>
						</div>
						<div class="form-group text-center">
							<label for="username">用户名:</label>
							<input type="text" name="username" id="username" placeholder="用户名" required="required" class="form-control" />
						</div>
						<div class="form-group text-center">
							<label for="password">密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
							<input type="password" name="password" id="password" placeholder="密码" required="required" class="form-control" />
						</div>
						<div class="form-group text-center" style="margin-bottom: 0;">
							<label for="password">验证码:</label>
						</div>
						<div class="form-group form-inline" style="margin-top: 0;">
							<input type="text" name="check" id="check" placeholder="验证码" required="required" class="form-control" style="width: 70%"/>
							<img alt="验证码" src="" id="checkPic" height="34px" width="100px">
						</div>

						<div class=" btn-groups text-center">
							<button class="btn btn-block isbtn">
								<span class="icon-checkmark"></span>
							</button>
							<span class="icon-locked unbtn"></span>
						</div>

						<div class="form-group text-right" id="role">
						<label>您的身份:</label>
							<div class="radio-inline">
								<label>
							      <input type="radio" name="user" value="student" checked="checked">学生
							    </label>
							</div>
							<div class="radio-inline">
								<label>
							      <input type="radio" name="user" value="teacher">老师
							    </label>
							</div>
							<div class="radio-inline">
								<label>
							      <input type="radio" name="user" value="admin">管理员
							    </label>
							</div>
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</body>
	<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script src="js/login.js"></script>
	<script type="text/javascript">
		var basePath = "${pageContext.request.contextPath}"
	</script>

</html>