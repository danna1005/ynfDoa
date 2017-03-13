<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_app_category/doaAppCategory.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_app_category/doaAppCategory.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_app_category/doaAppCategory.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_app_category/doaAppCategory.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaAppCategoryForm, 'deleteall');">
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
				<sunbor:column property="doaAppCategory.name">
					<bean:message bundle="third-doa" key="doaAppCategory.name"/>
				</sunbor:column>
				<sunbor:column property="doaAppCategory.order">
					<bean:message bundle="third-doa" key="doaAppCategory.order"/>
				</sunbor:column>
				<sunbor:column property="doaAppCategory.remark">
					<bean:message bundle="third-doa" key="doaAppCategory.remark"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaAppCategory" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_app_category/doaAppCategory.do" />?method=view&fdId=${doaAppCategory.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaAppCategory.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaAppCategory.name}" />
				</td>
				<td>
					<c:out value="${doaAppCategory.order}" />
				</td>
				<td>
					<c:out value="${doaAppCategory.remark}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>