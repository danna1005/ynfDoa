<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript" src="<c:url value="/resource/js/jquery.js"/>"></script>
<html:form action="/third/doa/doa_application/doaApplication.do?method=refresh">
<div id="optBarDiv">
	<input type=button value="刷新缓存"
		onclick="refreshCache();">
	<input type=button value="刷新应用"
		onclick="refreshApp();">
</div>

<center>
<script type="text/javascript">
function refreshCache(){
	 $.ajax({
	        url: '<c:url value="/third/doa/doa_application/doaApplication.do?method=refresh&item=cache" />',
	        success: function(data) {
	    		alert("success");
	        },
            error : function(){
         	alert("fail");
         }
	    });
}
function refreshApp(){
	 $.ajax({
	        url: '<c:url value="/third/doa/doa_application/doaApplication.do?method=refresh&item=app" />',
	        success: function(data) {
	    		alert("success");
	        },
         error : function(){
      	alert("fail");
      }
	    });
}
</script>

</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>
