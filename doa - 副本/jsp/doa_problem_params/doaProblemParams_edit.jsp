<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/doa/doa_problem_params/doaProblemParams.do">
<div id="optBarDiv">
	<c:if test="${doaProblemParamsForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaProblemParamsForm, 'update');">
	</c:if>
	<c:if test="${doaProblemParamsForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaProblemParamsForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaProblemParamsForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaProblemparams"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemParams.problemCategory.typeName"/>
		</td><td width="35%">
			<xform:select property="typeId">
				<xform:beanDataSource serviceBean="doaProblemTypeService" selectBlock="fdId,name" orderBy="" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemParams.vipWaitTime"/>
		</td><td width="35%">
			<xform:text property="vipWaitTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemParams.normalWaitTime"/>
		</td><td width="35%">
			<xform:text property="normalWaitTime" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemParams.delayHandler.handler"/>
		</td><td width="35%">
			<xform:select property="handlerId">
				<xform:beanDataSource serviceBean="doaProblemHandlerService" selectBlock="fdId,handler" orderBy="" />
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