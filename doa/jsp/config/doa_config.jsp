<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
<div id="optBarDiv">
	<input type=button value="<bean:message key="button.update"/>"
		onclick="commitMethod();">
</div>
<p class="txttitle"><bean:message bundle="sys-organization" key="sysOrgConfig"/></p>
<center>
<script type="text/javascript">
function commitMethod(){
	   Com_Submit(document.sysAppConfigForm, 'update');
}


</script>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=20%>
			优先处理（岗位，人员）
		</td>
		<td colspan="3">
			<html:hidden property="value(firstPersons)" /> 
			<html:text
						property="value(firstPersonNames)" style="width:80%" readonly="true"
						styleClass="inputsgl" /> 
						<xform:address textarea="true" mulSelect="true" propertyId="value(firstPersons)" propertyName="value(firstPersonNames)" style="width:97%;height:90px;" >
						</xform:address>		
		</td>
	</tr>
		<tr>
		<td class="td_normal_title" width=20%>
			吐槽提醒（人员）
		</td>
		<td colspan="3">
			<html:hidden property="value(feedbackPersons)" /> 
			<html:text
						property="value(feedbackPersonNames)" style="width:80%" readonly="true"
						styleClass="inputsgl" /> 
						<xform:address textarea="true" mulSelect="true" propertyId="value(feedbackPersons)" propertyName="value(feedbackPersonNames)" orgType="ORG_TYPE_PERSON" style="width:97%;height:90px;" >
						</xform:address>		
		</td>
	</tr>
</table>
</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>
