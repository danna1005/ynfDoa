<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page import="org.apache.struts.Globals"%>
<%@page import="com.landray.kmss.util.StringUtil"%> 
<%
	session.setAttribute("S_PADFlag","1");
	String localeLang = request.getParameter("lang");
	if (localeLang != null) {
		session.setAttribute(Globals.LOCALE_KEY, ResourceUtil
				.getLocale(localeLang));
	}
%>
<%
	String times = ResourceUtil.getKmssConfigString("kmss.verifycode.times");
	String need_validation_code = (String)request.getSession().getAttribute("need_validation_code");
	String verifyCodeEnabled = ResourceUtil.getKmssConfigString("kmss.verifycode.enabled");
    if(StringUtil.isNotNull(verifyCodeEnabled)&& verifyCodeEnabled.equalsIgnoreCase("true")&&"0".equals(times)&&StringUtil.isNull(need_validation_code)){
    	request.getSession().setAttribute("need_validation_code","yes");
    }
    
%>
<template:include file="/third/pda/template.jsp" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${lfn:message('third-pda:phone.login.title') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<link type="text/css" rel="Stylesheet" href="${LUI_ContextPath}/third/pda/resource/style/login.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript">Com_IncludeFile("security.js");</script>
	</template:replace>
	<template:replace name="content">
		<form id="_form" action="<c:url value='/j_acegi_security_check'/>" method="POST" onsubmit="return kmss_onsubmit();" autocomplete="off">
		
			<%--登录头部--%>
		    <div class="muiLoginHeadBox">
		        <div class="muiLoginSculpture">
		            <div class="coverRing"></div>
		            <div class="inner"><img src="${LUI_ContextPath}/third/pda/resource/images/loginSculpture.png" alt="头像" /></div>
		        </div>
		        <div class="div_error">
					<c:set var="securityMsg" value="${ACEGI_SECURITY_LAST_EXCEPTION.message}" />
					<c:if test="${not empty securityMsg }">
						<c:choose>
							<c:when test="${securityMsg=='Bad credentials'}">
								<i class="mui mui-wrong"></i><bean:message key="login.error.password"/>
							</c:when>
							<c:otherwise>
								<i class="mui mui-wrong"></i><c:out value="${securityMsg}"/>
							</c:otherwise>
						</c:choose>
					</c:if>
				</div>
		    </div>
			
			 <ul class="muiLoginBar">
			 	<%-- 账号 --%>
	            <li>
	                <span class="iconBox"><i class="mui mui-loginAccount"></i></span>
	                <input type='text' name='j_username' value="${param.username}" placeholder="用户名"
	                	onfocus="focusInp(this,'j_password');" onkeydown="changeDisplay(this);" onkeypress="changeDisplay(this);" onkeyup="changeDisplay(this);"/>
	                <div id='j_username_del' class="inp_delete" onclick="clearOpt('j_username');">
	                	<i class="mui mui-fail"></i>
	                </div>
	            </li>
	            <%-- 密码 --%>
	            <li>
	                <span class="iconBox"><i class="mui mui-loginKey"></i></span>
	                <input type='password' name='j_password' placeholder="密码" 
	                	onfocus="focusInp(this,'j_username');" onkeydown="changeDisplay(this);" onkeypress="changeDisplay(this);" onkeyup="changeDisplay(this);" />
	                <div id='j_password_del' class="inp_delete" onclick="clearOpt('j_password');">
	                	<i class="mui mui-fail"></i>
	                </div>
	            </li>
	            <%
				if (request.getSession().getAttribute("need_validation_code") != null
						&& request.getSession()
								.getAttribute("need_validation_code").toString()
								.equals("yes")) {
				%>
				 <%-- 验证码  --%>
				 <li class="IDcodeBar">
	                <span class="iconBox"><i class="mui mui-loginIDCode"></i></span>
	                <input type='text' name='j_validation_code' placeholder="验证码"
	                	onkeydown="checkSubmitButton();" onkeypress="checkSubmitButton();" onkeyup="checkSubmitButton();"/> 
	                <span class="IDCode">
	                	<img onclick="this.src='<%=request.getContextPath()%>/vcode.jsp?xx='+Math.random()" style='cursor: pointer;' src='<c:url value="/vcode.jsp"/>' align="middle"/>
	                </span>
	            </li>
				<%
					}
				%>
	        </ul>
			<%--信息保存 #20878:因安全问题暂时移除
	        <div class="muiLoginTip">
	            <ul>
	                <li>
	                    <span class="remember" onclick="toggleIsRemember();">
	                        <span class="checkbox" id="remember"><i class="mui mui-checked"></i></span>
	                        <label for="remember">
	                        	<bean:message bundle="third-pda" key="login.recordpassword"/>
	                        </label>
	                    </span>
	                </li>
	            </ul>
	        </div>--%>
	        <%-- 登陆按钮 --%>
			<div class="muiLoginBtnBox">
	            <button class="muiLoginBtnSubmit" type="submit">
	            	<bean:message bundle="third-pda" key="login.login"/>
	            </button>
	        </div>
			<div style="display: none">
				<input type=hidden name="j_redirectto" value='<c:out value="${ACEGI_SECURITY_TARGET_URL}"/>'/> 
			</div>
			
		</form>
		<%-- 切换登陆 --%>
        <div class="muiLoginFooter">
	        <ul>
	            <li class="on">
	            	<a href="javascript:void(0);" title="手机登录">
	            		<i class="mui mui-loginMobile"></i>手机登录
	            	</a>
	            </li>
	            <li>
	            	<a href="javascript:void(0);" title="电脑登录" id="pc" onclick="changetype(this.id);">
	            		<i class="mui mui-loginPC"></i>电脑登录
	            	</a>
	            </li>
	        </ul>
	    </div>
	</template:replace>
	
</template:include>

<script type="text/javascript">
	require(['dojo/ready', 'dojo/query', 'dojo/request', 'mui/dialog/Tip', 'dojo/dom-class'],function(ready, query, request, Tip, domClass){
		var isRemember=false;
		ready(function(){
			var j_username=query('[name="j_username"]')[0],
				j_password=query('[name="j_password"]')[0];
			/* if(GetCookie("saveinfo")=="1"){
				toggleIsRemember();
				//j_password.value=GetCookie("password");
				//disableSubmitBtn(false);
			}else{
				//disableSubmitBtn(true);//登陆按钮禁用
			} */
			var username=GetCookie("username");
			if(username!=null && username!=""){
				j_username.value=username;
			}
			window.checkSubmitButton();
			setTimeout(function(){
				window.scrollTo(0, 1); 
			}, 100);
			
			query('.muiLoginFooter')[0].style.display='block';
			var h = document.documentElement.clientHeight-30;
			query('#_form')[0].style.height=h+'px';
		});
		
		//提交登陆
		window.kmss_onsubmit=function(){
			var loginInput = '<bean:message key="login.inupt"/>';//请输入用户名和密码
			var j_username=query('[name="j_username"]')[0],
				j_password=query('[name="j_password"]')[0];
			if(j_username.value==''){
				Tip.fail({
					text:loginInput
				});
				j_username.focus();
				return false;
			}
			if(j_password.value==""){
				Tip.fail({
					text:loginInput
				});
				j_password.focus();
				return false;
			}
			var j_code=query('[name="j_validation_code"]');
			if(j_code.length > 0 && j_code[0].value == ''){
				Tip.fail({
					text:'请输入验证码'
				});
				j_code[0].focus();
				return false;
			}
			var password = j_password.value;
			try{
				j_password.value = desEncrypt(j_password.value);
			}catch(e){};
			var expdate = new Date(); 
		    expdate.setTime(expdate.getTime() + (86400 * 1000 * 1)); 
			//if(isRemember){
			document.cookie="saveinfo=1"+";expires="+expdate.toGMTString();
				//document.cookie="password=" + encodeURIComponent(password)+";expires="+expdate.toGMTString();
			//}else{
			//	deleteCookie("saveinfo");
				//deleteCookie("password");
			//}
			document.cookie="username=" + encodeURIComponent(j_username.value)+";expires="+expdate.toGMTString();
			domClass.add(query('.muiLoginSculpture .coverRing')[0],'active');
			return true;
		};
		
		//切换登陆模式
		window.changetype = function(obj){
			var loading = Tip.processing("请稍后..");
			var url = "";
			var access = "1";
			if(obj == "pc"){
				url = '<c:url value="/login.jsp"/>';
				access = "0"; 
			}
			if(obj == "pda"){
				url = '<c:url value="/third/pda/login.jsp"/>';
				access = "1";
			}
			request.post('<c:url value="/third/pda/access.jsp"/>',{data:{'access':access}}).then(function(){
					loading.hide();
					location.href = url;
				},function(){
					loading.hide();
					location.href = url;
				});
	
		};
		
		window.toggleIsRemember=function(){
			isRemember=!isRemember;
			var __cb=query('.checkbox')[0];
			if(isRemember){
				domClass.add(__cb,'on');
			}else{
				domClass.remove(__cb,'on');
			}
		};
		
		function GetCookie(name){
			var arr=document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
			if(arr!=null)return decodeURIComponent(arr[2]);
			return null;
		}
		
		function deleteCookie(name) { 
			var expdate = new Date(); 
		    expdate.setTime(expdate.getTime() - (86400 * 1000 * 1)); 
		    document.cookie= name + "=;expires=" + expdate.toGMTString();
		}
		
		window.clearOpt=function(name){
			var inputObj=document.getElementsByName(name)[0];
			inputObj.value="";
			changeDisplay(inputObj);
			inputObj.focus();
		};
		
		window.changeDisplay=function(obj,optStr){
			var idStr=obj.getAttribute("name")+"_del";
			var optVar=document.getElementById(idStr);
			if(optVar!=null){
				if(obj.value.trim()==""){
					optVar.style.display="none";
				}else{
					optVar.style.display="block";
				}
			}
			if(optStr!=null){
				var otherVar=document.getElementById(optStr+"_del");
				if(otherVar!=null)
					otherVar.style.display="none";
			}
			checkSubmitButton();
		};
		
		window.focusInp=function(obj,optStr){
			obj.select();
			changeDisplay(obj,optStr);
		};
		
		//提交按钮是否可用
		window.checkSubmitButton=function(){
			var disable=true;//不可用标识
			var	j_username=query('[name="j_username"]')[0],
				j_password=query('[name="j_password"]')[0];
			if(j_username.value && j_password.value){
				var j_validation_code=query('[name="j_validation_code"]');
				if(j_validation_code.length==0){
					disable=false;
				}else{
					j_validation_code=j_validation_code[0];
					if(j_validation_code.value){
						disable=false;
					}
				}
			}
			disableSubmitBtn(disable);
		};
		
		function disableSubmitBtn(disable){
			if(disable){
				domClass.add(query('.muiLoginBtnSubmit')[0],'disable');
			}else{
				domClass.remove(query('.muiLoginBtnSubmit')[0],'disable');
			}
		}
		
		
	});
</script>
