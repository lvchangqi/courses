<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="../../css/bootstrap.min.css" />
<link rel="stylesheet" href="../../css/style.css" />
<script type="text/javascript" src="../../js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<title>查看已发布课题</title>
<style type="text/css">
		div[role="alert"]{
				position: absolute;
				top:4%;
				left: 37%;
				display: none;
			}
</style>
</head>
<body style="padding-top: 10px">
		<div class="alert alert-danger alert-dismissible" role="alert">
			<h4>恭喜你! 课题选择成功.</h4> 
		</div>
</body>
<script>
	var basePath ='${pageContext.request.contextPath}'
	var collapse = '<div class="panel-group">'
			+ '<div class="panel panel-info">'
			+ '<div class="panel-heading">'
			+ '<h4 class="panel-title">'
			+ '<a data-toggle="collapse" href="">'
			+ '<strong>这是bug</strong>'
			+ '<span class="caret"></span>'
			+ '</a>'
			+ '<button class="btn btn-default btn-sm btn-choose" style="margin-left:40px">选择此课题</button>'
			+ '<button class="btn btn-danger btn-sm btn-delete" style="margin-left:40px">删除此课题</button>'
			+ '<time style="float: right;line-height: 30px;"></time>'
			+ '</h4>'
			+ '</div>'
			+ '<div id="" class="panel-collapse collapse">'
			+ '<div class="panel-body">看到这个说明程序出bug了╮(╯▽╰)╭<a href="tencent://message/?uin=675812074&Menu=yes">点这里联系我</a></div>'
			+ '<hr/>'
			+ '<h6 style="margin:-10px 0 10px 12px;">备注:<span class="other"></span></h6>'
			+ '</div>' + '</div>' + '</div>'
	$(function() {
		
		var name = '${user.promiss}'
		var realname = getUrlParam('realname')
		if(realname){
			name = decodeURI(realname)
		}
		
		$.post(basePath +'/design/getAll',{tname:name},function(data){
			if(data.length==0){
				collapse = '<button class="btn btn-primary btn-block disabled" style="font-weight:700;font-size:17px;letter-spacing:0.3em;border-radius:0" disabled>暂无课题</button>'
				$(collapse).appendTo('body').animate({
					marginTop: '240px'
				},1300)
			}else{
				for (var i = 0; i < data.length; i++) {
					$(collapse).appendTo('body')
					if(!realname){
						$('.btn-choose').remove()
					} else {
						$('.btn-delete').remove()
					}
				}
				for (var i = 0; i < data.length; i++) {
					var depend = "collapse" + i
					$('a[data-toggle="collapse"]').eq(i).attr('href', '#' + depend)
					$('strong').eq(i).html(data[i].title+'<small>(剩余'+data[i].counter+'人可选)</small>')
					$('.collapse').eq(i).attr('id', depend)
					$('.panel-body').eq(i).text(data[i].content)
					$('.other').eq(i).text(data[i].other)
					$('time').eq(i).text("发布时间: "+new Date(data[i].time).toLocaleDateString())
					
					if(data[i].counter == 0 && realname){
						errorShow($('strong').eq(i), '当前课题人数已达上限,请选择其他课题')
						$('.btn-choose').eq(i).addClass('disabled')
					}
				}
			}
		})
		//==选择==//
		$(document).on('click','.btn-choose',function(){
			var title = $(this).siblings('a').find('strong').text().split('(')[0]
			$.post(basePath+"/design/select",{title: title,studentid: '${user.studentid}'},function(data){
				if(data){
					$('.alert').css('display','block').animate({
						top: '30%'
					},1200)
					setTimeout(function(){
						$('a[href='+data+']',window.parent.document).children('li').click()
						$('.alert')	.css('display','none')
					}, 1200)
				}
			})
		})
		
		//==删除==//
		$(document).on('click','.btn-delete',function(){
			var title = $(this).siblings('a').find('strong').text().split('(')[0]
			if(confirm("确认删除?")){
				$.get(basePath+"/design/delete",{title: title},function(data){
					if(data){
						window.location.reload(true)
					}
				})
			}
		})
	})
//得到url传入参数
function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]); return null;
} 
function errorShow(obj,title){
	/**错误检测**/
obj.attr('data-original-title',title)
obj.tooltip({
	'placement': 'bottom',
	'container': 'body',
	'trigger' : 'hover'
	})
}
</script>
</html>