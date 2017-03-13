/*
	HR系统的ajax
*/
function hrAjax(url,data,suc,err)
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