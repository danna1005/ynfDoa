Com_IncludeFile("dialog.js");
Com_IncludeFile('json2.js');
Com_IncludeFile('common.js');
Com_IncludeFile("../../sys/xform/designer/relation/relation_common.js");
/**
 * 微协同表单控件
 */
Designer_Config.controls['yworkcontrol'] = {
		type : "yworkcontrol",
		storeType : 'field',
		inherit : 'base',
		onDraw : _Designer_Control_YworkControl_OnDraw, //绘制函数
		drawXML : _Designer_Control_YworkControl_DrawXML, //生成数据字典
		implementDetailsTable : false, // 是否支持明细表
		attrs : { // 这个是属性对话框配置
			label : Designer_Config.attrs.label, // 内置显示文字属性
			help: {
				text: "配置说明",
				value: "",
				type: 'self',
				show: true,
				required: false,
				draw:_Designer_Control_YworkControl_Help_Draw
			},
			share: {
				text: "分享内容",
				value: "",
				type: 'self',
				show: true,
				required: false,
				draw:_Designer_Control_YworkControl_Share_Draw
			},
			callback: {
				text: "回写内容",
				value: "",
				type: 'self',
				show: true,
				required: false,
				draw:_Designer_Control_YworkControl_Callback_Draw
			},
			formula: Designer_Config.attrs.formula,
			reCalculate: Designer_Config.attrs.reCalculate
		},
		info : {
			name: "微协同表单分享控件"
		},
		resizeMode : 'all'
};

/**
 * 绘制文本域的html代码
 */
function _Designer_Control_YworkControl_Help_Draw(name, attr, value, form, attrs, values) {
	var html = "<div>&nbsp;&nbsp;<a href='javascript:void(0)' onclick='openHelp();'>帮助</a></div>";
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}

function sy(){
	var curWwwPath = window.document.location.href;
	var pathName =  window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	var localhostPaht = curWwwPath.substring(0,pos);
	var projectName="";
	if(pathName.indexOf("/sys")!=0){
		projectName =  pathName.substring(0,pathName.indexOf("/sys"));
	}
	return localhostPaht + projectName;
}

function openHelp(){
	Com_OpenWindow(sy()+'/third/ywork/ywork_share/yworkDoc_help.jsp');
}
function _Designer_Control_YworkControl_Share_Draw(name, attr, value, form, attrs, values) {
	var html = "";
	if(!(values&&values.yworkShareNames)){
		html = "<textarea style='width: 95%' id='yworkShareNames' name='yworkShareNames' readOnly></textarea>" +
		"<input type='hidden' id='yworkShareIds' name='yworkShareIds'><a href='javascript:void(0)' onclick='getYworkField(1,"+values.id+")'>选择</a>";
	}else{
		html = "<textarea style='width: 95%' id='yworkShareNames' name='yworkShareNames' readOnly>"+values.yworkShareNames+"</textarea>" +
		"<input type='hidden' id='yworkShareIds' name='yworkShareIds' value='"+values.yworkShareIds+"'><a href='javascript:void(0)' onclick='getYworkField(1,"+values.id+")'>选择</a>";
	}
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}
function _Designer_Control_YworkControl_Callback_Draw(name, attr, value, form, attrs, values) {
	var html = "";
	if(!(values&&values.yworkCallBackNames)){
		html = "<textarea style='width: 95%' id='yworkCallBackNames' name='yworkCallBackNames' readOnly></textarea>" +
		"<input type='hidden' id='yworkCallBackIds' name='yworkCallBackIds'><a href='javascript:void(0)' onclick='getYworkField(0,"+values.id+")'>选择</a>";
	}else{
		html = "<textarea style='width: 95%' id='yworkCallBackNames' name='yworkCallBackNames' readOnly>"+values.yworkCallBackNames+"</textarea>" +
		"<input type='hidden' id='yworkCallBackIds' name='yworkCallBackIds' value='"+values.yworkCallBackIds+"'><a href='javascript:void(0)' onclick='getYworkField(0,"+values.id+")'>选择</a>";
	}
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}

function getYworkField(type,id){
	var yworks = Designer.instance.getObj(false);
	if(yworks){
		var ids = "";
		var names  = "";
		var types = "";
		var jsont = null;
		for(var i=0;i<yworks.length;i++){
			jsont = eval(yworks[i]);
			ids += jsont.name+";";
			names += jsont.label+"|;|";
			types += jsont.type+";";
		}
		var configIds = null; 
		var configNames = null; 
		if(type=='1'){
			configNames = document.getElementById("yworkShareNames");
			configIds = document.getElementById("yworkShareIds");
		}else{
			configNames = document.getElementById("yworkCallBackNames");
			configIds = document.getElementById("yworkCallBackIds");
		}
		Dialog_List(true, configIds, configNames, ';  ', 'yworkDesignControlListService&type='+type+'&ids='+ids+'&names='+encodeURI(names)+'&types='+types+"&id="+id.id);
	}
}

Designer_Config.operations['yworkcontrol'] = {
		imgIndex : 58,
		title : "分享控件",
		run : function (designer) {
			designer.toolBar.selectButton('yworkcontrol');
		},
		type : 'cmd',
		shortcut : 'Q',
		select: true,
		cursorImg: 'style/cursor/weixin.cur'
};
Designer_Config.buttons.control.push("yworkcontrol");
Designer_Menus.add.menu['yworkcontrol'] = Designer_Config.operations['yworkcontrol'];

/**
 * 微协同表单控件的绘制
 */
function _Designer_Control_YworkControl_OnDraw(parentNode, childNode){
	// 必须要做ID设置
	if(this.options.values.id == null)
		this.options.values.id = "fd_" + Designer.generateID();
	// 调用内建方法创建dom对象
	var domElement = _CreateDesignElement('div', this, parentNode, childNode);
	// 以下是绘制
	var selectDom = document.createElement('input');
	selectDom.type = "hidden";
	selectDom.id = this.options.values.id;
	if (this.options.values.description) {
		selectDom.description = this.options.values.description;
	}
	selectDom.label = _Get_Designer_Control_Label(this.options.values, this);
	if (this.parent != null) {
		selectDom.tableName=_Get_Designer_Control_TableName(this.parent);
	}
	selectDom.required = (this.options.values.required == 'true' ? 'true' : 'false');
	selectDom.canShow = (this.options.values.canShow == 'true' ? 'true' : 'false');
	if (this.options.values.formula != null && this.options.values.formula != '') {
		selectDom.formula = 'true';
		selectDom.defaultValue = this.options.values.defaultValue;
		selectDom.reCalculate = (this.options.values.reCalculate == 'true' ? 'true' : 'false');
	}else if (this.options.values.defaultValue != null && this.options.values.defaultValue != '') {
		selectDom.defaultValue = this.options.values.defaultValue;
	}
	if (this.options.values.share != null){
		selectDom.share = this.options.values.share;
	}
	if (this.options.values.callback != null){
		selectDom.callback = this.options.values.callback;
	}
	var buf = [];
	buf.push("<img width='22' src='style/img/weixin.gif'/>");
	if(this.options.values.required == 'true') {
		buf.push('<span class=txtstrong>*</span>');
	}
	domElement.innerHTML = buf.join('');
	domElement.appendChild(selectDom);
	domElement.className = 'select_div_box';
}

/**
 * 数据字典的设置
 */
function _Designer_Control_YworkControl_DrawXML() {
	var values = this.options.values;
	var buf = [];
	buf.push('<extendSimpleProperty ');
	buf.push('name="', values.id, '" ');
	buf.push('label="', values.label, '" ');
	if (values.required == "true") {
		buf.push('notNull="true" ');
	}
	buf.push('type="', values.dataType ? values.dataType : 'String', '" ');
	if (values.formula != '' && values.formula != null) {
		buf.push('formula="true" ');
		buf.push('defaultValue="', values.formula, '" ');
		if (values.reCalculate == 'true') {
			buf.push('recalculateOnSave="true" ');
		}
	} else if (values.defaultValue != '' && values.defaultValue != null) {
		buf.push('defaultValue="', values.defaultValue, '" ');
	}
	buf.push('/>');
	
	buf.push('<extendSimpleProperty ');
	buf.push('name="ywork_share_ids" ');
	buf.push('label="', values.label, '" ');
	if (values.required == "true") {
		buf.push('notNull="true" ');
	}
	buf.push('type="', values.dataType ? values.dataType : 'String', '" ');
	if (values.formula != '' && values.formula != null) {
		buf.push('formula="true" ');
		buf.push('defaultValue="', values.formula, '" ');
		if (values.reCalculate == 'true') {
			buf.push('recalculateOnSave="true" ');
		}
	} else if (values.defaultValue != '' && values.defaultValue != null) {
		buf.push('defaultValue="', values.defaultValue, '" ');
	}
	buf.push('length="4000" ');
	buf.push('/>');
	buf.push('<extendSimpleProperty ');
	buf.push('name="ywork_share_names" ');
	buf.push('label="', values.label, '" ');
	if (values.required == "true") {
		buf.push('notNull="true" ');
	}
	buf.push('type="', values.dataType ? values.dataType : 'String', '" ');
	if (values.formula != '' && values.formula != null) {
		buf.push('formula="true" ');
		buf.push('defaultValue="', values.formula, '" ');
		if (values.reCalculate == 'true') {
			buf.push('recalculateOnSave="true" ');
		}
	} else if (values.defaultValue != '' && values.defaultValue != null) {
		buf.push('defaultValue="', values.defaultValue, '" ');
	}
	buf.push('length="4000" ');
	buf.push('/>');
	
	buf.push('<extendSimpleProperty ');
	buf.push('name="ywork_callback_ids" ');
	buf.push('label="', values.label, '" ');
	if (values.required == "true") {
		buf.push('notNull="true" ');
	}
	buf.push('type="', values.dataType ? values.dataType : 'String', '" ');
	if (values.formula != '' && values.formula != null) {
		buf.push('formula="true" ');
		buf.push('defaultValue="', values.formula, '" ');
		if (values.reCalculate == 'true') {
			buf.push('recalculateOnSave="true" ');
		}
	} else if (values.defaultValue != '' && values.defaultValue != null) {
		buf.push('defaultValue="', values.defaultValue, '" ');
	}
	buf.push('length="4000" ');
	buf.push('/>');
	buf.push('<extendSimpleProperty ');
	buf.push('name="ywork_callback_names" ');
	buf.push('label="', values.label, '" ');
	if (values.required == "true") {
		buf.push('notNull="true" ');
	}
	buf.push('type="', values.dataType ? values.dataType : 'String', '" ');
	if (values.formula != '' && values.formula != null) {
		buf.push('formula="true" ');
		buf.push('defaultValue="', values.formula, '" ');
		if (values.reCalculate == 'true') {
			buf.push('recalculateOnSave="true" ');
		}
	} else if (values.defaultValue != '' && values.defaultValue != null) {
		buf.push('defaultValue="', values.defaultValue, '" ');
	}
	buf.push('length="4000" ');
	buf.push('/>');
	
	return buf.join('');
}