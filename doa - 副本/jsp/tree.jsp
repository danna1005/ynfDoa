<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.third.doa" bundle="third-doa"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	
	n2 = n1.AppendURLChild(
		"<bean:message bundle="third-doa" key="doa.initAuth"/>",
		"<c:url value="/third/doa/doa_application/doaApplication.do?method=initAuth"/>");
	
	// 参数设置
	n2=n1.AppendURLChild(
		"<bean:message key="doa.paramSet" bundle="third-doa" />",
		"<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.third.doa.model.DoaConfig" />"
	);
	n2 = n1.AppendURLChild(
		"数据刷新",
		"<c:url value="/third/doa/jsp/config/doa_refresh.jsp"/>");
	<%-- 消息 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaMsg" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_msg/doaMsg.do?method=list" />"
	);
	
	<%-- 我的日常 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaDiaryApp" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_diary_app/doaDiaryApp.do?method=list" />"
	);
	<%-- 应用分类 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaAppCategory" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_app_category/doaAppCategory.do?method=list" />"
	);
	<%-- 应用 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaApplication" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_application/doaApplication.do?method=list" />"
	);
	<%-- 问题分类 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaProblemType" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_problem_type/doaProblemType.do?method=list" />"
	);
	<%-- IT问题 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaProblem" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_problem/doaProblem.do?method=list" />"
	);
	
	<%-- IT处理人 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaProblemHandler" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_problem_handler/doaProblemHandler.do?method=list" />"
	);
	
	<%-- IT系统配置 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaProblemparams" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_problem_params/doaProblemParams.do?method=list" />"
	);
	
	
	<%-- IT知识库 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaItKnowledge" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_it_knowledge/doaItKnowledge.do?method=list" />"
	);
	
	
        <%-- 反馈 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaFeedback" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_feedback/doaFeedback.do?method=list" />"
	);
	
	<%-- 座位位置 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaLocation" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_location/doaLocation.do?method=list" />"
	);
	<%-- 人员位置 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaPersonLocation" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_person_location/doaPersonLocation.do?method=list" />"
	);
        <%-- 日志 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.doaLog" bundle="third-doa" />",
		"<c:url value="/third/doa/doa_log/doaLog.do?method=list" />"
	);
	
	<% if(UserUtil.checkRole("ROLE_THIRDDOA_NOTICE_MANAGE")){ %>
	<%-- 通知消息的维护等 --%>
	n2 = n1.AppendURLChild(
		"首页通知",
		"<c:url value="/third/doa/doa_notice/doaNotice.do?method=list" />"
	);
	<% } %>
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>