<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<script>seajs.use(['theme!portal']);</script>
		<link type="text/css" rel="stylesheet"
			href="${LUI_ContextPath}/third/mail/coremail/coremail.css?v=1.9" />
		<script type="text/javascript">
			Com_IncludeFile("jquery.js");
		</script>
		
		<div class="lui_dataview_classic" style="display: none;">
			<div class="lui_dataview_classic_row clearfloat"
				style="padding-left: 8px; line-height: 35px; font-weight: normal; color: #333;">
			<span style="float: left; cursor: pointer;"><a
				onclick="location.reload();"><img
				src="images/refresh.png"
				 /></a></span>
			</div>
		</div>


		<c:forEach var="mailInfo" items="${mailInfos}">
			<div class="lui_dataview_classic_row clearfloat lui_coremail">
			<span
				class="lui_coremail_title_icon lui_coremail_content_1"></span>
			<div class="lui_dataview_classic_textArea clearfloat">
				<a title='<c:out value="${mailInfo.subject}"/>' href='<c:url value="${mailInfo.url}" />'
				class="lui_dataview_classic_link" target="_blank"
				> <c:out
				value="${mailInfo.subject}" /> </a></div>
			</div>
		</c:forEach>

		<c:if test="${empty mailInfos}">
			<span style="font-size: 14px;">没有新邮件</span>
		</c:if>

		<script language='javascript'>
	
	//统一门户列表中待办数量
	$(document).ready(function(){
		
	});
	
	
</script>
	</template:replace>
</template:include>