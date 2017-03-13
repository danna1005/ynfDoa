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
	<kmss:auth requestURL="/third/ywork/ywork_module_config/yworkModuleConfig.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('yworkModuleConfig.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/ywork/ywork_module_config/yworkModuleConfig.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('yworkModuleConfig.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-ywork" key="table.yworkModuleConfig"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkModuleConfig.fdName"/>
		</td><td width="35%">
			<xform:text property="fdName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkModuleConfig.fdPath"/>
		</td><td width="35%">
			<xform:text property="fdPath" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkModuleConfig.fdTempModelName"/>
		</td><td width="35%">
			<xform:text property="fdTempModelName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkModuleConfig.fdModelName"/>
		</td><td width="35%">
			<xform:text property="fdModelName" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkModuleConfig.fdIsAvai"/>
		</td><td width="35%">
			<xform:radio property="fdIsAvai">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkModuleConfig.fdIsCategory"/>
		</td><td width="35%">
			<xform:radio property="fdIsCategory">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkModuleConfig.fdSystem"/>
		</td><td width="35%">
			<c:out value="${yworkModuleConfigForm.fdSystemName}" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>