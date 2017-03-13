<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("jquery.js");
</script>
<script type="text/javascript">
	//页面加载完以后把当前窗口的父窗口高度重新设置
	$(document).ready(function(){
			var height=$(document).height();
			var father =window.parent.document;
			if(father){
				var listframe=father.getElementById("listframe");
				$(listframe).attr("height",height);
				}
		})
</script>
<html:form action="/third/im/kk/kkNotifyLog.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/im/kk/kkNotifyLog.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/im/kk/kkNotifyLog.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/im/kk/kkNotifyLog.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kkNotifyLogForm, 'deleteall');">
		</kmss:auth>
	</div>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt">
					<input type="checkbox" name="List_Tongle">
				</td>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="kkNotifyLog.fdSubject">
					<bean:message bundle="third-im-kk" key="kkNotifyLog.fdSubject"/>
				</sunbor:column>
				<sunbor:column property="kkNotifyLog.sendTime">
					<bean:message bundle="third-im-kk" key="kkNotifyLog.sendTime"/>
				</sunbor:column>
				<sunbor:column property="kkNotifyLog.rtnTime">
					<bean:message bundle="third-im-kk" key="kkNotifyLog.rtnTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kkNotifyLog" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/im/kk/kkNotifyLog.do" />?method=view&fdId=${kkNotifyLog.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kkNotifyLog.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kkNotifyLog.fdSubject}" />
				</td>
				<td>
					<c:out value="${kkNotifyLog.sendTime}" />
				</td>
				<td>
					<c:out value="${kkNotifyLog.rtnTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>