$(function(){
	var width = window.screen.width >= window.innerWidth?window.innerWidth:window.screen.width; 
	$('html').css({'fontSize':width*20/360+'px'});
	$('body').css({'width':width});
	
	if(!$('.doa-guide').hasClass('dis-none')){
		$('.prompt-panel').fadeIn(100);
		loadGuide();
		/*$('.apps-highlight,.tips').click(function(e){
			e.preventDefault();
		})*/
	}
	
	//commonfunction
	function pxToNum(i)
	{
		return +i.replace(/rem|em|px/g,"");
	}
	function defer(fn)
	{

		setTimeout(function(){
			fn();
		},1000);
	}
	var addMore={
		bg:$(".addMoreBg"),
		ser:$(".addmore-panel"),


	};
	var addClose={
		open:$('.moreService'),
		close:$(".close-more-panel")

	};
	// addmore
	var flag = true;
	addMore.ser.tap(function(){
		if($(this).hasClass('up')){
			flag =false;
		}
		if(flag){
			addClose.open.show();
			$(this).addClass('up').find('.addMoreSer').removeClass('icon-down').addClass('icon-up');
			flag =false;
		}else{
			addClose.open.hide();
			$(this).removeClass('up').find('.addMoreSer').removeClass('icon-up').addClass('icon-down');
			flag=true;
		}
		//$(this).hide();
		//addMore.bg.hide();

	});
	
	// close
	addClose.close.tap(function(){
		addClose.open.hide();
		addMore.removeClass('up').find('.addMoreSer').removeClass('icon-up').addClass('icon-down');
		//addMore.ser.show();
		//addMore.bg.show();
	});
	//touch
	var detailDistanceHash={
		initX:0,
		length:0,
		unitW:0,
		index:0,
		unique:true
	};

	function touchMove(){
		var oTouch=$(".detailPage").get(0);
		oTouch.addEventListener("touchstart",function(ev){
			var event=ev.touches[0];
			detailDistanceHash.initX=event.pageX;
			//page style change
			var len=detailDistanceHash.length=$(".detailPage span").length+1;
			var unitW
				=detailDistanceHash.unitW
				=+$(".detailPage span").eq(0).css("width").replace(/rem|em|px/g,"");
	
			$(this).css({"width":unitW*len});
			detailDistanceHash.unique=true;
		},false);
		oTouch.addEventListener("touchmove",function(ev){
			var event=ev.touches[0];
			var distanceX=event.pageX-detailDistanceHash.initX;
			detailDistanceHash.initX=event.pageX;
			var iLeft=+$(this).css("left").replace(/rem|em|px/g,"");
			var endX=iLeft+distanceX;	
			if(endX<0)
			{
				if(endX>=(detailDistanceHash.length-5)*(-detailDistanceHash.unitW))
				{
	
					if(detailDistanceHash.unique)
					{
						if(distanceX<0)
						{
							detailDistanceHash.index--;
						}
						else if(distanceX>0)
						{
							detailDistanceHash.index++;
						}
						detailDistanceHash.unique=false;
						if(detailDistanceHash.index<-Math.floor(detailDistanceHash.length))
						{
							detailDistanceHash.index=-Math.floor(detailDistanceHash.length);
						}
						if(detailDistanceHash.index>0)
						{
							detailDistanceHash.index=0;
						}
						if(detailDistanceHash.index==detailDistanceHash.length){
							addMore.ser.hide();				
						}
						$(this).animate({left:detailDistanceHash.index*detailDistanceHash.unitW});
						if(endX<=(-detailDistanceHash.unitW)*1)
						{
							 //addMore.bg.hide();
							// addMore.ser.hide();
							// addMore.b.css({width:addMore.bChangeWidth});					
							// addMore.spanEle.css({width:detailDistanceHash.unitW-addMore.spanPR});
						}
						else
						{
							 //addMore.bg.show();
							// addMore.ser.show();
							// addMore.b.css({width:addMore.bOriWidth});
							// addMore.spanEle.css({width:addMore.spanW});
						}
					}
				}	
			}
		},false);
	}
	
	
	// 数字1
	defer(commonFnNum);
	function commonFnNum()
	{
		var commonFnHash={
			w:+$(".commonFn strong").css("width").replace(/rem|em|px/g,""),
			h:+$(".commonFn strong").css("height").replace(/rem|em|px/g,""),
			br:+$(".commonFn strong").css("border-radius").replace(/rem|em|px/g,"")
		};
		$(".commonFn strong").each(function(index,element){
			var a=+$(this).html();
			if(a<=99)
			{
				if(a<10){
					$(this).css('width',commonFnHash.h).css('border-radius','50%');
				}else{
					$(this).css('border-radius','0.5rem');
				}
			}
			else
			{
				$(this).css('border-radius','0.5rem').html('99+');
			}
		});

	}
	//detailPageI自适应宽度
	function detailPageI()
	{
		$('.detailPage b').each(function(index,element){
			var width=$(this).css('width');
			$(this).siblings("i").css({width:width});
		});

	}
	defer(detailPageI);
	
	
	//我的日常
	defer(detailClick);
	function detailClick()
	{
		$('.detailSelection span').click(function(element){
			var index=$(this).index();
			//加入class用于后期关联判断
			$(this).siblings("span").removeClass("cur");
			$(this).addClass("cur");
			var id = $(this).attr("id");
			logJsonText(id);
			var contentDIV = $("#content-"+id);
			contentDIV.siblings('.applist').addClass("hidden").removeClass("cur");
			contentDIV.removeClass("hidden").addClass("cur");
			/*var selectContent = contentDIV.find('.selectionContent'),
				rowsNum = Math.ceil(selectContent.find('span').length/4);
			if(rowsNum>2){
				contentDIV.find('.nextPart').removeClass('dis-none');
				contentDIV.find('.selectionContent').height('7.15rem');
			}else{
				contentDIV.find('.nextPart').addClass('dis-none');
				contentDIV.find('.selectionContent').height('auto');
			}		
			$('.applist').find('.nextIcon').addClass('down').animate({'transform': 'rotateX(0deg)'});*/

			// 改变链接的 hash 值	
			window.location.hash = $(".detailPage .cur").data("hash");
		});
		
		//加载更多分类隐藏前三个
		$(".speInforChildren p").each(function(index){
			if(index<4){
				$(this).hide();
			}
			else{
				$(this).addClass("speBtn");
			}
		});
		
		// 切换分类 里面点击的动作效果 ; 
		// 这里还需要考虑首页的锚点加载的问题 如#=4（人力资源），现在已经在index_data.js里面，数据请求加载的时候做了修改，
		$(".speInforChildren p").click(function(){
			var id = $(this).data("id"),
				nav = $(this).find('span').text();
			
			// 当前点击tab
			$(this).addClass("current");
			$(this).siblings(".speBtn").removeClass("current");
			
			// 修改点击动作，控制到关联的tab点击
			$(this).siblings(".speBtn").each(function(){
				var speHideID = $(this).data("id");
				$("#"+speHideID).addClass("hidden");
			});

			// 自己的tab点击
			$("#"+id).removeClass("hidden").addClass("cur");
			$("#"+id).siblings("span").removeClass("cur");	

			// 控制tab关联内容的显示
			var contentDIV = $("#content-"+id);
			contentDIV.siblings(".applist").addClass("hidden").removeClass("cur");
			contentDIV.removeClass("hidden").addClass("cur");
			window.location.hash = $("#"+id).data("hash");


			addClose.open.hide();
			addMore.ser.removeClass('up').find('.addMoreSer').removeClass('icon-up').addClass('icon-down');
			
			flag=true;
			//addMore.ser.show();
			//addMore.bg.show();
			
			// addClose.close.tap();
//			var width = $(".detailPage span").eq(0).css("width").replace(/rem|em|px/g,"");
//			var ind = contentDIV.index()-1;
//			var left = -ind*width;
//			$('.detailPage').animate({left:left},100);			
		});
		
		//app分类少于五个则不显示加更多
		var categoryNum = $('.detailPage>span').length;
		logJsonText(categoryNum);
		if(categoryNum<=4){
			$('.addmore-panel').hide();
		}else{
			$('.addmore-panel').show();
		}
	}	
	
	function outerHeight(element)
	{
		var a=["height",'padding-top','padding-bottom','margin-top','margin-bottom'];
		var b=0;
		for(var i=0,len=a.length;i<len;i++)
		{
			var s=element.css(a[i]).replace(/px|rem|em/g,"");
			if(s!="")
			{
				b+=parseFloat(element.css(a[i]).replace(/px|rem|em/g,""));
			}
		}
		return b;
	}
	
	
	// 初始化加载的时候，那个nextPart的倒三角显示更多。
	//defer(loadMore);
	function loadMore(){		
		//加载和收起应用
		var container= $('.applist.cur');
		var rowsNum = Math.ceil(container.find('.selectionContent').find('span').length/4);	
		if(rowsNum>2){
			container.find('.nextPart').removeClass('dis-none');
			container.find('.selectionContent').height('7.15rem');
		}else{
			container.find('.nextPart').addClass('dis-none');
			container.find('.selectionContent').height('auto');
		}	
		
		$('.applist').on('click','.nextPart',function(){	
			var btn = $(this).find(".nextIcon");
			var contentDIV = btn.parents('.applist'),
				selectContent = contentDIV.find('.selectionContent');
			if(btn.hasClass('down')){
				selectContent.animate(
						{
					        height:'auto',   
				        }, 
			        	80,
			        	'ease-in-out'
			     );	
				btn.removeClass('down').animate({'transform': 'rotateX(180deg)'});
			}else{
				selectContent.animate({'height':'7.15rem'},80,'ease-in-out');
				btn.addClass('down').animate({'transform': 'rotateX(0deg)'});	
			}
		});		
	}
	//给我的流程区别高亮，用于新手指引凸显应用图标
	defer(addHighlight);
	function addHighlight(){
		$('.selectionContent > span').each(function(){
			var appPanel = $(this).find('b').text();
			if(appPanel=="我的流程"){
				$(this).find('.apps-highlight').addClass('tips');
			}
		});	
	}
	//新手指引
	function loadGuide(){	
		$('.prompt-guide>ul>li').each(function(){
			if($(this).hasClass('cur')){
				var index = $(this).index();	
				$('.apps-highlight').css({'border-color':'#fff','z-index':'1'});										//全部高亮层级默认为1
				$('.commonFn > p').eq(index).find('.apps-highlight').css({'border-color':'#000','z-index':'1003'});		//当前应用高亮			
				var appWidth= $('.commonFn > p').eq(index).find('.apps-highlight').width(), 							//应用图标宽
					left = $('.commonFn > p').eq(index).find('.apps-highlight')[0].offsetLeft + appWidth;				//应用左边距
					
					restworkLeft = left - appWidth/3.5;
				$('.guide-clock').css({'left':left/2});														//考勤图片定位
				$('.guide-restwork').css({'left':restworkLeft});														//代办事项图片定位
				$('.guide-email').css({'left':left-appWidth/2});												//钉邮图片定位
				$('.guide-server').css({'right':left});																	//it服务图片定位
			}
		});
		//点击我知道进入下一步 操作
		$('.prompt-guide>ul>li').find('.next-step').click(function(){
			var index = $(this).parent().index();			
			$('.apps-highlight').css({'border-color':'#fff','z-index':'1'});
			$(this).parent().next().addClass('cur').siblings().removeClass('cur');
			$('.commonFn > p').eq(index).next().find('.apps-highlight').css({'border-color':'#000','z-index':'1003'});
			if(index==3){
				//我的流程高亮及图片定位
				var appPanel =  $('.detailFn').find('.tips').parent(),
				width = $('.detailFn').find('.tips').width(),
				height = $('.detailFn').find('.tips').height(),
				left = appPanel[0].offsetLeft,
				top = $('.detailFn').find('.tips').parent()[0].offsetTop;
				$('.detailFn').find('.tips').css({'border-color':'#000','z-index':'1003'});	
				$('.guide-process').css({'left':left,'top':top-height/2});
			}
			$('.guide-page-no').find('span').eq(index).next().addClass('cur').siblings().removeClass('cur');
			if(index==5){
				$('.doa-guide').addClass('dis-none');
			}
		});		
	}
	
	//关闭弹出窗
	$("#occlude").click(function() {	
		$("#prompt").addClass("dis-none");		
	});
});

