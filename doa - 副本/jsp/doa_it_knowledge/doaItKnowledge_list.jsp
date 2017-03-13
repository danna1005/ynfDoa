<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/third/doa/doa_it_knowledge/doaItKnowledge.do">
	<div id="optBarDiv">
		<kmss:auth requestURL="/third/doa/doa_it_knowledge/doaItKnowledge.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/doa/doa_it_knowledge/doaItKnowledge.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/doa/doa_it_knowledge/doaItKnowledge.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.doaItKnowledgeForm, 'deleteall');">
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
				<sunbor:column property="doaItKnowledge.description">
					<bean:message bundle="third-doa" key="doaItKnowledge.description"/>
				</sunbor:column>
				<sunbor:column property="doaItKnowledge.createTime">
					<bean:message bundle="third-doa" key="doaItKnowledge.createTime"/>
				</sunbor:column>
				<sunbor:column property="doaItKnowledge.totalGood">
					<bean:message bundle="third-doa" key="doaItKnowledge.totalGood"/>
				</sunbor:column>
				<sunbor:column property="doaItKnowledge.docCreator.fdName">
					<bean:message bundle="third-doa" key="doaItKnowledge.docCreator"/>
				</sunbor:column>
				<sunbor:column property="doaItKnowledge.type.name">
					<bean:message bundle="third-doa" key="doaItKnowledge.type"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="doaItKnowledge" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/third/doa/doa_it_knowledge/doaItKnowledge.do" />?method=view&fdId=${doaItKnowledge.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${doaItKnowledge.fdId}">
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${doaItKnowledge.description}" />
				</td>
				<td>
					<kmss:showDate value="${doaItKnowledge.createTime}" />
				</td>
				<td>
					<c:out value="${doaItKnowledge.totalGood}" />
				</td>
				<td>
					<c:out value="${doaItKnowledge.docCreator.fdName}" />
				</td>
				<td>
					<c:out value="${doaItKnowledge.type.name}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>