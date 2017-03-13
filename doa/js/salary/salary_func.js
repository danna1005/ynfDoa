//初始进来弹出提示
$.modal({
	title:"高压线提醒",
	text: "<div style='text-align:left;text-indent:1.5rem'>该页面将会显示您的工资信息，按公司要求，仅允许本人查看。</div>",
	buttons:[
		{
			text:"确定",
			onClick:function()
			{
				//显示页面并弹出密码框
				$('.page-group').removeClass('hide');
				$.popup('.popup-pwd');
			}
		}
	]
});

//$.popup('.popup-pwd');
//每月工资单详情展开、收起
$('#FIRST-LEVEL').on('click','.first-level>.item-content',function(){
	$(this).find('.icon-down').toggleClass('icon-up').parents('.first-level').find('.month-detail-list').toggleClass('hide');			
})

//弹出工资详情
$("body").on('click','.month-detail-list ul>li',function(ind)
{
	var id = $(this).data("id");
	$.popup("."+id);
})
//时间段筛选
$('.salary-month-filter').on('click','li',function(){
	var ind = $(this).index();
	$(this).addClass('cur').siblings().removeClass('cur');	
	switch (ind){
		case 0:
			//console.log(getLast12Months(1));
			break;
		case 1:
			//console.log(getLast12Months(3));
			break;
		case 2:
			//console.log(getLast12Months(6));
			break;
		default :;
	}
})
//获取近n个月月份
function getLast12Months(n){  
    var last12Months = [];  
    var today = new Date();  
      
    today.setMonth(today.getMonth()+1);  
    for(var i=0;i<n;i++){  
        var lastMonth = today.setMonth(today.getMonth()-1);  
        last12Months[11-i] = today.getFullYear() + "年" + (Number(today.getMonth())+1) + "月";  
    }  
    return last12Months.reverse();  //将数组反转，倒序
} 
$(function(){
	//重置密码
	// $('.content-block').on('click','a.reset-btn',function(e){
	// 	e.preventDefault();
	// 	$.modal({
 //    		title:"提示",
 //    		text: "新密码已经发送到您的邮箱，tangmi@yujiahui.com，请查收",
 //    		buttons:[
 //    			{
 //    				text:"确定",
 //    				onClick:function()
 //    				{
 //    					//发送重置密码邮件
 //    				}
 //    			}
 //    		]
 //    	});
	// 	//$.alert('新密码已经发送到您的邮箱，tangmi@yujiahui.com，请查收', '提示');
	// })
	// //查询
	// $('.content-block').find('a.search-btn').tap(function(e){
	// 	e.preventDefault();
	// 	$.closeModal('.popup-pwd');
	// })
	
	//返回顶部
	$('.popup-m-content').scroll(function(){ 
		if ($('.popup-m-content').scrollTop()>50){ 
			$(".return-top").show(); 
		}else{ 
			$(".return-top").hide();
		} 
	})
	$(".popup-detail").on('click','.return-top',function(){ 	
		$('.popup-m-content').scrollTop(0);
		$(".return-top").hide();
	});
});