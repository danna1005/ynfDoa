<%@ page language="java" contentType="text/javascript; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
define(function(require, exports, module) { 
	
	var $ = require("lui/jquery");
	var strutil = require('lui/util/str');
	function ImKK(config) {
		this.kkPrefix = "landray://im?u=";
		this.imType = "t=0"
		this.awareport = "<%=ResourceUtil.getKmssConfigString("kmss.ims.kk.awareport") %>";
		this.awareIp = "<%=ResourceUtil.getKmssConfigString("third.im.kk.serverIp") %>";
		this.params = $.extend({}, config);
		this.imgPrefix = "http://" + this.awareIp + ":" + this.awareport + "/kkonline//?p=0:";
	}
	//show事件,___params为communicate的参数
	ImKK.prototype.onShow =  function ($content, ___params) {
		var self = this;
		if(self.awareport != "null" && self.awareIp != "null") {
		    var $img = $content.find("img");
			var loginName = ___params.loginName;
			var prefix = self.imgPrefix + loginName;
			var time = new Date().getTime();
			$img.attr("src", prefix + "&" + time );
			
			setTimeout(function() {
				var time = new Date().getTime();
				$img.attr("src", prefix + "&" + time );
				
				setTimeout(arguments.callee, 50000);
			}, 50000);
		}
	};
	
	ImKK.prototype.onClick = function($content, ___params) {
		if(___params.loginName) {
			window.open(this.kkPrefix + ___params.loginName + "&" + this.imType,
						"_parent");
		}
	};
	module.exports = ImKK;
	
});