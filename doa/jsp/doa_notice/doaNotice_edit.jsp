<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/doa/doa_notice/doaNotice.do">
<div id="optBarDiv">
	<c:if test="${doaNoticeForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaNoticeForm, 'update');">
	</c:if>
	<c:if test="${doaNoticeForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaNoticeForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaNoticeForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaNotice"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.name"/>
		</td>
		<td colspan="3" width="85%">
			<xform:text property="name" style="width:85%" />
		</td>
	</tr>
	<tr>
		<%-- <td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.content"/>
		</td> --%>
		<td colspan="4" width="85%">
			<kmss:editor property="content"  toolbarSet="Default" height="300"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.createTime"/>
		</td><td width="35%">
			<xform:datetime property="createTime" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.lastModifiedTime"/>
		</td><td width="35%">
			<xform:datetime property="lastModifiedTime" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.status"/>
		</td>
		<td width="35%">
			<xform:text property="status" style="width:85%" />
		</td> 
		<%-- <td>
			<xform:radio property="status">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td> --%>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.model"/>
		</td>
		<td width="35%">
			<xform:text property="model" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.mustRead"/>
		</td><td width="35%">
			<xform:radio property="mustRead">
				<xform:enumsDataSource enumsType="common_yesno" />
			</xform:radio>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNotice.org"/>
		</td><td width="35%">
			<xform:text property="org" style="width:85%" />
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