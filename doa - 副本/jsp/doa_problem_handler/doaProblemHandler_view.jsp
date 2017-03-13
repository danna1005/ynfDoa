<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/third/doa/doa_problem_handler/doaProblemHandler.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('doaProblemHandler.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/doa/doa_problem_handler/doaProblemHandler.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('doaProblemHandler.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaProblemHandler"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.handler"/>
		</td><td width="35%">
			<c:out value="${doaProblemHandlerForm.handler}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.startTime"/>
		</td>
		<td width="35%">
			<c:out value="${doaProblemHandlerForm.startTime}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.endTime"/>
		</td><td width="35%">
			<c:out value="${doaProblemHandlerForm.endTime}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.status"/>
		</td><td width="35%">
			<c:out value="${doaProblemHandlerForm.status.statusValue}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>