<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/doa/doa_app_category/doaAppCategory.do">
<div id="optBarDiv">
	<c:if test="${doaAppCategoryForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaAppCategoryForm, 'update');">
	</c:if>
	<c:if test="${doaAppCategoryForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaAppCategoryForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaAppCategoryForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaAppCategory"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaAppCategory.name"/>
		</td><td width="35%">
			<xform:text property="name" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaAppCategory.order"/>
		</td><td width="35%">
			<xform:text property="order" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaAppCategory.remark"/>
		</td><td width="35%">
			<xform:text property="remark" style="width:85%" />
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