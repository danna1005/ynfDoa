//代表在开发测试环境

//通用的 ajax方法
function baseAjax(url,type,data,suc,err)
{
	$.ajax({
		url:url,
		type:type,
		data:data,
		dataType:"json",
		async:true,
		success:function(r){
			if(suc) suc(r);
		},
		error:function(r){
			logJsonText("connect fail @ "+url);
			if(err) err(r);
			logJsonText("拉取数据失败，99.9% 的可能是需要先登录。"+url);
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
		var url = window.location.origin+"/ekp/"+res;
	}
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
	var date = new Date(p);
	var dateTxt = date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日";
	return dateTxt;
}

//对象转化为字符
function toString(obj)
{
	return JSON.stringify(obj);
}