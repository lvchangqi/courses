<%@ page language="java" contentType="text/html; charset=UTF-8"
    language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%
	int y,m,d,q;
	String xq = "";
	Calendar c = Calendar.getInstance();
	y = c.get(Calendar.YEAR); //年
	m = c.get(Calendar.MONTH) + 1; //月
	d = c.get(Calendar.DAY_OF_MONTH); //日
	q = c.get(Calendar.DAY_OF_WEEK); //星期
	if(q==1) xq = "星期天";
	if(q==2) xq = "星期一";
	if(q==3) xq = "星期二";
	if(q==4) xq = "星期三";
	if(q==5) xq = "星期四";
	if(q==6) xq = "星期五";
	if(q==7) xq = "星期六";
 %>
<!DOCTYPE html>
<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../css/bootstrap.min.css" />
		<link rel="stylesheet" href="../css/public.css" />
		<link rel="stylesheet" href="../css/style.css" />
		<link rel="stylesheet" href="../css/list.css" />
		<link rel="icon" href="../img/console.ico" type="image/x-icon" />
		<script type="text/javascript" src="../js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../js/holder.min.js"></script>
		<title>控制台</title>
	</head>

	<body>
		<div class="main-container">
			<div class="col-md-2 container-left">
				<div class="text-center left-header">
				<a href="#openModal" onclick="$('#openImgModal').click()" id="face">
					<img alt="头像" src="holder.js/70x70" class="img-circle" width="70px" height="70px"/>
				</a>
					<span style="display:block;">欢迎您!</span>
						<div class="dropdown-toggle down-btn">
							<span>${user.promiss}(${user.role})</span>
						</div>
				</div>
				<ul class="menu">
				
					<shiro:hasRole name="student">
					<button data-toggle="modal" data-target=".bs" id="gg" style="display: none;"></button>
					<a href="#select" data-src="./iframe/two.jsp">
						<li class="open-menu"><span class="icon icon-clipboard2"></span>课题选择</li>
					</a>
					<a href="#upload" data-src="./iframe/three.jsp">
						<li class="open-menu"><span class="icon icon-clipboard3"></span>选题查看及提交</li>
					</a>
					</shiro:hasRole>
					<shiro:hasRole name="teacher">
						<a href="#self" data-src="./iframe/t-two.jsp">
							<li class="open-menu"><span class="icon icon-file-text2"></span>查看已发布课题</li>
						</a>
						<a href="#self" data-src="./iframe/t-three-i.jsp">
							<li class="open-menu"><span class="icon icon-magnifier"></span>查看学生</li>
						</a>
						<a href="#self" data-src="./iframe/t-one.jsp">
							<li class="open-menu"><span class="icon icon-edit"></span>发布课题</li>
						</a>
						<a href="#notice" data-src="./iframe/t-four.jsp">
							<li class="open-menu"><span class="icon icon-sound"></span>发布公告</li>
						</a>
					</shiro:hasRole>
					<shiro:hasAnyRoles name="student,teacher">
						<a href="#self" data-src="./iframe/one.jsp">
							<li class="open-menu"><span class="icon icon-user2"></span>修改个人信息</li>
						</a>
					</shiro:hasAnyRoles>
					<shiro:hasRole name="admin">
						<a href="#notice" data-src="./iframe/a-two.jsp">
							<li class="open-menu"><span class="icon icon-users"></span>用户管理</li>
						</a>
						<a href="#notice" data-src="./iframe/a-one.jsp">
							<li class="open-menu"><span class="icon icon-sound"></span>发布公告</li>
						</a>
					</shiro:hasRole>
					<a href="#openModal" onclick="$('#openModal').click()">
						<li><span class="icon icon-locked"></span>修改密码</li>
					</a>
					<a href="${pageContext.request.contextPath}/user/logout">
						<li><span class="icon icon-switch2"></span>安全退出</li>
					</a>
					<div style="position: absolute; bottom: 10px; color:rgb(167, 177, 194);text-align: center; margin-left: 10px;">
						Copyright&copy;2016 <abbr title="吕长奇">AndiOS工作室</abbr> <br/>
						All Right Reserved
					</div>
				</ul>
			</div>
			<div class="col-md-10 container-right" style="padding: 0;">
				<div style="width: 100%;border-bottom: 2px solid #2f4050;">
					<div class="breadcrumb" style="height: 100%;padding-top: 23px;">
					<div style="position: absolute; top:0;font-size:15px;" class="text-danger" id="sound">
						<span class="icon-sound"></span>
						<span id="notice" style="font-size:13px">&nbsp;暂无公告</span> 
					</div>
						<div class="btn btn-primary btn-dead btn-live ">
							主页
						</div>
						<time class="text-muted" id="calendar" style="float: right;font-size: 15px;">
							<span class="icon-calendar" style="font-size: 23px;"></span>
							<%=y %>年<%=m %>月<%=d %>日 <%=xq %>
						</time>
					</div>
				</div>
				<iframe src="./iframe/placeholder.jsp" width="100%" frameborder="no" style="position: absolute;bottom: 0;"></iframe>
			</div>
		</div>
		<jsp:include page="./modal.jsp"/>
	</body>
	<script type="text/javascript" src="../js/list.js"></script>
	<script type="text/javascript">
		var shiro = '${user.role}'
		if(shiro == '同学'){
			$('#gg').click()
		}
		notice()
		var basePath ='${pageContext.request.contextPath}'
			$.get(basePath+"/user/res",{username:'${user.username}'},function(data){
				if(data){
					$('#face > img').attr('src',data.imgpath)
				}
			})
			$.post(basePath+"/admin/notice",{name:'${user.tname}'},function(data){
				$('#t-content').text(data.content)
				$('#t-time').text(new Date(data.time).toLocaleString())
			})
		function notice(){
			$.post(basePath+"/admin/notice",{name:'管理员'},function(data){
				if(data != "notice"&&data){
					$('#notice').html("公告:     "+data.content+'<font color="gray">(公告发布时间:'+new Date(data.time).toLocaleString()+')</font>')
				}
			})
		}
		
		console.log("%c有些样式我实在懒的写了,你要是看这觉得不爽的话可以联系我,我把源码给你,你来改","font-size:21px;color:gray;")
	</script>
</html>