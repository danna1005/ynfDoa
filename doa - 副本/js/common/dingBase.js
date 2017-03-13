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
		        'biz.navigation.setIcon']
		});
	    
		
		dd.ready(function() 
		{
//			setDingLeft();
			executeIfExist("setDingTopMenu");
//			setDingLeft();
//			setDingIcon();
		});

		dd.error(function(r) {
			logJsonText(r);
//			alert("ddError");
//			alert(JSON.stringify(r));
		});

	},function(r){
		logJsonText("dingMsg POST失败"+JSON.stringify(r));
//		alert("dingMsg POST失败"+JSON.stringify(r));
	});

	$("body").on("click","[data-chat-id]",function(){
		var btn = $(this);
		var cid = btn.attr("data-chat-id");
		wakeChat(cid);
	});

	//需要openLink操作的链接
	$('body').on('click','a.openLink-true',function(e){
		var url = $(this).attr("href");
		if(url.indexOf("dingtalk://")==-1){
			e.preventDefault();
			openLink(url);
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
	    onFail : function() {}
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
		else{
//			alert("没有"+func+"函数");
		}
	}
	catch(e)
	{
//		alert("没有"+func+"函数，并产生异常");
	}
}
////设置菜单
//function setDingTopMenu(){
//	dd.biz.navigation.setMenu({
//        backgroundColor : "#FF6600",
//        items : [
////            {
////                "id":"1",//字符串
//////            "iconId":"file",//字符串，图标命名
////              "text":"帮助"
////            },
//            {
//                "id":"2",
////            "iconId":"photo",
//              "text":"相机"
//            },
//            {
//                "id":"3",
////            "iconId":"setting",
//              "text":"设置",
//            },
//            {
//                "id":"4",
////            "iconId":"time",
//              "text":"关闭"
//            }
//        ],
//        onSuccess: function(data) 
//        {
//        	if(data.id == 4)
//        	{
//        		dd.biz.navigation.close({
//        		    onSuccess : function(result) {
//        		       alert("您触发了关闭按钮，已经执行了关闭操作"+JSON.stringify(result));
//        		    },
//        		    onFail : function(err) {
//        		    	
//        		    }
//        		})
//        	}
//        	else{
//        		alert("您点击了"+data.id+"号按钮");
//        	}
//        },
//        onFail: function(err) 
//        {
//        	alert("功能出错");
//        }
//    });
//}

function setDingLeft()
{
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '回',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	    	alert("返回事件被调用");
	    	//如果control为true，则onSuccess将在发生按钮点击事件被回调
	    },
	    onFail : function(err) {}
	});
}

//function setDingIcon()
//{
//	dd.biz.navigation.setIcon({
//	    showIcon : true,//是否显示icon
//	    iconIndex : 99,//显示的iconIndex,如上图
//	    onSuccess : function(result) {
//	        alert("点击帮助");
//	    },
//	    onFail : function(err) {
//	    //jsapi调用失败将会回调此函数
//	    }
//	});
//}



