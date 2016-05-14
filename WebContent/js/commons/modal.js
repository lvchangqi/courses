$(function(){
//	var basePath = path.substring(0,path.indexOf("/",1));
	$('#password').blur(function(){
		var parent = $(this).parent().parent();
		if($(this).val())
		$.get(basePath+'/user/updatePwd',{inputpwd:$(this).val()},function(data){
			parent.removeClass('has-success has-error')
			$('small').text('')
			if(data){
				parent.addClass('has-success')
				flag[0] = true
			}
			else{
				parent.addClass('has-error')
				$('small').text('*原始密码错误,请重新输入')
			}
		})
	})
	
	var newp = $('#renewPassword')
	var rep = $('#newPassword')
	newp.keyup(function(){checkChange(newp,rep)})
	rep.keyup(function(){checkChange(newp,rep)})
	
	$('#updateButton').click(function(){
		if(flag[0]&&flag[1]){
			$.get('/Articles/user/updatePwd',{newpwd:newp.val()},function(data){
				if(data){
					$('small').text('*修改成功,本次登录信息过期,正在为您跳转到首页...').css('color','green')
					setTimeout(function(){
						window.location.href = "/Articles/user/loginOut"
					}, 1500)
				}
			})	
		} else {
			console.log(flag)
		}
			
	})
})
var flag = new Array();
function checkChange(newp,rep){
	if(newp.val()&&rep.val())
	if(newp.val() === rep.val()){
		newp.parent().parent().addClass('has-success').removeClass('has-error')
		rep.parent().parent().addClass('has-success').removeClass('has-error')
		$('small').text('')
		flag[1] = true
	} else {
		newp.parent().parent().addClass('has-error')
		rep.parent().parent().addClass('has-error')
		$('small').text('*两次密码不一致,请重新输入')
	}
}