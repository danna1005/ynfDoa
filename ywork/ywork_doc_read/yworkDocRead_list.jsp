<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>

<%@page import="com.landray.kmss.third.ywork.model.YworkDocRead"%>
<%@page import="com.landray.kmss.third.ywork.util.EmojiUtil"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/third/ywork/css/zoom.css?v=20160422" />
<script type="text/javascript">
	Com_IncludeFile("jquery.js", null, "js");
</script>
<script type="text/javascript" src="${KMSS_Parameter_ContextPath}third/ywork/js/jquery.zoom.js?v=20160422"></script>
<html:form action="/third/ywork/ywork_doc_read/yworkDocRead.do">
	<%-- <div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_doc_read/yworkDocRead.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_doc_read/yworkDocRead.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_doc_read/yworkDocRead.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkDocReadForm, 'deleteall');">
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
				<%--<td width="10pt">
					<input type="checkbox" name="List_Tongle">
				</td>
				<sunbor:column property="yworkDocRead.fdBusinessId">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdBusinessId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocRead.fdCompanyId">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdCompanyId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocRead.fdCompanyName">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdCompanyName"/>
				</sunbor:column>
				<sunbor:column property="yworkDocRead.fdSourceShareId">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdSourceShareId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocRead.fdDoc.fdName">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdDoc"/>
				</sunbor:column>--%>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="yworkDocRead.fdName">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdHead"/>/<bean:message bundle="third-ywork" key="yworkDocRead.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkDocRead.fdUser.fdName">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdUser"/>
				</sunbor:column>
				<sunbor:column property="yworkDocRead.fdDate">
					<bean:message bundle="third-ywork" key="yworkDocRead.fdDate"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkDocRead" varStatus="vstatus">
			<%--<tr
				kmss_href="<c:url value="/third/ywork/ywork_doc_read/yworkDocRead.do" />?method=view&fdId=${yworkDocRead.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkDocRead.fdId}">
				</td>
				<td>
					<c:out value="${yworkDocRead.fdBusinessId}" />
				</td>
				<td>
					<c:out value="${yworkDocRead.fdCompanyId}" />
				</td>
				<td>
					<c:out value="${yworkDocRead.fdCompanyName}" />
				</td>
				<td>
					<c:out value="${yworkDocRead.fdSourceShareId}" />
				</td>
				<td>
					<c:out value="${yworkDocRead.fdDoc.fdName}" />
				</td>--%>
				<tr><td>
					${vstatus.index+1}
				</td>
				<td>
					<c:if test="${!empty yworkDocRead.fdHead}">
	                    <a name="zoom" href="#${yworkDocRead.fdId }" style="text-decoration: none">
	                        <img height="28px" src='<c:out value="${yworkDocRead.fdHead}" />' style="vertical-align: middle;">
	                    </a>
	                   <div id="${yworkDocRead.fdId }" style="display:none;"><img height="200px" src='<c:out value="${yworkDocRead.fdHead}" />'></div>
                   </c:if>&nbsp;
					<%
						YworkDocRead read = (YworkDocRead)pageContext.getAttribute("yworkDocRead");
						out.print(EmojiUtil.filterEmoji(read.getFdName(), ""));
					%>
				</td>
				<td>
					<c:out value="${yworkDocRead.fdUser.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${yworkDocRead.fdDate}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<script>
$(function(){
	$('a[name="zoom"]').fancyZoom({scaleImg: true, closeOnClick: true});
});
</script>
<%@ include file="/resource/jsp/list_down.jsp"%>