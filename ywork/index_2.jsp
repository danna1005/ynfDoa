<%@page import="com.landray.kmss.framework.hibernate.extend.SqlPartitionConfig"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<template:include ref="config.edit">
	<template:replace name="title">
		悦工作配置
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
	        .select-one span,.oper-select span.ycheck{background-color: #a7a7a7;margin-right:20px;display: inline-block;width: 4px;height: 4px;-webkit-border-radius: 4px;border-radius: 4px;-moz-border-radius: 4px;position: relative;top:-2px;}
	        .oper-select{margin-left: 50px;margin-top: 50px;font-size: 14px;color:#323232;}
	        .oper-select span{color:#13a4e1;;cursor: pointer;text-decoration:underline;}
	        .config-type .config-type-one span,.oper-select span.check{display: inline-block;width: 13px;height: 13px;border: 1px solid #bbb;position: relative; top: 3px;margin-right:11px;}
	        .config-type .config-type-one span.active.oper-select span.check.active{background: url(./images/selected.png) no-repeat center;}
	        .open-btn{margin-top:50px;height: 50px;text-align: center;line-height: 50px;color: #646464;font-size: 18px;border: 1px solid #b6b7bc;background-color: #e1e1e1;-webkit-border-radius: 4px;border-radius: 4px;-moz-border-radius: 4px;}
	        .open-btn.active{background-color: #4596cf;color:#fff;cursor: pointer;}
	        .config-content{margin-left:50px;border: 1px solid #e6e9f2;}
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
	        <div class="title">跨组织协同<span class="open">启用</span><span style="display: none;" class="high-mode">高级模式</span><span style="display: none;" class="close">禁用</span></div>
	        <div class="text-mod">可以有选择的让用户将企业内部的知识、新闻、流程等私有数据，安全的通过微信发送给客户、合作伙伴。并可将客户、合作伙伴等填写的数据，返回到企业内部系统中。整个传输过程全程加密，并有完善的水印、阅读记录、分享记录，供企业进行安全审计。</div>
	        <div class="pro-photo"><img src="./images/pro-mod.png"></div>
	        <div class="config" style="display: none;">
	            <div class="config-title">配置</div>
	            <div class="config-content">
	            	<iframe id="wxt" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" width="100%"></iframe>
	            </div>
	        </div>
	    </div>

	   <div style="margin-top: 	40px">
	   	 <iframe id="_wxapp" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" width="1135" height="600"></iframe>
	   </div>
	    
	    
	    <script>
	    	$(function(){
	    		 $.get("<c:url value='/third/ywork/ywork_system/yworkSystem.do?method=isOpenYWork' />",function(data){
		             if(data.isopen=='1'){
			             $("#wxt").attr("src","<c:url value='/third/ywork/ywork_module_config/yworkModuleConfig.do?method=edit' />");
			             $(".open").hide();
			             $(".open").siblings().show();
			             $(".pro-photo").hide();
			             $(".config").show();
		             }else{
						alert("微协同开启失败！");
		             }
	             },"json");

                // https://test.ywork.me/yw/static/bridge/co/index.html
  			$.get("<c:url value='/third/ywork/yworkSso.do?method=postBaseInfor2YWork&s_ajax=true' />",function(data){
	             if(data.code=='success'){
		             var includeUrl=data.data.url;
		             includeUrl="https://test.ywork.me/yw/static/bridge/co/index.html";
		             $("#_wxapp").attr("src",includeUrl);
		             $(".open").hide();
		             $(".open").siblings().show();
		             $(".pro-photo").hide();
		             $(".config").show();
	             }else{
					alert(data.data);
	             }
            },"json");
	             
	         $(".open").bind("click",function(){
	             $.get("<c:url value='/third/ywork/ywork_system/yworkSystem.do?method=openYWork&flag=1' />",function(data){
		             if(data.open=='1'){
			             $(".open").hide();
			             $(".open").siblings().show();
			             $(".pro-photo").hide();
			             $(".config").show();
		             }else{
						alert("微协同开启失败！");
		             }
	             },"json");
	         });
	         $(".close").bind("click",function(){
	             $(".open").show();
	             $(".open").siblings().hide();
	             $(".pro-photo").show();
	             $(".config").hide();
	             $.get("<c:url value='/third/ywork/ywork_system/yworkSystem.do?method=openYWork&flag=0' />");
	         });
	         
	         $(".open-btn").bind("click",function(){
	             $(".app").eq(0).hide();
	             $(".app").eq(1).show();
	         });

	         $(".check").bind("click",function(){
	        	 $(".check").removeClass("check").addClass("ycheck");
	             $(".open-btn").addClass("active");
	         });

	         $("#wxt").load(function(){
	        	 var mainheight = $("#wxt").contents().find("body").height()+150;
	        	 $("#wxt").height(mainheight);
	        }); 
		        
	    	});
	    </script>
	</template:replace>
</template:include>
