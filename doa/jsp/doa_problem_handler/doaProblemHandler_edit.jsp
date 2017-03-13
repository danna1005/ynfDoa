<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("dialog.js");

</script>
<html:form action="/third/doa/doa_problem_handler/doaProblemHandler.do">
<div id="optBarDiv">
	<c:if test="${doaProblemHandlerForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaProblemHandlerForm, 'update');">
	</c:if>
	<c:if test="${doaProblemHandlerForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaProblemHandlerForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaProblemHandlerForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaProblemHandler"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.handler"/>
		</td><td width="35%">
			<xform:text property="handler" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.startTime"/>
		</td></td><td width="35%">
			<xform:datetime property="startTime" />
		</td>
		
		
	</tr>
	<tr>
	<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.endTime"/>
		</td></td><td width="35%">
			<xform:datetime property="endTime" />
		</td>
		
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaProblemHandler.status"/>
		</td></td><td width="35%">
			<xform:select property="statusKey" showStatus="edit" >
					<xform:beanDataSource serviceBean="doaStatusService" selectBlock="fdId,statusValue" orderBy="" />
			</xform:select>
		
					
			
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