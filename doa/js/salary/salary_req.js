/* 
我的薪酬数据请求实现
*/
var password = false;

//请求的链接
var salaryUrl = makeHRUrl("/portal/pt/ynfaction/payslip/getPaySlip"); 
var resetPwdUrl = makeHRUrl("/portal/pt/ynfaction/payslip/resetQueryPW");

//选择器
var pwdSubmitBtn = ".search-btn";
var pwdResetBtn = ".reset-btn";
var pwdValInput = "[type='password']";

$(document).ready(function(){
	//第一次请求 带密码
	$('.content-block').on('click','a.search-btn',function(e)
	{
		e.preventDefault();
		var monthBegin = getMonthAdd(-3);
		var monthEnd = getMonthAdd(-1);
		submitPwdFunc(monthBegin,monthEnd,true);
	});

	//重置密码的点击
	$('.content-block').on('click','a.reset-btn',function(e){
		e.preventDefault();
		resetPassword();
	});




	//一个月的数据
	$('#one-month').click(function(e)
	{
		var monthBegin = getMonthAdd(-1);
		var monthEnd = getMonthAdd(-1);
		submitPwdFunc(monthBegin,monthEnd,false);
		e.preventDefault();
	});

	//三个月的数据
	$('#three-month').click(function(e)
	{
		var monthBegin = getMonthAdd(-3);
		var monthEnd = getMonthAdd(-1);
		submitPwdFunc(monthBegin,monthEnd,false);
		e.preventDefault();
	});

	//六个月的数据
	$('#six-month').click(function(e){
		var monthBegin = getMonthAdd(-6);
		var monthEnd = getMonthAdd(-1);
		submitPwdFunc(monthBegin,monthEnd,false);
		e.preventDefault();
	});

});


/* 
	进行工资数据请求的提交,
	最后一个参数 usePwd 代表是否使用密码 
*/
function submitPwdFunc(beginMonth,endMonth,usePwd)
{
	var proClass = "processing";
	if($("body").hasClass(proClass))
	{
		logSalaryJsonText("正在查询数据,莫着急","莫急莫急");
	}
	else
	{
		password =  $.trim($(pwdValInput).val());		
		if(isEmpty(password))
		{
			emptyPwdAlert();
		}
		else
		{
			//password = hex_md5(password);
			$("body").addClass(proClass);
			requestBegin();
			var para = new Object();
			//需要修改
			// para.LtpaToken = getCookie("LtpaToken");
			if(usePwd)
			{
				
				para.password = password;
			}
			para.beginMonth = beginMonth;//"2016-03";
			para.endMonth = endMonth;//"2016-12";
			salaryAjax(salaryUrl,para,function(data)
			{
				logSalaryJsonText(data,"请求数据");
				if(true == data.result)
				{
					if(true == usePwd)
					{
						$.closeModal('.popup-pwd');
					}
					//处理数据的JS代码
					var dataHandled = handleData(data);
					htmlFirstLevel(dataHandled);
					htmlPopUps(dataHandled);
					requestEnd();
				}
				else
				{
					if(usePwd && "E108"==data.errcode)
					{
						$.closeModal('.popup-pwd');
					}
					$("#FIRST-LEVEL").html("");
					requestEnd();
					$.alert("<div style='text-align:left;text-indent:1.5rem'>"+data.errMsg+"</div>","提示");
				}
				$("body").removeClass(proClass);
			},function(){
				$("body").removeClass(proClass);
				$.alert("接口尚未开放","提示");
				requestEnd();
			});
		}
	}
}

//重置密码
function resetPwdFunc(){
	var para = new Object();
	//发请求啦
	salaryAjax(resetPwdUrl,para,function(data)
	{
		logSalaryJsonText(data);
		if(true == data.result){
			$.alert(data.data, '提示');
		}
		else{
			$.alert("<div style='text-align:left;text-indent:1.5rem'>"+data.errMsg+"</div>", '提示');		
		}
	},function(){
		$.alert("接口尚未开放", '提示');		
	});
}


//密码为空的提示
function emptyPwdAlert(){
	$.alert("请输入查询密码", '提示');
}

/****/
function salaryAjax(url,data,suc,err)
{
	$.ajax({
		url:url,
		type:"POST",
		data:data,
		dataType:"json",
		timeout:30000,
		async:true,
		//薪资查询需要加上，不然不能记住密码，以及不能传cookie
		xhrFields:
		{
	    	withCredentials:true
	  	},
	  	crossDomain:true,
	  	// headers : {
	  	// 	'Access-Control-Allow-Origin':'*',
	  	// },
		//
		success:function(r){
			if(r.errCode == "200")
			{
				logJsonText("监听到了200 ，需要登录:"+url);
			}
			if(suc) suc(r);
		},
		error:function(xhr,textStatus)
		{
			logJsonText("|------------");
			if(xhr.status == 408)
			{
				logJsonText("# 连接超时");
			}
			else if(xhr.status == 500)
			{
				logJsonText("# 服务器内部错误");
			}
			else if(xhr.status == 303)
			{
				logJsonText("# 重定向");
			}
			logJsonText("链接错误 @ status["+ xhr.status+"]"+url);
			logJsonText("------------|");
			if(err) err(textStatus);
		}
	});
}

/***********/
function requestBegin(){
	$.modal({
		title:"提示",
		text: "正在查询数据",
		extraClass:"requestBegin"
	});
}

function requestEnd(){
	$.closeModal(".requestBegin");
}


//重置密码
function resetPassword(){
	$.modal({
			title:"提示",
			text: "是否确定要重置密码",
			buttons:[
				{
					text:"确定",
					onClick:function()
					{
						//发送重置密码邮件
						resetPwdFunc();
						// e.preventDefault();
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

//
function modalErr(errMsg){
	$.modal({
		title:"提示",
		text: errMsg,
		buttons:[
			{
				text:"确定",
				onClick:function()
				{
					//发送重置密码邮件
					resetPwdFunc();
					e.preventDefault();
				}
			}
		]
	});
}





/* 数据的处理模块 */

//获取默认月份
function getDefaultMonth(){
	var date = new Date();
	var dateTxt = date.getFullYear()+(date.getMonth()+1);
	return dateTxt;
}

//获取前几个月的月份数据
function getMonthAdd(monthAdd){
	var date = new Date();
	var curYear = date.getFullYear();
	var curMonth = date.getMonth()+1;
	var resultYear = "";
	var resultMonth = "";
	if( ( Number(curMonth) + Number(monthAdd) ) <= 0 ){
		resultMonth = Number(curMonth) + 12 + Number(monthAdd);
		resultYear = Number(curYear) -1;
	} 
	else{
		resultMonth = Number(curMonth) + Number(monthAdd);
		resultYear = curYear ;	
	}
	if(Number(resultMonth)< 10 ){
		resultMonth = "0"+resultMonth;
	}
	return resultYear + "-" + resultMonth;
}


//将薪资数据整理为 月份=>按类型数组 的结构
function handleData(data)
{	
	var dataHandled = new Object();
	for(var i = 0 ; i<data.data.length ; i++)
	{
		var item = data.data[i];
		var year = getYearFromTitle(item.tital);
		var month = getMonthFromTitle(item.tital);
		
		//获取需要显示的标题，获取这一项的钱数，获取总的钱数
		item.title = getTypeFromTitle(item.tital,true);
		item.money = getMoneyFromTitle(item.detail);
		if(Number(year) >0 && Number(month) > 0 )
		{
			var year_month_t = year+"年"+month+"月";
			var year_month = year+""+month;
			if( isEmpty(dataHandled[year_month]) )
			{
				dataHandled[year_month] = new Object();
				dataHandled[year_month]["title"] = year_month_t;
				dataHandled[year_month]["data"] = new Array();
				dataHandled[year_month]["data"].push(item);
				//这个月的总钱数
				dataHandled[year_month]["money"]=handleMoney(item.money);
			}
			else{
				dataHandled[year_month]["data"].push(item);
				var moneyFloat = parseFloat(item.money) + parseFloat(dataHandled[year_month]["money"]);
				dataHandled[year_month]["money"]=handleMoney(moneyFloat);
			}
		}

	}
	logSalaryJsonText(dataHandled,"数据整理");
	return dataHandled;
}


/*拼接HTML部分的代码 BEGIN *************************************************/
function htmlFirstLevel(data)
{
	var FLhtml = "";
	var cnt = 1;
	for(var key in data)
	{
		item = data[key];
		//第一个默认打开
		var iconClass = "icon-down";
		var contentClass = "hide";
		if(1== cnt){
			// iconClass="icon-down icon-up";
			iconClass="icon-down";
		}
		// else{
		// 	contentClass = "hide";
		// }
		//开头的数据
		var level= '<div class="first-level">'+
						'<div class="item-content">'+
							'<div class="item-inner">'+
								'<div class="item-title">'+item.title+'</div>'+
								'<div class="item-after">实发总金额：<span class="color33">'+item.money+'元</span></div>'+
							'</div>'+
							'<div class="item-media"><i class="icon '+iconClass+'"></i></div>'+
						'</div>'+
						'<div class="list-block month-detail-list  '+contentClass+'">'+
							'<ul>';
		//各项数据
		for(var i =0; i< item.data.length ;i++)
		{
			var id = key+"-"+getTypeFromTitle(item.data[i].tital,false);
			var info = item.data[i];
			level+=
			'<li class="item-content" data-id='+id+'>\
				<div class="item-inner">\
					<div class="item-title">'+info.title+'</div>\
					<div class="item-after"><span class="color33">'+info.money+'元</span></div>\
				</div>\
				<div class="item-media"><i class="icon icon-right"></i></div>\
			</li>';
		}
		level+="</ul></div></div>";
		cnt +=1;
		FLhtml +=level;
	}
	$("#FIRST-LEVEL").html(FLhtml);
}


//弹出的工资详情
function htmlPopUps(data){
	var htmlContent = "";
	for(var key in data)
	{
		var item = data[key];
		for(var i =0; i< item.data.length ;i++)
		{
			var itemInfo = item.data[i];
			//每一项都是一个popup
			var id = key+"-"+getTypeFromTitle(itemInfo.tital,false);
			var htmlItem = 
			'<div class="popup '+id+'">\
		    	<div class="page page-current" style="background: #fff;">\
		    		<header class="bar bar-nav m-header-container">\
						<a class="button button-link button-nav pull-left m-header-return close-popup"><span class="icon icon-left"></span>\
						</a>\
						<div class="title m-header-title">'+itemInfo.title+'</div>\
					</header>\
					<div class="content m-content popup-m-content">\
						<div class="list-block salary-list" style="display:block">\
							<ul>';
			for(var keyItem in itemInfo.detail)
			{
				var moneyInfo = itemInfo.detail[keyItem];
				var htmlMoney =
				'<li class="item-content">\
					<div class="item-inner">\
						<div class="item-title">'+moneyInfo.name+'</div>\
						<div class="item-after">'+moneyInfo.value+'</div>\
					</div>\
				</li>' ;
				htmlItem += htmlMoney;
			}
			htmlItem+="</ul></div></div></div></div>";
			htmlContent += htmlItem;
		}
	}
	$("#SALARY-POPUPS").html(htmlContent);
}
/*拼接HTML部分的代码 END *************************************************/

//2016年 04月;御家汇;季度固定奖金;(人民币) 提取年的信息
function getYearFromTitle(title)
{
	// var year = 2017;
	var year = "-1";
	for(var i = 2000; i< 3000;i++){
		var yearN = i;
		var yearT = i+"年";
		if(title.indexOf(yearT) >=0 ){
			year = yearN;
			break;
		}
	}
	return year;
}

//2016年 04月;御家汇;季度固定奖金;(人民币) 提取年的信息
function getMonthFromTitle(title)
{
	var month = "-1";
	for(var i = 1; i<= 12;i++)
	{
		var monthN = i<10 ? "0" + i : i;
		monthT = monthN +"月";
		if(title.indexOf(monthT) >=0 ){
			month = monthN;
			break;
		}
	}
	//提取月份后进行进一步确定,季度奖金归到当季度最后一个月去
	var type = getTypeFromTitle(title,false);
	if( Number(type) >= 2 && Number(type) <= 4)
	{
		if("01" == month){
			month = "03";
		}
		else if("02" == month){
			month = "06";
		}
		else if("03" == month){
			month = "09";
		}
		else if("04" == month){
			month = "12";
		}
	}
	return month;
}

/*
2016年 04月;御家汇;季度固定奖金;(人民币) 提取资金类型的信息
1 : 月度工资/工厂工资
2 : 季度固定奖金
3 : 季度浮动奖金
4 : 季度业绩突破奖
*/
function getTypeFromTitle(title,returnTitle)
{
	var type = -1;
	var titleReturn = "薪资"
	if( title.indexOf("本部工资")>=0 ||title.indexOf("本部薪资方案")>=0)
	{
		type = 1;
		titleReturn = "月度工资";
	}
	else if( title.indexOf("工厂工资")>=0 )
	{
		type = 1;
		titleReturn = "月度工资";
	}
	else if( title.indexOf("季度固定奖金")>=0){
		type = 2;
		titleReturn = "季度固定奖金";
	}
	else if( title.indexOf("季度浮动奖金")>=0){
		type = 3;
		titleReturn = "季度浮动奖金";
	}
	else if( title.indexOf("季度业绩突破奖")>=0){
		type = 4;
		titleReturn = "季度业绩突破奖";
	}
	else{
		type = 100;
		titleReturn = "薪资";
	}

	//返回文字显示还是数字类型
	if(returnTitle){
		return titleReturn;
	}
	else{
		return type;	
	}
	
}

//获取工资钱数
function getMoneyFromTitle(detail)
{
	var money = -100;
	for(var k in detail)
	{
		var item = detail[k];
		if(item.name.indexOf("实发金额")>=0
			||item.name.indexOf("季度发放金额")>=0
			||item.name.indexOf("实发合计")>=0
			||item.name.indexOf("月度工资合计")>=0 )
		{
			money = $.trim(item.value);
			break;
		}
		else
		{
			money = -99;
		}
	}
	return handleMoney(money);
}

//统一处理金额的小数位
function handleMoney(money)
{
	return parseFloat(money).toFixed(2);
}

function logSalaryJsonText(data,title)
{
	console.log("---"+title+"---BRGIN---");
	console.log(JSON.stringify(data));
	console.log("---"+title+"---END---");
}

