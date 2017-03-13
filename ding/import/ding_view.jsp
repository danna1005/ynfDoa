<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,
	com.landray.kmss.util.*,
	com.landray.kmss.common.forms.ExtendForm,
	com.landray.kmss.third.ding.action.DingJsapiAction" %>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="mainModelForm" value="${requestScope[param.formName]}" scope="request"/>

		<%
		//在钉钉的特殊处理 add by wubing date 2015-09-05
		if(isDingInEnter(request.getHeader("user-agent"))){
			ExtendForm efm = (ExtendForm)request.getAttribute("mainModelForm");
			String docCreatorId = DingJsapiAction.getDocCreatorId(efm.getFdId(),efm.getModelClass().getName());
			if(docCreatorId.equals(UserUtil.getUser().getFdId())){
		%>

		<c:if test="${(mainModelForm.docStatus>='20' && mainModelForm.docStatus<'30') || mainModelForm.docStatus == '11'}">
		<div class="muiDing"><i class="mui mui-ding" onclick="dingMsg()"></i></div>
			<script type="text/javascript">
				function dingMsg(){
					var url = "<c:url value="/third/ding/jsapi/dingmsg.jsp" />";
					url = Com_SetUrlParameter(url, "fdModelId", "${mainModelForm.fdId}");
					url = Com_SetUrlParameter(url, "fdModelName", "${mainModelForm.modelClass.name}");
					Com_OpenWindow(url);
				}
			</script>
		</c:if>

		<%}
		}%>

<%!
public boolean isDingInEnter(String useragent){
	String USERAGENG_DINGTALK="DingTalk";
	if(useragent.indexOf(USERAGENG_DINGTALK)!=-1){
		return true;
	}
	return false;
}

public String getEncodeString(String str)throws Exception{
	return java.net.URLEncoder.encode(str,"UTF-8");
}

%>