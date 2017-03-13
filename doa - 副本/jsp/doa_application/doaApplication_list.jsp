<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_application/doaApplication.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_application/doaApplication.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_application/doaApplication.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_application/doaApplication.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaApplicationForm, 'deleteall');">
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
				<sunbor:column property="doaApplication.name">
					<bean:message bundle="third-doa" key="doaApplication.name"/>
				</sunbor:column>
				
				<sunbor:column property="doaApplication.order">
					<bean:message bundle="third-doa" key="doaApplication.order"/>
				</sunbor:column>
				<sunbor:column property="doaApplication.status">
					<bean:message bundle="third-doa" key="doaApplication.status"/>
				</sunbor:column>
				<sunbor:column property="doaApplication.remark">
					<bean:message bundle="third-doa" key="doaApplication.remark"/>
				</sunbor:column>
				<sunbor:column property="doaApplication.iconurl">
					<bean:message bundle="third-doa" key="doaApplication.iconurl"/>
				</sunbor:column>
				<sunbor:column property="doaApplication.isdefault">
					<bean:message bundle="third-doa" key="doaApplication.isdefault"/>
				</sunbor:column>
				<sunbor:column property="doaApplication.isdingdingapp">
					<bean:message bundle="third-doa" key="doaApplication.isdingdingapp"/>
				</sunbor:column>
				<sunbor:column property="doaApplication.appCategory.name">
					<bean:message bundle="third-doa" key="doaApplication.appCategory"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaApplication" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_application/doaApplication.do" />?method=view&fdId=${doaApplication.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaApplication.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaApplication.name}" />
				</td>
			
				<td>
					<c:out value="${doaApplication.order}" />
				</td>
				<td>
					<c:out value="${doaApplication.status}" />
				</td>
				<td>
					<c:out value="${doaApplication.remark}" />
				</td>
				<td>
					<c:out value="${doaApplication.iconurl}" />
				</td>
				<td>
					<xform:radio value="${doaApplication.isdefault}" property="isdefault" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<xform:radio value="${doaApplication.isdingdingapp}" property="isdingdingapp" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<c:out value="${doaApplication.appCategory.name}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>