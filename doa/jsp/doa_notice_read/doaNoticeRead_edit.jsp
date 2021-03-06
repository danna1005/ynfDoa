<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/third/doa/doa_notice_read/doaNoticeRead.do">
<div id="optBarDiv">
	<c:if test="${doaNoticeReadForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.doaNoticeReadForm, 'update');">
	</c:if>
	<c:if test="${doaNoticeReadForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.doaNoticeReadForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.doaNoticeReadForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="third-doa" key="table.doaNoticeRead"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNoticeRead.notice"/>
		</td><td width="35%">
			<xform:select property="noticeId">
				<xform:beanDataSource serviceBean="doaNoticeService" selectBlock="fdId,name" orderBy="" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-doa" key="doaNoticeRead.reader"/>
		</td><td width="35%">
			<xform:address propertyId="readerId" propertyName="readerName" orgType="ORG_TYPE_ALL" style="width:85%" />
		</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	Com_IncludeFile("dialog.js");
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>