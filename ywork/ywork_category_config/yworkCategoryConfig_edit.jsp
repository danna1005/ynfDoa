<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/ywork/ywork_category_config/yworkCategoryConfig.do">
<div id="optBarDiv">
	<c:if test="${yworkCategoryConfigForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.yworkCategoryConfigForm, 'update');">
	</c:if>
	<c:if test="${yworkCategoryConfigForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.yworkCategoryConfigForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.yworkCategoryConfigForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
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
			<xform:select property="fdModuleId">
				<xform:beanDataSource serviceBean="yworkModuleConfigService" selectBlock="fdId,fdName" orderBy="" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>