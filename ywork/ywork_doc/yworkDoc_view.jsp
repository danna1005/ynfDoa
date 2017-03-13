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
	<kmss:auth requestURL="/third/ywork/ywork_doc/yworkDoc.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('yworkDoc.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/ywork/ywork_doc/yworkDoc.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('yworkDoc.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
 --%>
<p class="txttitle"><bean:message bundle="third-ywork" key="table.yworkDoc"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdAllPath"/>
		</td><td width="35%">
			<xform:text property="fdAllPath" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdType"/>
		</td><td width="35%">
			<xform:text property="fdType" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdBusinessId"/>
		</td><td width="35%">
			<xform:text property="fdBusinessId" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdCodeUrl"/>
		</td><td width="35%" colspan="3">
			<xform:text property="fdCodeUrl" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdRemark"/>
		</td><td width="35%" colspan="3">
			<xform:text property="fdRemark" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdContent"/>
		</td><td width="35%" colspan="3">
			<%-- ${ yworkDocForm.fdContent} --%>
			<xform:text property="fdContent" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdFromContent"/>
		</td><td width="35%" colspan="3">
			<xform:textarea property="fdFromContent" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdCompanyId"/>
		</td><td width="35%">
			<xform:text property="fdCompanyId" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdModelId"/>
		</td><td width="35%">
			<xform:text property="fdModelId" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdModelName"/>
		</td><td width="35%">
			<xform:text property="fdModelName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdExpireTime"/>
		</td><td width="35%">
			<xform:datetime property="fdExpireTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdExtra"/>
		</td><td width="35%">
			<xform:text property="fdExtra" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdUpdateTime"/>
		</td><td width="35%">
			<xform:datetime property="fdUpdateTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdCodeExpire"/>
		</td><td width="35%">
			<xform:datetime property="fdCodeExpire" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdCate"/>
		</td><td width="35%">
			<c:out value="${yworkDocForm.fdCateName}" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdCreate"/>
		</td><td width="35%">
			<c:out value="${yworkDocForm.fdCreateName}" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkDoc.fdShare"/>
		</td><td width="35%">
			<c:out value="${yworkDocForm.fdShareName}" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>