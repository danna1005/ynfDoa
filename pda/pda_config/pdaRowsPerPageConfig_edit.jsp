<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>

<html:form action="/third/pda/pda_rows_per_page_config/pdaRowsPerPageConfig.do">
<div id="optBarDiv">
	<input type=button value="<bean:message key="button.update"/>" onclick="submint();">
</div>
<p class="txttitle"><bean:message key="pdaGeneralConfig.rowsPerPageConfig" bundle="third-pda"/></p>
<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message key="pdaGeneralConfig.fdRowsNumber" bundle="third-pda"/>
		</td><td colspan=3>
			<html:text property="fdRowsNumber" size="10"/><span class="txtstrong">*</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message key="pdaGeneralConfig.fdAttDownLoadEnabled" bundle="third-pda"/>
		</td><td colspan=3>
			<html:checkbox property="fdAttDownLoadEnabled" value="true"/>
			<bean:message key="pdaGeneralConfig.fdIsEnabled" bundle="third-pda"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message key="pdaGeneralConfig.fdExtendsUrl" bundle="third-pda"/>
		</td><td colspan=3>
			<html:textarea property="fdExtendsUrl" style="width:80%"/><br/>
			<span><bean:message key="pdaGeneralConfig.fdExtends.remark" bundle="third-pda"/></span>
		</td>
	</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>
<script type="text/javascript">
function submint(){
	var rowsNumber = document.getElementsByName("fdRowsNumber")[0].value;
	if(rowsNumber == null || rowsNumber == ""){
		alert('<bean:message key="pdaGeneralConfig.fdRowsNumber" bundle="third-pda"/><bean:message key="validate.notNull" bundle="third-pda"/>');
		return;
	}
	var   r   =  /^[0-9]*[1-9][0-9]*$/;//正整数     
	if(!r.test(rowsNumber)){
		alert('<bean:message key="pdaGeneralConfig.fdRowsNumber" bundle="third-pda"/><bean:message key="validate.mustBeInteger" bundle="third-pda"/>');
		return;
	}
	Com_Submit(document.pdaRowsPerPageConfigForm, 'update');
}
</script>
<%@ include file="/resource/jsp/edit_down.jsp"%>