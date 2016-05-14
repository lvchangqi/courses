$(function(){
	
	//向后台请求验证码
	$('#change').click(function(){
		$('img').attr("src", basePath + "/safecode/create_sc?K=" + Math.random());
	});
	$('#change').click();
	
	
	$('.main-banner').css('height', window.innerHeight);
		var $name = $("input[name='username']")
		var $pwd = $("input[name='password']")
		var $check = $("input[name='check']")
		var $role = $("input[name='user']")
		var role = $role.val()
		$role.click(function(){
			role = $(this).val()
		})
		$('#about').tooltip({
			'placement': 'bottom',
			'container': 'body',
			'title': '联系我?',
		});
		
		var flag = false
		document.getElementById('check').oninput=function(){
			if($check.val().length===4)
			$.ajax({
				type: "post",
		        url: basePath + "/safecode/check_sc",
		        data: "safecode=" + $("input[name='check']").val(),
		        dataType: "text",
		        success: function(data){
		        	if(data == 'true'){
		        		checkOut()
		        		$check.tooltip('destroy');
		        		flag = true
		        	} else {
		        		$check.tooltip({
		        			'placement': 'right',
		        			'title' : '验证码错误',
		        			'container': 'body',
		        			'trigger' : 'click'
		        		})
		        		$check.tooltip('show');
		        		flag = false
		        	}
		        }
			});
		};
		
		$(".isbtn").click(function() {
			$(".preloading").css("display", "none").next().css("display", "block");
		})
		$('form').submit(function(){
			if(flag)
			$.post(basePath+'/user/login',{username:$name.val(),password:$pwd.val(),role:role},function(data){
				if(!data){
					window.location.replace(basePath+"/auth/control.jsp")
				} else {
					switch (data) {
					case 'role':
						errorShow($role,'权限不匹配')
						break;

					case 'not':
						errorShow($name,'该用户不存在,您可以先去注册')
						break;
					
					case 'upass':
						errorShow($pwd,'密码错误')
						break;
					}
				}
			})
			return false;
		})
		
		function checkOut() {
			if ($name.val() && $pwd.val() && $check.val()) {
				$(".isbtn").animate({
					"width": "358px",
					"opacity": 1,
				}, 2000)
				$(".unbtn").animate({
					"left": "370px",
					"opacity": 0,
				}, 2000)
			}
		}
})
function errorShow(obj,title){
	/**错误检测**/
	obj.attr('data-original-title',title)
	obj.tooltip({
		'placement': 'right',
		'container': 'body',
		'trigger' : 'click'
	})
	obj.tooltip('show');
	$(".preloading").css("display", "block").next().css("display", "none");
//	var color = "#a94442"
//	if(success)
//		color = '#5cb85c'
}	
