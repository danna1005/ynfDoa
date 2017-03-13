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
	<kmss:auth requestURL="/third/doa/doa_problem_type/doaProblemType.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('doaProblemType.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/doa/doa_problem_type/doaProblemType.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('doaProblemType.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaProblemType"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemType.name"/>
		</td><td width="35%">
			<xform:text property="name" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemType.parent"/>
		</td><td width="35%">
			<c:out value="${doaProblemTypeForm.parentName}" />
		</td>
	</tr>
	<tr>
				<td class="td_normal_title" width=15%><bean:message
					bundle="third-doa" key="table.doaProblemDefaultHandler" /></td>
				<td colspan=3><bean:write name="doaProblemTypeForm"
					property="defaultHandlerNames" /></td>

			</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>