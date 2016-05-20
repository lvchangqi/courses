<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>document</title>
		<link rel="stylesheet" type="text/css" href="../../css/bootstrap.min.css" />
		<link rel="stylesheet" href="../../css/style.css" />
		<script type="text/javascript" src="../../js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
		<style>
			.container{
				margin-top: 11px;
			}
			dl {
				margin-top: 40px;
			}
			
			dl dt,
			dl dd {
				font-size: 20px;
			}
		.cover{
				position: absolute;
				left: 0;
				top: 0;
				width: 100%;
				height: 100%;
				background-color: rgba(0,0,0,0.7);
				display: none;
			}
			div[role="alert"]{
				position: absolute;
				top:4%;
				left: 37%;
				display: none;
			}
		</style>
	</head>

	<body>
		<div class="container well">
			<div class="row">
				<form  method="POST" class="col-md-10">
					<dl class="dl-horizontal">
						<dt>课题名:</dt>
						<dd><input name="title" type="text" class="form-control" /></dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>说明:</dt>
						<dd><textarea name="content" cols="30" rows="10" class="form-control"></textarea></dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>备注:</dt>
						<dd><input name="other" type="text" class="form-control" /></dd>
					</dl>
					<dl class="dl-horizontal">
						<dd><input type="submit" class="btn btn-primary form-control" value="确定"/></dd>
					</dl>
					<input type="hidden" value="${user.promiss}" name="tname"/>
				</form>
			</div>
		</div>
		<div class="cover"></div>
		<div class="alert alert-danger alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<strong>请检查! 填写所有的必填选项后提交.</strong> 
		</div>
	</body>
	<script>
		var $title = $("input[name='title']")
		var $content = $("textarea[name='content']")
		var $alert = $('div[role="alert"]')
		errorShow($title, ' 此项为必填项')
		errorShow($content, ' 此项为必填项')
		$('form').submit(function() {
			$('.cover').css('display','block')
			if ($title.val() && $content.val()) {
				$alert.removeClass('alert-danger').addClass('alert-success').find('strong').text('恭喜您! 课题发布成功')
				$.ajax({
					url: "${pageContext.request.contextPath}/design/create",
					type: 'post',
					data: $('form').serialize(),
					dataType: 'text',
					success: function(data){
						if(data){
							setTimeout(function(){window.location.reload(true);}, 1200)
						}
					}
				})
			} 
			$alert.css('display','block').animate({
				top: '30%'
			},1200)
			return false
		})
		$('.close').click(function(){
			$('.cover').css('display','none')
		})

		function errorShow(obj, title) {
			/**错误检测**/
			obj.attr('data-original-title', title)
			obj.tooltip({
				'placement': 'right',
				'container': 'body',
				'trigger': 'click'
			})
			obj.tooltip('show');
			obj.blur(function() {
				if ($(this).val()) {
					errorShow($(this), '')
				} else {
					errorShow($(this), '此项为必填项')
				}
			})
		}
	</script>

</html>