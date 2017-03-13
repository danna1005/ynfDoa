<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_log/doaLog.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_log/doaLog.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_log/doaLog.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_log/doaLog.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaLogForm, 'deleteall');">
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
				<sunbor:column property="doaLog.action">
					<bean:message bundle="third-doa" key="doaLog.action"/>
				</sunbor:column>
				<sunbor:column property="doaLog.logContent">
					<bean:message bundle="third-doa" key="doaLog.logContent"/>
				</sunbor:column>
				<sunbor:column property="doaLog.appName">
					<bean:message bundle="third-doa" key="doaLog.appName"/>
				</sunbor:column>
				<sunbor:column property="doaLog.createTime">
					<bean:message bundle="third-doa" key="doaLog.createTime"/>
				</sunbor:column>
				<sunbor:column property="doaLog.creator.fdName">
					<bean:message bundle="third-doa" key="doaLog.creator"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaLog" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_log/doaLog.do" />?method=view&fdId=${doaLog.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaLog.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaLog.action}" />
				</td>
				<td>
					<c:out value="${doaLog.logContent}" />
				</td>
				<td>
					<c:out value="${doaLog.appName}" />
				</td>
				<td>
					<kmss:showDate value="${doaLog.createTime}" />
				</td>
				<td>
					<c:out value="${doaLog.creator.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>