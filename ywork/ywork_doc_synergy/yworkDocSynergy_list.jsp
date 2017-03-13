<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>

<%@page import="com.landray.kmss.third.ywork.util.EmojiUtil"%><style type="text/css">
.tb_normal{width:98%;background-color: #ffffff;border-collapse: collapse;border: 1px #d2d2d2 solid;padding: 8px !important;text-align: left; margin: 0 auto;}
.tb_normal>tbody>.tr_normal_title{ background-color:#f6f6f6; text-align:center;}
.tb_normal>tbody>tr{border-bottom: 1px solid #d2d2d2;border-top: 1px solid #d2d2d2;}
.tb_normal>tbody>tr>td {padding: 8px; word-break:break-word; border-left: 1px #d2d2d2 solid; border-right: 1px #d2d2d2 solid; }
.tb_normal>tbody>tr>.td_normal_title{ background-color:#f6f6f6;}
</style>
<%@page import="com.landray.kmss.third.ywork.model.YworkDocSynergy"%>
<%@page import="java.util.Iterator"%><link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/third/ywork/css/zoom.css?v=20160422" />
<script type="text/javascript">
	Com_IncludeFile("jquery.js", null, "js");
</script>
<script type="text/javascript" src="${KMSS_Parameter_ContextPath}third/ywork/js/jquery.zoom.js?v=20160422"></script>
<html:form action="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do">
<%-- <div id="optBarDiv">
		<kmss:auth requestURL="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do?method=add">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do" />?method=add');">
		</kmss:auth>
		<kmss:auth requestURL="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do?method=deleteall">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.yworkDocSynergyForm, 'deleteall');">
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
				<sunbor:column property="yworkDocSynergy.fdBusinessId">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdBusinessId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdCompanyId">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdCompanyId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdCompanyName">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdCompanyName"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdSourceShareId">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdSourceShareId"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdDoc.fdName">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdDoc"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdData">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdData"/>
				</sunbor:column>
				--%>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="yworkDocSynergy.fdName">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdHead"/>/<bean:message bundle="third-ywork" key="yworkDocSynergy.fdName"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdUser.fdName">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdUser"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdDate">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdDate"/>
				</sunbor:column>
				<sunbor:column property="yworkDocSynergy.fdDataInfo">
					<bean:message bundle="third-ywork" key="yworkDocSynergy.fdDataInfo"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="yworkDocSynergy" varStatus="vstatus">
			<%-- <tr
				kmss_href="<c:url value="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do" />?method=view&fdId=${yworkDocSynergy.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${yworkDocSynergy.fdId}">
				</td>
				<td>
					<c:out value="${yworkDocSynergy.fdBusinessId}" />
				</td>
				<td>
					<c:out value="${yworkDocSynergy.fdCompanyId}" />
				</td>
				<td>
					<c:out value="${yworkDocSynergy.fdCompanyName}" />
				</td>
				<td>
					<c:out value="${yworkDocSynergy.fdSourceShareId}" />
				</td>
				<td>
					<c:out value="${yworkDocSynergy.fdDoc.fdName}" />
				</td>
				<td>
					<c:out value="${yworkDocSynergy.fdData}" />
				</td>
				--%>
				<tr>
				<td>
					${vstatus.index+1}
				</td>
				<td valign="middle">
					<c:if test="${!empty yworkDocSynergy.fdHead}">
	                    <a name="zoom" href="#${yworkDocSynergy.fdId }" style="text-decoration: none">
	                        <img height="28px" src='<c:out value="${yworkDocSynergy.fdHead}" />' style="vertical-align: middle;">
	                    </a>
	                   <div id="${yworkDocSynergy.fdId }" style="display:none;"><img height="200px" src='<c:out value="${yworkDocSynergy.fdHead}" />'></div>
                   </c:if>&nbsp;
					<%
						YworkDocSynergy read = (YworkDocSynergy)pageContext.getAttribute("yworkDocSynergy");
						out.print(EmojiUtil.filterEmoji(read.getFdName(), ""));
					%>
				</td>
				<td>
					<c:out value="${yworkDocSynergy.fdUser.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${yworkDocSynergy.fdDate}" />
				</td>
				<td>
					<a href="#${yworkDocSynergy.fdId}w" onclick="pzoom('${yworkDocSynergy.fdId}w');"><bean:message bundle="third-ywork" key="ywork.share.form.info"/></a>
					<%
						YworkDocSynergy synergy = (YworkDocSynergy)pageContext.getAttribute("yworkDocSynergy");
						if(synergy!=null){
							String jsonStr = synergy.getFdDataInfo();
							if(StringUtil.isNotNull(jsonStr)){
								JSONObject json = JSONObject.fromObject(jsonStr);
								Iterator<String> it = json.keys();
								String key = null;
								StringBuffer sb = new StringBuffer();
								sb.append("<div id='"+synergy.getFdId()+"w' style='display:none;'><table class='tb_normal' style='width:100%'><tr>");
								int count = 0;
								int tdcount = 0;
								while(it.hasNext()){
									key = it.next();
									count++;
									tdcount++;
									sb.append("<td class='td_normal_title' width='15%'>"+key+"</td><td width='35%'>"+json.get(key)+"</td>");
									if(count%2==0){
										sb.append("</tr><tr>");
									}
								}
								if(tdcount%2!=0){
									sb.append("<td class='td_normal_title' width='15%'></td><td width='35%'></td>");
								}
								sb.append("</tr></table></div>");
								out.print(sb.toString());
							}
						}
					%>
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
	//$('a[name="word"]').fancyZoom({width:820, height:800});
});
function pzoom(c){
    var dl=$(window.parent.document).find("#dialog");
    dl.html($("#"+c).html());
    var da = $(window.parent.document).find("#dialogOpen");
    da.click();
}
</script>
<%@ include file="/resource/jsp/list_down.jsp"%>