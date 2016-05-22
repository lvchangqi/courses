$(function() {
	$('.main-banner').css('height', window.innerHeight);
	$('#about').tooltip({
		'placement': 'bottom',
		'container': 'body',
		'title': '联系我?',
	});
	/**样式调整结束**/
	var $name = $('#username')
	var $study = $('#studentid')
	var $pwd = $('#password')
	var $re = $('#repassword')

	var flag = new Array()
	var regExp = {
		username: new RegExp('^[0-9_a-zA-Z]{6,20}$'),
		password: new RegExp('^[0-9_a-zA-Z]{6,20}$'),
		studentid1: new RegExp('^[0-9]{13}$'),
		studentid2: new RegExp('^[0-9]{5}$'),
	}

	/**用户名检测**/
	$name.blur(function() {
			if (regExp.username.test($(this).val())) {
				$.post(basePath + '/user/checkUser', {
					username: $(this).val()
				}, function(data) {
					if (data) {
						errorShow($name, '此用户名不存在,您可以注册之后使用')
					}
					flag[0] = !data
				})
			} else {
				errorShow($(this), '用户名由6-10位由数字、大小写英文字母组成')
				flag[0] = false
			}
		})
		/**用户名检测**/
		/**学号检测**/
	$study.blur(function() {
			if (regExp.studentid1.test($(this).val()) || regExp.studentid2.test($(this).val())) {
				$.post(basePath + '/user/checkUser', {
					studentid: $(this).val()
				}, function(data) {
					if (data) {
						errorShow($study, '此学号/工号还未注册')
					}
					flag[1] = !data
				})
			} else {
				errorShow($(this), '学号/工号为13/5位数字')
				flag[1] = false
			}
		})
		/**学号检测**/
		/**密码检测**/
	$pwd.blur(function() {
		if (regExp.password.test($(this).val()) && $(this).val()) {
			checkPassword($(this), $re)
		} else {
			errorShow($(this), '密码由6-10位由数字、大小写英文字母组成')
			flag[2] = false;
		}
	})
	$re.blur(function() {
		checkPassword($(this), $pwd)
	})

	function checkPassword(obj1, obj2) {
		if (obj1.val() != obj2.val()) {
			errorShow(obj1, '两次密码不一致')
			errorShow(obj2, '两次密码不一致')
			flag[2] = false
		} else {
			obj1.tooltip('destroy')
			obj2.tooltip('destroy')
			flag[2] = true
		}
	}
	/**密码检测**/

	document.onkeydown = function(){
		can(flag, $('#send'))
	}
	$('#send').click(function() {
		$.get(basePath+'/user/mail',{name:$name.val(),studentid:$study.val()},function(data){
			if(data=="unmatch"){
				alert('用户名和学(工)号不匹配')
			} else{
				setCookie("code", data, 30)
			}
		})
		var i = 60
		$(this).attr("disabled", "");
		var shutdown = setInterval(function() {
			$('#send').text('重新发送(' + i + ')');
			if (i == 0) {
				$('#send').text('获取验证码').removeAttr("disabled");
				clearInterval(shutdown);
			}
			i--;
		}, 1000);
	})
	
	document.getElementById('check').oninput = function() {
		
		if (getCookie("code")&&this.value == getCookie("code")) {
			flag[3] = true
			$(this).tooltip('destroy')
		} else {
			flag[3] = false
			errorShow($(this), '验证码不正确')
		}
		if(can(flag)){
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
	$(".isbtn").click(function(){
		clearCookie("code")
		$.get(basePath+'/user/found',{inputpwd:$pwd.val(),studentid:$study.val()},function(data){
			if(data){
				$('div[role="alert"]').fadeToggle(1200,function(){
					window.location.href = "./login.jsp"
				})
			}
		})
		$(".preloading").css("display", "none").next().css("display", "block");
	})
})

function can(flag, obj) {
	/**打开按钮**/
	var open = false;
	for (var i in flag) {
		open = flag[i]
		if (!flag[i]) {
			break;
		}
	}
	if (open&&obj) {
		obj.removeAttr('disabled')
	}
	if(!obj) return open
}

function errorShow(obj, title) {
	/**错误检测**/
	obj.attr('data-original-title', title)
	obj.tooltip({
		'placement': 'right',
		'container': 'body',
		'trigger': 'click'
	})
	obj.tooltip('show');
}