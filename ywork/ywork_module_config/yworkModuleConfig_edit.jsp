<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<template:include ref="config.list">
	<template:replace name="title">${ lfn:message('km-review:table.kmReviewMain') }</template:replace>
	<template:replace name="content">
		<table class="tb_normal" style="width:98%">
		  <c:forEach var="module" items="${modules}">
			  <tr class="tr_normal_title parent" style="text-align:left;">
			  		<td align="left" style="border-right-width: 0px">
			  			<label style="cursor:pointer;">
				  			<c:if test="${module.fdIsAvai }">
		  						<input type="checkbox" id="fdIsAvai_${module.fdId }" name="fdIsAvai_${module.fdId }" value="1" checked onclick="showRow(this);"/>
		  					</c:if>
				  			<c:if test="${!module.fdIsAvai }">
		  						<input type="checkbox" id="fdIsAvai_${module.fdId }" name="fdIsAvai_${module.fdId }" value="1" onclick="showRow(this);"/>
		  					</c:if>
				  			<c:out value="${module.fdName}" />
			  			</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  		</td>
			  		<td align="right" style="border-left-width: 0px">
			  			<c:if test="${module.fdIsCategory }">
	  						<ui:button text="${ lfn:message('third-ywork:ywork.module.set') }" id="add" onclick="addGlobalCategory('${module.fdTempModelName }','${module.fdId }',this)"></ui:button>
	  					</c:if>
			  			<c:if test="${!module.fdIsCategory }">
	  						<ui:button text="${ lfn:message('third-ywork:ywork.module.set') }" id="add" onclick="addSimpleCategory('${module.fdTempModelName }','${module.fdId }',this)"></ui:button>
	  					</c:if>
			  		</td>
			  </tr>
			  <tr <c:if test="${!module.fdIsAvai }">style="display: none;"</c:if>>
			  	<td height="40px" colspan="2">
			  		<c:if test="${empty moduleMap[module.fdId].fdCategorysNames }">
			  			<div style="min-height:25px;line-height: 18px;" id="${module.fdId }"></div>
			  		</c:if>
					<c:if test="${!empty moduleMap[module.fdId].fdCategorysNames }">
						<div class="config-list" style="min-height:25px;line-height: 18px;" id="${module.fdId }">
							<c:forEach var="content" items="${moduleMapContent[module.fdId]}">
								<span>${content }&nbsp;</span>
							</c:forEach>
						</div>
					</c:if>
					<input id="fdCategorysIds_${module.fdId }" name="fdCategorysIds_${module.fdId }" type="hidden" value="${moduleMap[module.fdId].fdCategorysIds }">
					<input id="fdCategorysNames_${module.fdId }" name="fdCategorysNames_${module.fdId }" type="hidden" value="${moduleMap[module.fdId].fdCategorysNames }">
				</td>
			  </tr>
		  </c:forEach>
	</table>
 	<script type="text/javascript">
 		Com_IncludeFile("dialog.js|data.js");
 	</script>
 	<script type="text/javascript">
		function showRow(obj){
			var trObj = $(obj).parents("tr").next();
			if(trObj.is(":hidden")){
				trObj.show();
				var url = "<c:url value='/third/ywork/ywork_module_config/yworkModuleConfig.do?method=updateModule' />";
				var fdId = obj.name.split("fdIsAvai_");
				if(fdId.length==2){
					url += "&moduleId="+fdId[1]+"&moduleFlag=1";
					$.post(url, function(data){
		 	 	 		if(data.suc=='1'){
		 	 	 			//alert('<bean:message bundle="third-ywork" key="ywork.save.sucess"/>');
		 	 	 		}else{
		 	 	 			//alert('<bean:message bundle="third-ywork" key="ywork.save.fail"/>');
		 	 	 		}
		 	 		});
				}
			}else{
				trObj.hide();
				var url = "<c:url value='/third/ywork/ywork_module_config/yworkModuleConfig.do?method=updateModule' />";
				var fdId = obj.name.split("fdIsAvai_");
				if(fdId.length==2){
					url += "&moduleId="+fdId[1]+"&moduleFlag=0";
					$.post(url, function(data){
		 	 	 		if(data.suc=='1'){
		 	 	 			//alert('<bean:message bundle="third-ywork" key="ywork.save.sucess"/>');
		 	 	 		}else{
		 	 	 			//alert('<bean:message bundle="third-ywork" key="ywork.save.fail"/>');
		 	 	 		}
		 	 		});
				}
			}
		}
		
		function setSel(obj,fdId){
			obj = $(obj).parents("tr").next();
			if(obj.is(":hidden")){
				obj.show();
			}
			$("#fdIsAvai_"+fdId).prop("checked",true);
		}
		
	 	function addGlobalCategory(fdModel,fdId,obj){
	 		setSel(obj,fdId);
	 		Dialog_GlobalCategory(fdModel,"fdCategorysIds_"+fdId,"fdCategorysNames_"+fdId,true,";",null,function(rtnVal){
	 			subData(fdId);
				setRtn(fdId);
			});
	 	}
	 	function addSimpleCategory(fdModel,fdId,obj){
	 		setSel(obj,fdId);
	 		Dialog_SimpleCategory(fdModel,"fdCategorysIds_"+fdId,"fdCategorysNames_"+fdId,true,";",null,function(rtnVal){
	 			subData(fdId);
				setRtn(fdId);
			});
	 	}
	 	function setRtn(fdId){
			var names = $("#fdCategorysNames_"+fdId).val().split(";");
			var content = "";
			for(var i=0;i<names.length;i++){
				content += "<span>"+names[i]+"</span>&nbsp;&nbsp;";
			}
			$("#"+fdId).html(content);
		}
	 	function subData(fdId){
 	 		var url = "<c:url value='/third/ywork/ywork_module_config/yworkModuleConfig.do?method=updateModule' />";
 	 		url += "&moduleId="+fdId+"&ids="+$("#fdCategorysIds_"+fdId).val()+"&names="+encodeURI($("#fdCategorysNames_"+fdId).val());
 	 		$.post(url, function(data){
 	 	 		if(data.suc=='1'){
 	 	 			//alert('<bean:message bundle="third-ywork" key="ywork.save.sucess"/>');
 	 	 		}else{
 	 	 			//alert('<bean:message bundle="third-ywork" key="ywork.save.fail"/>');
 	 	 		}
 	 		});
 		}
	 	</script>
	</template:replace>
</template:include>
