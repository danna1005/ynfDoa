<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="java.util.*,
	java.net.URLDecoder,
	com.landray.kmss.util.*,
	com.landray.kmss.third.ding.action.DingJsapiAction,
	com.landray.kmss.third.ding.constant.*,
	com.landray.kmss.third.ding.oms.*
	" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
<title><bean:message bundle="third-ding" key="third.ding.ding.loading" /></title>
</head>
<%
DingApiService dingApiService = new DingApiServiceImpl();

String appId= request.getParameter("appId");
String fdTodoId= request.getParameter("fdTodoId");
//String viewUrl="/sys/notify/sys_notify_todo/sysNotifyTodo.do?method=view&fdId="+fdTodoId+"&oauth=ekp";
//String viewUrl="/sys/notify/sys_notify_todo/sysNotifyTodo.do?method=view&fdId="+fdTodoId+"";
String viewUrl="/third/ding/sso/pc_redirect.jsp?type=todo&id="+fdTodoId+"";
if (StringUtil.isNotNull(DingConstant.DING_NOTIFY_DOMAIN)) {
	viewUrl = DingConstant.DING_NOTIFY_DOMAIN + viewUrl;
} else {
	viewUrl = StringUtil.formatUrl(viewUrl);
}

%>
<body>

<script type="text/javascript">
var _ctx = "<%= request.getContextPath() %>";
var _config = <%= dingApiService.getConfig(request.getRequestURL().toString(),request.getQueryString()) %>;
var _appId="<%=appId%>";
var _scode="";

function dingOpen(){

	document.getElementById("_load").innerHTML="请在弹开的浏览器中查看文档内容";
	
	DingTalkPC.biz.util.openLink({
		url: "<%=viewUrl%>&scode="+_scode,//要打开链接的地址

		onSuccess : function(info) {
            logger.i('biz.ding info: ' + JSON.stringify(info));
		},
		onFail : function(err) {
            logger.e('biz.ding fail: ' + JSON.stringify(err));
		}
	})

}

</script>
<script type="text/javascript" src="js/zepto.min.js"></script>
<script type="text/javascript" src="http://g.alicdn.com/dingding/dingtalk-pc-api/2.3.1/index.js">
</script>
<script type="text/javascript" src="js/logger.js"></script>
<script type="text/javascript" src="js/apps.js">
</script>

<div id="_load">
	正在获取授权信息，请稍候...
</div>
</body>

</html>
