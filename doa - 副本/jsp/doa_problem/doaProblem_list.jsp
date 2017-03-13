<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_problem/doaProblem.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_problem/doaProblem.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_problem/doaProblem.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_problem/doaProblem.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaProblemForm, 'deleteall');">
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
				<sunbor:column property="doaProblem.description">
					<bean:message bundle="third-doa" key="doaProblem.description"/>
				</sunbor:column>
				<sunbor:column property="doaProblem.createTime">
					<bean:message bundle="third-doa" key="doaProblem.createTime"/>
				</sunbor:column>
				<sunbor:column property="doaProblem.modifiedTime">
					<bean:message bundle="third-doa" key="doaProblem.modifiedTime"/>
				</sunbor:column>
				<sunbor:column property="doaProblem.status">
					<bean:message bundle="third-doa" key="doaProblem.status"/>
				</sunbor:column>
				<sunbor:column property="doaProblem.comment">
					<bean:message bundle="third-doa" key="doaProblem.comment"/>
				</sunbor:column>
				<sunbor:column property="doaProblem.type.name">
					<bean:message bundle="third-doa" key="doaProblem.type"/>
				</sunbor:column>
				<sunbor:column property="doaProblem.docCreator.fdName">
					<bean:message bundle="third-doa" key="doaProblem.docCreator"/>
				</sunbor:column>
				<sunbor:column property="doaProblem.currentHandler.fdName">
					<bean:message bundle="third-doa" key="doaProblem.currentHandler"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaProblem" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_problem/doaProblem.do" />?method=view&fdId=${doaProblem.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaProblem.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaProblem.description}" />
				</td>
				<td>
					<kmss:showDate value="${doaProblem.createTime}" />
				</td>
				<td>
					<kmss:showDate value="${doaProblem.modifiedTime}" />
				</td>
				<td>
					<c:out value="${doaProblem.status}" />
				</td>
				<td>
					<c:out value="${doaProblem.comment}" />
				</td>
				<td>
					<c:out value="${doaProblem.type.name}" />
				</td>
				<td>
					<c:out value="${doaProblem.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${doaProblem.currentHandler.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>