<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String redirect="pages/index.html";
String target= request.getParameter("target");
if(target != null && !target.equals("")){
	redirect = target;
}
	
%>
<script >
location.href="<%=redirect%>";
</script>