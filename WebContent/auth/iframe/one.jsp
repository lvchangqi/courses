<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../../css/bootstrap.min.css" />
	<link rel="stylesheet" href="../../css/public.css" />
	<link rel="stylesheet" href="../../css/style.css" />
<title>Document</title>
</head>
<body>
	<img alt="占位符" src="" class="img-thumbnail"/>
</body>
	<script type="text/javascript" src="../../js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
	<script type="text/javascript">
		var h = window.innerHeight
		var w = window.innerWidth
		var src = 'holder.js/' + w + 'x' + h
		$('img').attr('src',src)
	</script>
	<script type="text/javascript" src="../../js/holder.min.js"></script>
</html>