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

	</body>

</html>