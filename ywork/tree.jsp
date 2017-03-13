<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="module.third.ywork" bundle="third-ywork"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;

	
	<kmss:authShow roles="ROLE_THIRDYWORK_ADMIN">
	<%-- n2 = n1.AppendURLChild(
		"<bean:message key="module.third.ywork.tree.setting.open" bundle="third-ywork"/>",
		"<c:url value="/third/ywork/yworkSso.do?method=postBaseInfor2YWork" />"
	);--%>
	<%-- 悦工作配置 --%>
	<%--n3 = n1.AppendURLChild(
		"<bean:message key="module.third.ywork.tree.setting" bundle="third-ywork"/>",
		"<c:url value="/third/ywork/yworkMainConfig.do?method=edit" />"
	);
	n2 = n1.AppendURLChild(
		"悦工作的开通配置",
		"<c:url value="/third/ywork/yworkSso.do?method=toViewYWork" />"
	);--%>
	</kmss:authShow>
	
	n2 = n1.AppendURLChild(
		"悦工作配置",
		"<c:url value="/third/ywork/index.jsp" />"
	);
	<%-- 文档信息 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.yworkDoc" bundle="third-ywork" />",
		"<c:url value="/third/ywork/ywork_doc/yworkDoc.do?method=list" />"
	);
	<%-- 类别配置 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.yworkCategoryConfig" bundle="third-ywork" />",
		"<c:url value="/third/ywork/ywork_category_config/yworkCategoryConfig.do?method=list" />"
	);
	<%-- 模块配置 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.yworkModuleConfig" bundle="third-ywork" />",
		"<c:url value="/third/ywork/ywork_module_config/yworkModuleConfig.do?method=list" />"
	);
	<%-- 微协同系统配置 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.yworkSystem" bundle="third-ywork" />",
		"<c:url value="/third/ywork/ywork_system/yworkSystem.do?method=list" />"
	);
	<%-- 授权配置信息 --%>
	n2 = n1.AppendURLChild(
		"<bean:message key="table.yworkToken" bundle="third-ywork" />",
		"<c:url value="/third/ywork/ywork_token/yworkToken.do?method=list" />"
	);
	
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>