$(function(){
	/**样式调整**/
	$('#about').tooltip({
		'placement': 'bottom',
		'container': 'body',
		'title': '联系我?',
	});
	
	$(".isbtn").click(function() {
		$(".preloading").css("display", "none").next().css("display", "block");
	})
	$('.main-banner').css('height', (window.innerHeight+28) + 'px');
	$('.main-over').css('height', (window.innerHeight+28) + 'px');
	/**样式调整**/
	
		var flag = new Array(false,false,false,false,false,false);//开关数组
		var $name = $("input[name='username']")
		var $pwd = $("input[name='password']")
		var $re = $("input[name='repassword']")
		var $study = $("input[name='studentid']")
		var $qq = $("input[name='qq']")
		var $tel = $("input[name='phone']")
		var $check = $("input[name='role']")
		
	/**前端检测开始**/	
	var regExp={
		username: new RegExp('^[0-9_$*a-zA-Z\u4e00-\u9fa5]{2,10}$'),
		password: new RegExp('^[0-9_a-zA-Z]{6,20}$'),
		studentid1: new RegExp('^[0-9]{13}$'),
		studentid2: new RegExp('^[0-9]{5}$'),
		qq: new RegExp('^[0-9]{7,11}$'),
		phone: new RegExp('^[1][358][0-9]{9}$')
	}
	
	/**用户名检测**/
	$name.blur(function(){
		if(regExp.username.test($(this).val())){
			$.post(basePath+'/user/checkUser',{username:$(this).val()},function(data){
				if(data){
					errorShow($name,'恭喜你,此帐号可以使用')
				} else {
					errorShow($name,'此帐号已存在')
				}
				flag[0] = data
			})
		} else {
			errorShow($(this),'用户名为2-10位')
			flag[0] = false
		}
	})
	/**用户名检测**/
	/**密码检测**/
	$pwd.blur(function(){
		if(regExp.password.test($(this).val())&&$(this).val()){
			checkPassword($(this), $re)
		} else {
			errorShow($(this), '密码由6-10位由数字、大小写英文字母组成')
			flag[1] = false;
		}
	})
	$re.blur(function(){
		checkPassword($(this), $pwd)
	})
	function checkPassword(obj1,obj2){
		if(obj1.val() != obj2.val()){
			errorShow(obj1, '两次密码不一致')
			errorShow(obj2, '两次密码不一致')
			flag[1] = false
		} else {
			obj1.tooltip('destroy')
			obj2.tooltip('destroy')
			flag[1] = true
		}
	}
	/**密码检测**/
		
	/**学号检测**/
	$study.blur(function(){
		if(regExp.studentid1.test($(this).val())||regExp.studentid2.test($(this).val())){
			$.post(basePath+'/user/checkUser',{studentid:$(this).val()},function(data){
				if(!data){
					errorShow($study,'此学号/工号已注册')
				} else {
					errorShow($study,'此学号/工号还未注册,可以使用')
				}
				flag[2] = data
			})
		} else {
			errorShow($(this),'学号/工号为13/5位数字')
			flag[2] = false
		}
	})
	/**学号检测**/
	
	/**QQ检测**/
	$qq.blur(function(){
		if(regExp.qq.test($(this).val())){
			$(this).tooltip('destroy')
			flag[3] = true
		} else {
			errorShow($(this),'请正确输入7-11位QQ号码')
			flag[3] = false
		}
	})
	/**QQ检测**/
	
	/**QQ检测**/
	$tel.blur(function(){
		if(regExp.phone.test($(this).val())){
			$(this).tooltip('destroy')
			flag[4] = true
		} else {
			errorShow($(this),'请正确输入手机号码')
			flag[4] = false
		}
	})
	/**QQ检测**/
	
	//向后台请求验证码
	$('#change').click(function(){
		$('img').attr("src", basePath + "/safecode/create_sc?K=" + Math.random());
	});
	$('#change').click();
	
	document.getElementById('check').oninput=function(){
		if(this.value.length==4)
		$.ajax({
			type: "post",
	        url: basePath + "/safecode/check_sc",
	        data: "safecode=" + $("input[name='check']").val(),
	        dataType: "text",
	        success: function(data){
	        	if(data == 'true'){
	        		flag[5] = true
	        		$('#check').tooltip('destroy');
	        	} else {
	        		errorShow($('#check'), '验证码错误')
	        		flag[5] = false
	        	}
	        	can(flag)
	        }
		});
	};
	//验证码结束
	/**前端检测结束**/

})
function can(flag) {
	/**打开按钮**/
	var open = false;
	for(var i in flag){
		open = flag[i]
		if(!flag[i]){
			break;
		}
	}
	console.log(flag)
	if(open){
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

function errorShow(obj,title){
	/**错误检测**/
	obj.attr('data-original-title',title)
	obj.tooltip({
		'placement': 'right',
		'container': 'body',
		'trigger' : 'click'
	})
	obj.tooltip('show');
//	var color = "#a94442"
//	if(success)
//		color = '#5cb85c'
}
