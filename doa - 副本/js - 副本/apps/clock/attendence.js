$(document).ready(function()
{
	//提取数据
	loadAttendenceData();
	//忽略
	$("body").on("click",".ignoreBtn",function(){
		var btn = $(this);
		var url = btn.data("get-href");
		commonGet(url,null,function(r){
			if(r.data && r.data.success == true){
				btn.closest(".item-after").html("已忽略");
			}else{
				var eMsg = r.errMsg;
				if(r.data && r.data.error){
					eMsg+=":"+r.r.data.error;
				}
				commonAlert(eMsg);
			}
		},false);
	});
	//处理
	$("body").on("click" , ".dealBtn" , function()
	{
		var btn = $(this);
//		var url = btn.data("get-href");
//		commonGet(url,null,function(r){
//			if(r.data && r.data.success == true)
//			{
//				//btn.closest(".item-after").html("已处理");
//			}else{
//				var eMsg = r.errMsg;
//				if(r.data && r.data.error){
//					eMsg+=":"+r.r.data.error;
//				}
//				commonAlert(eMsg);
//			}
//		},false);
		var approvalUrl = btn.data("approval-href")
		btn.attr("href",approvalUrl);
		btn.click();
	});
	
	//应用帮助
	$('.page').on('click','.help-icon',function(){
		$('.prompt-panel').fadeIn('slow');		
	});
	
	$('.prompt-panel').on('click','.prompt-close',function(){
		$('.prompt-panel').fadeOut();		
	});
});

//加载所有的考勤打卡数据
function loadAttendenceData()
{
	var url = makeUrl("/third/doa/doa_attendence/attendence.do?method=listAtten");
	commonGet(url,false,handleAttenData,logJsonText);
}

//处理考勤打卡数据
function handleAttenData(r)
{
	if(noError(r))
	{
		$("#abnormalCnt").html(r.data.abnormalCnt);
		fillAbnormalAttenData(r.data);
		if(r.data.attenAppUrl)
		{
			$("#attenAppUrl").attr("href",r.data.attenAppUrl);
		}
	}
	else
	{
		logJsonText(r);
	}
}

//打卡异常的数据填充到打卡异常里面去
function fillAbnormalAttenData(data)
{
	var list = data.abnormalAttenList
	var approvalUrl = data.approvalUrl;
	var html = "";
	for(var i = 0; i<list.length; i++)
	{
		var item = list[i];
		var titleResult = false;
		var titleClass = false;
		var checkType = false;
		var checkTimeName="打卡时间";
		if(item.timeResult == "Late" || item.timeResult == "SeriousLate" ){
			titleResult = "迟到";
			titleClass = "late";
		}else if(item.timeResult == "Early" ){
			titleResult = "早退";
			titleClass = "early";
		}else if(item.timeResult == "NotSigned" ){
			titleResult = "缺卡";
			titleClass = "missing";
		}
		if(item.checkType == "OnDuty"){
			checkType = "上班卡";
			checkTimeName="上班时间";
		}else if(item.checkType == "OffDuty"){
			checkType = "下班卡";
			checkTimeName="下班时间";
		}
		html += joinAttendenceHtml(titleResult,titleClass,checkTimeName,checkType,item,approvalUrl);
		
	}
	$("#abnormalAttenList").html(html);
	if(list<1){
		$('.empty-block').removeClass('dis-none');	    	 
	}else{
	 	$('.empty-block').addClass('dis-none');
	}
}

//输入几个变量生成html
function joinAttendenceHtml(titleResult,titleClass,checkTimeName,checkType,item,approvalUrl)
{	
	var checkTime = item.userCheckTime;
	var status = item.status;
	var ignoreUrl = makeIgnoreUrl(item.id);
	var dealUrl = makeDealUrl(item.id);
	var statusHtml = false;
	if(status == 0)
	{
		statusHtml =  '<a class="ignore dealBtn" href="#" data-get-href="' + dealUrl + '" data-approval-href="'+approvalUrl+'">\
		          			<img src="../../../images/apps/clock/chuli.png" style="height:1.5rem;widht:1.5rem;"/></a>\
		          	   <a href="#" class="ignoreBtn" data-get-href="' + ignoreUrl + '">\
		          	   		<img src="../../../images/apps/clock/hulue.png" style="height:1.5rem;widht:1.5rem;"/></a>';
	}
	else if(status == 1)
	{
		statusHtml =  '已忽略';
	}
	else if(status == 2)
	{
		statusHtml =  '已处理';
	}
	var html = '<li class="item-content">\
			        <div class="item-media">\
			        	<div class="round ' + titleClass + '">' + titleResult + '</div>\
			        </div>\
			        <div class="item-inner">\
			           <div class="item-title">\
			           	  <div class="list-content-title">' + checkType + '</div>\
			          	  <div class="list-content-txt">'+checkTimeName+':' + checkTime + '</div>\
			          </div>\
			          <div class="item-after">'
			          +statusHtml+
			          '</div>\
			        </div>\
			     </li>';
	return html;
}

//忽略这一条考勤异常的链接
function makeIgnoreUrl(id)
{
	var url = makeUrl("third/doa/doa_attendence/attendence.do?method=ignoreAtten&id="+id);
	return url;
}

//忽略这一条考勤异常的链接
function makeDealUrl(id)
{
	var url = makeUrl("third/doa/doa_attendence/attendence.do?method=dealAtten&id="+id);
	return url;
}
