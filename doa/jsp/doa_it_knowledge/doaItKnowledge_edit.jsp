<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/doa/doa_it_knowledge/doaItKnowledge.do">
<div id="optBarDiv">
	<c:if test="${doaItKnowledgeForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaItKnowledgeForm, 'update');">
	</c:if>
	<c:if test="${doaItKnowledgeForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaItKnowledgeForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaItKnowledgeForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaItKnowledge"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaItKnowledge.description"/>
		</td><td width="35%">
			<xform:text property="description" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaItKnowledge.createTime"/>
		</td><td width="35%">
			<xform:datetime property="createTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaItKnowledge.totalGood"/>
		</td><td width="35%">
			<xform:text property="totalGood" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaItKnowledge.handleResult"/>
		</td><td width="35%">
			<xform:rtf property="handleResult" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaItKnowledge.docCreator"/>
		</td><td width="35%">
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaItKnowledge.type"/>
		</td><td width="35%">
			<xform:select property="typeId">
				<xform:beanDataSource serviceBean="doaProblemTypeService" selectBlock="fdId,name" orderBy="" />
			</xform:select>
		</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("calendar.js");
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>