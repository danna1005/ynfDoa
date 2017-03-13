<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/ywork/ywork_category_config/yworkCategoryConfig.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_category_config/yworkCategoryConfig.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_category_config/yworkCategoryConfig.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_category_config/yworkCategoryConfig.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkCategoryConfigForm, 'deleteall');">
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
				<sunbor:column property="yworkCategoryConfig.fdName">
					<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkCategoryConfig.fdModelId">
					<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdModelId"/>
				</sunbor:column>
				<sunbor:column property="yworkCategoryConfig.fdModelName">
					<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdModelName"/>
				</sunbor:column>
				<sunbor:column property="yworkCategoryConfig.fdAllPath">
					<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdAllPath"/>
				</sunbor:column>
				<sunbor:column property="yworkCategoryConfig.fdModule.fdName">
					<bean:message bundle="third-ywork" key="yworkCategoryConfig.fdModule"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkCategoryConfig" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/ywork/ywork_category_config/yworkCategoryConfig.do" />?method=view&fdId=${yworkCategoryConfig.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkCategoryConfig.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${yworkCategoryConfig.fdName}" />
				</td>
				<td>
					<c:out value="${yworkCategoryConfig.fdModelId}" />
				</td>
				<td>
					<c:out value="${yworkCategoryConfig.fdModelName}" />
				</td>
				<td>
					<c:out value="${yworkCategoryConfig.fdAllPath}" />
				</td>
				<td>
					<c:out value="${yworkCategoryConfig.fdModule.fdName}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>