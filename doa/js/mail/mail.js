var url = null;
var courierlist = null;
var expressType = 1;
var charge = 1;
$(document).ready(function() {	
	getMailList();
	getMyMailList();
	getCourierList();

	$('#saveDeliveryInfo').click(function() {
		addMail(1);
	});	

	$('#submitDeliveryInfo').click(function() {
		addMail(2);
	});

	
	$('#addReceiver').click(function() {
		addReceiver();
	});	
	
	$('#addSender').click(function() {
		addSender();
	});	
});

function addMail(status) {
	url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=save");
	var para = getPara();
	if(para.fdId!=undefined&&para.fdId!=null&&para.fdId!='null'){
		url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=update");
	}
	para.status = status;
	
	var result = validateSender(para);
	result = result+validateReceiver(para);
	if(result != ''){
		$.toast(result,4000);
	}else{
		$.showPreloader('请稍等...');
		commonPost(url, para, function(data) {
			$.hidePreloader();
			if(data.errCode==0){
				$.toast("操作成功");
				getMyMailList();
				$.closeModal('.popup-new-step2');
				$.closeModal('.popup-new-step1');
				//window.location.href = 'index.html';
			}else{
				$.toast(data.errMsg);
			}
			
		
		}, function(data) {
			$.hidePreloader();
			$.toast("操作失败");
		});
	}
	
}

function getMailList() {
	url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=listData&rowsize=9999&pageno=1");
	commonGet(url,null,loadMailList, false);	
	
}

function getMyMailList() {
	url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=list&rowsize=9999&pageno=1");
	commonGet(url,null,loadMyMailList, false);	
	
}

function detailsClick(fdId){
	url = makeUrl("third/doa/doa_delivery/doaDelivery.do?method=view&fdId="+fdId);
	commonGet(url,null,loadMailDetails, false);
}

function updateExpressCode(id,code){
	var para = new Object();
	para.fdId = id;
	para.expressCode = code;
	url = makeUrl("third/doa/doa_delivery/doaDelivery.do?method=updateExpressCode");
	commonPost(url,para,loadMailDetails, false);
}

function getCourierList(){
	url = makeUrl("/third/doa/doa_courier/doaCourier.do?method=list");
	commonGet(url,null,loadCourierList, false);
}

function loadCourierList(result) {
	var expValues  = new Array();
	if(result.errCode==0){
		courierlist = result.data;
		for ( var i = 0; i < result.data.length; i++) {
			expValues.push(result.data[i].name);
		}
	}

	//点击快递公司 请选择
	$('#selectExpress').picker({
		toolbarTemplate: '<header class="bar bar-nav">\
	  	<button class="button button-link pull-right save-value" onClick="enterExpress()">确定</button>\
	  	</header>',
	  	cols: [
		    {
		      textAlign: 'center',
		      values: expValues
		    }
	  	],
	  	onClose:function(){
	  		
	  	}
	});
}

function enterExpress(){
	$('#selectExpress').picker("close");
	var selectValue = $('.picker-modal-inner').find('.picker-selected').attr('data-picker-value');
	$('#expressInp').val(selectValue);
}



$('#rdbPublic').click(function() {
	expressType = 1;
});

$('#rdbPrivate').click(function() {
	expressType = 2;
});

$('#send').click(function() {
	charge = 1;
});

$('#received').click(function() {
	charge = 2;
});

function getCourierId(courier){
	for ( var i = 0; i < courierlist.length; i++) {
		if (courierlist[i].name == courier) {
			courier = courierlist[i].fdId;
		}
	}
	return courier;
}

function updateMail(mailId,status){
	url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=update");
	var para = new Object();
	para.status = status;
	para.id = mailId;
	$.showPreloader('正在提交');
	commonPost(url, para, function(data) {
		$.hidePreloader();
		if(data.errCode==0){
			$.toast("提交成功");
			getMailList();
		}else{
			$.toast(data.errMsg);
		}
		
	}, function(data) {
		$.hidePreloader();
		$.toast("提交失败");
	});
}
function getExpressCode(expressCode){
	$('#expressCode').val(expressCode);
}

function substrReceiver(para,str){
	if (isContains("省", str)) {
		para.receiverProvince = str.split("省")[0] + "省";
		para.receiverCity = str.split("省")[1].split("市")[0] + "市";
		para.receiverCounty = str.split("省")[1].split("市")[1];
	} else {
		para.receiverProvince = str.split("市")[0] + "市";
		para.receiverCity = str.split("市")[1];
		para.receiverCounty = "";
	}
	return para;
}

function substrSend(para,str){
	if (isContains("省", str)) {
		para.senderProvince = str.split("省")[0] + "省";
		para.senderCity = str.split("省")[1].split("市")[0] + "市";
		para.senderCounty = str.split("省")[1].split("市")[1];
	} else {
		para.senderProvince =str.split("市")[0] + "市";
		para.senderCity = str.split("市")[1];
		para.senderCounty = "";
	}
	return para;
}

function substrAddress(para,str){
	if (isContains("省", str)) {
		para.province = str.split("省")[0] + "省";
		para.city = str.split("省")[1].split("市")[0] + "市";
		para.county = str.split("省")[1].split("市")[1];
	} else {
		para.province = str.split("市")[0] + "市";
		para.city = str.split("市")[1];
		para.county = "";
	}
	return para;
}

function isContains(substr,str) {
	var reg = eval("/"+substr+"/ig");
	return reg.test(str);
}

function dateFormat(createTime){
	var newTime = new Date(createTime);
	return newTime.getFullYear() + "-" + (newTime.getMonth() + 1) + "-" + newTime.getDate() + "  " + newTime.getHours() + ":" + newTime.getMinutes() + ":" + newTime.getSeconds();
}

function updateMyMail(fdId){
	url = makeUrl("third/doa/doa_delivery/doaDelivery.do?method=view&fdId="+fdId);
	commonGet(url,null,loadMyMail, false);
}

function loadMyMail(result){
	$.popup('.popup-new-step1'); 
	var para = result.data;
	if(para.senderCounty == undefined){
		para.senderCounty ="";
	}
	if(para.receiverCounty == undefined){
		para.receiverCounty ="";
	}
	
	if (para.type == 2) {
		$('#rdoselect').removeClass("icon-rdoselect");
		$('#rdo').addClass("icon-rdoselect");
		$('#rdo').removeClass("icon-rdo");
		$('#rdoselect').addClass("icon-rdo");
	}
	if (para.deliveryMode == 2) {
		$('#rdoselect1').removeClass("icon-rdoselect");
		$('#rdo1').addClass("icon-rdoselect");
		$('#rdo1').removeClass("icon-rdo");
		$('#rdoselect1').addClass("icon-rdo");
	}
	$('#expressCode').val(para.expressCode);
	$('#expressCode').val(para.expressCode);
	$('#remark').val(para.remark);
	$('#sendMenInp').val(para.senderName);
	$('#senderMobile').val(para.senderMobile);
	$('#senderAddressDetail').val(para.senderAddressDetail);
	$('#senderPostcode').val(para.senderPostcode);
	$('#receiverMenInp').val(para.receiverName);
	$('#receiverMobile').val(para.receiverMobile);
	$('#receiverAddressDetail').val(para.receiverAddressDetail);
	$('#receiverPostcode').val(para.receiverPostcode);
	$('#receiverCompany').val(para.receiverCompany);
	$('#senderAddress').html(para.senderProvince+para.senderCity+para.senderCounty);
	$('#receiverAddress').html(para.receiverProvince+para.receiverCity+para.receiverCounty);
	$('#expressInp').val(para.express.name);
	$('#fdId').val(para.fdId);
	
}

function addReceiver(){
	var receiver = getAddressPara('receiver');
	var result = validatePara(receiver);
	if(result != ''){
		$.toast(result,4000);
	}else{
		savePostInfo(receiver);
	}
}

function addSender(){
	var sender = getAddressPara('sender');
	var result = validatePara(sender);
	if(result != ''){
		$.toast(result,4000);
	}else{
		savePostInfo(sender);
	}
}

/**
 * 填充寄收件人参数
 * @param infoType sender:寄件人 other:收件人
 */
function getAddressPara(infoType){
	var para = new Object();
	//寄件人
	if (infoType == 'sender') {
		para.name = $('#sendMenInp').val();
		para.mobile = $('#senderMobile').val(); 
		para.addressDetail = $('#senderAddressDetail').val(); 
		para.postCode = $('#senderPostcode').val(); 
		para.postType = 'sender';
		para.company = $('#receiverCompany').val();
		para = substrAddress(para, $('#senderAddress').text());
	} else {
		//收件人
		para.name = $('#receiverMenInp').val();
		para.mobile = $('#receiverMobile').val(); 
		para.addressDetail = $('#receiverAddressDetail').val(); 
		para.postCode = $('#receiverPostcode').val(); 
		para.company = $('#receiverCompany').val(); 
		para.postType = 'receiver';
		para = substrAddress(para, $('#receiverAddress').text());
	}
	return para;
}

/**
 * 验证寄收件人信息是否合法
 */
function validatePara(para){
	var result = '';
	var postType = (para.postType == 'sender') ? '寄件人':'收件人';
	if($.trim(para.name) == ''){
		result += '姓名、';
	}
	if($.trim(para.mobile) == ''){
		result += '手机、';
	}
	if($.trim(para.city)== ''){
		result += '地区、';
	}
	if($.trim(para.addressDetail) == ''){
		result += '地址、';
	}else if( $.trim(para.addressDetail).length < 5){
		result += '地址字数太少、';
	}
	if(result != ''){
		result = '<span style="font-size:0.7rem"> 请输入' + postType + result.substring(0,result.length - 1) + '</span>';
	}
	return result;
}
function validateSender(para){
	var result = '';
	var postType ='寄件人';
	if($.trim(para.senderName) == ''){
		result += '姓名、';
	}
	if($.trim(para.senderMobile) == ''){
		result += '手机、';
	}
	if($.trim(para.senderCity)== ''){
		result += '地区、';
	}
	if($.trim(para.senderAddressDetail) == ''){
		result += '地址、';
	}else if( $.trim(para.senderAddressDetail).length < 5){
		result += '地址字数太少、';
	}
	if(result != ''){
		result = '<span style="font-size:0.7rem"> 请输入' + postType + result.substring(0,result.length - 1) + '</span>';
	}
	return result;
}

function validateReceiver(para){
	var result = '';
	var postType = '收件人';
	if($.trim(para.receiverName) == ''){
		result += '姓名、';
	}
	if($.trim(para.receiverMobile) == ''){
		result += '手机、';
	}
	if($.trim(para.receiverCity)== ''){
		result += '地区、';
	}
	if($.trim(para.receiverAddressDetail) == ''){
		result += '地址、';
	}else if( $.trim(para.receiverAddressDetail).length < 5){
		result += '地址字数太少、';
	}
	if(result != ''){
		result = '<span style="font-size:0.7rem"> 请输入' + postType + result.substring(0,result.length - 1) + '</span>';
	}
	return result;
}


/**
 * 保存寄收件人信息
 * @param postInfo
 */
function savePostInfo(postInfo){
	url = makeUrl("third/doa/doa_delivery_address/doaDeliveryAddress.do?method=save");
	$.showPreloader('正在提交');
	commonPost(url, postInfo, function(data) {
		$.hidePreloader();
		if(data.errCode==0){
			$.toast("提交成功");
		}else{
			$.toast(data.errMsg);
		}
		
	}, function(data) {
		$.hidePreloader();
		$.toast("提交失败");
	});
}


function getPara(){
	var para = new Object();
	para.expressCode = $('#expressCode').val();
	para.type = expressType;
	para.deliveryMode = charge;
	para.remark = $('#remark').val();
	para.senderName = $('#sendMenInp').val();
	para.senderMobile = $('#senderMobile').val(); 
	para.senderAddressDetail = $('#senderAddressDetail').val(); 
	para.senderPostcode = $('#senderPostcode').val(); 
	para.receiverName = $('#receiverMenInp').val();
	para.receiverMobile = $('#receiverMobile').val(); 
	para.receiverAddressDetail = $('#receiverAddressDetail').val(); 
	para.receiverPostcode = $('#receiverPostcode').val();
	para.receiverCompany = $('#receiverCompany').val();
	para = substrReceiver(para, $('#receiverAddress').text());
	para = substrSend(para, $('#senderAddress').text());
	para.expressId = getCourierId($('#expressInp').val());
	if($('#fdId').val()!=null&&$('#fdId').val()!='null'){
		para.fdId = $('#fdId').val();
	}
	
	return para;
}

function loadMailList(result) {
	$('#stayList').html("");
	$('#alreadyList').html("");
	if(result.errCode==0){
		$.each(result.data.list, function(i, item) {
			var mailId = "'"+item.fdId+"'";
			if(item.receiverCounty == undefined){
				item.receiverCounty ="";
			}
			var store = '<div class="item-inner"> <div class="item-title"><div class="list-content-txt"><p>收件人:'+item.receiverName+'</p><p>收件地址:'+item.receiverProvince+item.receiverCity+item.receiverCounty+item.receiverAddressDetail+'</p><p>说明:'+item.remark+'</p><p>创建时间:'+dateFormat(item.createTime)+'</p></div></div></div>';
			if (item.status==2) {
				$('#tips1').html("");
				$('#stayList').append(' <li class="open-detail-popup" ><div class="subsidiary-title-container" onclick="detailsClick('+mailId+')"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div></div><ul class="mail-content" ><li class="item-content">'+store+'<div class="item-after"><a class="btn org" href="#"  onclick="updateMail('+mailId+',3)">通过</a><a class="btn" href="#"  onclick="updateMail('+mailId+',4)">驳回</a></div></li></ul></li>');
			} else if (item.status==3) {
				$('#tips2').html("");
				$('#alreadyList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-ysh">已审核</span></div>'+store+'<div class="item-after"><a href="#" class="icon icon-right"></a></div></li></ul></li>');
			} else if (item.status==4) {
				$('#tips2').html("");
				$('#alreadyList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-bh">已驳回</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
			} else if (item.status==5) {
				$('#tips2').html("");
				$('#alreadyList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-jj">已寄件</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
			}
		});
	}
}

function loadMyMailList(result) {
	$('#myMailList').html("");
	if(result.errCode==0){
		$.each(result.data.list, function(i, item) {
			if(item.receiverCounty == undefined){
				item.receiverCounty ="";
			}
			$('#tips3').html("");
			var mailId = "'"+item.fdId+"'";
			var store = '<div class="item-inner"> <div class="item-title"><div class="list-content-txt"><p>收件人:'+item.receiverName+'</p><p>收件地址:'+item.receiverProvince+item.receiverCity+item.receiverCounty+item.receiverAddressDetail+'</p><p>说明:'+item.remark+'</p><p>创建时间:'+dateFormat(item.createTime)+'</p></div></div></div>';
			if (item.status==2) {
				$('#myMailList').append(' <li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div></div><ul class="mail-content" ><li class="item-content"><div class="item-media"><span class="type type-ds">待审核</span></div>'+store+'<div class="item-after"><a href="#" class="icon icon-right"></a></div></li></ul></li>');
			} else if (item.status==1) {
				$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-zc">暂存</span></div>'+store+'<div class="item-after"><a class="btn org" href="#"  onclick="updateMyMail('+mailId+')">修改</a></div></li></ul></li>');
			} else if (item.status==3) {
				$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-ysh">已审核</span></div>'+store+'<div class="item-after"><a class="btn org dingScan" data-id='+mailId+'>扫描单号</a></div></li></ul></li>');
			} else if (item.status==4) {
				$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-bh">已驳回</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
			} else if (item.status==5) {
				$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.expressName+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-jj">已寄件</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
			}
		});
	}
}

function loadMailDetails(result) {
	if(result.errCode==0){
		var item = result.data;
		if(item.senderCounty == undefined){
			item.senderCounty ="";
		}
		if(item.receiverCounty == undefined){
			item.receiverCounty ="";
		}
		if(item.deliveryMode==1){
			$('#paymentType').html("寄件寄付");
		}else{
			$('#paymentType').html("收件到付");
		}
		if(item.type==1){
			$('#expressType').html("公件");
		}else{
			$('#expressType').html("私件");
		}
		$('#expressName').html(item.express.name);
		$('#expressText').html(item.remark);
		$('#expressNo').html(item.expressCode);
		$('#expressTime').html(dateFormat(item.createTime));
		$('#sName').html(item.senderName);
		$('#sMobile').html(item.senderMobile);
		$('#sAddress').html(
				item.senderProvince + item.senderCity + item.senderCounty
						+ item.senderAddressDetail);
		$('#rCompany').html(item.receiverCompany);
		$('#rName').html(item.receiverName);
		$('#rMobile').html(item.receiverMobile);
		$('#rAddress').html(
				item.receiverProvince + item.receiverCity + item.receiverCounty
						+ item.receiverAddressDetail);
	}

}
