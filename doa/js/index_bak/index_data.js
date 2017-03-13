$(function() {
    //中上部分APP数据
    var reqAppDataURL = "third/doa/doa_application/doaApplication.do?method=getAppsJson";
    
    /**四个角标**/
    //获取首页考勤角标数据的地址
    var reqAttenDataURL = "third/doa/doa_attendence/attendence.do?method=countAbnormal";
    
    //获取首页待办事宜部分数据的地址
    // var reqRestWorkURL = "sys/notify/sys_notify_todo/sysNotifyTodo.do?method=sumTodoCount&s_ajax=true";
    var reqRestWorkURL = "third/doa/doa_systodo/sysToDo.do?method=count";

    //获取首页我的流程部分数据的地址
    var reqMyFlowURL = "km/review/km_review_index/kmReviewIndex.do?method=count&q.mydoc=approval&orderby=docCreateTime&ordertype=down";
    var myMailCnt = "third/mail/coremail/loginCoreMail.do?method=getNotReadMail&s_ajax=true";
    
   
    
   
    
    //我的流程跳转链接
    var myProsUrl = makeUrl("km/review/mobile/?moduleName=新建流程");
    
    //御家资讯里面的那个更多
    var newsHref = makeUrl("sys/news/mobile/?moduleName=新闻公告");
    
  //得到操作指引阅读情况
	var guideUrl = makeUrl("third/doa/doa_notice/doaNotice.do?method=getNotice&model=index");
	commonGet(guideUrl,null,function(r){
		
		if(noError(r)){
			
			if (r.errCode==0){
				$('.doa-guide').removeClass('dis-none');
				if(!$('.doa-guide').hasClass('dis-none')){
					$('.doa-guide').find('.prompt-panel').fadeIn(100);
					loadGuide(r.data.fdId);	 
					/*$('.apps-highlight,.tips').click(function(e){
						e.preventDefault();
					})*/
				}
				//javascript:$('#guide1').show(); 
				/*$.ajax({			            
		            type:"POST",	 
		            url:makeUrl("third/doa/doa_notice_read/doaNoticeRead.do?method=save"),			            
		            data:{noticeId:r.data.fdId}, 
		            datatype: "json",
		            success:function(data){
		            	
		            	 
		            },
		            error: function(){
		            	
		            }         
				});
				*/
			}
		}
  	},false);
	
    //页面上面部分快捷方式部分的数据
    var commonData = {
        main:{
            item1:{
                text:"考勤打卡",
                imgurl:"../images/apps/new/location.png",
                tipNum:0,
                url:"apps/clock/clock.html?v=68784545",
                "class":"hidden"
            },
            item2:{
                text:"待办事宜",
                imgurl:"../images/apps/new/restTrouble.png",
                tipNum:0,
                url:"apps/restWork/rest-work.html?v=5656",
                "class":"hidden"
            },
            item3:{
                text:"钉邮",
                imgurl:"../images/index/dingMail.png",
                tipNum:0,
                url:"#",
                "class":"hidden"
            },
            item4:{
                text:"IT服务",
                imgurl:"../images/apps/new/IT.png",
                tipNum:0,
                url:"apps/it/support.html",
                "class":"hidden"
            }
        }
    };
    var top = new Vue({
        el:".commonFn",
        data:{
            main:commonData.main
        },
        ready:function() {
            //考勤角标
            commonGet(makeUrl(reqAttenDataURL), null, function(r) {
                top.main.item1.tipNum = r.data.abnormalCnt;
                //没有考勤异常 那么直接跳到考勤打卡的页面
                top.main.item3.url = r.data.dingMailUrl;
                if (parseInt(top.main.item1.tipNum) == 0) {
                    top.main.item1.url = r.data.attenURL;
                    logJsonText(r.data.token);
                    top.main.item1.class = "hidden";
                } else {
                    top.main.item1.class = "normal";
                }
            }, false);
            //待办角标
            commonGet(makeUrl(reqRestWorkURL), null, function(r) 
            {
                if(noError(r)){
                    top.main.item2.tipNum = parseInt(r.data.count);
                    if (parseInt(top.main.item2.tipNum) == 0) {
                        top.main.item2.class = "hidden";
                    } else {
                        top.main.item2.class = "normal";
                    }
                }
                else{
                    logJsonText(r);
                }

            }, false);
            //钉邮角标
            commonGet(makeUrl(myMailCnt), null, function(r) {
                top.main.item3.tipNum = parseInt(r.num);
                if (parseInt(top.main.item3.tipNum) == 0) {
                    top.main.item3.class = "hidden";
                } else {
                    top.main.item3.class = "normal";
                }
            }, false);
        }
    });
    //中间部分的APP数据
    var appData = new Vue({
        el:".detailFn",
        data:{
            appCategores:"",
            list:""
        },
        ready:function() {
            var url = makeUrl(reqAppDataURL);
            commonGet(url, null, function(r) {
                if (noError(r)) {
                    //应用分类数据的处理
                    appData.appCategores = r.data.appCategores;
                    // 没有 window.location.hash , 0 会等于这个hash
                    var whash = window.location.hash;
                    whash = whash.replace("#", "");
                    var curCateName = "";
                    // 控制一下锚点在不能显示的第4个tab之后，是否隐藏第4个tab
                    var hashFind = false;
                    for (var i in appData.appCategores) {
                        if (whash == appData.appCategores[i].orderNum) {
                            hashFind = true;
                            appData.appCategores[i].className = "cur";
                            curCateName = appData.appCategores[i].name;
                            appData.appCategores[i].classForSpe = "cur";  
                            if (i >= 4) {
                                appData.appCategores[i].className = "hidden";
                                
                                $('.addmore-panel').addClass("up").find(".addMoreSer").removeClass("icon-down").addClass("icon-up");
                                $('.moreService').show();
                            }
                        } else {
                            if(i<4){
                                appData.appCategores[i].classForSpe = 'hidden';
                            }
                            if (i >= 4) {
                                appData.appCategores[i].className = "hidden";
                            }
                        }
                    }
                    //没有hash对应，而又有分类数据，那么默认设置第一个为当前分类
                    if (curCateName == "" && appData.appCategores.length > 0) {
                        curCateName = appData.appCategores[0].name;
                        appData.appCategores[0].className = "cur";
                    }
                    //应用数据的处理，对当前应用分类（由hash获取），设置class为cur，费当前应用分类设置为hidden
                    appData.list = r.data.apps;
                    for (var item in appData.list) {
                        var list = improveAppIconUrl(appData.list[item]);
                        appData.list[item] = new Object();
                        if (curCateName == item) {
                            appData.list[item].class = "cur";
                        } else {
                            appData.list[item].class = "hidden";
                        }
                        appData.list[item].list = list;
                    }
                } else {
                    logJsonText(r);
                }
            }, false);
        }
    });


});

//给icon的链接加上../images/index/
function improveAppIconUrl(list) {
    for (var i = 0; i < list.length; i++) {
        list[i].icon = "../images/index/" + list[i].icon;
        
        if(list[i].url=="hr"){
        	
        	list[i].url = "javascript:void(0)";        	
        }else if (list[i].url && list[i].url.indexOf("dingtalk") < 0 && list[i].id != "add_more") {
            list[i].url = makeUrl(list[i].url);
        }
    }
    return list;
}

//判断应用列表 list 里面的应用, 是否出现在我的日常应用列表 defaultList 里面,如果出现 设置为隐藏
function hideAppInDefaultList(list, defaultList) {
    for (var i = 0; i < list.length; i++) {
        list[i].class = "normal";
        for (var j = 0; j < defaultList.length; j++) {
            //判断这个链接是不是在我的日常里面的链接
            if (list[i].icon == defaultList[j].icon && list[i].name == defaultList[j].name) {
                list[i].class = "hidden";
                break;
            }
        }
    }
}


//新手指引
function loadGuide(fdId){	
	$('.prompt-guide>ul>li').each(function(){
		if($(this).hasClass('cur')){
			var index = $(this).index();	
			$('.apps-highlight').removeClass('tips');										//全部高亮层级默认为1
			$('.commonFn > p').eq(index).find('.apps-highlight').addClass('tips');		//当前应用高亮			
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
		$('.apps-highlight').removeClass('tips');
		$(this).parent().next().addClass('cur').siblings().removeClass('cur');
		$('.commonFn > p').eq(index).next().find('.apps-highlight').addClass('tips');
		if(index==3){
			//我的流程高亮及图片定位
			$(".selectionContent > span").each(function() {
	            var appPanel = $(this).find("a > b").text();
	            if (appPanel == "我的流程") {
	                $(this).find(".apps-highlight").addClass("tips");
	            }
	        });
			var appPanel =  $('.detailFn').find('.tips').parent(),
			width = $('.detailFn').find('.tips').width(),
			height = $('.detailFn').find('.tips').height(),
			left = appPanel[0].offsetLeft,
			top = $('.detailFn').find('.tips').parent()[0].offsetTop;
			$('.guide-process').css({'left':left,'top':top-height/2});
		}
		$('.guide-page-no').find('span').eq(index).next().addClass('cur').siblings().removeClass('cur');
		if(index==5){
			$('.doa-guide').addClass('dis-none').html('');
			$.ajax({			            
	            type:"POST",	 
	            url:makeUrl("third/doa/doa_notice_read/doaNoticeRead.do?method=save"),			            
	            data:{noticeId:fdId}, 
	            datatype: "json",
	            success:function(data){
	            },
	            error: function(){
	            }         
			});
		}
	});		
}	
