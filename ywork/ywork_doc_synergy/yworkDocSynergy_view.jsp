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
<%--<div id="optBarDiv">
	<kmss:auth requestURL="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('yworkDocSynergy.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('yworkDocSynergy.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
 --%>
<p class="txttitle"><bean:message bundle="third-ywork" key="table.yworkDocSynergy"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdBusinessId"/>
		</td><td width="35%">
			<xform:text property="fdBusinessId" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdCompanyId"/>
		</td><td width="35%">
			<xform:text property="fdCompanyId" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdCompanyName"/>
		</td><td width="35%">
			<xform:text property="fdCompanyName" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdData"/>
		</td><td width="35%">
			<xform:textarea property="fdData" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdHead"/>
		</td><td width="35%">
			<xform:text property="fdHead" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdDate"/>
		</td><td width="35%">
			<xform:datetime property="fdDate" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdSourceShareId"/>
		</td><td width="35%">
			<xform:text property="fdSourceShareId" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdDataInfo"/>
		</td><td width="35%">
			<xform:textarea property="fdDataInfo" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdUser"/>
		</td><td width="35%">
			<c:out value="${yworkDocSynergyForm.fdUserName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDocSynergy.fdDoc"/>
		</td><td width="35%">
			<c:out value="${yworkDocSynergyForm.fdDocName}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>