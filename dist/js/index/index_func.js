
$(function() {
    var width = window.screen.width >= window.innerWidth ? window.innerWidth :window.screen.width;
    $("html").css({
        fontSize:width * 20 / 360 + "px"
    });
    $("body").css({
        width:width
    });    
    function defer(fn) {
        setTimeout(function() {
            fn();
        }, 200);
    }
    var addMore = {
        bg:$(".addMoreBg"),
        ser:$(".addmore-panel")
    };
    // addmore
    var flag = true;
    addMore.ser.tap(function() {
        if ($(this).hasClass("up")) {
            flag = false;
        }
        if (flag) {
            $(this).addClass("up").find(".addMoreSer").removeClass("icon-down").addClass("icon-up");
            $('.detailSelection > .detailPage').css({'height':'auto'});
            flag = false;
        } else {
        	$('.detailSelection > .detailPage').css({'height':'2rem'});
            $(this).removeClass("up").find(".addMoreSer").removeClass("icon-up").addClass("icon-down");
            flag = true;
        }
    });    
    // 数字1
    defer(commonFnNum);
    function commonFnNum() {
        var commonFnHash = {
            w:+$(".commonFn strong").css("width").replace(/rem|em|px/g, ""),
            h:+$(".commonFn strong").css("height").replace(/rem|em|px/g, ""),
            br:+$(".commonFn strong").css("border-radius").replace(/rem|em|px/g, "")
        };
        $(".commonFn strong").each(function(index, element) {
            var a = +$(this).html();
            if (a <= 99) {
                if (a < 10) {
                    $(this).css("width", commonFnHash.h).css("border-radius", "50%");
                } else {
                    $(this).css("border-radius", "0.5rem");
                }
            } else {
                $(this).css("border-radius", "0.5rem").html("99+");
            }
        });
    }
    //detailPageI自适应宽度
    function detailPageI() {
        $(".detailPage b").each(function(index, element) {
            var width = $(this).css("width");
            $(this).siblings("i").css({
                width:width
            });
        });        
    }
    defer(detailPageI);
    //我的日常
    defer(detailClick);
    function detailClick() {
        // $(".detailSelection .detailPage span").click(function(element) {
            $("body").on("click" , ".detailSelection .detailPage span",function(element) {
            var index = $(this).index();
            //加入class用于后期关联判断
            $(this).addClass("cur").siblings("span").removeClass("cur");
            var id = $(this).attr("id");
            var contentDIV = $("#content-" + id);
            contentDIV.siblings(".applist").addClass("hidden").removeClass("cur");
            contentDIV.removeClass("hidden").addClass("cur");
            // 改变链接的 hash 值	
            /*var hash = $(".detailPage .cur").data("hash");            
            window.location.hash = $(".detailPage .cur").data("hash");*/
        });     
    }
        
    
    //关闭弹出窗
    $("#occlude").click(function() {
        $("#prompt").addClass("dis-none");
    });
    
    //关闭人力资源应用提示框
    $(".hr-prompt-panel").on('click','.prompt-close',function(){
    	$(".hr-prompt-panel").fadeOut();
    }); 
    
    $('.msg-remind-panel').on('click','i.icon-close',function(){
    	$('.msg-remind-panel').animate({'height':0,'marginBottom':0},200);
    });
    
    var $this = $(".msg-remind-panel")
	 ,   scrollTimer
	 ,   length;
	 length = $(".msg-remind-list>table").find('tr').length;
	 /* 超过一条垂直滚动显示 */
	 if(length>1){
		 scrollTimer = setInterval(function() { 
		 	scrollNews($this); 
		 }, 4000);
	 }
	 /* $this.swipe(function(){
		 clearInterval(scrollTimer); 				 
	 }) */
	 
	 //关闭通知
	 $(".msg-remind-panel").on('click','.icon-close',function(){
		 $(".msg-remind-panel").animate({'height':'0'},500);
	 });

});

//打开弹出窗 人力资源应用没有提示待开发...
function aListClick(obj){
	var str = obj.href;
	if(str=="javascript:void(0)"){		
		$(".hr-prompt-panel").fadeIn();
		return false;		
	}else{		
		return true;
	}	
}

//通知滚动
function scrollNews(obj) { 
	var $self = obj.find("table")
	,	lineHeight= $self.find("td").height(); 
	$self.animate({ 
		"marginTop": -lineHeight + "px" 
	}, 800, function() { 
		$self.css({ 
			marginTop: 0 
		}).find("tr").eq(0).appendTo($self); 
	});
} 

//监听浏览器当前页面是否被激活的事件
var hiddenProperty = 'hidden' in document ? 'hidden' :    
    'webkitHidden' in document ? 'webkitHidden' :    
    'mozHidden' in document ? 'mozHidden' :    
    null;
var visibilityChangeEvent = hiddenProperty.replace(/hidden/i, 'visibilitychange');
var onVisibilityChange = function()
{
    if(!document[hiddenProperty]){	
    	fetchIconData();
    	fetchMailCntData();
//    	alert("调用了接口");
    }
}
document.addEventListener(visibilityChangeEvent, onVisibilityChange);

