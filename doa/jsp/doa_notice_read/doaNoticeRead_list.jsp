<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_notice_read/doaNoticeRead.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_notice_read/doaNoticeRead.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_notice_read/doaNoticeRead.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_notice_read/doaNoticeRead.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaNoticeReadForm, 'deleteall');">
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
				<sunbor:column property="doaNoticeRead.notice.name">
					<bean:message bundle="third-doa" key="doaNoticeRead.notice"/>
				</sunbor:column>
				<sunbor:column property="doaNoticeRead.reader.fdName">
					<bean:message bundle="third-doa" key="doaNoticeRead.reader"/>
				</sunbor:column>
				<sunbor:column property="doaNoticeRead.createTime">
					<bean:message bundle="third-doa" key="doaNotice.createTime"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaNoticeRead" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_notice_read/doaNoticeRead.do" />?method=view&fdId=${doaNoticeRead.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaNoticeRead.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaNoticeRead.notice.name}" />
				</td>
				<td>
					<c:out value="${doaNoticeRead.reader.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${doaNoticeRead.createTime}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>