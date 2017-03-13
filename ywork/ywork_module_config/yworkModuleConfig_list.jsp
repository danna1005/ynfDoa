<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/ywork/ywork_module_config/yworkModuleConfig.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_module_config/yworkModuleConfig.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_module_config/yworkModuleConfig.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_module_config/yworkModuleConfig.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkModuleConfigForm, 'deleteall');">
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
				<sunbor:column property="yworkModuleConfig.fdName">
					<bean:message bundle="third-ywork" key="yworkModuleConfig.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkModuleConfig.fdPath">
					<bean:message bundle="third-ywork" key="yworkModuleConfig.fdPath"/>
				</sunbor:column>
				<sunbor:column property="yworkModuleConfig.fdTempModelName">
					<bean:message bundle="third-ywork" key="yworkModuleConfig.fdTempModelName"/>
				</sunbor:column>
				<sunbor:column property="yworkModuleConfig.fdModelName">
					<bean:message bundle="third-ywork" key="yworkModuleConfig.fdModelName"/>
				</sunbor:column>
				<sunbor:column property="yworkModuleConfig.fdIsAvai">
					<bean:message bundle="third-ywork" key="yworkModuleConfig.fdIsAvai"/>
				</sunbor:column>
				<sunbor:column property="yworkModuleConfig.fdIsCategory">
					<bean:message bundle="third-ywork" key="yworkModuleConfig.fdIsCategory"/>
				</sunbor:column>
				<sunbor:column property="yworkModuleConfig.fdSystem.fdId">
					<bean:message bundle="third-ywork" key="yworkModuleConfig.fdSystem"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkModuleConfig" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/ywork/ywork_module_config/yworkModuleConfig.do" />?method=view&fdId=${yworkModuleConfig.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkModuleConfig.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${yworkModuleConfig.fdName}" />
				</td>
				<td>
					<c:out value="${yworkModuleConfig.fdPath}" />
				</td>
				<td>
					<c:out value="${yworkModuleConfig.fdTempModelName}" />
				</td>
				<td>
					<c:out value="${yworkModuleConfig.fdModelName}" />
				</td>
				<td>
					<xform:radio value="${yworkModuleConfig.fdIsAvai}" property="fdIsAvai" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<xform:radio value="${yworkModuleConfig.fdIsCategory}" property="fdIsCategory" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<c:out value="${yworkModuleConfig.fdSystem.fdId}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>