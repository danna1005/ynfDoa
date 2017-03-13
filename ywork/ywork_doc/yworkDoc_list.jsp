<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/ywork/ywork_doc/yworkDoc.do">
	<%--<div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_doc/yworkDoc.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_doc/yworkDoc.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_doc/yworkDoc.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkDocForm, 'deleteall');">
		</kmss:auth>
	</div>--%>
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
				<sunbor:column property="yworkDoc.fdAllPath">
					<bean:message bundle="third-ywork" key="yworkDoc.fdAllPath"/>
				</sunbor:column>
				<sunbor:column property="yworkDoc.fdType">
					<bean:message bundle="third-ywork" key="yworkDoc.fdType"/>
				</sunbor:column>
				<sunbor:column property="yworkDoc.fdName">
					<bean:message bundle="third-ywork" key="yworkDoc.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkDoc.fdUpdateTime">
					<bean:message bundle="third-ywork" key="yworkDoc.fdUpdateTime"/>
				</sunbor:column>
				<sunbor:column property="yworkDoc.fdCate.fdName">
					<bean:message bundle="third-ywork" key="yworkDoc.fdCate"/>
				</sunbor:column>
				<sunbor:column property="yworkDoc.fdCreate.fdName">
					<bean:message bundle="third-ywork" key="yworkDoc.fdCreate"/>
				</sunbor:column>
				<sunbor:column property="yworkDoc.fdShare.fdName">
					<bean:message bundle="third-ywork" key="yworkDoc.fdShare"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkDoc" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/ywork/ywork_doc/yworkDoc.do" />?method=view&fdId=${yworkDoc.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkDoc.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${yworkDoc.fdAllPath}" />
				</td>
				<td>
					<c:out value="${yworkDoc.fdType}" />
				</td>
				<td>
					<c:out value="${yworkDoc.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${yworkDoc.fdUpdateTime}" />
				</td>
				<td>
					<c:out value="${yworkDoc.fdCate.fdName}" />
				</td>
				<td>
					<c:out value="${yworkDoc.fdCreate.fdName}" />
				</td>
				<td>
					<c:out value="${yworkDoc.fdShare.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>