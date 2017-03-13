//代表在开发测试环境

//通用的 ajax方法
function baseAjax(url,type,data,suc,err)
{
	$.ajax({
		url:url,
		type:type,
		data:data,
		dataType:"json",
		timeout:30000,
		async:true,
		success:function(r){
			if(r.errCode && r.errCode == "200")
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

//通用的GET
function commonGet(url,data,suc,err){
	baseAjax(url,"GET",data,suc,err);
}

//通用的POST
function commonPost(url,data,suc,err){
	baseAjax(url,"POST",data,suc,err);
}

//把json格式的结果转化为字符串，输出到控制台
function logJsonText(data){
	console.log(JSON.stringify(data));
}

//判断返回结果有没有错误
function noError(data){
	if(data.errCode == "0" && data.errMsg == "ok"){
		return true;
	}
	else{
		return false;
	}
}

//拼接URL
function makeUrl(res)
{
	var url = window.location.origin+"/"+res;
	if(window.location.href.indexOf("/ekp/") > 0 ){
		url = window.location.origin+"/ekp/"+res;
	}
	//加上这个链接oauth=ekp，先用?号做判断，暂时没问题的。带参数的应该都含有？号。
	// if(url.indexOf("?") >0)
	// {
	// 	url += "&oauth=ekp";
	// } 
	// else{
	// 	url += "?oauth=ekp";
	// }
	return url; 
}

//通用的提醒函数
function commonAlert(msg){
	alert(msg);
}

//页面跳转
function headerTo(url){
	window.location = url;
}

//unicode时间戳格式化
function getLocalTime(p) {
	var today = new Date();
	var date = new Date(p);
	if(date.getFullYear() == today.getFullYear() && date.getMonth() == today.getMonth() && date.getDate() == today.getDate()){
		return date.getHours()+":"+ date.getMinutes();
	}
	else{
		var dateTxt = date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日";
		return dateTxt;	
	}
	
}

//对象转化为字符
function toString(obj)
{
	return JSON.stringify(obj);
}

//获取当前时间字符串
function getCurTime()
{
	var date = new Date();
	return date.getHours()+":"+ date.getMinutes()+":"+date.getSeconds();
}

//获取页面链接hash值
function getHash()
{
	var mhash = window.location.hash;
	if(mhash != null){
		return mhash.replace("#", "")
	}else {
		return '';
	}
}

//设置页面链接hash值
function setHash(val)
{
	window.location.hash = val;
}

//为空判断
function isEmpty(obj){
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


//获取单个Cookie值
function getCookie(cookie_name)
{
    var allcookies = document.cookie;
    var cookie_pos = allcookies.indexOf(cookie_name);   //索引的长度
  
    // 如果找到了索引，就代表cookie存在，
    // 反之，就说明不存在。
    if (cookie_pos != -1)
    {
        // 把cookie_pos放在值的开始，只要给值加1即可。
        cookie_pos += cookie_name.length + 1;      //这里容易出问题，所以请大家参考的时候自己好好研究一下
        var cookie_end = allcookies.indexOf(";", cookie_pos);
  
        if (cookie_end == -1)
        {
            cookie_end = allcookies.length;
        }
  
        var value = unescape(allcookies.substring(cookie_pos, cookie_end));         //这里就可以得到你想要的cookie的值了。。。
    }
    return value;
}

function log(r,title){
	console.log("----"+title+"--B--");
	logJsonText(r);
	console.log("----"+title+"--E--");
}



/*
	数组按照指定字段进行降序排列
*/
function sortArrayDesc(arr,field)
{
	for(var i=0 ; i<arr.length-1 ; i++)
	{
		for(var j=i+1 ; j<arr.length ; j++)
		if(!time1IsLateThanTime2(arr[i][field],arr[j][field]))
		{
			var obj = arr[i];
			arr[i] = arr[j];
			arr[j] = obj;
		}
	}
	return arr;
}

/*
	时间比较大小
*/
function time1IsLateThanTime2(timeX,timeY){
	var dateX = new Date(timeX);
	var dateY = new Date(timeY);
	return dateX > dateY;
}

/***********/
function commonRequestBegin(title){
	 var titleInfo = title?title:"正在查询数据";
	// $.modal({
	// 	title:"提示",
	// 	text: titleInfo,
	// 	extraClass:"requestBegin"
	// });
	$.showPreloader(titleInfo);
}

function commonRequestEnd(){
	// $.closeModal(".requestBegin");
	$.hidePreloader();
}

//返回上一页
$('.bar-nav').on('click','.doa-go-back',function(e){
	e.preventDefault();
	window.history.go(-1);
});

