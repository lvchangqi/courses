<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="zh-CN">

	<head>
		<meta charset="UTF-8" />
		<!-- 
		<link rel="stylesheet" href="../css/bootstrap.min.css" />
		<script type="text/javascript" src="../js/jquery-1.11.3.min.js" ></script>
		<script type="text/javascript" src="../js/bootstrap.min.js" ></script>
		-->
		<script type="text/javascript" src="../js/commons/modal.js" ></script>
		<script type="text/javascript">var basePath = "${pageContext.request.contextPath}"</script>
		<title>修改密码</title>
	</head>

	<body>
		<button type="button" class="btn btn-link" data-toggle="modal" data-target=".bs-example-modal-lg" id="openModal" style="display: none;">修改密码</button>
		
		<!-- 修改密码 -->
		<div class="modal fade bs-example-modal-lg" role="dialog" aria-labelledby="gridSystemModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改密码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small style="color:red;font-size: 14px;"></small></h4>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          <form class="form-horizontal">
  <div class="form-group">
    <label for="password" class="col-sm-2 control-label">原始密码</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="password" placeholder="原始密码~" required="required">
    </div>
  </div>
  <div class="form-group">
    <label for="newPassword" class="col-sm-2 control-label">新密码</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="newPassword" placeholder="新密码~" required="required">
    </div>
  </div>
  <div class="form-group">
    <label for="renewPassword" class="col-sm-2 control-label">确认密码</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="renewPassword" placeholder="确认密码~" required="required">
    </div>
  </div>
</form>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="updateButton">确认修改</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- 修改密码 -->
<button id="openImgModal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" style="display: none;">
  上传照片
</button>
<!-- 上传图片 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <!-- TODO: -->
        <form class="modal-body" action="${pageContext.request.contextPath}/user/imgUp" method="POST" enctype="multipart/form-data">
			<input type="file" name="img" id="img" style="display: none;" required="required"/>
			<input type="hidden" name="imgName" value="" id="imgName" />
			<input type="hidden" name="username" value="${user.username}"/>
			<label for="img" class="img-thumbnail" style="display: block; height: 180px;">
				<span class="icon-pictures2 con" style="position: absolute;top:30%;left:44%;font-size: 34px;"></span>
				<span style="position: absolute;bottom:47%;left:37%;"class="con">点击上传图片</span>
				<span style="position: absolute;bottom:40%;left:24%;"class="con">(JPG/PNG格式,大小限制1M)</span>
				<img src="" width="100%" height="100%"  style="display: none;" id="imgface"/>
			</label>
				<input type="submit" value="确定上传" class="btn btn-block btn-primary"/>
				<input type="reset"  value="取消"  data-dismiss="modal" class="btn btn-block btn-default"/>
		</form>
    </div>
  </div>
</div>
<!-- 上传图片 -->
	</body>
<script type="text/javascript">
$('input[type="reset"]').click(function(){
	$("#img").removeAttr('src')
	$('.con').css('z-index','1');
})
$("#img").change(function() {
	switch ($(this).val().split(".")[1].toLowerCase()) {
	case 'jpg':break;
	case 'png':break;
	default:
		alert("图片格式不正确");
		return false
	}
	$('#imgName').val($(this).val())
	var objUrl = getObjectURL(this.files[0]);
	if (objUrl) {
		$('.con').css('z-index','-1');
		$("#imgface").attr("src", objUrl).css('display','block');
	}
});
//建立一個可存取到該file的url
function getObjectURL(file) {
	var url = null;
	if (window.createObjectURL != undefined) { // basic
		url = window.createObjectURL(file);
	} else if (window.URL != undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file);
	} else if (window.webkitURL != undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file);
	}
	return url;
}
</script>
</html>