//通知公告角标
 

 $('.corner').each(function(){
	 var noticeCorner = $(this),
 	 noticeNum = $.trim(noticeCorner.html());
	 if(noticeNum<=99){
		 if(noticeNum<10){
			 noticeCorner.css({'padding':'0'});
			 if(noticeNum==0){
				noticeCorner.css('display','none');
			 }				 
		 }else{
			 noticeCorner.css({'padding':'0 .1rem'});	
		 }
	 }else{
		 noticeCorner.css({'padding':'0 .1rem'}).html('99+');
		 if($(this).hasClass('pos-abs')){
			 noticeCorner.css({'margin-left':'-.4rem'});
		 }
	 }
 });
 
//有新消息,显示新消息弹层，底部页面禁止滑动
$('.news-prompt-panel').fadeIn();
var state =$('.news-prompt-panel').css('display');
if($('.news-prompt-panel').css('display')=="block"){
	$('.h-content').css('overflow','hidden');
}else{
	$('.h-content').css('overflow','auto');
}

//忽略 新消息，逐条删除
$('.news-list-block').on('click','i.icon-close',function(){
	$(this).parents('li').remove();	
	noticeCount();
});

//计算新消息条数，小于1 则不显示新消息 弹层
function noticeCount(){
	var noticeCount = $('.news-list-block').find('li').length;
	if(noticeCount<1){
		$('.news-prompt-panel').fadeOut();
		$('.h-content').css('overflow','auto');
	}
}
noticeCount();

//返回顶部
$('.h-content').scroll(function(){ 
	if ($('.h-content').scrollTop()>50){ 
		$('.return-top').show(); 
	}else{ 
		$('.return-top').hide();
	} 
});
$('.page-group').on('click','.return-top',function(){ 	
	$('.h-content').scrollTop(0);
	$('.return-top').hide();
});