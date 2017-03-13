﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.log" bundle="third-im-kk"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	
	<%-- kk待办集成日志 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.kkNotifyLog" bundle="third-im-kk" />",
		"<c:url value="/third/im/kk/kkNotifyLog.do?method=list&orderby=kkNotifyLog.sendTime&ordertype=down" />"
	);
	
	<%-- kk在线感知 \.jsp--%>
	n2 = n1.AppendURLChild(
		"<bean:message key="kkAware.treeDes" bundle="third-im-kk" />",
		"<c:url value="/third/im/kk/kk_awareness/kk_awareness_help.jsp" />"
	);
	
	<%--  待办发送失败次数 --%>
	n2 = n1.AppendURLChild(
		"待办发送失败次数",
		"<c:url value="/third/im/kk/kkNotifyLog.do?method=listFailTimes" />"
	);
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>