<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微信企业号待办推送测试</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
	function doAjax(){
	 var postSubject = document.getElementsByName("postSubject")[0].value;
	 var personId = document.getElementsByName("personId")[0].value;
	 var content = document.getElementsByName("content")[0].value;

	 if(!(postSubject!='' && postSubject.length>0)){
		 alert('标题不能为空');
		 return false; 
	   }
	   
	 if(!(personId!='' && personId.length>0)){
		 alert('请选择接收人');
		 return false; 
	   }

	 if(!(content!='' && content.length>0)){
		  alert('请输入推送的内容');
		  return false; 
	   }

	 $.ajax({
			url: Com_Parameter.ContextPath + 'third/wechat/wechatNotify.do?method=doSendNotify',
			type: 'POST',
			dataType: 'json',
			async : false,
			data:{postSubject:postSubject,personId:personId,content:content},    
			success: function(data) {
				var code =data.code;
				var retInfor =data.retInfor;
				var message=code+":"+retInfor;
				$("#_result").val(message);
				$("#_retResult").show();
			},
			error: function(data) {
				var code =data.code;
				var retInfor =data.retInfor;
				var message=code+":"+retInfor;
				$("#_result").val(message);
				$("#_retResult").show();
			}
		});
	}
</script>
<body>
<html:form action="/third/wechat/wechatNotify.do?method=doSendNotify">
<p class="txttitle">微信企业号待办推送模拟测试</p>
<center>
<table class="tb_normal">
	<tr>
	  <td class="td_normal_title" > 标题：</td>
	  <td colspan=3><xform:text property="postSubject" style="width:97%" showStatus="edit" /></td>
	</tr>
	
  	<tr>
	    <td class="td_normal_title" >接收者：</td>
		<td colspan=3>	
		  <span id="isWriterSpan" >
	         <xform:text property="receiverId"  isLoadDataDict="false"   required="true"/>
		  </span>
		  <span>
		      <xform:address  required="true"  style="width:98%" isLoadDataDict="false"  showStatus="edit"  
		         propertyId="personId" propertyName="personName" orgType='ORG_TYPE_PERSON' className="input" ></xform:address>
		  </span>
		</td>
    </tr>
    
    <tr>
       <td class="td_normal_title" >发送内容：</td>
       <td width="85%" colspan="3">
		   <xform:textarea property="content" showStatus="edit"  style="width:97%;height:90px"/>
	   </td>
    </tr>
    
    <tr id="_retResult" style="display:none;">
       <td class="td_normal_title" >反馈结果：</td>
       <td width="85%" colspan="3">
		   <input type="text" name="result" id="_result"  readonly="readonly" disabled="disabled" style="width:97%;height:90px">
	   </td>
    </tr>
    
    <tr>
      <td style="display: none"></td>
      <td colspan="3">
         <div style="margin-left: 50%">
	         <input type="button"  id="doButton" value="发送" onclick="doAjax();">
         </div>
      </td>
    </tr>
</table>
</center>
</html:form>
</body>
</html>