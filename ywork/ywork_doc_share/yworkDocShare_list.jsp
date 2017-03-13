<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>

<%@page import="com.landray.kmss.third.ywork.model.YworkDocShare"%>
<%@page import="com.landray.kmss.third.ywork.util.EmojiUtil"%><link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/third/ywork/css/zoom.css?v=20160422" />
<script type="text/javascript">
	Com_IncludeFile("jquery.js", null, "js");
</script>
<script type="text/javascript" src="${KMSS_Parameter_ContextPath}third/ywork/js/jquery.zoom.js?v=20160422"></script>
<html:form action="/third/ywork/ywork_doc_share/yworkDocShare.do">
	<%--<div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_doc_share/yworkDocShare.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_doc_share/yworkDocShare.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_doc_share/yworkDocShare.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkDocShareForm, 'deleteall');">
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
				<sunbor:column property="yworkDocShare.fdBusinessId">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdBusinessId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShare.fdCompanyId">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdCompanyId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShare.fdCompanyName">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdCompanyName"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShare.fdSourceShareId">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdSourceShareId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShare.fdDoc.fdName">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdDoc"/>
				</sunbor:column>--%>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="yworkDocShare.fdName">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdHead"/>/<bean:message bundle="third-ywork" key="yworkDocShare.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShare.fdUser.fdName">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdUser"/>
				</sunbor:column>
				<sunbor:column property="yworkDocShare.fdDate">
					<bean:message bundle="third-ywork" key="yworkDocShare.fdDate"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkDocShare" varStatus="vstatus">
			<%--<tr
				kmss_href="<c:url value="/third/ywork/ywork_doc_share/yworkDocShare.do" />?method=view&fdId=${yworkDocShare.fdId}">
				
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkDocShare.fdId}">
				</td>
				<td>
					<c:out value="${yworkDocShare.fdBusinessId}" />
				</td>
				<td>
					<c:out value="${yworkDocShare.fdCompanyId}" />
				</td>
				<td>
					<c:out value="${yworkDocShare.fdCompanyName}" />
				</td>
				<td>
					<c:out value="${yworkDocShare.fdSourceShareId}" />
				</td>
				<td>
					<c:out value="${yworkDocShare.fdDoc.fdName}" />
				</td>--%>
				<tr><td>
					${vstatus.index+1}
				</td>
				<td>
					<c:if test="${!empty yworkDocShare.fdHead}">
	                    <a name="zoom" href="#${yworkDocShare.fdId }" style="text-decoration: none">
	                        <img height="28px" src='<c:out value="${yworkDocShare.fdHead}" />' style="vertical-align: middle;">
	                    </a>
	                   <div id="${yworkDocShare.fdId }" style="display:none;"><img height="200px" src='<c:out value="${yworkDocShare.fdHead}" />'></div>
                   </c:if>&nbsp;
					<%
						YworkDocShare read = (YworkDocShare)pageContext.getAttribute("yworkDocShare");
						out.print(EmojiUtil.filterEmoji(read.getFdName(), ""));
					%>
				</td>
				<td>
					<c:out value="${yworkDocShare.fdUser.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${yworkDocShare.fdDate}" />
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