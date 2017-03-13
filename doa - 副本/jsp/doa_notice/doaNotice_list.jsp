<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_notice/doaNotice.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_notice/doaNotice.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_notice/doaNotice.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_notice/doaNotice.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaNoticeForm, 'deleteall');">
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
				<sunbor:column property="doaNotice.name">
					<bean:message bundle="third-doa" key="doaNotice.name"/>
				</sunbor:column>
				<sunbor:column property="doaNotice.content">
					<bean:message bundle="third-doa" key="doaNotice.content"/>
				</sunbor:column>
				<sunbor:column property="doaNotice.createTime">
					<bean:message bundle="third-doa" key="doaNotice.createTime"/>
				</sunbor:column>
				<sunbor:column property="doaNotice.lastModifiedTime">
					<bean:message bundle="third-doa" key="doaNotice.lastModifiedTime"/>
				</sunbor:column>
				<sunbor:column property="doaNotice.status">
					<bean:message bundle="third-doa" key="doaNotice.status"/>
				</sunbor:column>
				<sunbor:column property="doaNotice.model">
					<bean:message bundle="third-doa" key="doaNotice.model"/>
				</sunbor:column>
				<sunbor:column property="doaNotice.mustRead">
					<bean:message bundle="third-doa" key="doaNotice.mustRead"/>
				</sunbor:column>
				<sunbor:column property="doaNotice.org">
					<bean:message bundle="third-doa" key="doaNotice.org"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaNotice" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_notice/doaNotice.do" />?method=view&fdId=${doaNotice.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaNotice.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaNotice.name}" />
				</td>
				<td>
					<c:out value="${fn:substring(doaNotice.content,0,100)}" /> 
				</td>
				<td>
					<kmss:showDate value="${doaNotice.createTime}" />
				</td>
				<td>
					<kmss:showDate value="${doaNotice.lastModifiedTime}" />
				</td>
				<td>
					<c:out value="${doaNotice.status}" />
				</td>
				<td>
					<c:out value="${doaNotice.model}" />
				</td>
				<td>
					<xform:radio value="${doaNotice.mustRead}" property="mustRead" showStatus="view">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
				<td>
					<c:out value="${doaNotice.org}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>