<%@page import="com.landray.kmss.framework.hibernate.extend.SqlPartitionConfig"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="config.edit">
	<template:replace name="title">
		<bean:message bundle="third-ywork" key="module.third.work.tree.setting"/>
	</template:replace>
	<template:replace name="head">
		<style>
	        .clear{content:"";display:block;height:0;clear:both;visibility:hidden;}
	        body{font-family:"Helvetica Neue", "微软雅黑";padding: 20px;}
	        .logo{width: 100px;height: 40px;background: url(./images/logo.png) no-repeat center;}
	        .content,.app{border: 1px solid #e6e9f2;padding: 10px;margin-top:20px;}
	        .app{margin-top: 50px;}
	        .title{height: 40px;line-height: 40px;font-size: 18px;color: #323232;font-weight: bold;border-bottom: 1px solid #eee;position: relative;}
	        .app .title{border-bottom:none;}
	        .app .btn{cursor:pointer;width: 300px;height: 50px;text-align:center;line-height: 50px;background-color: #ff9000;color: #fff;font-size: 18px;-webkit-border-radius: 5px;border-radius:5px;-moz-border-radius:5px;    margin: 0 auto;margin-top: 20px;}
	        .title span{display:inline-block;height: 30px;padding: 0 15px;;line-height: 30px;text-align: center;font-size: 14px;font-weight: 100;color: #fff;background-color: #13a4e1;cursor: pointer;position: absolute;}
	        .title .open{right: 0px;bottom:5px;}
	        .title .close{right: 0px;bottom:5px;background-color:#f5f5f5;border: 1px solid #e6e9f2;color:#323232;}
	        .title .high-mode{right: 80px;bottom:5px;background-color:#f17436;border: 1px solid #e6e9f2;color:#fff;}
	        .text-mod{font-size: 16px;color:#646464;line-height: 20px;margin-top: 20px;}
	        .pro-photo{height: 312px;background: url(./images/pro-back.png) repeat-x center;margin-top: 10px;padding-top: 20px;}
	        .pro-photo img{margin: 0 auto;display: block;}
	        .right{width: 400px;float: right;margin-right:50px;}
	        .left{margin-right: 450px;}
	        .two-title{margin-top: 25px;line-height: 50px;font-size: 18px;color: #323232;}
	        .server-list{margin-top: 10px;display: inline-block;}
	        .server-one{width: 68px;height: 100px;float: left;margin-right: 50px;font-size: 14px;color:#646464;}
	        .server-one .photo{width: 68px;height: 68px;}
	        .server-one .photo.forum{background: url(./images/forum.png) repeat-x center;}
	        .server-one .photo.process{background: url(./images/process.png) repeat-x center;}
	        .server-one .photo.news{background: url(./images/news.png) repeat-x center;}
	        .server-one .photo.task{background: url(./images/task.png) repeat-x center;}
	        .server-one .photo.log{background: url(./images/log.png) repeat-x center;}
	        .server-one .photo.vote{background: url(./images/vote.png) repeat-x center;}
	        .server-one .photo.app-task{background: url(./images/app-task.png) repeat-x center;}
	        .server-one .photo.notice{background: url(./images/notice.png) repeat-x center;}
	        .server-one .photo.more{background: url(./images/more.png) repeat-x center;}
	        .server-one .server-title{height: 33px;line-height: 33px;text-align: center;}
	        .oper{background-color: #f8f8fa;height: 360px;width: 360px;border:1px solid #e6e9f2;margin-top: 23px;padding: 20px;margin-bottom:20px;}
	        .select-one{margin-left: 50px;font-size: 14px;color:#646464;margin-top:15px;}
	        .select-one span{background-color:#a7a7a7;margin-right:20px;display: inline-block;width: 4px;height: 4px;-webkit-border-radius: 4px;border-radius: 4px;-moz-border-radius: 4px;position: relative;top:-2px;}
	        
	        .oper-select{margin-left: 50px;margin-top: 50px;font-size: 14px;color:#323232;}
	        .oper-select span{color:#13a4e1;;cursor: pointer;text-decoration:underline;}
	        .config-type .config-type-one span,.oper-select span.check{display: inline-block;width: 13px;height: 13px;border: 1px solid #bbb;position: relative; top: 3px;margin-right:11px;}
	        .oper-select span.check.ycheckbox{background: url(./images/selected.png) no-repeat center;}
	        .config-type .config-type-one span.active.oper-select span.check.active{background: url(./images/selected.png) no-repeat center;}
	        .open-btn{margin-top:50px;height: 50px;text-align: center;line-height: 50px;color: #646464;font-size: 18px;border: 1px solid #b6b7bc;background-color: #e1e1e1;-webkit-border-radius: 4px;border-radius: 4px;-moz-border-radius: 4px;}
	        .open-btn.active{background-color: #4596cf;color:#fff;cursor: pointer;}
	        .config-content{margin-left:50px;border: 1px solid #e6e9f2;height: 100%}
	        .config-title{line-height: 40px;height: 40px;font-size: 16px;color:#323232;}
	        .config-type{background-color: #f5f5f5;line-height: 50px;font-size: 14px;color:#323232;position: relative;border-bottom: 1px solid #e6e9f2;}
	        .config-type .config-type-btn{position: absolute;top: 10px;right: 10px;height: 30px;width: 100px;text-align: center;line-height: 30px;font-size: 14px;color:#fff;background-color: #13a4e1;cursor: pointer;}
	        .config-type .config-type-one{margin-left:10px;font-size: 14px;color:#323232;}
	        .config-type .config-type-one span{border: 1px solid #aaa;margin-right:5px;}
	        .config-list{font-size: 14px;color:#646464;line-height: 30px;border-bottom: 1px solid #e6e9f2;}
	        .config-list:last-child{border-bottom: none;}
	    </style>
	</template:replace>
	<template:replace name="content"> 
		<div class="logo"></div>
	    <div class="content">
	        <div class="title"><bean:message bundle="third-ywork" key="ywork.index.org"/><span class="open"><bean:message bundle="third-ywork" key="ywork.index.open"/></span><%-- <span style="display: none;" class="high-mode">高级模式</span> --%><span style="display: none;" class="close"><bean:message bundle="third-ywork" key="ywork.index.disabled"/></span></div>
	        <div class="text-mod"><bean:message bundle="third-ywork" key="ywork.index.org.desc"/></div>
	        <div class="pro-photo" <c:if test="${isOpen=='true'}">style="display: none;"</c:if>><img src="./images/pro-mod.png"></div>
	        <div class="config" style="display: none;">
	            <div class="config-title"><bean:message bundle="third-ywork" key="ywork.index.config"/></div>
	            <div class="config-content">
	            	<iframe id="wxt" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" width="100%" ></iframe>
	            </div>
	        </div>
	    </div>
	    <div class="app" id="_noAuth">
	         <div class="title"><bean:message bundle="third-ywork" key="ywork.index.appshop"/></div>
	         <div class="right">
	              <div class="oper">
	                  <div class="title"><bean:message bundle="third-ywork" key="ywork.index.appshop.open.need.auth"/></div>
	                  <div class="select-one"><span></span><bean:message bundle="third-ywork" key="ywork.index.company.info"/></div>
	                  <div class="select-one"><span></span><bean:message bundle="third-ywork" key="ywork.index.company.org.info"/></div>
	                  <div class="select-one"><span></span><bean:message bundle="third-ywork" key="ywork.index.person.info"/></div>
	                  <div class="select-one"><span></span><bean:message bundle="third-ywork" key="ywork.index.access.auth"/></div>
	                  <div class="oper-select"><span class="check" style=""></span><bean:message bundle="third-ywork" key="ywork.index.readed"/><span><bean:message bundle="third-ywork" key="ywork.index.ywork.protocol"/></span></div>
	                  <div class="open-btn" id="_doAuth"><bean:message bundle="third-ywork" key="ywork.index.start"/></div>
	              </div>
	         </div>
	         <div class="left">
	             <div class="text-mod"><bean:message bundle="third-ywork" key="ywork.index.start.desc"/></div>
	             <div class="two-title"><bean:message bundle="third-ywork" key="ywork.index.private.service"/></div>
	             <div class="server-list">
	                  <div class="server-one">
	                      <div class="photo forum"></div>
	                      <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.forum"/></div>
	                  </div>
	                 <div class="server-one">
	                     <div class="photo process"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.review"/></div>
	                 </div>
	                 <div class="server-one">
	                     <div class="photo news"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.news"/></div>
	                 </div>
	                 <div class="server-one">
	                     <div class="photo task"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.task"/></div>
	                 </div>
	                 <div class="server-one">
	                     <div class="photo more"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.more"/></div>
	                 </div>
	                 <div class="clear"></div>
	             </div>
	             <div class="two-title"><bean:message bundle="third-ywork" key="ywork.index.cloud.app"/></div>
	             <div class="server-list">
	                 <div class="server-one">
	                     <div class="photo log"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.logs"/></div>
	                 </div>
	                 <div class="server-one">
	                     <div class="photo vote"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.vote"/></div>
	                 </div>
	                 <div class="server-one">
	                     <div class="photo app-task"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.work"/></div>
	                 </div>
	                 <div class="server-one">
	                     <div class="photo notice"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.inform"/></div>
	                 </div>
	                 <div class="server-one">
	                     <div class="photo more"></div>
	                     <div class="server-title"><bean:message bundle="third-ywork" key="ywork.index.module.more"/></div>
	                 </div>
	                 <div class="clear"></div>
	             </div>
	         </div>
	         <div class="clear"></div>
	    </div>
	    <div class="app" style="display: none;" id="_inAppShop">
	        <div class="title"><bean:message bundle="third-ywork" key="ywork.index.appshop"/></div>
	        <div class="text-mod"><bean:message bundle="third-ywork" key="ywork.index.private.service.desc"/><br/><bean:message bundle="third-ywork" key="ywork.index.light.app"/></div>
	        <div class="btn" id="_inAppCenter"><bean:message bundle="third-ywork" key="ywork.index.enter.appshop"/></div>
	    </div>
	    <div class=""></div>
	    
	    <script>
	    	$(function(){
		    	//分享组件
		    	var isOpen = '${isOpen}';
		    	if(isOpen=='true'){
		             $("#wxt").attr("src","<c:url value='/third/ywork/ywork_module_config/yworkModuleConfig.do?method=edit' />");
		             $(".open").hide();
		             $(".open").siblings().show();
		             $(".pro-photo").hide();
		             $(".config").show();
		    	}

	    		 //应用商店
	    		 var appShopIsOpen='${appShopFlag}';
		             if(appShopIsOpen=='true'){
			             $("#_noAuth").hide("fast");
			             $("#_inAppShop").show();
		             }else{
			             $("#_noAuth").show();
			             $("#_inAppShop").hide("fast");
			             //$("#_inAppShop").css('display','none'); 
		             }

	             $.get("<c:url value='/third/ywork/yworkSso.do?method=pushYworkVersionToYworkPlatform' />",function(data){
	            	 console.error(data.msg);
	             },"json");
		                 
		     //开启分享组件      serviceId=100
	         $(".open").bind("click",function(){
	             $.get("<c:url value='/third/ywork/ywork_system/yworkSystem.do?method=openYWork&serviceId=100&flag=1' />",function(data){
		             if(data.open=='1'){
		            	 $("#wxt").attr("src","<c:url value='/third/ywork/ywork_module_config/yworkModuleConfig.do?method=edit' />");
			             $(".open").hide();
			             $(".open").siblings().show();
			             $(".pro-photo").hide();
			             $(".config").show();
		             }else{
						alert('<bean:message bundle="third-ywork" key="ywork.index.synergy.open.fail"/>');
		             }
	             },"json");
	         });

	         //开启应用商店  serviceId=200 
	         $("#_doAuth").bind("click",function(){
		         if($("#_doAuth").hasClass("active")){
		        	 $.get("<c:url value='/third/ywork/yworkSso.do?method=postBaseInfor2YWork&serviceId=200&flag=1&s_ajax=true' />",function(data){
			             if(data.code==0){
			            	  $("#_noAuth").hide("fast");
			            	  $("#_inAppShop").show("fast");
			             }else{
			            	console.error(data.msg);
							alert('<bean:message bundle="third-ywork" key="ywork.index.appshop.open.fail"/>');
			             }
		             },"json");
		         }
	         });

	        $("#_inAppCenter").bind("click",function(){
	        	 $.get("<c:url value='/third/ywork/yworkSso.do?method=inAppCenter&s_ajax=true' />",function(data){
		             if(data.code==0){
		            	 window.open(data.url);
		             }else{
		            	 console.error(data.msg);
						alert('<bean:message bundle="third-ywork" key="ywork.index.appshop.enter.fail"/>');
		             }
		      },"json");
	        });
	         
	         $(".close").bind("click",function(){
	             $(".open").show();
	             $(".open").siblings().hide();
	             $(".pro-photo").show();
	             $(".config").hide();
	             $.get("<c:url value='/third/ywork/ywork_system/yworkSystem.do?method=openYWork&serviceId=100&flag=0' />");
	         });
	         
	         /*$(".open-btn").bind("click",function(){
	             $(".app").eq(0).hide();
	             $(".app").eq(1).show();
	         });
	         */

	         $(".check").bind("click",function(){
		         if(!$(".check").hasClass("ycheckbox")){
		        	 $(".check").addClass("ycheckbox");
		             $(".open-btn").addClass("active");
			      }else{
			    	  $(".check").removeClass("ycheckbox");
			          $(".open-btn").removeClass("active");
			      }
	        	 
	         });
	    	});
	    </script>
	    <script>
		    var browserVersion = window.navigator.userAgent.toUpperCase();
		    var isOpera = false, isFireFox = false, isChrome = false, isSafari = false, isIE = false;
		    function reinitIframe(iframeId, minHeight) {
		        try {
		            var iframe = document.getElementById(iframeId);
		            var bHeight = 0;
		            if (isChrome == false && isSafari == false){
		                bHeight = iframe.contentWindow.document.getElementsByTagName("table")[0].scrollHeight;
		            }
		            var dHeight = 0;
		            if (isFireFox){
		                dHeight = iframe.contentWindow.document.getElementsByTagName("table")[0].offsetHeight + 2;
		            }else if (!isIE && !isOpera){
		                dHeight = iframe.contentWindow.document.getElementsByTagName("table")[0].scrollHeight;
		            }else if (isIE && -[1,] ) {
		            } //ie9+
		            else
		                bHeight += 3;
	
		            var height = Math.max(bHeight, dHeight)+30;
		            iframe.style.height = height + "px";
		        } catch (ex) {
		        }
		    }
		    function startInit(iframeId, minHeight) {
		        isOpera = browserVersion.indexOf("OPERA") > -1 ? true : false;
		        isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
		        isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
		        isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
		        if (!!window.ActiveXObject || "ActiveXObject" in window)
		            isIE = true;
		        window.setInterval("reinitIframe('" + iframeId + "'," + minHeight + ")", 100);
		    }
		    startInit('wxt', 250);
	    </script>
	</template:replace>
</template:include>
