<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<script type="text/javascript" src="${KMSS_Parameter_ContextPath}resource/js/jquery.js"></script>
<html:form action="/third/ywork/yworkMainConfig.do">
<div id="optBarDiv">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.yworkMainConfigForm, 'update');">
</div>
<center>
<table class="tb_normal" width=95%>
	   <tr>
	        <td class="td_normal_title" width=15%>悦工作授权状态：</td>
	        <td >
			    ${yworkMainConfigForm.ywork_isAuth=="true"? "已授权" : "未授权"}
			</td>
		    <td class="td_normal_title" width=15%>悦工作域名：</td>
			<td >
				<xform:text property="ywork_domain" style="width:100%"></xform:text>
			</td>
		</tr>
		
		<tr>
			<td class="td_normal_title" width=15%>代办消息推送：</td>
			<td width=35%> <xform:radio property="ywork_lbEnable" showStatus="edit" >
					<xform:simpleDataSource value="true">启用</xform:simpleDataSource>
					<xform:simpleDataSource value="false">禁用</xform:simpleDataSource>
				  </xform:radio>
				  
				  <div id="_lb" style="display: none">
				       <input type="checkbox" name="ywork_isSendTodo" value="true" id="_ywork_isSendTodo">待审
				       <input type="checkbox" name="ywork_isSendView" value="true" id="_ywork_isSendView">待阅
				  </div>
			</td>
			
			<td class="td_normal_title" width=15%>基本信息地址：</td>
			<td >
				<xform:text property="ywork_baseUrl" style="width:100%"></xform:text>
			</td>
		</tr>
		
		 <tr>
		    <td class="td_normal_title" width=15%>调试模式(日志输出控制台)：</td>
			<td >
				 <xform:radio property="ywork_isDebug" showStatus="edit" >
					<xform:simpleDataSource value="true">启用</xform:simpleDataSource>
					<xform:simpleDataSource value="false">禁用</xform:simpleDataSource>
				 </xform:radio>
			</td>
			
			<td class="td_normal_title" width=15%>代办消息推送地址：</td>
			<td >
				<xform:text property="ywork_notifUrl" style="width:100%"></xform:text>
			</td>
		</tr>
		
		 <tr>
		    <td class="td_normal_title" width=15%>悦工作服务总开关：</td>
			<td >
			 <xform:radio property="ywork_serverIsOpen" showStatus="edit" >
				<xform:simpleDataSource value="true">启用</xform:simpleDataSource>
				<xform:simpleDataSource value="false">禁用</xform:simpleDataSource>
			 </xform:radio>
			 <span class="txtstrong">
			   <div class="message">(说明:只有在已经授权开启过悦工作服务的前提下进行启用/禁用操作才起作用)</div>
			 </span>
			</td>
			
			
			<td class="td_normal_title" width=15%>授权地址：</td>
			<td >
				<xform:text property="ywork_authUrl" style="width:100%" ></xform:text>
			</td>
			
		</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>

<%@ include file="/resource/jsp/edit_down.jsp"%>
<script type="text/javascript">
  var ywork_lbEnable= '${yworkMainConfigForm.ywork_lbEnable}';
  $(document).ready(function(){
  	if(ywork_lbEnable=='true'){
  	  	  var ywork_isSendTodo ='${yworkMainConfigForm.ywork_isSendTodo}';
  	  	  var ywork_isSendView ='${yworkMainConfigForm.ywork_isSendView}';
  	  	  
  	  	  if(ywork_isSendTodo == 'true'){
	  	  	  $("#_ywork_isSendTodo").attr('checked',true);
  	  	  	}
	  	  if(ywork_isSendView == 'true'){
	  		  $("#_ywork_isSendView").attr('checked',true);
		  }
		  
		  $("#_lb").css("display","block");
		}else{
		  $("#_lb").css("display","none");
	}
	
	$("input:radio[name='ywork_lbEnable']").bind("click",function(){
		 var lbcheckval=$(this).val();
		 if(lbcheckval=='true'){
			  $("#_lb").css("display","block");
		  }else{
			  $("input[name='ywork_isSendTodo']")[0].checked=false;
			  $("input[name='ywork_isSendView']")[0].checked=false;
		  }
	});
});
</script>