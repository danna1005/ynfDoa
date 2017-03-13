var url = null;
var courierlist = null;
var expressType = 1;
var charge = 1;
$(document).ready(function() {	
	getMailList();
	getCourierList();
	getMyMailList();

		

	$('#rejectProductDeclare').click(function() {
		addMail(1);
	});
	

	$('#approveProductDeclare').click(function() {
		addMail(2);
	});	
	
	$('#approveProductDeclare').click(function() {
		updateMail(3);
	});	
	
	$('#approveProductDeclare').click(function() {
		updateMail(4);
	});	
	
	$('#addRecieve').click(function() {
		getAddressPara(false);
	});	
	
	$('#addSender').click(function() {
		getAddressPara(true);
	});	
});

function addMail(status) {
	url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=save");
	var para = getPara();
	para.status = status;
	$.showPreloader('正在提交');
	commonPost(url, para, function(data) {
		$.hidePreloader();
		$.toast("提交成功");

	}, function(data) {
		$.hidePreloader();
		$.toast("提交失败");
	});
}

function getMailList() {
	url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=listData");
	//url = makeUrl("third/doa/doa_delivery/doaDelivery.do?method=view&fdId=15a4b4faad6278f7fa811814a8783b8b");
	commonGet(url,null,loadMailList, false);	
	
}

function getMyMailList() {
	url = makeUrl("/third/doa/doa_delivery/doaDelivery.do?method=list");
	//url = makeUrl("third/doa/doa_delivery/doaDelivery.do?method=view&fdId=15a4b4faad6278f7fa811814a8783b8b");
	commonGet(url,null,loadMyMailList, false);	
	
}

function detailsClick(fdId){
	url = makeUrl("third/doa/doa_delivery/doaDelivery.do?method=view&fdId="+fdId);
	commonGet(url,null,loadMailDetails, false);
}

function getCourierList(){
	url = makeUrl("/third/doa/doa_courier/doaCourier.do?method=list");
	commonGet(url,null,loadCourierList, false);
}

function loadCourierList(result) {
	var expValues  = new Array();
	courierlist = result.data;
	for ( var i = 0; i < result.data.length; i++) {
		expValues.push(result.data[i].name);
	}
	//选择快递

	//点击快递公司 请选择
	$('#selectExpress').picker({
		toolbarTemplate: '<header class="bar bar-nav">\
	  	<button class="button button-link pull-right close-picker save-value">确定</button>\
	  	</header>',
	  	cols: [
		    {
		      textAlign: 'center',
		      values: expValues
		    }
	  	],
	  	onClose:function(){
	  		var selectValue = $('.picker-modal-inner').find('.picker-selected').attr('data-picker-value');
	  		$('#expressInp').val(selectValue);
	  	}
	});
	
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
	var para = getPara();
	para.status = status;
	para.fdId = mailId;
	$.showPreloader('正在提交');
	commonPost(url, para, function(data) {
		$.hidePreloader();
		$.toast("提交成功");
		getMailList();
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
		para.receiverProvince = "";
		para.receiverCity = str.split("市")[0] + "市";
		para.receiverCounty = str.split("市")[1];
	}
	return para;
}

function substrSend(para,str){
	if (isContains("省", str)) {
		para.sendProvince = str.split("省")[0] + "省";
		para.sendCity = str.split("省")[1].split("市")[0] + "市";
		para.sendCounty = str.split("省")[1].split("市")[1];
	} else {
		para.sendProvince = "";
		para.sendCity = str.split("市")[0] + "市";
		para.sendCounty = str.split("市")[1];
	}
	return para;
}

function substrAddress(para,str){
	if (isContains("省", str)) {
		para.province = str.split("省")[0] + "省";
		para.city = str.split("省")[1].split("市")[0] + "市";
		para.county = str.split("省")[1].split("市")[1];
	} else {
		para.province = "";
		para.city = str.split("市")[0] + "市";
		para.county = str.split("市")[1];
	}
	return para;
}

function isContains(substr,str) {
	var reg = eval("/"+substr+"/ig");
	return reg.test(str);
}

function dateFormat(createTime){
	var newTime = new Date(createTime);
	return newTime.getFullYear() + "-" + (newTime.getMonth() + 1) + "-" + newTime.getDate() + "-" + newTime.getHours() + ":" + newTime.getMinutes() + ":" + newTime.getSeconds();
}

function updateMyMail(fdId){
	url = makeUrl("third/doa/doa_delivery/doaDelivery.do?method=view&fdId="+fdId);
	commonGet(url,null,loadMyMail, false);
}

function loadMyMail(result){
	$.popup('.popup-new-step1'); 
	var para = result.data;
	$('#expressCode').val(para.expressCode);
	$('#expressCode').val(para.expressCode);
	$('#remark').val(para.remark);
	$('#sendMenInp').val(para.senderName);
	$('#senderMobile').val(para.senderMobile);
	$('#senderAddressDetail').val(para.senderAddressDetail);
	$('#senderPostcode').val(para.senderPostcode);
	$('#recieveMenInp').val(para.receiverName);
	$('#receiverMobile').val(para.receiverMobile);
	$('#receiverAddressDetail').val(para.receiverAddressDetail);
	$('#receiverPostcode').val(para.receiverPostcode);
	$('#receiverCompany').val(para.receiverCompany);
	$('#senderAddress').html(para.senderProvince+para.senderCity+para.senderCounty);
	$('#receiverAddress').html(para.receiverProvince+para.receiverCity+para.receiverCounty);
	$('#expressInp').val(para.express.name);
	$('#fdId').val(para.fdId);
	
}

function addRecieve(){
	var para = new Object();
}

function getAddressPara(flag){
	var para = new Object();
	if (flag) {
		para.name = $('#sendMenInp').val();
		para.mobile = $('#senderMobile').val(); 
		para.addressDetail = $('#senderAddressDetail').val(); 
		para.postCode = $('#senderPostcode').val(); 
		para = substrAddress(para, $('#senderAddress').text());
	} else {
		para.name = $('#recieveMenInp').val();
		para.mobile = $('#receiverMobile').val(); 
		para.addressDetail = $('#receiverAddressDetail').val(); 
		para.postCode = $('#receiverPostcode').val(); 
		para = substrAddress(para, $('#receiverAddress').text());
	}
	addSender(para);
}

function addSender(para){
	url = makeUrl("third/doa/doa_delivery_address/doaDeliveryAddress.do?method=save");
	$.showPreloader('正在提交');
	commonPost(url, para, function(data) {
		$.hidePreloader();
		$.toast("提交成功");
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
	para.receiverName = $('#receiveMenInp').val();
	para.receiverMobile = $('#receiverMobile').val(); 
	para.receiverAddressDetail = $('#receiverAddressDetail').val(); 
	para.receiverPostcode = $('#receiverPostcode').val();
	para.receiverCompany = $('#receiverCompany').val();
	para = substrReceiver(para, $('#receiverAddress').text());
	para = substrSend(para, $('#senderAddress').text());
	para.expressId = getCourierId($('#expressInp').val());
	if($('#fdId').val()!=null){
		para.fdId = $('#fdId').val();
	}
	return para;
}

function loadMailList(result) {
	var item = null;
	$('#stayList').html("");
	$('#alreadyList').html("");
	for ( var i = 0; i < result.data.length; i++) {
		item = result.data[i];
		var mailId = "'"+item.fdId+"'";
		var store = '<div class="item-inner"> <div class="item-title"><div class="list-content-txt"><p>收件人:'+item.receiverName+'</p><p>收件地址:'+item.receiverProvince+item.receiverCity+item.receiverCounty+item.receiverAddressDetail+'</p><p>说明:'+item.remark+'</p><p>创建时间:'+dateFormat(item.createTime)+'</p></div></div></div>';
		if (item.status==2) {
			$('#stayList').append(' <li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div></div><ul class="mail-content" ><li class="item-content">'+store+'<div class="item-after"><a class="btn org" href="#"  onclick="updateMail('+mailId+',3)">通过</a><a class="btn" href="#"  onclick="updateMail('+mailId+',4)">驳回</a></div></li></ul></li>');
		} else if (item.status==3) {
			$('#alreadyList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-ys">已审核</span></div>'+store+'<div class="item-after"><a class="btn org">扫描单号</a></div></li></ul></li>');
		} else if (item.status==4) {
			$('#alreadyList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-bh">已驳回</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
		} else if (item.status==5) {
			$('#alreadyList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-jj">已寄件</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
		}
	}
}

function loadMyMailList(result) {
	var item = null;
	//$('#myMailList').html("");
	for ( var i = 0; i < result.data.length; i++) {
		item = result.data[i];
		var mailId = "'"+item.fdId+"'";
		var store = '<div class="item-inner"> <div class="item-title"><div class="list-content-txt"><p>收件人:'+item.receiverName+'</p><p>收件地址:'+item.receiverProvince+item.receiverCity+item.receiverCounty+item.receiverAddressDetail+'</p><p>说明:'+item.remark+'</p><p>创建时间:'+dateFormat(item.createTime)+'</p></div></div></div>';
		if (item.status==2) {
			$('#myMailList').append(' <li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div></div><ul class="mail-content" ><li class="item-content"><div class="item-media"><span class="type type-zc">待审核</span></div>'+store+'<div class="item-after"><a href="#" class="icon icon-right"></a></div></li></ul></li>');
		} else if (item.status==1) {
			$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-zc">暂存</span></div>'+store+'<div class="item-after"><a class="btn org" href="#"  onclick="updateMyMail('+mailId+')">修改</a></div></li></ul></li>');
		} else if (item.status==3) {
			$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-ys">已审核</span></div>'+store+'<div class="item-after"><a class="btn org">扫描单号</a></div></li></ul></li>');
		} else if (item.status==4) {
			$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-bh">已驳回</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
		} else if (item.status==5) {
			$('#myMailList').append('<li class="open-detail-popup" onclick="detailsClick('+mailId+')"><div class="subsidiary-title-container"><div class="subsidiary-title">'+item.express.name+'</div><div class="subsidiary-explain" style="float:right;">'+item.senderName+'</div> </div><ul class="mail-content"><li class="item-content"><div class="item-media"><span class="type type-jj">已寄件</span></div>'+store+'<div class="item-after"> <a href="#" class="icon icon-right"></a></div></li></ul></li>');
		}
	}
}

function loadMailDetails(result){
	var item = result.data;
	if(item.type==1){
		$('#expressType').html("公件");
	}else{
		$('#expressType').html("私件");
	}
	
	if(item.deliveryMode==1){
		$('#paymentType').html("寄件寄付");
	}else{
		$('#paymentType').html("收件到付");
	}
	$('#expressName').html(item.express.name);
	$('#expressText').html(item.remark);
	$('#expressNo').html(item.expressCode);
	$('#expressTime').html(dateFormat(item.createTime));
	$('#sName').html(item.senderName);
	$('#sMobile').html(item.senderMobile);
	$('#sAddress').html(item.senderProvince+item.senderCity+item.senderCounty+item.senderAddressDetail);
	$('#rCompany').html(item.receiverCompany);
	$('#rName').html(item.receiverName);
	$('#rMobile').html(item.receiverMobile);
	$('#rAddress').html(item.receiverProvince+item.receiverCity+item.receiverCounty+item.receiverAddressDetail);
	

	
}
