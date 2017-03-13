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
	<kmss:auth requestURL="/third/doa/doa_problem/doaProblem.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('doaProblem.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/doa/doa_problem/doaProblem.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('doaProblem.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaProblem"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.description"/>
		</td><td width="35%">
			<xform:text property="description" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.createTime"/>
		</td><td width="35%">
			<xform:datetime property="createTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.modifiedTime"/>
		</td><td width="35%">
			<xform:datetime property="modifiedTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.status"/>
		</td><td width="35%">
			<xform:text property="status" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.comment"/>
		</td><td width="35%">
			<xform:text property="comment" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.handleResult"/>
		</td><td width="35%">
			<xform:rtf property="handleResult" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.type"/>
		</td><td width="35%">
			<c:out value="${doaProblemForm.typeName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.docCreator"/>
		</td><td width="35%">
			<c:out value="${doaProblemForm.docCreatorName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.currentHandler"/>
		</td><td width="35%">
			<c:out value="${doaProblemForm.currentHandlerName}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>