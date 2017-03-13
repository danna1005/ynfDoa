<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js");
</script>
<html:form action="/third/doa/doa_problem_type/doaProblemType.do">
<div id="optBarDiv">
	<c:if test="${doaProblemTypeForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaProblemTypeForm, 'update');">
	</c:if>
	<c:if test="${doaProblemTypeForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaProblemTypeForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaProblemTypeForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
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
			<xform:select property="parentId">
				<xform:beanDataSource serviceBean="doaProblemTypeService" selectBlock="fdId,name" orderBy="" />
			</xform:select>
		</td>
	</tr>
	<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="third-doa" key="table.doaProblemDefaultHandler" /></td>
					<td colspan=3><html:hidden property="defaultHandlerIds" /> <html:text
						property="defaultHandlerNames" style="width:80%" readonly="true"
						styleClass="inputsgl" /> 
						<xform:address textarea="true" mulSelect="true" propertyId="defaultHandlerIds" propertyName="defaultHandlerNames" style="width:97%;height:90px;" ></xform:address>
					</td>

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