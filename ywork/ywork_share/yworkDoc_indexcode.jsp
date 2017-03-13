<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
	<style>
	   .show{cursor: pointer;}
	   .ewm-mark{height: 100%;width: 100%;background-color: rgba(0,0,0,0.5);display: none;position: relative;}
       .erweima{border: 1px solid #e1e1e1;line-height: 8px;display:none;z-index: 99999;position: absolute;right:-65px;height: 180px;width: 160px; text-align: center;background-color: white;}
   </style>
   <div class="lui_portal_header_text">
		<div class="show"><bean:message bundle="third-ywork" key="ywork.index.code.wxoffice"/><div class="lui_icon_s lui_portal_header_icon_arrow"></div></div>
     	<div style="position: relative;">
          <div class="erweima">
          	<img id="ig" style="height:160px;border=0;" onerror="onfind(this);" src=""/><font color="black"><bean:message bundle="third-ywork" key="ywork.index.code.scaneopenwxoffice"/></font>
          </div>
     	</div>
   </div>
	<script type="text/javascript">
			Com_IncludeFile("jquery.js", null, "js");
	</script>
	<script>
		$(function(){
			var url = '<c:url value="/third/ywork/ywork_doc_person_code/yworkDocPersonCode.do?method=findPersonCode" />';
			$.post(url,function(data){
				status = data.status;
				var igurl = '<c:url value="/third/ywork/images/indexWXError.png" />';
				if(data.status=="1"){
					igurl = data.codeUrl;
				}
				$("#ig").attr("src",igurl);
			},"json");
		});
		$(".show").bind("mouseover",function(){
			if($(".erweima img").length>0){
				$(".erweima").show();
			}
	   });
	   $(".show").bind("mouseout",function(){
	       $(".erweima").hide();
	       return;
	   });

		function onfind(val){
			val.src='<c:url value="/third/ywork/images/indexWXError.png" />';
			val.onerror=null; 
		}
	   
	</script>

