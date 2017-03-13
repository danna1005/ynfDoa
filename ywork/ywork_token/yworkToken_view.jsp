<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<%--<div id="optBarDiv">
	<kmss:auth requestURL="/third/ywork/ywork_token/yworkToken.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('yworkToken.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/third/ywork/ywork_token/yworkToken.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('yworkToken.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
--%>
<p class="txttitle"><bean:message bundle="third-ywork" key="table.yworkToken"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkToken.fdCorpid"/>
		</td><td width="35%">
			<xform:text property="fdCorpid" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkToken.fdSecret"/>
		</td><td width="35%">
			<xform:text property="fdSecret" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkToken.fdAccessToken"/>
		</td><td width="35%">
			<xform:text property="fdAccessToken" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkToken.fdTokenExpire"/>
		</td><td width="35%">
			<xform:datetime property="fdTokenExpire" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkToken.fdOssid"/>
		</td><td width="35%">
			<xform:text property="fdOssid" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkToken.fdOsskey"/>
		</td><td width="35%">
			<xform:text property="fdOsskey" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-ywork" key="yworkToken.fdBucket"/>
		</td><td width="35%">
			<xform:text property="fdBucket" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>