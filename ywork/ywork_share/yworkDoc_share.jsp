<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>

<%@page import="com.landray.kmss.third.ywork.service.IYworkDocService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.third.ywork.model.YworkDoc"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%
	String modelId = (String)request.getParameter("modelId");
	String modelName = (String)request.getParameter("modelName");
	String templateId = (String)request.getParameter("templateId");
	String allPath = (String)request.getParameter("allPath");
	String readRecord = (String)request.getParameter("readRecord");
	String shareRecord = (String)request.getParameter("shareRecord");
	String showTag = (String)request.getParameter("showTag");
	if(StringUtil.isNull(showTag)){
		showTag = "true";
	}
	request.setAttribute("showTag",showTag);
	IYworkDocService docService = (IYworkDocService)SpringBeanUtil.getBean("yworkDocService");
	//接口方式调用
	request.setAttribute("status","0");
	Object doc = request.getAttribute("ydoc");
	if(doc!=null&&StringUtil.isNotNull(((YworkDoc)doc).getFdCodeUrl())){
		request.setAttribute("status","1");
		request.setAttribute("codeUrl",((YworkDoc)doc).getFdCodeUrl());
	}else{
		boolean flag = docService.isShare(modelId,modelName,templateId);
		if(flag){
			request.setAttribute("status","1");
		}
	}
	boolean wxflag = docService.isWXCodeShare(templateId);
	if(wxflag){
		request.setAttribute("showq","1");
	}else{
		request.setAttribute("showq","0");
	}
%>

<c:if test="${status=='1'}">
	<style>
		.tip{color: white;width: 100%;height: 100%;background-color:black;position: relative;font-size: 16px;}
		.timg{width: 100%;height: 100%;}
		.shareOuter{border: 1px solid #e1e1e1;padding: 10px; background:#fff;width:150px;height:170px;position:fixed;right:-170px;top:50%; margin-top:-85px;}
		#shareMain{padding: 30px 0;cursor:pointer;position:absolute;right:170px;top:40px; background:#5c93e0;width: 30px;text-align: center;height: 50px;color:#fff;-webkit-border-radius: 5px 0  0 5px; border-radius: 5px 0  0 5px;border-radius: 5px 0  0 5px;}
	</style>
	<style>
        .clear{content:"";display:block;height:0;clear:both;visibility:hidden;}
        body{font-family:"Helvetica Neue", "微软雅黑";padding: 20px;}
        .tab{border-bottom: 1px solid #d8dadd;}
        .tab>span{cursor: pointer;margin-bottom:-1px;color:#a9b1ba;display:inline-block;height: 30px;width:70px;margin-right:20px;text-align: center;line-height: 30px;}
        .tab>span.active{color:#323232;border-bottom: 1px solid #2268a8;}
    </style>
	<script type="text/javascript">
			Com_IncludeFile("jquery.js", null, "js");
	</script>
	<script type="text/javascript" src="${KMSS_Parameter_ContextPath}third\ywork\js\jquery.qrcode.min.js?v=20160422"></script>
	<script type="text/javascript" src="${KMSS_Parameter_ContextPath}resource/js/jquery-ui/jquery.ui.js?v=20160422"></script>
	
	<div class="shareOuter" id="shareCode" style="z-index: 9999">
		<span id="shareMain" style="font-size: 16px;"><bean:message bundle="third-ywork" key="ywork.share"/></span>
		<font size="2"><bean:message bundle="third-ywork" key="ywork.weixin.share"/></font>
	</div>
	
	<script>
		var timer = null;
		function starMove(target){
			var speed = 0;
			if( $(outer).css("right")=="-170px" ){
				 speed = 5;
			}else{
				 speed = -5;
			}
			clearInterval(timer);
			timer = setInterval(
				function(){
					 if($(outer).css("right")==(target+"px")){
						 clearInterval(timer);							 
					 }else{
						 $(outer).css("right",parseInt($(outer).css("right").replace("px",""))+speed+"px");
					 }          
				}
			,30);
		}
		var outer=$(".shareOuter").eq(0);
		$(outer).bind("click",function(){
			if($(outer).css("right")=="-170px"){
				var fdModelId = '${param.modelId}';
				var fdModelName = '${param.modelName}';
				var templateId = '${param.templateId}';
				var fdAllPath = '${param.allPath}';
				if($(outer).find("canvas").length==0){
					var error = '${error}';
					if(error!=''){
						if(error=='0'){
							var codeUrl = '${codeUrl}';
							$("#shareCode").html("");
							$("#shareCode").html('<span id="shareMain" style="font-size: 16px;"><bean:message bundle="third-ywork" key="ywork.share"/></span><font size="2"><bean:message bundle="third-ywork" key="ywork.weixin.share"/></font>');
							$("#shareCode").qrcode({ 
							    render: "canvas", //canvas方式 
							    width: 150, //宽度 
							    height:150, //高度 
							    text: codeUrl //任意内容 
							});
							starMove(0);
						}else{
							$("#shareCode").html("");
							var imgurl = '<c:url value="/third/ywork/images/indexWXError.png" />';
							var img = '<span id="shareMain" style="font-size: 16px;"><bean:message bundle="third-ywork" key="ywork.share"/></span><div class="tip"><bean:message bundle="third-ywork" key="ywork.share.error.info"/><div class="timg"><img style="width: 150px;height: 170px;margin-top: -147px;opacity:0.1;" src="'+imgurl+'" /></div></div>';
							$("#shareCode").html(img);
							starMove(0);
						}
					}else{
						var url = '<c:url value="/third/ywork/ywork_doc/yworkDoc.do?method=findDocURL" />';
						url += "&fdModelId="+fdModelId+"&fdModelName="+fdModelName+"&fdTemplateId="+templateId+"&fdAllPath="+encodeURI(fdAllPath);
						$.post(url,function(data){
							status = data.status;
							if(data.status=="1"){
								$("#shareCode").html("");
								$("#shareCode").html('<span id="shareMain" style="font-size: 16px;"><bean:message bundle="third-ywork" key="ywork.share"/></span><font size="2"><bean:message bundle="third-ywork" key="ywork.weixin.share"/></font>');
								$("#shareCode").qrcode({ 
								    render: "canvas", //canvas方式 
								    width: 150, //宽度 
								    height:150, //高度 
								    text: data.codeUrl //任意内容 
								});
								starMove(0);
							}else if(data.status=="0"){
								$("#shareCode").html("");
								var imgurl = '<c:url value="/third/ywork/images/indexWXError.png" />';
								var img = '<span id="shareMain" style="font-size: 16px;"><bean:message bundle="third-ywork" key="ywork.share"/></span><div class="tip"><bean:message bundle="third-ywork" key="ywork.share.error.info"/><div class="timg"><img style="width: 150px;height: 170px;margin-top: -147px;opacity:0.1;" src="'+imgurl+'" /></div></div>';
								$("#shareCode").html(img);
								starMove(0);
							}else{
								$("#shareCode").html("");
								var imgurl = '<c:url value="/third/ywork/images/newsWord.png" />';
								var img = '<span id="shareMain" style="font-size: 16px;"><bean:message bundle="third-ywork" key="ywork.share"/></span><img style="width:160px;height:160px;margin-left:-5px;margin-top:5px;" src="'+imgurl+'" /></div>';
								$("#shareCode").html(img);
								starMove(0);
							}
						},"json");
					}
				}else if($(outer).find("canvas").length==1){
					starMove(0);
				}
			}else{
				starMove(-170);
			}
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
	            } else{//ie9+
	                bHeight += 3;
	            }
			
	            var height = Math.max(bHeight, dHeight)+30;
	            if(height<minHeight)
	            	height = minHeight;
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
        $(function(){
			 $(".tab>span").bind("click",function(){
	            var obj = $(this);
	            var index = $(obj).index();
	            $(obj).addClass("active").siblings("span").removeClass("active");
	            $(".all-list div").eq(index).show().siblings().hide();
	            var iframeid = $(".all-list div").eq(index).children("iframe").attr("id");
	            if("logSynergyContent"==iframeid&&typeof($("#logSynergyContent").attr("src"))=="undefined"){
					$("#logSynergyContent").attr("src",'<c:url value="/third/ywork/ywork_doc_synergy/yworkDocSynergy.do" />?method=list&modelId=${param.modelId}&modelName=${param.modelName}');
	            }else if("logReadContent"==iframeid&&typeof($("#logReadContent").attr("src"))=="undefined"){
	            	$("#logReadContent").attr("src",'<c:url value="/third/ywork/ywork_doc_read/yworkDocRead.do" />?method=list&modelId=${param.modelId}&modelName=${param.modelName}');
	            }else if("logShareContent"==iframeid&&typeof($("#logShareContent").attr("src"))=="undefined"){
	            	$("#logShareContent").attr("src",'<c:url value="/third/ywork/ywork_doc_share/yworkDocShare.do" />?method=list&modelId=${param.modelId}&modelName=${param.modelName}');
	            }
	        });
			//初始化第一个为选择数据
			 $(".tab>span:first").addClass("active");
			 $(".tab>span:first").click();
			 $(".all-list>div:gt(0)").hide();
        });

        $(function() {
            $("#dialog").dialog({modal: true,resizable: true,width:800,autoOpen: false});
        });

        function dialogOpen(){
        	$("#dialog").dialog("open");
        }
        
    </script>
    <c:if test="${showTag == 'true' }">
		<ui:content title="${ lfn:message('third-ywork:ywork.share.weixin.log') }">
			<div class="tab">
				<c:if test="${param.synergyRecord=='true'}">
					<span>${ lfn:message('third-ywork:table.yworkDocSynergy') }</span>
				</c:if>
		        <c:if test="${param.readRecord=='true'}">
		        	<span>${ lfn:message('third-ywork:table.yworkDocRead') }</span>
		        </c:if>
		        <c:if test="${param.shareRecord=='true'}">
		        	<span>${ lfn:message('third-ywork:table.yworkDocShare') }</span>
		        </c:if>
		        <div class="clear"></div>
		    </div>
		    <div class="all-list">
				<c:if test="${param.synergyRecord=='true'}">
		        	<div>
						<iframe id="logSynergyContent" width="100%" frameborder=0 scrolling=no></iframe>
						<script>
							startInit('logSynergyContent', 100);
						</script>
						<div id=dialog></div><a id="dialogOpen" onclick="dialogOpen();"></a>
					</div>
				</c:if>
		       	<c:if test="${param.readRecord=='true'}">
		        	<div>
						<iframe id="logReadContent" width="100%" frameborder=0 scrolling=no></iframe>
						<script>
							startInit('logReadContent', 300);
						</script>
		        	</div>
				</c:if>
		       	<c:if test="${param.shareRecord=='true'}">
		       		<div>
						<iframe id="logShareContent" width="100%" frameborder=0 scrolling=no></iframe>
						<script>
							startInit('logShareContent', 300);
						</script>
		        	</div>
				</c:if>
		    </div>
		</ui:content>
	</c:if>
</c:if>

