<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/doa/doa_application/doaApplication.do">
<div id="optBarDiv">
	<c:if test="${doaApplicationForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaApplicationForm, 'update');">
	</c:if>
	<c:if test="${doaApplicationForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaApplicationForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaApplicationForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaApplication"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.name"/>
		</td><td width="35%">
			<xform:text property="name" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.url"/>
		</td><td width="35%">
			<xform:text property="url" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.order"/>
		</td><td width="35%">
			<xform:text property="order" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.status"/>
		</td><td width="35%">
			<xform:text property="status" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.remark"/>
		</td><td width="35%">
			<xform:text property="remark" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.iconurl"/>
		</td><td width="35%">
			<xform:text property="iconurl" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.isdefault"/>
		</td><td width="35%">
			<xform:radio property="isdefault">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.isdingdingapp"/>
		</td><td width="35%">
			<xform:radio property="isdingdingapp">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaApplication.appCategory"/>
		</td><td width="35%">
			<xform:select property="appCategoryId">
				<xform:beanDataSource serviceBean="doaAppCategoryService" selectBlock="fdId,name" orderBy="" />
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