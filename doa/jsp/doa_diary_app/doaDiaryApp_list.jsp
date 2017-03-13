<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_diary_app/doaDiaryApp.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_diary_app/doaDiaryApp.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_diary_app/doaDiaryApp.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_diary_app/doaDiaryApp.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaDiaryAppForm, 'deleteall');">
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
				<sunbor:column property="doaDiaryApp.orderNum">
					<bean:message bundle="third-doa" key="doaDiaryApp.orderNum"/>
				</sunbor:column>
				<sunbor:column property="doaDiaryApp.createTime">
					<bean:message bundle="third-doa" key="doaDiaryApp.createTime"/>
				</sunbor:column>
				<sunbor:column property="doaDiaryApp.person.fdName">
					<bean:message bundle="third-doa" key="doaDiaryApp.person"/>
				</sunbor:column>
				<sunbor:column property="doaDiaryApp.app.name">
					<bean:message bundle="third-doa" key="doaDiaryApp.app"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaDiaryApp" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_diary_app/doaDiaryApp.do" />?method=view&fdId=${doaDiaryApp.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaDiaryApp.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<kmss:showDate value="${doaDiaryApp.orderNum}" />
				</td>
				<td>
					<kmss:showDate value="${doaDiaryApp.createTime}" />
				</td>
				<td>
					<c:out value="${doaDiaryApp.person.fdName}" />
				</td>
				<td>
					<c:out value="${doaDiaryApp.app.name}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>