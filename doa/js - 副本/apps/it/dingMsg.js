//钉钉消息的JS
var _config = new Object();
$(document).ready(function(){
	
	var authBaseUrl = "third/doa/doa_ding_auth/dingAuth.do" + "?method=fetchAuth" ;
	var url = makeUrl(authBaseUrl);
	//请求钉钉权限数据
	var data = new Object();
	data.url = window.location.href;
	commonPost(url,data,function(r){
		_config = JSON.parse(r.data);
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
		        'biz.chat.chooseConversationByCorpId']
		});
	    
		
		dd.ready(function() 
		{

		});

		dd.error(function(r) {
			logJsonText(r);
		});

	},false);

	$("body").on("click","[data-chat-id]",function(){
		var btn = $(this);
		var cid = btn.attr("data-chat-id");
		wakeChat(cid);
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