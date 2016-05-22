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
</head>
<body style="padding-top: 10px">
	
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
			+ '<button class="btn btn-default btn-sm" style="margin-left:40px">选择此课题</button>'
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
						$('button').remove()
					}
				}
				for (var i = 0; i < data.length; i++) {
					var depend = "collapse" + i
					$('a[data-toggle="collapse"]').eq(i).attr('href', '#' + depend)
					$('strong').eq(i).text(data[i].title)
					$('.collapse').eq(i).attr('id', depend)
					$('.panel-body').eq(i).text(data[i].content)
					$('.other').eq(i).text(data[i].other)
					$('time').eq(i).text("发布时间: "+new Date(data[i].time).toLocaleDateString())
				}
			}
		})
	})
	//得到url传入参数
function getUrlParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) return unescape(r[2]); return null;
} 
</script>
</body>
</html>