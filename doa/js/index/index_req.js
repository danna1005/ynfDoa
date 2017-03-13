/*
调整后的首页请求 
2016-12-28 拓凡
*/
var doaVersion = new Date().getTime();
var curAppClass = "";
var storage = window.localStorage;
var authEkp = "";
$(document).ready(function(){
	
	refreshDoaVersion();
	
	hadleIndexDetails();
	
	//请求1 角标
	fetchIconData();

	//请求2 app 新闻
	fetchAppAndNews();

	//请求3 未读邮件数目
	//fetchMailCntData();


	//可能的请求4 判断是否需要加载操作指引，需要的话就加载加载一下
	fetchGuideData();
	
//	//未读通知的获取
//	loadHomeNoticeNews();
//
//	//首页更新的通知
//	loadSysUpdateNotice();
//	
//	//关闭更新的通知
//	$("#sysUpdateNotice .prompt-close").click(function(){
//		closeSysUpdateNotice();
//	});
});
function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}

//判断json
function isNullOrEmpty(obj){
	if (obj == null) {
		return true;
	} else if ($.trim(obj) == "") {
		return true;
	} else if (obj == "undefined") {
		return true;
	} else {
		return false;
	}
}
//获取应用以及新闻的JS代码
function fetchAppAndNews()
{
	//先加载localstorage的数据
	var lastDateTime = storage.getItem("lastDateTime");
	
	var appCategory  = storage.getItem("appCategory"),
		appsList = storage.getItem("appsList"),
		indexNews = storage.getItem("indexNews");
	if(!isNullOrEmpty(appCategory)){
		handleCategores(JSON.parse(appCategory));
	}
	
	if(!isNullOrEmpty(appsList)){
		handleAppData(JSON.parse(appsList));
	}
	if(!isNullOrEmpty(indexNews)){
		handleIndexNews(JSON.parse(indexNews));
	}
	

	var	url;
	if(!isNullOrEmpty(lastDateTime) && !isNullOrEmpty(appCategory) && !isNullOrEmpty(appsList)&& !isNullOrEmpty(indexNews)){
		url = "third/doa/index.do?method=getIndexData"+authEkp+"&lastDataTime="+lastDateTime;
	}else{
		url = "third/doa/index.do?method=getIndexData"+authEkp+"&lastDataTime=";
	}
	var reqUrl = makeUrl(url);
	commonGet(reqUrl,null,function(r){		
		if(noError(r))
		{
			if(!isNullOrEmpty(r.data.appCategores)){
				handleCategores(r.data.appCategores);
			}
			if(!isNullOrEmpty(r.data.apps)){
				handleAppData(r.data.apps);	
			}
			if(!isNullOrEmpty(r.data.indexNews)){
				handleIndexNews(r.data.indexNews);	
			}	
			storage.setItem("lastDateTime",r.data.lastDataTime);

		}
		else{
			// alert("请求出错了");
		}
	},function(){
			// alert("没请求成功");
	});
}

//处理分类
function handleCategores(cates)
{	
	if(!isNullOrEmpty(cates)&&cates.length>0){
		storage.setItem("appCategory",JSON.stringify(cates));
	}
	//填充上面的主分类
	var mainHtml = "";
	var subHtml = "";
	for(var i =0; i<cates.length;i++)
	{	
		var item = cates[i];
		var mainClassVal = "";
		curAppClass = item.name;
		if(i==0){
			mainClassVal =  "cur"; //第一个菜单默认选中
		}
		/*var hash = getHash();
		var mainClassVal = "";
		if(hash == "" && i == 0){
			mainClassVal =  "cur";
			curAppClass = item.name;
		}
		else if(item.orderNum == hash){
			mainClassVal =  "cur";
			curAppClass = item.name;
			if(i>3){
				//非第一行分类hash选中则展开所有
				$('.detailSelection > .detailPage').css({'height':'auto'});
				$('.addmore-panel').addClass("up").find(".addMoreSer").removeClass("icon-down").addClass("icon-up");
			}
		}*/
		mainHtml += generateMainClassSpan(item.name,item.orderNum,mainClassVal);
	}
	$(".detailContent>.detailSelection>.detailPage").html(mainHtml);	
}

//处理各个分类的应用
function handleAppData(apps)
{		
	if(!isNullOrEmpty(apps)){
		storage.setItem("appsList",JSON.stringify(apps));
	}
	var appsHtml = "";
	for(var key in apps)
	{
		var list = apps[key];
		improveAppIconUrl(list);
		//var curClass = curAppClass == key ? "cur" : "hidden";
		var curClass = "hidden";
		var curAppsHtml = '<div class="row no-gutter applist '+curClass+'" id="content-'+key+'">\
            					<div class="selectionContent">';		
		for(var i=0;i<list.length;i++){
			var item = list[i];
			var appHtml = geneAppSpan(item);
			curAppsHtml += appHtml;
		}
		curAppsHtml +="</div></div>";
		appsHtml += curAppsHtml;
	}
	$(".detailContent>.appItems").html(appsHtml);
	$('.applist').eq(3).removeClass('hidden').addClass('cur'); //默认显示我的日常apps
}

//把新闻添加到页面
function handleIndexNews(data)
{
	if(!isNullOrEmpty(data)&&data.length>0){
		storage.setItem("indexNews",JSON.stringify(data));
	}
	var newsHtml = "";
	for(var i =0; i<data.length;i++)
	{
		var item = data[i];
		var url = makeUrl(item.url);
		item.time = getLocalTime(item.time);
		newsHtml += generateNewsA(url,item.title,item.pic,item.content,item.time);
	}
	$("#yujiaNews>.newsItems").html(newsHtml);
}

//首页第一个请求：请求上面的角标
function fetchIconData()
{
	var url = "third/doa/index.do?method=getIndexCount"+authEkp;
	var reqUrl = makeUrl(url);
	commonGet(reqUrl,null,function(r){
		if(noError(r)){
			var attenTipNum = r.data.abnormalCnt;
			var todoTipNum = r.data.sysToDoCount;
			var dingAttenUrl = r.data.attenURL;
			storage.setItem("attenUrl",dingAttenUrl);
			var dingMailUrl = r.data.dingMailUrl;
			storage.setItem("mailUrl",dingMailUrl);
			//考勤异常的数量
			if(parseInt(attenTipNum)>0)
			{
				showTipNum(0,attenTipNum);
				changeUrl(0,makeUrl("third/doa/pages/apps/clock/clock.html?v="+doaVersion));
			}
			else{						
				changeUrl(0,dingAttenUrl);
			}
			//待办的数量
			if(parseInt(todoTipNum)>0)
			{
				showTipNum(1,todoTipNum);
			}
			changeUrl(2,dingMailUrl);
		}
	},false);
}

//获取未读邮件的数量
function fetchMailCntData()
{
	var myMailCnt = "third/mail/coremail/loginCoreMail.do?method=getNotReadMail&s_ajax=true"+authEkp;
    commonGet(makeUrl(myMailCnt), null, function(r) 
    {
        var tipNum = parseInt(r.num);
        if (parseInt(tipNum) > 0) 
        {
        	showTipNum(2,tipNum);
        }
    }, false);
}

//展示右上角角标
function showTipNum(eqNum,tipNum){
	var strong = $(".commonFn").children("p").eq(eqNum).find("a>span>strong");
	strong.html(tipNum).removeClass("hidden").addClass("normal");
	//新手指引需要点亮的这块也加上小图标数字
	var strongForGuide = $(".commonFn").children("p").eq(eqNum).find("span.apps-highlight>span>strong");
	strongForGuide.html(tipNum).removeClass("hidden").addClass("normal");
}

//改变图片的链接
function changeUrl(eqNum,url){
	var a = $(".commonFn").children("p").eq(eqNum).find("a");
	if(url.indexOf("dingtalk://")<0){
		a.data("href",url);
		a.attr("href","javascript:void(0)");
	}
	else{
		a.attr("href",url);
		a.data("href","");
//		a.removeClass("openLink-true");
	}
	
}

// //处理首页的细节
function hadleIndexDetails()
{
	var news_more_href = makeUrl("sys/news/mobile/?moduleName=新闻公告&v="+doaVersion);
	$("#newsMoreHref").attr("data-href",news_more_href);
	//钉邮和考勤的URL 启用缓存的URL
	var attenUrl = storage.getItem("attenUrl"),
		mailUrl  = storage.getItem("mailUrl");
	if(!isNullOrEmpty(attenUrl))
	{
		changeUrl(0,attenUrl);
	}
	else{
		changeUrl(0,makeUrl("third/doa/pages/apps/clock/clock.html?v="+doaVersion));
	}
	if(!isNullOrEmpty(mailUrl))
	{
		changeUrl(2,mailUrl);
	}
	changeUrl(1,makeUrl("third/doa/pages/apps/restWork/rest-work.html?v="+doaVersion));
	changeUrl(3,makeUrl("third/doa/pages/apps/it/support.html?v="+doaVersion));
	$("#rel_div a").attr("href",makeUrl("third/doa/pages/apps/info/discontent.html?v="+doaVersion));
}


//生成主分类代码
function generateMainClassSpan(name,orderNum,classVal)
{
	var span = '<span class="'+classVal+'" id="'+name+'" data-hash="'+orderNum+'">\
                    <b>'+name+'</b>\
                    <i></i>\
                </span>';
    return span;
}


// //生成副分类代码
function geneSubSpan(name,orderNum,classVal)
{
	var p = '<p class=" '+classVal+'" data-hash="'+orderNum+'" data-id="'+name+'">\
                <b>'+name+'</b>\
                <i></i>\
             </p>';
    return p;
}

//生成app的数据
function geneAppSpan(item)
{
	var needOpenLink = (item.urlType==1||item.urlType==3)?"openLink-true":"openLink-false";
	var hrefOrDataHref = "";
	if(item.urlType==2 || item.urlType==-1){
		hrefOrDataHref = ' href="'+item.url+'" ';
	}
	else{
		hrefOrDataHref = ' data-href="'+item.url+'" ';
	}
	var html='<span class="col-25">\
	            <a '+hrefOrDataHref+' class="a1 '+needOpenLink+'" data-anchor="'+item.icon+'" onclick="aListClick(this)">\
	                <svg class="icon" aria-hidden="true">\
	                	<use xlink:href="#'+item.icon+'"></use>\
	                </svg>\
	                <b>'+item.name+'</b>\
	            </a>\
	            <span class="apps-highlight">\
	                <svg class="icon" aria-hidden="true">\
	                	<use xlink:href="#'+item.icon+'"></use>\
	                </svg>\
	                <b>'+item.name+'</b>\
                </span>\
	         </span>';
	return html;	               

}

/**
 * 获取拓展属性
 */
function getExtendPara(item,name){
	if(!isEmpty(item.extendPara))
	{
		var obj = JSON.parse(item.extendPara);
		if(!isEmpty(eval('obj.'+name)))
		{
			return eval('obj.'+name);
		}
		else{
			return false;
		}
	}
	else{
		return false;
	}
}

//生成新闻代码
function generateNewsA(url,title,img,content,time)
{	
	if(!img)
	{
		img = "../images/apps/new/leftNews.png";
	}
	var a = '<div class="speNews">\
				<a  href="'+url+'" class="openLink-true">\
	                <div class="speNewsLeft">\
	                    <img src="'+img+'" onerror="this.src=\'../images/apps/new/leftNews.png\'">\
	                </div>\
	                <div class="speNewsRight">\
	                    <i class="iconfont icon-new1"></i>\
	                    <h2>'+title+'</h2>\
	    				<p>'+content+'</p>\
	    				<span class="newsTime">'+time+'</span>\
	                </div>\
	    			<div class="speNewsBg lastBg"></div>\
	            </a>\
	        </div>';
    return a;
}

/****操作指引部分的函数 begin ****/
var guideRead = storage.getItem("guideRead");
//得到操作指引阅读情况
function fetchGuideData(){
	var guideUrl = makeUrl("third/doa/doa_notice/doaNotice.do?method=getNotice&model=index"+authEkp);
	if(guideRead!=1){		
		commonGet(guideUrl,null,function(r){
			if(noError(r)){
				if (r.errCode==0){					
					$('.doa-guide').removeClass('dis-none');	
					$('.index-body').css('overflow','hidden');
					if(!$('.doa-guide').hasClass('dis-none')){
						$('.doa-guide').find('.prompt-panel').fadeIn(100);
						loadGuide(r.data.fdId);
					}
				}else{
					storage.setItem("guideRead",1);
					
					$('.index-body').css('overflow','auto');
				}
			}
	  	},false);
	}
}


//给icon的链接加上../images/index/
function improveAppIconUrl(list) {
    //处理URL
    for (var i = 0; i < list.length; i++) 
    {
        //list[i].icon = "../images/index/" + list[i].icon;
        if(-1==list[i].urlType)
        {
        	list[i].url = "javascript:void(0)";        	
        }
        else if (1==list[i].urlType)
        { 
        	if(list[i].url.indexOf("?")>=0)
        	{
        		//已加参数
        		list[i].url = makeUrl(list[i].url+"&v="+doaVersion);
        	} 
        	else{
        		list[i].url = makeUrl(list[i].url+"?v="+doaVersion);
        	}
            
        }
        else
        {
        	//其他的url就用自己的URL
        }

        //这个 添加APP 是在代码里面写的，一般不会变动
        if(list[i].icon=="more.png")
        {
        	list[i].icon = "icon-tianjia";
        	list[i].urlType = 3;
        	list[i].url=makeUrl("third/doa/pages/apps/daily/index.html?v="+doaVersion);
        }
    }
    return list;
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
	            	storage.setItem("guideRead",1); //读取成功设置localStorage为1
	            	$('.index-body').css('overflow','auto');
	            },
	            error: function(){
	            }         
			});
		}
	});	
}
/********操作指引部分的函数 end *******/	

window.setInterval('fetchIconData()',300000); //定时刷新5分钟取一次角标数据

//导入首页通知信息
function loadHomeNoticeNews(){
	var homeNoticeNewsUrl = makeUrl("third/doa/index.do?method=getHomeNoticeNews");
	commonGet(homeNoticeNewsUrl,null,function(r){
		if(noError(r)){
			if(r.data.length > 0)
			{
				var html = "";
				for(var i=0;i<r.data.length;i++)
				{
					var item = r.data[i];
					var res = "sys/news/sys_news_main/sysNewsMain.do?method=view&fdId="+item.fdId+"&_mobile=1";
					item.url = makeUrl(res);
					html += '<tr><td><a data-href="'+item.url+'">'+item.title+'<a></td></tr>';
				}
				$("#homeNoticeNews table").html(html);
			}
			else{
				$("#homeNoticeNews").addClass("hidden");
			}
		}
	},false);
}

//加载查看是否有更新的公告
function loadSysUpdateNotice()
{
	var homeNoticeNewsUrl = makeUrl("third/doa/index.do?method=getSysUpdateNotice");
	commonGet(homeNoticeNewsUrl,null,function(r){
		if(noError(r)){
			if(!isEmpty(r.data))
			{
				$("#sysUpdateNotice .prompt-header").html(r.data.title);
				$("#sysUpdateNotice .content-padded").html(r.data.content);
				$("#sysUpdateNotice").data("notice-id",r.data.id);
				$("#sysUpdateNotice").fadeIn("slow");
			}
			else
			{
				
			}
		}
	},false);
}

//关闭通知对话框
function closeSysUpdateNotice()
{
	$("#sysUpdateNotice").fadeOut();
	var obj = new Object();
	obj.id = $("#sysUpdateNotice").data("notice-id");
	var changeUrl = makeUrl("third/doa/index.do?method=setSysUpdateNoticeRead");
	commonPost(changeUrl,obj,function(r){
		logJsonText(r);
	},function(){
		logJsonText("连接异常");
	});
}

/**
 * 刷新一下链接上的版本号,通过链接上面的版本号V
 */
function refreshDoaVersion()
{
	var url = window.location.href;
	if(url != null && url.toString().length>0 )
	{
		var v = getQueryString("v");
		if(!isNullOrEmpty(v)){
			doaVersion = v;
		}
		
	}
}
/**
 * 正则表达式获取url的参数
 */
function getQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}