//钉钉消息的JS
var _config = new Object();
$(document).ready(function(){
	
	var authBaseUrl = "third/doa/doa_ding_auth/dingAuth.do" + "?method=fetchAuth" ;
	var url = makeUrl(authBaseUrl);
	//请求钉钉权限数据
	var data = new Object();
	data.url = decodeURIComponent(window.location.href);
	/*var info = window.location.href+" <>  "+data.url;
	console.log(info);
	alert(info);*/
	commonPost(url,data,function(r){
		_config = JSON.parse(r.data);
//		_config = r.data;
		dd.config({
		    agentId: '' ,
		    corpId: _config.corpId,
		    timeStamp: _config.timeStamp,
		    nonceStr: _config.nonceStr,
		    signature: _config.signature,
		    jsApiList: ['runtime.info',
		        'biz.contact.choose',
		        'device.notification.confirm',
		        'device.notification.alert',
		        'device.notification.prompt',
		        'biz.ding.post',
		        'biz.chat.toConversation',
		        'biz.chat.chooseConversationByCorpId',
		        'biz.util.openLink',
		        'biz.navigation.setMenu',
		        'biz.navigation.close',
		        'biz.navigation.setIcon',
		        'biz.util.scan',
		        'biz.navigation.setLeft']
		});
	    
		
		dd.ready(function() 
		{
			executeIfExist("setDingTopMenu");
			executeIfExist("setDingTopLeft");
			//alert("dingding ready");
		});

		dd.error(function(r) {
			logJsonText(r);
			//alert("ddError"+JSON.stringify(r));
		});

	},function(r){
		logJsonText("dingMsg POST失败"+JSON.stringify(r));
		//alert("dingMsg POST失败"+JSON.stringify(r));
	});

	$("body").on("click","[data-chat-id]",function(){
		var btn = $(this);
		var cid = btn.attr("data-chat-id");
		wakeChat(cid);
	});

	//需要openLink操作的链接
	$('body').on('click','a.openLink-true',function(e){
		var btn = $(this);
		var url = "";
		if($("body").hasClass("dataOpenLink"))
		{
			//body加了dataOpenLink的，需要从data-href里面取属性值进行openlink的操作
			url = btn.data("href");
		}
		else
		{
			url = btn.attr("href");
		}
		
		/*alert("URL:"+url);*/
		if(url.indexOf("dingtalk://")==-1 && url!=null && url!="" && url!=''){
			e.preventDefault();
			openLink(url);
		}
		else{
			
		}
	});
	
});

// 根据会话Id唤醒会话
function wakeChat(chatId){
	logJsonText("waking" + chatId);
	// alert(chatId+_config.corpId);
	dd.biz.chat.toConversation({
	    corpId: _config.corpId,  //企业id
	    chatId:chatId,  // 会话Id
	    onSuccess : function(r) 
	    {
			logJsonText(r);	
	    },
	    onFail : function(r) 
	    {
			logJsonText(r);
	    }
	});
}

//打开报表窗口
function openLink(url){
	dd.biz.util.openLink({
		url: url,//要打开链接的地址
	    onSuccess : function(result) {
	    },
	    onFail : function() {
	    	/*alert("openlink fail");*/
	    }
	});
}

//如果存在就执行
function executeIfExist(func)
{
	try{
		if(eval(func))
		{
			eval(func+"()");
		}
		else
		{
			
		}
	}
	catch(e)
	{
		
	}
}

//扫码函数
function dingScanCode(type,suc,err)
{
	if(type!="qrCode" && type!="barCode")
	{
		console.log("扫码的类型["+type+"]不符合规范");
	}
	else
	{
		dd.biz.util.scan({
		    type:type,//type为qrCode或者barCode
		    onSuccess:function(data)
		    {
		    	//onSuccess将在扫码成功之后回调
		    	if(suc)
		    	{
		    		suc(data);
		    	}
		    },
		    onFail:function(e) 
		    {
		    	if(err)
		    	{
		    		err(e);
		    	}
		    }
		});
	}
}





