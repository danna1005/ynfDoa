<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_problem_handler/doaProblemHandler.do">
<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_problem_handler/doaProblemHandler.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_problem_handler/doaProblemHandler.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_problem_handler/doaProblemHandler.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaProblemHandlerForm, 'deleteall');">
		</kmss:auth>
	</div>
	

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
				
				<sunbor:column property="doaProblemHandler.handler">
					<bean:message bundle="third-doa" key="doaProblemHandler.handler"/>
				</sunbor:column>
				<sunbor:column property="doaProblemHandler.startTime">
					<bean:message bundle="third-doa" key="doaProblemHandler.startTime"/>
				</sunbor:column>
				<sunbor:column property="doaProblemHandler.endTime">
					<bean:message bundle="third-doa" key="doaProblemHandler.endTime"/>
				</sunbor:column>
				<sunbor:column property="doaProblemHandler.status.statusValue">
					<bean:message bundle="third-doa" key="doaProblemHandler.status"/>
				</sunbor:column>
			
				
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaProblemHandler" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_problem_handler/doaProblemHandler.do" />?method=view&fdId=${doaProblemHandler.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaProblemHandler.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaProblemHandler.handler}" />
				</td>
				<td>
					<c:out value="${doaProblemHandler.startTime}" />
				</td>
				
				<td>
					<c:out value="${doaProblemHandler.endTime}" />
				</td>
				<td>
					<c:out value="${doaProblemHandler.status.statusValue}" />
					
				</td>
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>

</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>