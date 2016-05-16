<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../css/bootstrap.min.css" />
		<link rel="stylesheet" href="../css/public.css" />
		<link rel="stylesheet" href="../css/style.css" />
		<link rel="stylesheet" href="../css/list.css" />
		<script type="text/javascript" src="../js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/holder.min.js"></script>
		<title>控制台</title>
	</head>

	<body>
		<div class="main-container">
			<div class="col-md-2 container-left">
				<div class="text-center left-header">
					<span style="display:block;padding-top: 14%;">欢迎你!</span>
					<div class="btn-group">
						<div class="dropdown-toggle down-btn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<span>${user.username}(${user.role})</span>
							<span class="caret"></span>
						</div>
						<ul class="dropdown-menu  left-menu">
							<li><a href="#" data-src="./iframe/one.jsp" class="open-menu">修改个人信息</a></li>
							<li><a href="#openModal" onclick="$('#openModal').click()">修改密码</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="${pageContext.request.contextPath}/user/logout">退出</a></li>
						</ul>
					</div>
				</div>
				<ul class="menu">
					<a href="#">
						<li class="open-menu">课题选择</li>
					</a>
					<a href="#">
						<li class="open-menu">课程设计上传</li>
					</a>
					<a href="#">
						<li class="open-menu">预约指导老师</li>
					</a>
				</ul>
			</div>
			<div class="col-md-10 container-right" style="padding: 0;">
				<div style="width: 100%;border-bottom: 2px solid #2f4050;">
					<div class="breadcrumb" style="height: 100%;padding-top: 24px;">
						<div class="btn btn-primary btn-dead btn-live ">
							主页
						</div>
					</div>
				</div>
				<iframe src="" width="100%" frameborder="no" style="position: absolute;bottom: 0"></iframe>
			</div>
		</div>
		<jsp:include page="./modal.jsp"/>
	</body>
	<script type="text/javascript" src="../js/list.js"></script>

</html>