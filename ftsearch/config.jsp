<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/config/resource/edit_top.jsp"%>

<html>
<head>
<title>蓝凌统一搜索系统配置</title>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}js/util.js"></script>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}js/jquery.js"></script>
<script>
function _submitForm(){
	if(_check()){
		Com_Submit(document.onesearchConfigForm, "save");
	}
}

function _check(){
	var clusterName = document.getElementsByName("value(kmss.onesearch.config.clusterName)")[0].value.replace(/[ ]/g,""); 
	var host = document.getElementsByName("value(kmss.onesearch.config.host)")[0].value.replace(/[ ]/g,""); 
	var port = document.getElementsByName("value(kmss.onesearch.config.port)")[0].value.replace(/[ ]/g,""); 
	var system = document.getElementsByName("value(kmss.onesearch.config.system)")[0].value.replace(/[ ]/g,"");
	if(clusterName == "" || host == "" || port == ""||system=="" ){
		alert("都是必填项，不能缺省！");
		return false;
	}
	var near = document.getElementsByName("value(kmss.onesearch.config.near)")[0].value;
	var over = document.getElementsByName("value(kmss.onesearch.config.over)")[0].value;
	var factor = document.getElementsByName("value(kmss.onesearch.config.synonym.factor)")[0].value;
	var bigFileSize = document.getElementsByName("value(kmss.onesearch.config.bigFileSize)")[0].value;
	var maxFileSize = document.getElementsByName("value(kmss.onesearch.config.maxFileSize)")[0].value;
	if(validata(near) || validata(over) || validata(factor)||validata(bigFileSize)||validata(maxFileSize)){
		alert("相关参数配置中配置项必须是数字且保留一位小数，请确认！");
		return false;
	}
	return true;
}
function validata(value) {
	if(value == "0"){
		return true;
	}
	if (value.match("^[0-9]+(\\.[0-9]{1})?$")) {
		return false;
	}
	return true;
	
}
</script>
</head>
<body>
<html:form action="/third/ftsearch/onesearchConfig.do?method=save">
	<div id="optBarDiv">
		<input type="button" class="btnopt" value="保存" onclick="_submitForm();"/>
		<input type="button" class="btnopt" value="关闭" onclick="top.close();"/>
	</div>
<p class="txttitle">蓝凌统一搜索系统配置</p>
	<center>
	<table id="Label_Tabel" width=95%>
		<!-- 基本配置 -->
		<tr
			LKS_LabelName="基本配置">
			<td>
			<table class="tb_normal" width=100% id="onesearchConfigForm">
				<tr><td>
					<table class="tb_normal" width=100%>
					
						<tr id="esSearchSystem">
							<td class="td_normal_title" width="15%" >蓝凌统一搜索系统名称</td>
							<td>
								<html:text property="value(kmss.onesearch.config.system)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">系统名，默认ekp。</span>
							</td>
						</tr>
						
						<tr id="esClusterName">
							<td class="td_normal_title"  width="15%" >蓝凌统一搜索集群名称</td>
							<td>
								<html:text property="value(kmss.onesearch.config.clusterName)" style="width:150px" />
								<span class="txtstrong">*</span><br>
								<span class="message">集群名,默认default。 根据统一搜索安装config目录有个elasticsearch.yml的配置 文本打开可以设置 集群设置 例：cluster.name: default</span>
							</td>
						</tr>
	
						<tr id="esSearchServer">
							<td class="td_normal_title"  width="15%" >蓝凌统一搜索服务器地址</td>
							<td>
								<html:text property="value(kmss.onesearch.config.host)" style="width:150px" />
								<span class="txtstrong">*</span><br>
								<span class="message">服务器地址 与下面配置服务端口的顺序要一一对应，如有用到集群，地址用  ,号隔开 例：127.0.0.1,127.0.0.2</span>
							</td>
						</tr>
	
						<tr id="esSearchPort">
							<td class="td_normal_title" width="15%" >蓝凌统一搜索服务端口</td>
							<td>
								<html:text property="value(kmss.onesearch.config.port)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">服务端口 与服务器地址顺序要一一对应 如有用到集群，端口用,号隔开 例：9300,9300</span>
							</td>
						</tr>
						<tr id="esSearchServicePort">
							<td class="td_normal_title" width="15%" >蓝凌统一搜索服务后台管理端口</td>
							<td>
								<html:text property="value(kmss.onesearch.config.service.port)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">后台管理端口默认为18080,如果后台管理端口发生变化，此处必须与之一致。</span>
							</td>
						</tr>
						<tr id="esSearchServiceOutUrlHeader">
							<td class="td_normal_title" width="15%" >蓝凌统一搜索服务后台管理外网访问请求头</td>
							<td>
								<html:text property="value(kmss.onesearch.config.service.outURL.header)" style="width:150px"/>
								<br>
								<span class="message">该参数默认为空,如需外网访问统一搜索服务后台管理页面，需设置外网请求头，格式为http://ip:端口/或者http://域名：端口/，如(http://192.169.2.104:18080/)。</span>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<span class="message">此页面的参数配置修改直接保存即可生效不需要重启系统。</span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
	<tr LKS_LabelName="相关参数配置">
		<td>
			<table class="tb_normal" width=100% id="onesearchConfigForm" >
				<tr><td>
					<table class="tb_normal" width=100%>
						<tr id="stringSearchNear">
							<td class="td_normal_title" width="15%" >字母和数字组合搜索最小长度比例</td>
							<td>
								<html:text property="value(kmss.onesearch.config.near)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">字母和数字组合搜索最小长度比例，范围 0~1，默认0.5。</span>
							</td>
						</tr>
						<tr id="stringSearchOver">
							<td class="td_normal_title" width="15%" >字母和数字组合搜索最大长度比例</td>
							<td>
								<html:text property="value(kmss.onesearch.config.over)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">字符串搜索匹配字符串最大长度比例，范围1~10，默认2.0。</span>
							</td>					
						</tr>
						<tr id="synonymFactor">
							<td class="td_normal_title" width="15%" >同义词搜索权重缩放因子</td>
							<td>
								<html:text property="value(kmss.onesearch.config.synonym.factor)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">同义词搜索权重缩放因子，默认15.0。</span>
							</td>					
						</tr>
						<tr id="bigFileSize">
							<td class="td_normal_title" width="15%" >多线程索引时，附件解析串行处理阀值(单位m)</td>
							<td>
								<html:text property="value(kmss.onesearch.config.bigFileSize)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">索引线程数超过1时，当附件的大小超过此阀值时采用串行的方式处理，避免内存溢出(单位m)</span>
							</td>					
						</tr>
						<tr id="maxFileSize">
							<td class="td_normal_title" width="15%" >附件内容解析阀值(单位m，0为不限制)</td>
							<td>
								<html:text property="value(kmss.onesearch.config.maxFileSize)" style="width:150px"/>
								<span class="message">当附件大小超过此阈值时不解析附件内容(单位m，0为不限制)</span>
							</td>					
						</tr>
						<tr id="reqTimeout">
							<td class="td_normal_title" width="15%" >向统一搜索服务发起请求超时时间(单位秒)</td>
							<td>
								<html:text property="value(kmss.onesearch.config.reqTimeout)" style="width:150px"/>
								<span class="txtstrong">*</span><br>
								<span class="message">向统一搜索服务发起请求的超时时间,超时自动返回，避免请求堵塞</span>
							</td>					
						</tr>
						<tr>
							<td></td>
							<td class="message">注意：此页面的参数,只能保留一位小数且不是技术人员请不要随意更改!</td>
						</tr>
			</table>	
		</td>
	</tr>
	</table>
	</center>
</html:form>
</body>
</html>
