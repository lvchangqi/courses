$(function(){
	$('.main-banner').css('height', (window.innerHeight+155) + 'px');
	$('.main-over').css('height', (window.innerHeight+155) + 'px')
		var $name = $("input[name='username']")
		var $pwd = $("input[name='password']")
		var $re = $("input[name='repassword']")
		var $study = $("input[name='studentid']")
		var $qq = $("input[name='qq']")
		var $tel = $("input[name='phone']")
		var $check = $("input[name='role']")
		
		$('#about').tooltip({
			'placement': 'bottom',
			'container': 'body',
			'title': 'QQ:675812074',
		});
		
		/**错误检测**/
		//		$name.tooltip({
		//			'placement': 'right',
		//			'title' : '输入错误,请重新输入',
		//			'container': 'body',
		//			'trigger' : 'click'
		//		}).tooltip('toggle');
		$('.tooltip-inner').css("color", "#a94442")
		$(document).keydown(function() {
			if ($name.val() && $pwd.val() && $check.val()&& $re.val() && $study.val()&& $qq.val()&& $tel.val()) {
				$(".isbtn").animate({
					"width": "358px",
					"opacity": 1,
				}, 2000)
				$(".unbtn").animate({
					"left": "370px",
					"opacity": 0,
				}, 2000)
			}
		})
		$(".isbtn").click(function() {
			$(".preloading").css("display", "none").next().css("display", "block");
		})
		
	//向后台请求验证码
	$('#change').click(function(){
		$('img').attr("src", basePath + "/safecode/create_sc?K=" + Math.random());
	});
	$('#change').click();
	
	$('#check').blur(function(){
		$.ajax({
			type: "post",
	        url: basePath + "/safecode/check_sc",
	        data: "safecode=" + $("input[name='check']").val(),
	        dataType: "text",
	        success: function(data){
	        	alert(data)
	        }
		});
	});
	//验证码结束
})
