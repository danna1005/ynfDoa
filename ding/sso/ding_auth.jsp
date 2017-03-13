<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//if(PdaFlagUtil.checkClientIsPdaApp(request)){
	//	response.setHeader("contentType","text/plain; charset=UTF-8");
		System.out.println("ccc::"+request.getSession()
							.getAttribute("ACEGI_SECURITY_TARGET_URL"));
%>
			<div style="display: none">
			</div>

<script>
	/*
	window.onload=function(){
		window.location.href="";
	} 
	*/
</script>
<%//}%>