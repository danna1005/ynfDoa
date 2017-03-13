<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp"%>
<script type="text/javascript">
Com_IncludeFile("jquery.js");

function getMailNum(url){
	$.ajax(
	{
		url : url,
		dataType : 'json',
		data : '',
		jsonp : 'callback',
		success : function(result) {
			setMailSummaryInfo(result);
		},
		timeout : 5000
	});
}

function setMailSummaryInfo(data){
	//alert(data);
	//debugger;
	var div_num_zero = $("#div_num_zero");
	var div_num_nozero = $("#div_num_nozero");
	var div_num_err = $("#div_num_err");
	if(data.errMsg){
		div_num_zero.hide();
		div_num_nozero.hide();
		if("has no email"==data.errMsg){
			div_num_err.hide();
		}else{
			div_num_err.show();
			div_num_err.text("获取未读邮件数出错："+data.errMsg);
		}
	}else{
		var num = data.num;
		//debugger;
		if(num == "0"){
			div_num_zero.show();
			div_num_nozero.hide();
			div_num_err.hide();
		}else{
			$("#num_block").text(" "+num);
			div_num_zero.hide();
			div_num_nozero.show();
			div_num_err.hide();
		}
	}
	
}

window.onload = function(){
	var url = '<c:url value="/third/mail/coremail/loginCoreMail.do?method=getNotReadMail"/>';
	getMailNum(url);
}
</script>
	<div id="div_num_zero" style="display:none;">
	<bean:message bundle="sys-notify" key="sysMail.home.you" /><font style="color:#FF6600;"><b>
	<bean:message bundle="sys-notify" key="sysMail.home.notHave" /></b></font>
	<bean:message bundle="sys-notify" key="sysMail.home.rec" />
	<a href="<c:url value="/third/mail/coremail/sysHomeMain_redirect.jsp"/>" 
	target="_blank" 
	style="text-decoration: underline;">
	<bean:message bundle="sys-notify" key="sysNotify.type.email"/>
	</a>
	</div>
	<div id="div_num_nozero" style="display:none;font-size: 14px;">
	<bean:message bundle="sys-notify" key="sysMail.home.youHave"  /><font style="color:#FF6600;"><b id="num_block">
	</b></font>
	<bean:message bundle="sys-notify" key="sysMail.home.new"  />
	<a href="<c:url value="/third/mail/coremail/sysHomeMain_redirect.jsp"/>" 
	target="_blank" 
	style="text-decoration: underline;">
	<bean:message bundle="sys-notify" key="sysNotify.type.email" />
	</a>	
	</div>
<div id="div_num_err" style="display:none;">
	
</div>