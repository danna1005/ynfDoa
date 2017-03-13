<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/ywork/ywork_system/yworkSystem.do">
	<%--<div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_system/yworkSystem.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_system/yworkSystem.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_system/yworkSystem.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkSystemForm, 'deleteall');">
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
				<sunbor:column property="yworkSystem.fdName">
					<bean:message bundle="third-ywork" key="yworkSystem.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkSystem.fdIsAvai">
					<bean:message bundle="third-ywork" key="yworkSystem.fdIsAvai"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkSystem" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/ywork/ywork_system/yworkSystem.do" />?method=view&fdId=${yworkSystem.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkSystem.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${yworkSystem.fdName}" />
				</td>
				<td>
					<xform:radio value="${yworkSystem.fdIsAvai}" property="fdIsAvai" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>