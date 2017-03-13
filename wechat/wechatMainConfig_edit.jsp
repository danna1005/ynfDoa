<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<script type="text/javascript" src="${KMSS_Parameter_ContextPath}resource/js/jquery.js"></script>
<html:form action="/third/wechat/wechatMainConfig.do">
<div id="optBarDiv">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.wechatMainConfigForm, 'update');">
</div>
<center>
<table class="tb_normal" width=95%>
	
	   <tr>
		    <td class="td_normal_title" width=15%>License：</td>
			<td >
				<xform:text property="lwechat_license" style="width:100%"></xform:text>
			</td>
			<td class="td_normal_title" width=15%>企业号文件下载地址：</td>
			<td >
				<xform:text property="lwechat_qyDownloadUrl" style="width:100%"></xform:text>
			</td>
		</tr>
		
		<tr>
			<td class="td_normal_title" width=15%>微云系统地址：</td>
			<td width=25%>
				<xform:text property="lwechat_wyUrl" style="width:100%"></xform:text>
			</td>
			<td class="td_normal_title" width=15%>企业号系统地址：</td>
			<td>
			    <xform:text property="lwechat_qyUrl" style="width:100%"></xform:text>
			</td>
		</tr>
		 
		<tr>
			<td class="td_normal_title" width=15%>微云推送待办：</td>
			<td width=35%> <xform:radio property="lwechat_wyEnable" showStatus="edit" >
					<xform:simpleDataSource value="true">启用</xform:simpleDataSource>
					<xform:simpleDataSource value="false">禁用</xform:simpleDataSource>
				  </xform:radio>
				  
				  <div id="_wy" style="display: none">
				       <input type="checkbox" name="lwechat_wyisSendTodo" value="true" id="_lwechat_wyisSendTodo">待审
				       <input type="checkbox" name="lwechat_wyisSendView" value="true" id="_lwechat_wyisSendView">待阅
				  </div>
			</td>
			
			<td class="td_normal_title" width=15% >企业号推送待办：</td>
			<td><xform:radio property="lwechat_qyEnable" showStatus="edit" >
				<xform:simpleDataSource value="true">启用</xform:simpleDataSource>
					<xform:simpleDataSource value="false">禁用</xform:simpleDataSource>
				</xform:radio>
				
				<div id="_qy" style="display: none">
					 <input type="checkbox" name="lwechat_qyisSendTodo" value="true" id="_lwechat_qyisSendTodo">待审
					 <input type="checkbox" name="lwechat_qyisSendView" value="true" id="_lwechat_qyisSendView">待阅
				</div>
			</td>
		</tr>
		
		<tr>
			<td class="td_normal_title" width=15%>微云微信通知地址：</td>
			<td >
				<xform:text property="lwechat_wyNotifyUrl" style="width:100%"></xform:text>
			</td>
			<td class="td_normal_title" width=15%>企业微信通知地址：</td>
			<td >
				<xform:text property="lwechat_qyNotifyUrl" style="width:100%"></xform:text>
			</td>
		</tr>
</table>
</center>
<html:hidden property="method_GET"/>
</html:form>

<%@ include file="/resource/jsp/edit_down.jsp"%>
<script type="text/javascript">
  var lwechat_wyEnable= '${wechatMainConfigForm.lwechat_wyEnable}';
  var lwechat_qyEnable = '${wechatMainConfigForm.lwechat_qyEnable}';
$(document).ready(function(){
  	if(lwechat_wyEnable=='true'){
  	  	  var lwechat_wyisSendTodo ='${wechatMainConfigForm.lwechat_wyisSendTodo}';
  	  	  var lwechat_wyisSendView ='${wechatMainConfigForm.lwechat_wyisSendView}';
  	  	  
  	  	  if(lwechat_wyisSendTodo == 'true'){
	  	  	  $("#_lwechat_wyisSendTodo").attr('checked',true);
  	  	  	}
	  	  if(lwechat_wyisSendView == 'true'){
	  		  $("#_lwechat_wyisSendView").attr('checked',true);
		  }
		  
		  $("#_wy").css("display","block");
		}else{
		  $("#_wy").css("display","none");
	}
	
	$("input:radio[name='lwechat_wyEnable']").bind("click",function(){
		 var wycheckval=$(this).val();
		 if(wycheckval=='true'){
			  $("#_wy").css("display","block");
		  }else{
			  $("input[name='lwechat_wyisSendTodo']")[0].checked=false;
			  $("input[name='lwechat_wyisSendView']")[0].checked=false;
		  }
	});

	if(lwechat_qyEnable=='true'){
		  var lwechat_qyisSendTodo ='${wechatMainConfigForm.lwechat_qyisSendTodo}';
 	  	  var lwechat_qyisSendView = '${wechatMainConfigForm.lwechat_qyisSendView}';

 	  	  if(lwechat_qyisSendTodo == 'true'){
	  	  	  $("#_lwechat_qyisSendTodo").attr('checked',true);
 	  	  	}
	  	  if(lwechat_qyisSendView == 'true'){
	  		  $("#_lwechat_qyisSendView").attr('checked',true);
		  }
		  
		  $("#_qy").css("display","block");
		}else{
		  $("#_qy").css("display","none");
	}
	
	$("input:radio[name='lwechat_qyEnable']").bind("click",function(){
		 var qycheckval=$(this).val();
		 if(qycheckval=='true'){
			  $("#_qy").css("display","block");
		  }else{
			  $("input[name='lwechat_qyisSendTodo']")[0].checked=false;
			  $("input[name='lwechat_qyisSendView']")[0].checked=false;
		  }
	});
});
</script>