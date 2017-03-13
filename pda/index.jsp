<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.third.pda.service.IPdaDataShowService"%>
<%
	session.setAttribute("S_PADFlag","1");
%>
<%@ include file="/third/pda/htmlhead4index.jsp"%>
<title><bean:message key="phone.module.title" bundle="third-pda" />
</title>
<style>
html {
	font-size: 62.5%;
	font-family: Tahoma,Arial,Roboto,"Droid Sans","Helvetica Neue","Droid Sans Fallback","Heiti SC",sans-self;
}
.header_floatLayout{
    padding:0 1.5%;
    width:97%;
    height:65px;
    background-color:#0a93e1;
    position:fixed;
    left:0;
    top:0;
}
.header_floatLayout .header_infoLeft{
    display:table;
}
.header_floatLayout .header_infoLeft .logo{
    height:35px;
    overflow:hidden;
    vertical-align:middle;
    display:table-cell;
}
.header_floatLayout .header_infoLeft .logo img{
    height:100%;
}
.header_floatLayout .header_infoLeft h1{
    padding:0 20px;
    color:#333;
    font-size:1.8rem;
    line-height:60px;
    display:table-cell;
}
.header_floatLayout .btn_shutdown{
    position:absolute;
    right:1.5%;
    top:10px;
}

.btn_shutdown{
    width:40px;
    height:32px;
    border:2px solid #2877a2;
    border-radius:8px;
    background-image:url(./resource/images/icon_shutdown.png), -webkit-linear-gradient(top,#2d9ad3 0%,#1766a9 100%);
    background-image:url(./resource/images/icon_shutdown.png),-moz-linear-gradient(top,#2d9ad3 0%,#1766a9 100%);
    background-image:url(./resource/images/icon_shutdown.png),-ms-linear-gradient(top,#2d9ad3 0%,#1766a9 100%);
    background-image:url(./resource/images/icon_shutdown.png),-o-linear-gradient(top,#2d9ad3 0%,#1766a9 100%);
    background-image:url(./resource/images/icon_shutdown.png),linear-gradient(top,#2d9ad3 0%,#1766a9 100%);
    background-repeat:no-repeat;
    background-position:50%;
    display:block;
}
.btn_shutdown:hover{
    background-image:url(./resource/images/icon_shutdown.png), -webkit-linear-gradient(top,#2d9ad3 0%,#0c518c 100%);
    background-image:url(./resource/images/icon_shutdown.png),-moz-linear-gradient(top,#2d9ad3 0%,#0c518c 100%);
    background-image:url(./resource/images/icon_shutdown.png),-ms-linear-gradient(top,#2d9ad3 0%,#0c518c 100%);
    background-image:url(./resource/images/icon_shutdown.png),-o-linear-gradient(top,#2d9ad3 0%,#0c518c 100%);
    background-image:url(./resource/images/icon_shutdown.png),linear-gradient(top,#2d9ad3 0%,#0c518c 100%);
}

.navgationWrap{
    padding:0px 0.8% 15px;
}
.navgationWrap h4{
    margin-bottom: 10px;
    margin-top: 5px;  
    padding-top:20px;
    font-size:1.3rem;
    font-weight:normal;
}

.navgationList{
    width:98%;
    padding-top:5%;
    border-radius:3px;
    border:1px solid #E7E4E4;
    display:table;
}
.navgationList ul{
    display:table-row;
}
.navgationList li{
    width:25%;
    text-align:center;
    overflow:hidden;
    display:table-cell;
}
.navgationList li a{
    text-decoration: none;
    margin:auto;
    width:90%;
    color:#333;
    display:block;
    cursor:pointer;
    /*overflow:hidden;*/
}
.navgationList li a .iconBox{
    margin:auto;
    padding:3%;
    width:80%;
    border-radius:12px;
    display:block;
    overflow:hidden;
}
.navgationList li a .iconBox img{
    width:80%;
}
.navgationList li a .txt{
    margin-top:2px;
    padding-bottom:25%;
    font-size:1.1rem;
    display:block;
}
.banner {
	height: 8%;
	width: 100%;
	background-color:#0993E0;
	position: relative;
	z-index: 100;
}
.user {
	font-size: 1.5em;
	font-weight: bolder;
	left: 135px;
	top: 10px;
	padding: 5px;
	position: absolute;
}
.logout {
	background: url(./resource/images/but_banner.png) 0px 0px no-repeat;
	height: 29px;
	width: 40px;
	right: 3px;
	top: 10px;
	position: absolute;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	function syncResource(_url){
		try{
			 var xmlhttp = {};
			 if (window.XMLHttpRequest){// 所有浏览器
				 xmlhttp = new XMLHttpRequest();
			 }else if (window.ActiveXObject){// IE5 和 IE6
				 xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			 }
			 _url = Com_SetUrlParameter(_url, "s_cache", Com_Parameter.Cache);
			 xmlhttp.open("GET", _url, false);
			 xmlhttp.setRequestHeader("Accept", "text/plain");
			 xmlhttp.setRequestHeader("Content-Type","text/plain;charset=UTF-8");
		     xmlhttp.send(null);
		}catch(e){}
	}
	function preLoad(){
		syncResource("${LUI_ContextPath}/sys/mobile/css/themes/default/ios7.css");
		syncResource("${LUI_ContextPath}/sys/mobile/css/icon/font-mui.css");
		syncResource("${LUI_ContextPath}/sys/mobile/css/themes/default/common.css");
		syncResource("${LUI_ContextPath}/sys/mobile/js/dojo/dojo.js");
		syncResource("${LUI_ContextPath}/sys/mobile/js/dojox/mobile.js");
		syncResource('<mui:min-filepath name="mui.js"/>');
		syncResource('<mui:min-filepath name="list.css"/>');
	}
</script>
</head>
<body onload="preLoad();">
	<%
		List moduleList = null;
		moduleList = (List) request.getAttribute("moduleList");
		if (moduleList == null || moduleList.size() <= 0) {
			IPdaDataShowService showService = (IPdaDataShowService) SpringBeanUtil
					.getBean("pdaDataShowService");
			moduleList = showService.getPdaModuleListByCate();
		}  
		pageContext.setAttribute("moduleList", moduleList);
	%>
<c:if test="<%=moduleList!=null && moduleList.size()>0%>">
<article class="navgationWrap">
    	<c:forEach var="module" items="${moduleList}">
            <h4>${module.cateName}</h4>
            <div class="navgationList">
            <c:choose>
				<c:when test='${fn:length(module.list)<4}'>
				    <c:if test="${fn:length(module.list)==1}">
				      <ul>
					    <c:forEach var="modulelist" items="${module.list}" varStatus="vstatus">
		                    <li>
								<a href="<c:url value="/third/pda/pda_module_config_main/pdaModuleConfigMain.do"/>?method=open&fdId=${modulelist.fdId}">
								    <span class="iconBox"><img src="<c:url value="${modulelist.fdIconUrl}"/>"/></span>
		                            <span class="txt"><c:out value="${modulelist.fdName}"></c:out></span>
								</a>
		                    </li>
		                </c:forEach>
		                <li></li><li></li><li></li>
		               </ul>
				    </c:if>
				    <c:if test="${fn:length(module.list)==2}">
				       <ul>
					    <c:forEach var="modulelist" items="${module.list}" varStatus="vstatus">
		                    <li>
								<a href="<c:url value="/third/pda/pda_module_config_main/pdaModuleConfigMain.do"/>?method=open&fdId=${modulelist.fdId}">
								    <span class="iconBox  "><img src="<c:url value="${modulelist.fdIconUrl}"/>"/></span>
		                            <span class="txt"><c:out value="${modulelist.fdName}"></c:out></span>
								</a>
		                    </li>
		                </c:forEach>
		                <li></li><li></li>
		               </ul>
				    </c:if>
				    <c:if test="${fn:length(module.list)==3}">
				      <ul>
					    <c:forEach var="modulelist" items="${module.list}" varStatus="vstatus">
		                    <li>
								<a href="<c:url value="/third/pda/pda_module_config_main/pdaModuleConfigMain.do"/>?method=open&fdId=${modulelist.fdId}">
								    <span class="iconBox  "><img src="<c:url value="${modulelist.fdIconUrl}"/>"/></span>
		                            <span class="txt"><c:out value="${modulelist.fdName}"></c:out></span>
								</a>
		                    </li>
		                </c:forEach>
		                <li></li>
		               </ul>
				    </c:if>
				</c:when>
				<c:otherwise>
					<c:forEach var="modulelist" items="${module.list}" varStatus="vstatus">
		              <c:if test="${vstatus.index % 4 == 0}">
		                <ul>
		              </c:if>
		                    <li>
								<a href="<c:url value="/third/pda/pda_module_config_main/pdaModuleConfigMain.do"/>?method=open&fdId=${modulelist.fdId}">
								    <span class="iconBox  "><img src="<c:url value="${modulelist.fdIconUrl}"/>?s_cache=${MUI_Cache}"/></span>
		                            <span class="txt"><c:out value="${modulelist.fdName}"></c:out></span>
								</a>
		                    </li>
		               <c:if test="${(vstatus.index-3) % 4 == 0 or fn:length(module.list)<4}">
		                </ul>
		               </c:if> 
	               </c:forEach>
				</c:otherwise>
			</c:choose>
            
            </div>
       </c:forEach>
</article>
</c:if>
</body>
</html>
