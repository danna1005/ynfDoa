<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script>
Com_IncludeFile("doclist.js|dialog.js");
</script>
<script>  
function config_coremail_onloadFunc(){
	var tbObj = document.getElementById("kmss.integrate.coremail");
	var field = tbObj.rows[0].getElementsByTagName("INPUT")[0];
	var omsOut = document.getElementsByName("value(kmss.oms.out.coremail.enabled)")[0];
	var homeCoreMail = document.getElementsByName("value(kmss.mail.home.coremail.enabled)")[0];
	for(var i=1; i<tbObj.rows.length; i++){
		tbObj.rows[i].style.display = field.checked?"":"none";
		if(!field.checked){
			omsOut.checked = false;
			homeCoreMail.checked = false;
		}
		var cfgFields = tbObj.rows[i].getElementsByTagName("INPUT");
		for(var j=0; j<cfgFields.length; j++){
			cfgFields[j].disabled = !field.checked;
		}
	}
}  
config_addOnloadFuncList(config_coremail_onloadFunc);  
</script>
<table class="tb_normal" width=100% id="kmss.integrate.coremail">
	<tr>
		<td class="td_normal_title" colspan=2>
			<b>
				<label> 
					<html:checkbox property="value(kmss.integrate.coremail.enabled)" value="true" onclick="config_coremail_onloadFunc()"/>集成Coremail
				</label>
			</b>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">在门户中显示邮箱</td>
		<td> 
			<label> 
				<html:checkbox property="value(kmss.mail.home.coremail.enabled)" value="true"/>启用
			</label>
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" width="15%">服务器地址</td>
		<td>
			<xform:text showStatus="edit" property="value(kmss.coremail.ip)"  style="width:150px" subject="服务器地址" required="true"/><br>
			<span class="message">例：192.168.0.43</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">端口号</td>
		<td>
			<xform:text showStatus="edit" property="value(kmss.coremail.port)" style="width:150px" subject="端口号" required="true"/><br>
			<span class="message">例：6195</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">邮箱域名</td>
		<td>
			<xform:text showStatus="edit" property="value(kmss.coremail.domain)" style="width:150px" subject="网络域" required="true"/><br>
			<span class="message">例：.landray.com.cn</span>
			<span class="txtstrong"> （注意域前面必须加上“.”符号）</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">服务器DNS</td>
		<td>
			<xform:text showStatus="edit" property="value(kmss.coremail.webname)" style="width:85%" subject="服务器DNS" required="true"/><br>
			<span class="message">例：http://mail-c.landray.com.cn:9900， 其中，访问地址：http://mail-c.landray.com.cn，访问端口：9900</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">组织架构数据同步（接出）</td>
		<td>
			<label> 
				 <html:checkbox property="value(kmss.oms.out.coremail.enabled)" value="true"/>启用
			</label>
			<span class="txtstrong">（将组织架构数据同步到Coremail服务器中）</span>
			<html:hidden property="value(kmss.oms.out.type.coremail.key)"/>
			<html:hidden property="value(kmss.oms.out.type.coremail.service)"/>
			<html:hidden property="value(kmss.mail.home)" disabled="true"/>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">coremail组织同步关键字（providerId）</td>
		<td>
			<xform:text showStatus="edit" property="value(kmss.oms.out.coremail.providerId)" style="width:85%" subject="同步关键字"/><br>
			<span class="message">说明：coremail同步关键字，coremail安装初始化是产生，一般情况为1，但是在oracle数据库情况下初始化是localhost，需根据情况配置。</span>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width="15%">单点时取ekp组织架构邮箱地址</td>
		<td>
			<label> 
				<html:checkbox property="value(kmss.coremail.sso.getEkpMail)" value="true"/>启用
			</label>
			<span class="txtstrong">（注意：启用该选项可能引发coremail安全问题，当coremail登录名跟ekp一致时不要启用该选项）</span>
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" width="15%">单点时启用cookie验证</td>
		<td>
			<label> 
				<html:checkbox property="value(kmss.coremail.sso.validateCookie)" value="true"/>启用
			</label>
			<span class="txtstrong">（注意：如果coremail服务器和ekp服务器的访问地址是同域的，那么启用该选项，否则不要启用）</span>
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" width="15%">只同步配置了coremail邮箱的账号</td>
		<td>
			<label> 
				<html:checkbox property="value(kmss.coremail.sync.coremail.only)" value="true"/>启用
			</label>
			<span class="txtstrong">（如果不是所有的ekp用户都需要生成coremail邮箱，那么可以启用该选项，注意用户个人信息里面要配置正确的邮箱地址）</span>
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" width="15%">未读邮件列表数目</td>
		<td>
			<xform:text showStatus="edit" property="value(kmss.coremail.newMailInfos.size)" style="width:85%" subject="未读邮件列表数目"/><br>
			<span class="message">说明：获取未读邮件列表信息时，最多返回的记录数。不配置的话则按20处理</span>
		</td>
	</tr>
</table> 