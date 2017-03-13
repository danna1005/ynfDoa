<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_location/doaLocation.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_location/doaLocation.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_location/doaLocation.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_location/doaLocation.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaLocationForm, 'deleteall');">
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
				<sunbor:column property="doaLocation.department">
					<bean:message bundle="third-doa" key="doaLocation.department"/>
				</sunbor:column>
				<sunbor:column property="doaLocation.floor">
					<bean:message bundle="third-doa" key="doaLocation.floor"/>
				</sunbor:column>
				<sunbor:column property="doaLocation.room">
					<bean:message bundle="third-doa" key="doaLocation.room"/>
				</sunbor:column>
				<sunbor:column property="doaLocation.seatRow">
					<bean:message bundle="third-doa" key="doaLocation.seatRow"/>
				</sunbor:column>
				<sunbor:column property="doaLocation.seatColumn">
					<bean:message bundle="third-doa" key="doaLocation.seatColumn"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaLocation" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_location/doaLocation.do" />?method=view&fdId=${doaLocation.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaLocation.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaLocation.department}" />
				</td>
				<td>
					<c:out value="${doaLocation.floor}" />
				</td>
				<td>
					<c:out value="${doaLocation.room}" />
				</td>
				<td>
					<c:out value="${doaLocation.seatRow}" />
				</td>
				<td>
					<c:out value="${doaLocation.seatColumn}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>