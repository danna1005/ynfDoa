
var PROCESS_PAGENO = 1;
var PROCESS_PAGESIZE = 50;

var PROCESS_HAS_STATE_END = 1;

var LOAD_OA = 1;
var LOAD_HR = 2;
var LOAD_BOTH = 3;

//全局变量，整理HR以及OA的数据的时候，把这个放到里面
var hr_oa_list = new Object();

/*
	我的流程数据请求,用于首次二级分类请求
*/
$(document).ready(function(){
	
	//进到页面显示全部
	loadOaAndHrMyApply();

	//我的申请
	$(".myApplyBtn").click(function()
	{
		var curHtml = $.trim( $("#myApplyBtn>ul").html() );
		if(isEmpty(curHtml))
		{
			
			if($(".allProcess").hasClass("active"))
			{
				loadOaAndHrMyApply();
			}
			else if($(".oaProcess").hasClass("active"))
			{
				loadOaMyApply();
			}
			else if($(".hrProcess").hasClass("active"))
			{
				loadHrMyApply();
			}
		}
	});


	//待我审
	$(".approveBtn").click(function()
	{
		var curHtml = $.trim( $("#approveBtn>ul").html() );
		if(isEmpty(curHtml))
		{
			if($(".allProcess").hasClass("active")){
				//全部流程
				loadingBegin(LOAD_BOTH);
				getMyApproval(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaAndHrProcess(r,"OA","#approveBtn","待我审");
					getHrProcesses("UnRead",PROCESS_PAGENO,PROCESS_PAGESIZE,PROCESS_HAS_STATE_END,function(r){
						insertOaAndHrProcess(r,"HR","#approveBtn","待我审");
					},false);
				});
				
			}
			else if($(".oaProcess").hasClass("active")){
				//oa流程
				loadingBegin(LOAD_OA);
				getMyApproval(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaProcess(r,"#approveBtn","待我审");
				});
			}
			else if($(".hrProcess").hasClass("active")){
				//hr流程
				loadingBegin(LOAD_HR);
				getHrProcesses("UnRead",PROCESS_PAGENO,PROCESS_PAGESIZE,PROCESS_HAS_STATE_END,function(r)
				{
					insertHrProcess(r,"#approveBtn","待我审");
				},false);
			}
		}
	});

	//我已审
	$(".approvedBtn").click(function()
	{
		var curHtml = $.trim( $("#approvedBtn>ul").html() );
		if(isEmpty(curHtml))
		{
			if($(".allProcess").hasClass("active")){
				//全部流程
				loadingBegin(LOAD_BOTH);
				getMyApproved(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaAndHrProcess(r,"OA","#approvedBtn","我已审");
					getHrProcesses("Readed",PROCESS_PAGENO,PROCESS_PAGESIZE,PROCESS_HAS_STATE_END,function(r){
						insertOaAndHrProcess(r,"HR","#approvedBtn","我已审");
					},false);
				});
				
			}
			else if($(".oaProcess").hasClass("active")){
				//oa流程
				loadingBegin(LOAD_OA);
				getMyApproved(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaProcess(r,"#approvedBtn","我已审");
				});
			}
			else if($(".hrProcess").hasClass("active")){
				//hr流程
				loadingBegin(LOAD_HR);
				getHrProcesses("Readed",PROCESS_PAGENO,PROCESS_PAGESIZE,PROCESS_HAS_STATE_END,function(r){
					insertHrProcess(r,"#approvedBtn","我已审");
				},false);
			}
		}
	});
	
	//待阅
	$(".doingBtn").click(function()
	{
		var curHtml = $.trim( $("#doingBtn>ul").html() );
		if(isEmpty(curHtml))
		{
			if($(".allProcess").hasClass("active")){
				//全部流程
				loadingBegin(LOAD_BOTH);
				getMyDoing(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaProcess(r,"#doingBtn","待我阅");
				});
			}
			else if($(".oaProcess").hasClass("active")){
				loadingBegin(LOAD_OA);
				getMyDoing(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaProcess(r,"#doingBtn","待我阅");
				});
			}
			else if($(".hrProcess").hasClass("active")){
				//hr流程
				// loadingBegin(LOAD_HR);
				$.toast("没有这一项");
			}
		}
	});

	//已办
	$(".doneBtn").click(function()
	{
		var curHtml = $.trim( $("#doneBtn>ul").html() );
		if(isEmpty(curHtml))
		{
			if($(".allProcess").hasClass("active")){
				//全部流程
				loadingBegin(LOAD_BOTH);
				getMyDone(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaProcess(r,"#doneBtn","已办");
				});
			}
			else if($(".oaProcess").hasClass("active")){
				loadingBegin(LOAD_OA);
				getMyDone(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
					insertOaProcess(r,"#doneBtn","已办");
				});
			}
			else if($(".hrProcess").hasClass("active")){
				//hr流程
				// loadingBegin(LOAD_HR);
				$.toast("没有这一项");
			}
		}
	});

	//搜索过滤
	$(".search-panel>.search-input>label").click(function(){
		var k = $.trim( $(this).siblings("#search").val() );
		filterProcess(k);
	});

	//
	$(".search-panel>.search-input>input#search").bind("input propertychange", function() {
		var k = $.trim( $(this).val() );
		filterProcess(k);
	});
	
	$('body').on('click','[data-href]',function(e){
		var href = $(this).data("href");
		window.location.href = href;
	});
});
//判断非空
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
/*数据加载的部分*/

/*
	OA/HR我的申请
*/
function loadOaAndHrMyApply(){
	loadingBegin(LOAD_BOTH);
	getMyApply(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
		insertOaAndHrProcess(r,"OA","#myApplyBtn","我的申请");
		getHrProcesses("Sended",PROCESS_PAGENO,PROCESS_PAGESIZE,PROCESS_HAS_STATE_END,function(r){
			insertOaAndHrProcess(r,"HR","#myApplyBtn","我的申请");
		},false);
	});
}

/*
	OA我的申请
*/
function loadOaMyApply(){
	//oa流程
	loadingBegin(LOAD_OA);
	getMyApply(PROCESS_PAGENO,PROCESS_PAGESIZE,function(r){
		insertOaProcess(r,"#myApplyBtn","我的申请");
	});
}

/*
	HR我的申请
*/
function loadHrMyApply(){
	//hr流程
	loadingBegin(LOAD_HR);
	getHrProcesses("Sended",PROCESS_PAGENO,PROCESS_PAGESIZE,PROCESS_HAS_STATE_END,function(r){
		insertHrProcess(r,"#myApplyBtn","我的申请");
	},false);
}







/*
	请求HR的数据
	flag : Sended 我的申请 ； UnRead 待我审 ； Readed 我已审
	pageNo : 默认 1
	pageSize : 默认 10
	hasStateEnd : 默认 1 ：我的申请 和 我已审 是否包含办结数据
*/
function getHrProcesses(flag,pageNo,pageSize,hasStateEnd,suc,err)
{
	var para = new Object();
	if(flag){
		para.flag = flag;
	}
	if(pageNo){
		para.pageNo = pageNo;
	}
	if(pageSize){
		para.pageSize = pageSize;
	}
	if(hasStateEnd){
		para.hasStateEnd = hasStateEnd;
	}

	// 请求的时候加搜索
	para.title = $("#search").val();

	var curUrl = makeHRUrl("/portal/pt/ynfaction/hrsswfmqry/getHrssWfm");

	hrAjax(curUrl,para,suc,function(){
		errFunc("OA");
	});
}

/*
	获取OA的流程，我的申请
*/
function getMyApply(pageNo,pageSize,func)
{
//	var u = "km/review/km_review_index/kmReviewIndex.do?method=list&q.mydoc=create&orderby=docCreateTime&ordertype=down";
	var u = "sys/lbpmmonitor/sys_lbpmmonitor_person/SysLbpmMonitorPerson.do?method=listChildren&q.myDoc=approval&orderby=fdCreateTime&ordertype=down&s_ajax=true";
	u = addPagePara(u,pageNo,pageSize);
	var curUrl = makeUrl(u);
	getOaProcess(curUrl,func);
}

/*
	获取OA的流程，待我审
*/
function getMyApproval(pageNo,pageSize,func)
{
//	var u = "km/review/km_review_index/kmReviewIndex.do?method=list&q.mydoc=approval&orderby=docCreateTime&ordertype=down";
	var u = "sys/lbpmmonitor/sys_lbpmmonitor_person/SysLbpmMonitorPerson.do?method=listChildren&q.myDoc=approval&orderby=fdCreateTime&ordertype=down&s_ajax=true";
	u = addPagePara(u,pageNo,pageSize);
	var curUrl = makeUrl(u);
	getOaProcess(curUrl,func);
}

/*
	获取OA的流程，我已审
*/
function getMyApproved(pageNo,pageSize,func)
{
//	var u = "km/review/km_review_index/kmReviewIndex.do?method=list&q.mydoc=approved&orderby=docCreateTime&ordertype=down";
	var u ="sys/lbpmmonitor/sys_lbpmmonitor_person/SysLbpmMonitorPerson.do?method=listChildren&q.myDoc=approved&orderby=fdCreateTime&ordertype=down&s_ajax=true"
	u = addPagePara(u,pageNo,pageSize);
	var curUrl = makeUrl(u);
	getOaProcess(curUrl,func);
}


/*
	获取OA的流程，已办
*/
function getMyDone(pageNo,pageSize,func)
{
	var u = "sys/notify/sys_notify_todo/sysNotifyTodo.do?method=mngList&oprType=done";
	u = addPagePara(u,pageNo,pageSize);
	var curUrl = makeUrl(u);
	getOaProcess(curUrl,func);
}

/*
	获取OA的流程，待阅
*/
function getMyDoing(pageNo,pageSize,func)
{
	var u = "sys/notify/sys_notify_todo/sysNotifyTodo.do?method=mngList&oprType=doing&fdType=2";
	u = addPagePara(u,pageNo,pageSize);
	var curUrl = makeUrl(u);
	getOaProcess(curUrl,func);
}

/*
	OA流程获取
*/
function getOaProcess(url,func){
	commonGet(url,null,function(r){
		if(func) func(r);
	},function(){
		errFunc("OA");
	});
}

/*
	添加分页的参数
*/
function addPagePara(u,pageNo,pageSize)
{
	return  u + "&pageNo=" + pageNo + "&pageSize=" + pageSize;
}



/*************** 流程内容 HTML 拼接的部分 ***************/

/* 
	单个HR流程拼接成对应的HTML 
*/
// function htmlHrProcess(r){
// 	var html = '<li>\
// 					<a href="'+makeHRUrl(r.url)+'">\
// 	        			<div class="item-content">\
// 							<div class="item-inner">\
// 					          <div class="item-title">\
// 					          	<span class="tit">\
// 					          		<span class="type type-cg">'+r.flowState+'</span>'
// 					          		+r.title+
// 					          		'</span>\
// 					          	<div class="item-subtitle">'+r.billtype+'<span>HR</span></div>\
// 					          </div>\
// 					          <div class="item-after">\
// 					          	<div class="user-name">'+r.submitor+'</div>\
// 					          	<div class="date-time">'+r.submitDate+'</div>\
// 					          </div>\
// 					        </div>\
// 	        			</div>\
// 	        		</a>\
//         		</li>';
//     return html;
// }

/* 
	流程数组拼接成对应的HTML 
*/
function htmlHrProcesses(r)
{
	var result = false;
	if(r.result)
	{
		result = '';
		for(var i=0; i<r.data.length;i++)
		{
			var obj = toProcessObj(r.data[i],"HR",false,false)
			result += htmlProcess(obj);
		}
	}
	else{
		result = "ERR";	
	}
	return result;
}

/* 
	单个HR流程拼接成对应的HTML 
*/
function htmlProcess(r){
	//根据状态设置不同样式
	var status = r.flowState,
		cls = "type-cg";
	if(!isNullOrEmpty(status)){
		switch(status){
			case '进行中':
				cls = "type-cg";
			break;
			case '待审':
				cls = "type-ds";
			break;			
			case '驳回':
				cls = "type-bh";
			break;
			case '废弃':
				cls = "type-fq";
			break;
			case '结束':
				cls = "type-js";
			break;
			case '已反馈':
				cls = "type-fk";
			break;
			default:
				cls = "type-cg";
		}
	}
	var html = '<li>\
					<a data-href="'+r.url+'">\
	        			<div class="item-content">\
							<div class="item-inner">\
					          <div class="item-title">\
					          	<span class="tit">\
					          		<span class="type '+cls+'">'+r.flowState+'</span>\
					          		<span class="processTitle">'+r.title+'</span>'+
					          		'</span>\
					          	<div class="item-subtitle">'+r.billtype+'<span>'+r.proType+'</span></div>\
					          </div>\
					          <div class="item-after">\
					          	<div class="user-name">'+r.submitor+'</div>\
					          	<div class="date-time">'+r.submitDate+'</div>\
					          </div>\
					        </div>\
	        			</div>\
	        		</a>\
        		</li>';
    return html;
}

/* 
	流程数组拼接成对应的HTML 
*/
function htmlOaProcesses(r,type,title)
{
	var result = false;
	result = '';
	for(var i=0; i<r.datas.length;i++)
	{
		var obj = toProcessObj(r.datas[i],"OA",type,title)
		result += htmlProcess(obj);	
	}
	return result;
}

/*
	对OA流程点击请求结果的处理
*/
function insertOaProcess(r,tabName,title)
{
	log(r,tabName);
	var html = htmlOaProcesses(r,tabName,title);
	if(html){
		html = '<ul>'+html+'</ul>';
		$(tabName).html(html);
	}
	else{
		$(tabName).html(htmlDefault(title));	
	}
	commonRequestEnd();
}

/*
	对OA流程点击请求结果的处理
*/
function insertHrProcess(r,tabName,title){
	log(r,tabName);
	var html = htmlHrProcesses(r);
	if(html == false){
		$(tabName).html(htmlDefault(title));
		commonRequestEnd();
	}
	else if("ERR" == html){
		commonRequestEnd();
		exceptionFunc("HR");
	}
	else{
		html = '<ul>'+html+'</ul>';
		$(tabName).html(html);
		commonRequestEnd();
	}
	
}

/* 
	默认为空的HTML 
*/
function htmlDefault(title)
{
	return '<div class="empty-block">\
				<img src="../../images/common/empty.png" class="empty-img" />\
				<p id="tips">暂无'+title+'相关流程</p>\
			</div>';
}

/*
	处理OA以及HR合起来的流程
*/
function insertOaAndHrProcess(r,type,tabName,title)
{
	if("OA" == type)
	{
		//处理OA的返回结果
		if( !hr_oa_list.hasHrData )
		{
			hr_oa_list.list = new Array();
		}
		for(var i=0; i<r.datas.length ;i++)
		{
			var obj = toProcessObj(r.datas[i],"OA",tabName,title);
			hr_oa_list.list.push(obj);
		}
		hr_oa_list.hasOaData = true;
	}
	else if("HR" == type )
	{
		//处理HR的返回结果
		if( !hr_oa_list.hasOaData )
		{
			hr_oa_list.list = new Array();
		}
		if(r.result){
			for(var i=0; i<r.data.length ;i++)
			{
				var obj = toProcessObj(r.data[i],"HR",tabName,title);
				hr_oa_list.list.push(obj);
			}
		}
		else{
			hr_oa_list.hrException = true;
		}
		hr_oa_list.hasHrData = true;
		if(hr_oa_list.hasHrData && hr_oa_list.hasOaData)
		{
			hr_oa_list.list = sortArrayDesc(hr_oa_list.list,"submitDate");
			htmlHrAndOrProcesses(hr_oa_list.list,tabName,title);
		}	
	}
}

/*
	把OA和HR的流程排序，进行拼接
*/
function htmlHrAndOrProcesses(list,tabName,title)
{
	var result = "";
	for(var i=0; i<list.length;i++)
	{
		result += htmlProcess(list[i]);	
	}
	if(!isEmpty(result)){
		var html = '<ul>'+result+'</ul>';
		$(tabName).html(html);
	}
	else{
		$(tabName).html(htmlDefault(title));
	}
	commonRequestEnd();
	if(hr_oa_list.hrException){
		exceptionFunc("HR");
	}
	hr_oa_list = new Object();
}

/*
	把OA、HR接口请求到的数据转化为通用的流程格式
*/
function toProcessObj(para,oaOrHr,type,title)
{
	var r = new Object();
	if("OA" == oaOrHr && true == para.oaFlow)
	{
		r = para;
		r.url = makeUrl(r.url);
	}
	else if("OA" == oaOrHr && !para.oaFlow)
	{
		
		var r = new Object();
		for(var i  in  para)
		{
			var p = para[i];
			if("status"==p.col)
			{
				r.flowState = $.trim( $("<p>"+p.value+"</p>").text() );
			}
			if("created"==p.col)
			{
				r.submitDate = p.value;
			}
			if("label"==p.col){
				r.title = p.value;
			}
			if("summary" == p.col){
				r.billtype = p.value;
			}
			if("creator" == p.col){
				r.submitor = p.value;	
			}
			if("href" == p.col){
				// r.url = makeUrl("km/review/km_review_main/kmReviewMain.do?method=view&fdId="+p.value+"&_mobile=1");
				if("#doingBtn" == type || "#doneBtn" == type ){
					r.url = p.value;
				}
				else{
					r.url = makeUrl(p.value);	
				}
				
			}

			if("modelNameText" == p.col){
				//代表这是已办和待阅
				r.billtype = title;
				r.flowState = title;
			}
		}
	}
	else if("HR" == oaOrHr)
	{
		r = para;
		//时间格式的转换
		var timeSplited = r.submitDate.split(" ");
		if(timeSplited.length > 1){
			r.submitDate = timeSplited[0];
		}
		if(!r.flowState){
			r.flowState = "进行中";
		}
		else if(r.flowState == "Run"){
			r.flowState = "进行中";
		}
		else if(r.flowState == "End"){
			r.flowState = "结束";	
		}
		else if(r.flowState == "Suspended"){
			r.flowState = "挂起";	
		}
		else if(r.flowState == "Cancellation"){
			r.flowState = "取消";	
		}

		r.url = makeHRUrl(r.url);
	}
	r.proType = oaOrHr;
	return r;
}

/*
	根据关键字完成对前台页面的搜索，关键字 k 用来过滤
*/
function filterProcess(k)
{
	var curTabContent = $(".process-list-block>div.active");
	curTabContent.find("ul>li").each(function(){
		var liContent = $(this);
		var title = liContent.find(".processTitle").text();
		if( title.indexOf(k) >= 0 )
		{
			liContent.removeClass("hidden");
		}
		else{
			liContent.addClass("hidden");
		}
	});
}

/*
	请求出错的情况
*/
function errFunc(title){
	commonRequestEnd();
	$.modal({
		title:"提示",
		text: title+"数据加载失败，请刷新页面",
		buttons:[
			{
				text:"刷新",
				onClick:function()
				{
					//显示页面并弹出密码框
					window.location.reload();
				}
			},
			{
				text:"取消",
				onClick:function()
				{

				}
			}
		]
	});
}

function exceptionFunc(title){
	$.modal({
		title:"提示",
		text: title+"数据加载异常，请刷新页面",
		buttons:[
			{
				text:"刷新",
				onClick:function()
				{
					//显示页面并弹出密码框
					window.location.reload();
				}
			},
			{
				text:"取消",
				onClick:function()
				{

				}
			}
		]
	});
}

/*
	正在加载开始
*/
function loadingBegin(t){
//	if(1==t){
//		commonRequestBegin("正在加载OA协同办公的流程数据");
//	}else if(2==t){
//		commonRequestBegin("正在加载HR人力资源流程数据");
//	}
//	else if(3==t){
//		commonRequestBegin("正在加载OA协同办公以及HR人力资源的流程数据");
//	}
} 

