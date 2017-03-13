$(function(){
	//中上部分APP数据
	var reqAppDataURL = "third/doa/doa_application/doaApplication.do?method=getAppsJson"; 
	
	/**四个角标**/
	//获取首页考勤角标数据的地址
	var reqAttenDataURL = "third/doa/doa_attendence/attendence.do?method=countAbnormal";
	//获取首页待办事宜部分数据的地址
	var reqRestWorkURL = "sys/notify/sys_notify_todo/sysNotifyTodo.do?method=sumTodoCount&s_ajax=true";
	//获取首页我的流程部分数据的地址
	var reqMyFlowURL = "km/review/km_review_index/kmReviewIndex.do?method=count&q.mydoc=approval&orderby=docCreateTime&ordertype=down";
	
	var myMailCnt = "third/mail/coremail/loginCoreMail.do?method=getNotReadMail&s_ajax=true";

	//获取首页御家资讯部分的数据
	var newsRowSize = 5;
	// var yujiaNewsURL = "sys/news/sys_news_main/sysNewsMain.do?method=jsonNewsList&categoryId=1519f8ec85c075cdcf4180241f491a79&status=all&showDocStatus=true&nodeType=CATEGORY&rowsize="+newsRowSize;
	var yujiaNewsURL = "third/doa/doa_sys_news/sysNews.do?method=listChildrenLst&categoryId=&q.docStatus=30&orderby=fdIsTop,fdTopTime,docAlterTime&ordertype=down&rowsize="+newsRowSize;
	
	//我的流程跳转链接
	var myProsUrl=makeUrl("km/review/mobile/?moduleName=新建流程");


	//御家资讯里面的那个更多
	var newsHref = makeUrl("sys/news/mobile/?moduleName=新闻公告");
	
	//页面上面部分快捷方式部分的数据
	var commonData={
		main:{
		    item1:{'text':'考勤打卡','imgurl':"../images/apps/new/location.png",'tipNum':0,'url':'apps/clock/clock.html?v=68784545',class:"hidden"},
		    item2:{'text':'待办事宜','imgurl':"../images/apps/new/restTrouble.png",'tipNum':0,'url':'apps/restWork/rest-work.html?v=5656',class:"hidden"},
		    item3:{'text':'钉邮','imgurl':"../images/index/dingMail.png",'tipNum':0,'url':'#',class:"hidden"},
		    item4:{'text':'IT服务','imgurl':"../images/apps/new/IT.png",'tipNum':0,'url':'apps/it/support.html',class:"hidden"},
		},
	};
	var top = new Vue({
	  el:'.commonFn',
	  data:{
	  	main:commonData.main,
	  },
	  ready:function(){
	  	//考勤角标
	  	commonGet(makeUrl(reqAttenDataURL),null,function(r){
			top.main.item1.tipNum = r.data.abnormalCnt;
			//没有考勤异常 那么直接跳到考勤打卡的页面
			top.main.item3.url = r.data.dingMailUrl;
			if(parseInt(top.main.item1.tipNum)==0)
			{
				top.main.item1.url = r.data.attenURL;
				logJsonText(r.data.token);
				top.main.item1.class = "hidden";
			}
			else{
				top.main.item1.class = "normal";	
			}
	  	},false);
	  	//待办角标
	  	commonGet(makeUrl(reqRestWorkURL),null,function(r){
	  		top.main.item2.tipNum = parseInt(r.type_1);
	  		if(parseInt(top.main.item2.tipNum) == 0){
	  			top.main.item2.class = "hidden";
	  		}
	  		else{
				top.main.item2.class = "normal";	
			}
	  	},false);
	  	//钉邮角标
	  	commonGet(makeUrl(myMailCnt),null,function(r){
	  		top.main.item3.tipNum = parseInt(r.num);
	  		if(parseInt(top.main.item3.tipNum) == 0){
	  			top.main.item3.class = "hidden";
	  		}
	  		else{
				top.main.item3.class = "normal";	
			}
	  	},false);
	  },
	});

	//中间部分的APP数据
	var appData = new Vue({
	  el:'.detailFn',
	  data:{
		appCategores:'',
	  	list:'',
	  },
	  ready:function(){
		  	var url = makeUrl(reqAppDataURL);
		  	commonGet(url,null,function(r){
		  		if(noError(r)){
		  			//应用分类数据的处理
		  			appData.appCategores = r.data.appCategores;
		  			// 没有 window.location.hash , 0 会等于这个hash
		  			var whash = window.location.hash;
		  			whash = whash.replace("#","");
		  			var curCateName = '';
		  			// 控制一下锚点在不能显示的第4个tab之后，是否隐藏第4个tab
		  			var hashFind = false;
		  			for(var i in appData.appCategores)
		  			{

		  				if(whash == appData.appCategores[i].orderNum)
		  				{
		  					hashFind = true;
		  					appData.appCategores[i].className="cur";
		  					curCateName = appData.appCategores[i].name;
		  					appData.appCategores[i].classForSpe="current";

		  				}
		  				else
		  				{
		  					if(i>=3 && hashFind == false)
		  					{
		  						appData.appCategores[i].className="hidden";
		  					}
		  				}
		  			}
		  			//没有hash对应，而又有分类数据，那么默认设置第一个为当前分类
		  			if(curCateName == '' && appData.appCategores.length >0 ){
		  				curCateName = appData.appCategores[0].name;
		  				appData.appCategores[0].className="cur";
		  			}
		  			//应用数据的处理，对当前应用分类（由hash获取），设置class为cur，费当前应用分类设置为hidden
		  			appData.list = r.data.apps;
		  			for(var item in appData.list)
		  			{
		  				var list = improveAppIconUrl(appData.list[item]);
		  				appData.list[item] = new Object();
		  				if(curCateName == item)
		  				{
		  					appData.list[item].class="cur";	
		  				}
		  				else{
		  					appData.list[item].class="hidden";	
		  				}
		  				appData.list[item].list=list;	
		  			}
		  			// logJsonText(appData.appCategores);
		  		}
		  		else
		  		{
		  			logJsonText(r);
		  		}
		  	},false);
	    }
	});
	
	//底部新闻数据拉取
	var newsData = new Vue({
	  el:'#yujiaNews',
	  data:{
	  	con:"",
	  	moreHref:newsHref,
	  },
	  ready:function(){
		  	var newsUrl = makeUrl(yujiaNewsURL);
		  	commonGet(newsUrl,null,function(r){
		  		newsData.con = getNewsList(r);
		  	},false);

	  },
	});

});

//给icon的链接加上../images/index/
function improveAppIconUrl(list)
{
	for(var i = 0 ; i<list.length ; i++)
	{
		list[i].icon = "../images/index/"+list[i].icon;
		if(list[i].url && list[i].url.indexOf("dingtalk") <0 && list[i].id != "add_more")
		{
			list[i].url = makeUrl(list[i].url);
		}
	}
	return list;
}

//判断应用列表 list 里面的应用, 是否出现在我的日常应用列表 defaultList 里面,如果出现 设置为隐藏
function hideAppInDefaultList(list,defaultList)
{	
	for(var i = 0 ; i<list.length; i++)
	{
		list[i].class = "normal";
		for(var j = 0 ; j< defaultList.length;j++)
		{
			//判断这个链接是不是在我的日常里面的链接
			if( list[i].icon == defaultList[j].icon && list[i].name == defaultList[j].name )
			{
				list[i].class = "hidden";
				break;
			}
		}
	}
}

//从新闻接口获取新闻数据
function getNewsList(r)
{
	for(var i=0 ; i<r.data.length ; i++)
	{
		if(typeof(r.data[i].pic) != 'undifined' && r.data[i].pic){
			r.data[i].imgUrl  = makeUrl(r.data[i].pic);	
		}
		else{
			r.data[i].imgUrl  = "../images/apps/new/leftNews.png";	
		}
		
		// r.data[i].content = $.trim($("<p>"+r.data[i].content+"</p>").text()).slice(0,32)+"...";
		r.data[i].content = $.trim(r.data[i].content).slice(0,32)+"...";
		r.data[i].time  = getLocalTime(r.data[i].time);
		r.data[i].url   = makeUrl(r.data[i].url);
	}
	return r.data;
}
