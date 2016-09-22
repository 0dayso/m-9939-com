// JavaScript Document
$(function(){
	/*导航点击展开*/
	var cli=true;
	$('nav span').click(function(){
		var cuvl=$(this).parent();
		if(cli){
			cuvl.css('height','auto');
			$(this).addClass('sp_02');
			cli=false;
		}
		else{
			cuvl.css('height','2.4rem');
			$(this).removeClass('sp_02');
			cli=true;	
		}
		
	});	
	/*点击收起展开*/
	var shol=true;
	var heis=$('.minbo .wind').height();
	$('a.loada').hide();
	if(heis>480){
		$('.minbo').addClass('limih');
		$('a.loada').show();
	}
	$('a.loada').click(function(){
		//$('.bocon div').removeClass('sho').addClass('disn');
		if(heis>480){
			if(shol){
				$(this).parent().find('.minbo').removeClass('limih');
				$(this).find('b').html("收起全文");
				$(this).find('span').removeClass('lodo').addClass('exp');
				shol=false;
			}
			else{
				$(this).parent().find('.minbo').addClass('limih');
				$(this).find('b').html("加载全文");
				$(this).find('span').removeClass('exp').addClass('lodo');
				shol=true;	
			}
		}
	});
	/*左上角弹出层*/
	var bool=true;
	$('.lin_02').click(function(){
		
		if(bool){
			$('.personal').show();	
			bool=false;
		}
		else{
			$('.personal').hide();	
			bool=true;		
		}
	});
	$('.f_nam').click(function(){
		$('.personal').hide();	
		bool=true;			
	});
	/*栏目切换*/
	$('h3.coclu a').click(function(){
		var inde=$(this).index();
		$('h3.coclu a').removeClass('custt');
		$(this).addClass('custt');
		$('.news_01').removeClass('sho').addClass('disn');
		$('.news_01').eq(inde).removeClass('disn').addClass('sho');	
	});
	/*放大缩小字体*/
	var trcon=true;
	$('.tranf a').click(function(){
		var innum=$(this).index();
		//$('.tranf a').removeClass('curre');
		//$(this).addClass('curre');
		$('.bocon p').removeClass('minum scale');
		//$('.bocon p').removeClass('scale');
		if(trcon){
			$('.bocon p').addClass('scale');
			$(this).find('sup').html('-');
			trcon=false;
		}	
		else{
			$('.bocon p').addClass('minum');
			$(this).find('sup').html('+');	
			trcon=true;
		}
	});
	$('.recom').find('a:last-child').css('border-bottom','none');
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});













































