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
	<kmss:auth requestURL="/third/ywork/ywork_category_config/yworkCategoryConfig.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('yworkCategoryConfig.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/ywork/ywork_category_config/yworkCategoryConfig.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('yworkCategoryConfig.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-ywork" key="table.yworkCategoryConfig"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdModelId"/>
		</td><td width="35%">
			<xform:text property="fdModelId" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdModelName"/>
		</td><td width="35%">
			<xform:text property="fdModelName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdAllPath"/>
		</td><td width="35%">
			<xform:text property="fdAllPath" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdModule"/>
		</td><td width="35%">
			<c:out value="${yworkCategoryConfigForm.fdModuleName}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>