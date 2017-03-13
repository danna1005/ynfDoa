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
	$.popup('.popup-new-step2');
	getSenderList();
});

/* 新建第二步 */
//返回上一步
$('.popup-new-step2').on('click','.return-new-step1',function(){
	$.closeModal('.popup-new-step2');
	$.popup('.popup-new-step1');
});
//选择寄件人
var sendmenlist=[]; //寄件人列表
var recievemenlist=[]; //收件人列表]
var senderList = null;
function getSenderList(){
	url = makeUrl("third/doa/doa_delivery_address/doaDeliveryAddress.do?method=list");
	commonGet(url,null,loadSenderList, false);
}

function loadSenderList(result) {
	senderList = result.data;
	for ( var i = 0; i < result.data.length; i++) {
		sendmenlist.push(result.data[i].name);
		recievemenlist.push(result.data[i].name);
	}
}

function selectSendMem(){
	if(!isNullOrEmpty(sendmenlist)&&sendmenlist.length>0){
		$('.select-sendmen').show();
	}else{
		$('.select-sendmen').hide();
	}    	
}
selectSendMem();
$('.select-sendmen').picker({
	toolbarTemplate: '<header class="bar bar-nav">\
	  	<button class="button button-link pull-right close-picker save-value">确定</button>\
	  	</header>',
	  	cols: [
		    {
		      textAlign: 'center',
		      values: sendmenlist
		    }
	  	],
	  	onClose:function(){
	  		var selectValue = $('.picker-modal-inner').find('.picker-selected').attr('data-picker-value');
	  		$('#sendMenInp').val(selectValue);
	  	}
});
$('.mail-new-form>ul').each(function(){
	//选择所在区域
	var $this = $(this);
	$this.find('.select-area').cityPicker({
        toolbarTemplate: '<header class="bar bar-nav">\
        <button class="button button-link pull-right close-picker" id="receiveCityPicker">确定</button>\
        <h1 class="title">选择收货地址</h1>\
        </header>',
        onClose:function(){                  	
        	var panel = $('.picker-modal-inner'),
	  			province = panel.find('.col-province').find('.picker-selected').attr('data-picker-value'),
	  			city = panel.find('.col-city').find('.picker-selected').attr('data-picker-value'),
	  			district= panel.find('.col-district').find('.picker-selected').attr('data-picker-value'),
	  			area;                		
	  			if(!isNullOrEmpty(district)){
	  				area = province +'省'+city+'市'+district;
	  			}else{
	  				area = province+'市'+city;
	  			}
	  		$this.find('.inp-area').html(area);
        }  
	});
});

/*//添加寄件人
$('.mail-new-form').on('click','.insert-send-member',function(){
	var member = $.trim($('#sendMenInp').val());
	if(member!==""){
		$.toast("添加常用寄件人成功");
		//保存寄件人
		sendmenlist.push(member);
		selectSendMem();
	}else{
		$.alert('请输入寄件人名称');
	}
})*/

/*//添加收件人
$('.mail-new-form').on('click','.insert-recieve-member',function(){
	var member = $.trim($('#recieveMenInp').val());
	if(member!==""){
		$.toast("添加常用收件人成功");
		//保存收件人
		recievemenlist.push(member);
		selectRecieveMem();			
	}else{
		$.alert('请输入收件人名称');
	}
})
*/
//选择收件人    	
function selectRecieveMem(){
	var len= recievemenlist.length;
	if(!isNullOrEmpty(recievemenlist)&&recievemenlist.length>0){
		$('.select-recievemen').show();
	}else{
		$('.select-recievemen').hide();
	}    	
}
selectRecieveMem();
$('.select-recievemen').picker({
	toolbarTemplate: '<header class="bar bar-nav">\
  	<button class="button button-link pull-right close-picker save-value">确定</button>\
  	</header>',
  	cols: [
	    {
	      textAlign: 'center',
	      values: recievemenlist
	    }
  	],
  	onClose:function(){
  		var selectValue = $('.picker-modal-inner').find('.picker-selected').attr('data-picker-value');
  		$('#recieveMenInp').val(selectValue);
  	}
});