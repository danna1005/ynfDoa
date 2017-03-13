//判断非空
function isNullOrEmpty(obj){
	if (obj == null) {
		return true;
	} else if ($.trim(obj) == "") {
		return true;
	} else if (obj == "undefined") {
		return true;
	} else {
		return false;
	}
}
/* 查看详情 */
$('.mail-list').on('click','li.open-detail-popup',function(){
	$.popup('.popup-detail');
});

/* 新建第一步 */
//点击新建弹出popup
$('.bar-nav').on('click','.button-new',function(){
	$.popup('.popup-new-step1');    	
});
//单选框操作 
$('.mail-list').find('li').each(function(){
	var _this = $(this);
	_this.on('click','.rdopanel>i',function(){
		$(this).parent().siblings().find('i').removeClass('icon-rdoselect').addClass('icon-rdo');
		$(this).removeClass('icon-rdo').addClass('icon-rdoselect');
	});
});

//申请详情字数控制
$('.popup').find('li').each(function(){
	var $this = $(this)
	$this.find(".applay-txt").bind('input propertychange', function() {	
		var num = $this.find('.count>span'),
			len = $this.find(".applay-txt").val().length;
		num.html(len);
		if(len>100){
			num.css("color","red")
		}else{
			num.css("color","#ccc")
		}     	 				
	});
});
//下一步
$('.popup-new-step1').on('click','#nextStepButton',function(){
	
	var expressInpVal = $('#expressInp').val();
	var remark = $('#remark').val();
	if(expressInpVal.trim() == '') {
		$.toast("请选择快递公司");
	}else if(remark.trim() == ''){
		$.toast("请输入收寄理由");
	}
	else{
		$.popup('.popup-new-step2');
		getSenderList();
	}
});

/* 新建第二步 */
//返回上一步
$('.popup-new-step2').on('click','.return-new-step1',function(){
	$.closeModal('.popup-new-step2');
	$.popup('.popup-new-step1');
});
var sendmenlist=[]; //寄件人列表
var recievemenlist=[]; //收件人列表
var senderList = null;
function getSenderList(){
	url = makeUrl("third/doa/doa_delivery_address/doaDeliveryAddress.do?method=list");
	commonGet(url,null,loadSenderList, false);
}

function loadSenderList(result) {
	senderList = result.data;
	for ( var i = 0; i < result.data.length; i++) {
		if(result.data[i].postType=='sender'){
			sendmenlist.push(result.data[i].name);
		}else{
			recievemenlist.push(result.data[i].name);
		}
	}
	selectSendMem();
	selectRecieveMem();
}

function selectSendMem(){
	if(!isNullOrEmpty(sendmenlist)&&sendmenlist.length>0){
		$('.select-sendmen').show();
	}else{
		$('.select-sendmen').hide();
	}    	
}
selectSendMem();

/**
 * 选择寄件人
 */
$('#selectSender').picker({
	toolbarTemplate: '<header class="bar bar-nav">\
	  	<button class="button button-link pull-right save-value" onClick="enterSender()">确定</button>\
	  	</header>',
	  	cols: [
		    {
		      textAlign: 'center',
		      values: sendmenlist
		    }
	  	],
	  	onClose:function(){
	  		
	  	}
});

function enterSender(){
	var selectValue = $('.picker-modal-inner').find('.picker-selected').attr('data-picker-value');
	$('#sendMenInp').val(selectValue);
	var para = new Object();
	for ( var i = 0; i < senderList.length; i++) {
		if (senderList[i].name == selectValue) {
			para = senderList[i];
			$('#senderMobile').val(para.mobile);
			$('#senderPostcode').val(para.postCode);
			$('#senderAddress').html(para.province+para.city+para.county);
			$('#senderAddressDetail').val(para.addressDetail);
		}
	}
	$("#selectSender").picker("close");
}

/**
 * 选择寄件人所在地区
 */
$('#selectSenderArea').cityPicker({
    toolbarTemplate: '<header class="bar bar-nav">\
    <button class="button button-link pull-right" id="receiveCityPicker" onClick="enterSenderCity()">确定</button>\
    <h1 class="title">选择寄件地区</h1>\
    </header>',
    onClose:function(){                  	
    	
    }
});

function enterSenderCity(){
	var panel = $('.picker-modal-inner'),
	province = panel.find('.col-province').find('.picker-selected').attr('data-picker-value'),
	city = panel.find('.col-city').find('.picker-selected').attr('data-picker-value'),
	district= panel.find('.col-district').find('.picker-selected').attr('data-picker-value'),area;                		
	if(!isNullOrEmpty(district)){
		area = province +'省'+city+'市'+district;
	}else{
		area = province+'市'+city;
	}
	$("#senderAddress").html(area);
	$("#selectSenderArea").picker("close");
}

function selectRecieveMem(){
	var len= recievemenlist.length;
	if(!isNullOrEmpty(recievemenlist)&&recievemenlist.length>0){
		$('.select-recievemen').show();
	}else{
		$('.select-recievemen').hide();
	}    	
}

selectRecieveMem();

/**
 * 选择收件人
 */
$('#selectReceiver').picker({
	toolbarTemplate: '<header class="bar bar-nav">\
  	<button class="button button-link pull-right save-value" onClick="enterReceiver()">确定</button>\
  	</header>',
  	cols: [
	    {
	      textAlign: 'center',
	      values: recievemenlist
	    }
  	],
  	onClose:function(){
  		
  	}
});

function enterReceiver(){
	var selectValue = $('.picker-modal-inner').find('.picker-selected').attr('data-picker-value');
	$('#recieveMenInp').val(selectValue);
	var para = new Object();
	for ( var i = 0; i < senderList.length; i++) {
		if (senderList[i].name == selectValue) {
			para = senderList[i];
			$('#receiverMobile').val(para.mobile);
			$('#receiverAddressDetail').val(para.addressDetail);
			$('#receiverPostcode').val(para.postCode);
			$('#receiverCompany').val(para.company);
			$('#receiverAddress').html(para.province+para.city+para.county);
		}
	}
	$("#selectReceiver").picker("close");
}

/**
 * 选择收货地区
 */
$('#selectReceiverArea').cityPicker({
    toolbarTemplate: '<header class="bar bar-nav">\
    <button class="button button-link pull-right" id="receiveCityPicker" onClick="enterReceiverArea()">确定</button>\
    <h1 class="title">选择收件地区</h1>\
    </header>',
    onClose:function(){                  	
    	
    }
});

function enterReceiverArea(){
	var panel = $('.picker-modal-inner'),
	province = panel.find('.col-province').find('.picker-selected').attr('data-picker-value'),
	city = panel.find('.col-city').find('.picker-selected').attr('data-picker-value'),
	district= panel.find('.col-district').find('.picker-selected').attr('data-picker-value'),area;                		
	if(!isNullOrEmpty(district)){
		area = province +'省'+city+'市'+district;
	}else{
		area = province+'市'+city;
	}
	$("#receiverAddress").html(area);
	$("#selectReceiverArea").picker("close");
}