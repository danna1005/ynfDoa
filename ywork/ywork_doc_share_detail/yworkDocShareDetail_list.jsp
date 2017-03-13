<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/ywork/ywork_doc_share_detail/yworkDocShareDetail.do">
	<%--<div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_doc_share_detail/yworkDocShareDetail.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_doc_share_detail/yworkDocShareDetail.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_doc_share_detail/yworkDocShareDetail.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkDocShareDetailForm, 'deleteall');">
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
				<sunbor:column property="yworkDocShareDetail.fdName">
					<bean:message bundle="third-ywork" key="yworkDocShareDetail.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShareDetail.fdShareTime">
					<bean:message bundle="third-ywork" key="yworkDocShareDetail.fdShareTime"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShareDetail.fdBusinessId">
					<bean:message bundle="third-ywork" key="yworkDocShareDetail.fdBusinessId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShareDetail.fdCodeUrl">
					<bean:message bundle="third-ywork" key="yworkDocShareDetail.fdCodeUrl"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShareDetail.fdDoc.fdName">
					<bean:message bundle="third-ywork" key="yworkDocShareDetail.fdDoc"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShareDetail.fdShare.fdName">
					<bean:message bundle="third-ywork" key="yworkDocShareDetail.fdShare"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkDocShareDetail" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/ywork/ywork_doc_share_detail/yworkDocShareDetail.do" />?method=view&fdId=${yworkDocShareDetail.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkDocShareDetail.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${yworkDocShareDetail.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${yworkDocShareDetail.fdShareTime}" />
				</td>
				<td>
					<c:out value="${yworkDocShareDetail.fdBusinessId}" />
				</td>
				<td>
					<c:out value="${yworkDocShareDetail.fdCodeUrl}" />
				</td>
				<td>
					<c:out value="${yworkDocShareDetail.fdDoc.fdName}" />
				</td>
				<td>
					<c:out value="${yworkDocShareDetail.fdShare.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>