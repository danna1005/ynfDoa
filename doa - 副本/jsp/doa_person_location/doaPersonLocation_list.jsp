<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_person_location/doaPersonLocation.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_person_location/doaPersonLocation.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_person_location/doaPersonLocation.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_person_location/doaPersonLocation.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaPersonLocationForm, 'deleteall');">
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
				<sunbor:column property="doaPersonLocation.seatRow">
					<bean:message bundle="third-doa" key="doaPersonLocation.seatRow"/>
				</sunbor:column>
				<sunbor:column property="doaPersonLocation.seatColumn">
					<bean:message bundle="third-doa" key="doaPersonLocation.seatColumn"/>
				</sunbor:column>
				<sunbor:column property="doaPersonLocation.seatNum">
					<bean:message bundle="third-doa" key="doaPersonLocation.seatNum"/>
				</sunbor:column>
				<sunbor:column property="doaPersonLocation.location.department">
					<bean:message bundle="third-doa" key="doaPersonLocation.location"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaPersonLocation" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_person_location/doaPersonLocation.do" />?method=view&fdId=${doaPersonLocation.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaPersonLocation.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaPersonLocation.seatRow}" />
				</td>
				<td>
					<c:out value="${doaPersonLocation.seatColumn}" />
				</td>
				<td>
					<c:out value="${doaPersonLocation.seatNum}" />
				</td>
				<td>
					<c:out value="${doaPersonLocation.location.department}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>