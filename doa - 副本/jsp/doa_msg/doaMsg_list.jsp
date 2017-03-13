<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_msg/doaMsg.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_msg/doaMsg.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_msg/doaMsg.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_msg/doaMsg.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaMsgForm, 'deleteall');">
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
				<sunbor:column property="doaMsg.fromId">
					<bean:message bundle="third-doa" key="doaMsg.fromId"/>
				</sunbor:column>
				<sunbor:column property="doaMsg.objId">
					<bean:message bundle="third-doa" key="doaMsg.objId"/>
				</sunbor:column>
				<sunbor:column property="doaMsg.appName">
					<bean:message bundle="third-doa" key="doaMsg.appName"/>
				</sunbor:column>
				<sunbor:column property="doaMsg.createTime">
					<bean:message bundle="third-doa" key="doaMsg.createTime"/>
				</sunbor:column>
				<sunbor:column property="doaMsg.to.fdName">
					<bean:message bundle="third-doa" key="doaMsg.to"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaMsg" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_msg/doaMsg.do" />?method=view&fdId=${doaMsg.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaMsg.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaMsg.fromId}" />
				</td>
				<td>
					<c:out value="${doaMsg.objId}" />
				</td>
				<td>
					<c:out value="${doaMsg.appName}" />
				</td>
				<td>
					<kmss:showDate value="${doaMsg.createTime}" />
				</td>
				<td>
					<c:out value="${doaMsg.to.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>