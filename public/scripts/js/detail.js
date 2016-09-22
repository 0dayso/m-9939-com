// JavaScript Document
$(function(){
	//首页点击切换
	$('.sexn a').click(function(){
		var inde=$(this).index();
		$(this).parent('.sexn').find('a').removeClass('curr');	
		$(this).addClass('curr');
		$(this).parent().next('.male').find('.sechoi').removeClass('shay').addClass('disn');
		$(this).parent().next('.male').find('.sechoi').eq(inde).removeClass('disn').addClass('shay');
	});
	//科室分类
	$('.classfi li').click(function(){
		$('.classfi li').find('div').removeClass('shay').addClass('disn');
		$('.classfi li').find('p').removeClass('disn').addClass('shay');
		$('.classfi li').find('>span').removeClass('disn').addClass('shay');	
		$('.classfi li').removeClass('cust');
		
		if($(this).attr('data-nu')=='0'){
			$(this).removeClass('cust').find('div').addClass('disn');	
			$(this).find('p').removeClass('disn').addClass('shay');
			$(this).find('>span').removeClass('disn').addClass('shay');	
			$(this).attr('data-nu','1');	
		}
		else{
			$(this).addClass('cust').find('p').removeClass('shay').addClass('disn');	
			$(this).find('div').removeClass('disn').addClass('shay');
			$(this).find('>span').removeClass('shay').addClass('disn');	
			$(this).attr('data-nu','0');
		}
	});
	//头部导航弹出
	var bool=true;
	$('a.clna').click(function(){
		if(bool){
			$('.heabar').removeClass('disn').addClass('shay');	
			bool=false;
		}
		else{
			$('.heabar').removeClass('shay').addClass('disn');	
			bool=true;		
		}	
	});
	$('span.arrow').click(function(){
		$('.heabar').removeClass('shay').addClass('disn');	
		bool=true;	
	});
	//其他查找点击展开
	var bo=true;
	$('.find dt').click(function(){
		if(bo){
			$(this).find('div').addClass('cur');
			$(this).nextAll('dd').show();
			bo=false;
		}
		else{
			$(this).find('div').removeClass('cur');
			$(this).nextAll('dd').hide();	
			bo=true;
		}
	});
	
	
	
	/*点击下拉*/
	var bo=true;
	$('.headis li span').click(function(){
		if(bo){
			$(this).next('.nexsib').removeClass('disn').addClass('shay');
			$(this).addClass('cusp');
			$(this).parent().css('padding-bottom','0');
			bo=false;	
		}	
		else{
			$(this).next('.nexsib').removeClass('shay').addClass('disn');
			$(this).removeClass('cusp');
			$(this).parent().css('padding-bottom','.23rem');
			bo=true;	
		}
	});
	
	
	
	
	
	/*点击查看更多下拉*/
	var bo=true;
	$('a.agmor').click(function(){
		if(bo){
			$('.diacl p').removeClass('inde').addClass('dimor');
			$(this).html('收起');
			bo=false;
		}
		else{
			$('.diacl p').removeClass('dimor').addClass('inde');
			$(this).html('点击查看更多');
			bo=true;	
		}
	});
	
	//展开全部
	var isExpa=true;
	
	$('a.loama').click(function(){
		if(isExpa){
			$('.spcon p:last-child').addClass('dimor');
			$(this).find('span').addClass('locust');
			isExpa=false;		
		}
		else{
			$('.spcon p:last-child').removeClass('dimor');
			$(this).find('span').removeClass('locust');
			isExpa=true;		
		}
	});
	/*字母切换*/
	$('.lette a').click(function(){
		var ind=$(this).index();
		$('.lette a').removeClass('cur');
		$(this).addClass('cur');
		$('.tora').find('.cure').removeClass('shay').addClass('disn');
		$('.tora').find('.cure').eq(ind).removeClass('disn').addClass('shay');
		
	});
	//母婴专题内容页，常用疾病切换
	$('.cuinf a').click(function(){
		var indx=$(this).index();
		$('.cuinf a').removeClass('cusx');
		$(this).addClass('cusx');
		$(this).parents('.physi').find('.slicon').removeClass('shay').addClass('disn');
		$(this).parents('.physi').find('.slicon').eq(indx).removeClass('disn').addClass('shay');
		
		
	});
	//加大字体
	var bol=true;
	$('.tranf a').click(function(){
		if(bol){
			$('.minbo p').removeClass('minfo').addClass('maxfo');
			$(this).find('sup').html('-');	
			bol=false;
		}
		else{
			$('.minbo p').removeClass('maxfo').addClass('minfo');
			$(this).find('sup').html('+');	
			bol=true;	
		}
		
	});
	//展开下面的
	var boc=true;
	$('a.loada').click(function(){
		if(boc){
			$('.bocon .minbo p').addClass('diall');	
			$(this).find('span').removeClass('lodo').addClass('exp');
			boc=false;
		}
		else{
			$('.bocon .minbo p').removeClass('diall');	
			$(this).find('span').removeClass('exp').addClass('lodo');
			boc=true;	
		}
	});
	//内容页心理新闻
	$('.coclu a').click(function(){
		var indx=$(this).index();
		$('.coclu a').removeClass('custt');
		$(this).addClass('custt');
		$(this).parents('.dosex').find('.news_01').removeClass('shay').addClass('disn');
		$(this).parents('.dosex').find('.news_01').eq(indx).removeClass('disn').addClass('shay');
			
	});
});
















































