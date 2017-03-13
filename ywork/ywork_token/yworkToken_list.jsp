<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/ywork/ywork_token/yworkToken.do">
	<%--<div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_token/yworkToken.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_token/yworkToken.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_token/yworkToken.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkTokenForm, 'deleteall');">
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
				<sunbor:column property="yworkToken.fdCorpid">
					<bean:message bundle="third-ywork" key="yworkToken.fdCorpid"/>
				</sunbor:column>
				<sunbor:column property="yworkToken.fdSecret">
					<bean:message bundle="third-ywork" key="yworkToken.fdSecret"/>
				</sunbor:column>
				<sunbor:column property="yworkToken.fdAccessToken">
					<bean:message bundle="third-ywork" key="yworkToken.fdAccessToken"/>
				</sunbor:column>
				<sunbor:column property="yworkToken.fdTokenExpire">
					<bean:message bundle="third-ywork" key="yworkToken.fdTokenExpire"/>
				</sunbor:column>
				<sunbor:column property="yworkToken.fdOssid">
					<bean:message bundle="third-ywork" key="yworkToken.fdOssid"/>
				</sunbor:column>
				<sunbor:column property="yworkToken.fdOsskey">
					<bean:message bundle="third-ywork" key="yworkToken.fdOsskey"/>
				</sunbor:column>
				<sunbor:column property="yworkToken.fdBucket">
					<bean:message bundle="third-ywork" key="yworkToken.fdBucket"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkToken" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/ywork/ywork_token/yworkToken.do" />?method=view&fdId=${yworkToken.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkToken.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${yworkToken.fdCorpid}" />
				</td>
				<td>
					<c:out value="${yworkToken.fdSecret}" />
				</td>
				<td>
					<c:out value="${yworkToken.fdAccessToken}" />
				</td>
				<td>
					<kmss:showDate value="${yworkToken.fdTokenExpire}" />
				</td>
				<td>
					<c:out value="${yworkToken.fdOssid}" />
				</td>
				<td>
					<c:out value="${yworkToken.fdOsskey}" />
				</td>
				<td>
					<c:out value="${yworkToken.fdBucket}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>