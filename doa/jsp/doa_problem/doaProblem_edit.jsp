<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/doa/doa_problem/doaProblem.do">
<div id="optBarDiv">
	<c:if test="${doaProblemForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaProblemForm, 'update');">
	</c:if>
	<c:if test="${doaProblemForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaProblemForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaProblemForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
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
			<xform:select property="typeId">
				<xform:beanDataSource serviceBean="doaProblemTypeService" selectBlock="fdId,name" orderBy="" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.docCreator"/>
		</td><td width="35%">
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblem.currentHandler"/>
		</td><td width="35%">
			<xform:address propertyId="currentHandlerId" propertyName="currentHandlerName" orgType="ORG_TYPE_ALL" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("calendar.js");
	Com_IncludeFile("dialog.js");
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>