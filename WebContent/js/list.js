$(function(){
	$('.container-left,.container-right,.main-container').css('height', window.innerHeight);
		$('iframe').css('height', window.innerHeight/11*10).siblings('div').css('height', window.innerHeight/11*1);
		$('.menu').children().click(function() {
			$(this).find('li').addClass('live')
			$(this).siblings().find('li').removeClass('live')
		})
		var menu = new Array() //菜单数组
		
		$('a').click(function(){
			var src = $(this).attr('data-src')
			$('iframe').attr('src',src)
			return false;
		})
		
		$('.breadcrumb').on("click",".btn .btn-close",function(e){
			e.stopPropagation()
			menu.splice($.inArray($(this).prev().text(),menu),1)
			if(!$(this).parent().hasClass('btn-dead-style')){
				$(this).parent().prev().removeClass('btn-dead-style')
				$('.open-menu:contains('+$(this).parent().prev().text().split('x')[0]+')').click()
				$('iframe').attr('src','')
			}
			if(menu.length===0){
				$('.open-menu:contains('+$(this).parent().text().split('x')[0]+')').removeClass('live')
				$('iframe').attr('src','')
			}
			$(this).parent().remove()
		})
		$('.breadcrumb').on("click",".btn-dead",function(){
			$(this).removeClass('btn-dead-style').siblings().addClass('btn-dead-style')
			$(this).find('.btn-close').css('display','inline-block')
			$('.open-menu:contains('+$(this).text().split('x')[0]+')').click()
		})
		
		$('.open-menu').click(function(){
			var btn = '<div class="btn btn-primary btn-dead btn-live">'+
							$(this).text()
						+'<div class="btn-close"><span>x</span></div>'+
					'</div>'
			var index = $.inArray($(this).text(),menu)
			if(index === -1){
				$('.breadcrumb').children().addClass('btn-dead-style')
				$('.breadcrumb').append(btn)
				menu.unshift($(this).text())
			} else {
				$('.breadcrumb').find('.btn')[index+1].click()
			}
			console.log(menu)
		})
		
})