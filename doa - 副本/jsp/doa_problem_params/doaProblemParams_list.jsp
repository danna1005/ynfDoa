<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_problem_params/doaProblemParams.do">
<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_problem_params/doaProblemParams.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_problem_params/doaProblemParams.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_problem_params/doaProblemParams.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaProblemParamsForm, 'deleteall');">
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
				
				<sunbor:column property="doaProblemParams.problemCategory.typeName">
					<bean:message bundle="third-doa" key="doaProblemParams.problemCategory.typeName"/>
				</sunbor:column>
				<sunbor:column property="doaProblemParams.vipWaitTime">
					<bean:message bundle="third-doa" key="doaProblemParams.vipWaitTime"/>
				</sunbor:column>
				<sunbor:column property="doaProblemParams.normalWaitTime">
					<bean:message bundle="third-doa" key="doaProblemParams.normalWaitTime"/>
				</sunbor:column>
				<sunbor:column property="doaProblemParams.delayHandler.handler">
					<bean:message bundle="third-doa" key="doaProblemParams.delayHandler.handler"/>
				</sunbor:column>
			
				
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaProblemParams" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_problem_params/doaProblemParams.do" />?method=view&fdId=${doaProblemParams.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaProblemParams.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaProblemParams.problemCategory.name}" />
				</td>
				<td>
					<c:out value="${doaProblemParams.vipWaitTime}"/>分钟
				</td>
				
				<td>
					<c:out value="${doaProblemParams.normalWaitTime}"  />分钟
				</td>
				<td>
					<c:out value="${doaProblemParams.delayHandler.handler}" />
				</td>
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>

</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>