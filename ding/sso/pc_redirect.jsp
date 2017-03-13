<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.landray.kmss.util.*,com.landray.kmss.third.ding.constant.DingConstant" %>
<%
String fdId = request.getParameter("id");
String type = request.getParameter("type");
String redirctUrl=request.getParameter("pg");
String domain = DingConstant.DING_NOTIFY_DOMAIN;
if("todo".equals(type)){
	redirctUrl = "/sys/notify/sys_notify_todo/sysNotifyTodo.do?method=view&fdId="+fdId;
}
if(StringUtil.isNotNull(domain)){
	redirctUrl=domain+redirctUrl;
}else{
	redirctUrl= StringUtil.formatUrl(redirctUrl);
}

System.out.println("redirctUrl="+redirctUrl);

//response.sendRedirect(redirctUrl);

%>
<script>

	window.onload=function(){
		window.location.href="<%=redirctUrl%>";
	} 

</script>
