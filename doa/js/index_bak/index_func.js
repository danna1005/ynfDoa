$(function() {
    var width = window.screen.width >= window.innerWidth ? window.innerWidth :window.screen.width;
    $("html").css({
        fontSize:width * 20 / 360 + "px"
    });
    $("body").css({
        width:width
    });
    //commonfunction
    function pxToNum(i) {
        return +i.replace(/rem|em|px/g, "");
    }
    function defer(fn) {
        setTimeout(function() {
            fn();
        }, 300);
    }
    var addMore = {
        bg:$(".addMoreBg"),
        ser:$(".addmore-panel")
    };
    var addClose = {
        open:$(".moreService"),
        close:$(".close-more-panel")
    };
    // addmore
    var flag = true;
    addMore.ser.tap(function() {
        if ($(this).hasClass("up")) {
            flag = false;
        }
        if (flag) {
            addClose.open.show();
            $(this).addClass("up").find(".addMoreSer").removeClass("icon-down").addClass("icon-up");
            flag = false;
        } else {
            addClose.open.hide();
            $(this).removeClass("up").find(".addMoreSer").removeClass("icon-up").addClass("icon-down");
            flag = true;
        }
    });
    // close
    addClose.close.tap(function() {
        addClose.open.hide();
        addMore.removeClass("up").find(".addMoreSer").removeClass("icon-up").addClass("icon-down");
    });
    //touch
    var detailDistanceHash = {
        initX:0,
        length:0,
        unitW:0,
        index:0,
        unique:true
    };
    function touchMove() {
        var oTouch = $(".detailPage").get(0);
        oTouch.addEventListener("touchstart", function(ev) {
            var event = ev.touches[0];
            detailDistanceHash.initX = event.pageX;
            //page style change
            var len = detailDistanceHash.length = $(".detailPage span").length + 1;
            var unitW = detailDistanceHash.unitW = +$(".detailPage span").eq(0).css("width").replace(/rem|em|px/g, "");
            $(this).css({
                width:unitW * len
            });
            detailDistanceHash.unique = true;
        }, false);
        oTouch.addEventListener("touchmove", function(ev) {
            var event = ev.touches[0];
            var distanceX = event.pageX - detailDistanceHash.initX;
            detailDistanceHash.initX = event.pageX;
            var iLeft = +$(this).css("left").replace(/rem|em|px/g, "");
            var endX = iLeft + distanceX;
            if (endX < 0) {
                if (endX >= (detailDistanceHash.length - 5) * -detailDistanceHash.unitW) {
                    if (detailDistanceHash.unique) {
                        if (distanceX < 0) {
                            detailDistanceHash.index--;
                        } else if (distanceX > 0) {
                            detailDistanceHash.index++;
                        }
                        detailDistanceHash.unique = false;
                        if (detailDistanceHash.index < -Math.floor(detailDistanceHash.length)) {
                            detailDistanceHash.index = -Math.floor(detailDistanceHash.length);
                        }
                        if (detailDistanceHash.index > 0) {
                            detailDistanceHash.index = 0;
                        }
                        if (detailDistanceHash.index == detailDistanceHash.length) {
                            addMore.ser.hide();
                        }
                        $(this).animate({
                            left:detailDistanceHash.index * detailDistanceHash.unitW
                        });
                        if (endX <= -detailDistanceHash.unitW * 1) {} else {}
                    }
                }
            }
        }, false);
    }
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
        
        $(".speInforChildren > p > b").each(function(index, element) {
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
        $(".detailSelection .detailPage span").click(function(element) {
            var index = $(this).index();
            //加入class用于后期关联判断
            $(this).siblings("span").removeClass("cur");
            $(this).addClass("cur");
            var id = $(this).attr("id");
            $(".speBtn").removeClass("cur");
            logJsonText(id);
            var contentDIV = $("#content-" + id);
            contentDIV.siblings(".applist").addClass("hidden").removeClass("cur");
            contentDIV.removeClass("hidden").addClass("cur");
            /*var selectContent = contentDIV.find('.selectionContent'),
				rowsNum = Math.ceil(selectContent.find('span').length/4);
			if(rowsNum>2){
				contentDIV.find('.nextPart').removeClass('dis-none');
				contentDIV.find('.selectionContent').height('7.15rem');
			}else{
				contentDIV.find('.nextPart').addClass('dis-none');
				contentDIV.find('.selectionContent').height('auto');
			}		
			$('.applist').find('.nextIcon').addClass('down').animate({'transform': 'rotateX(0deg)'});*/
            // 改变链接的 hash 值	
            window.location.hash = $(".detailPage .cur").data("hash");
        });
        //加载更多分类隐藏前三个
        $(".speInforChildren p").each(function(index) {
            if (index < 5) {
                $(this).hide();
            } else {
                // $(this).addClass("speBtn");
            }
        });
         $(".detailSelection .detailPage span").each(function(index){
            if (index >= 4) {
                $(this).hide();
            } 
         });
        // 切换分类 里面点击的动作效果 ; 
        // 这里还需要考虑首页的锚点加载的问题 如#=4（人力资源），现在已经在index_data.js里面，数据请求加载的时候做了修改，
        $(".speInforChildren p").click(function() {
            var id = $(this).data("id"), nav = $(this).find("span").text();
            // 当前点击tab
            $(this).addClass("cur");
            $(this).siblings(".speBtn").removeClass("cur");
            /*$('.detailPage').find('span').removeClass('cur');*/
            // 修改点击动作，控制到关联的tab点击
            $(this).siblings(".speBtn").each(function() {
                // 去掉替换（隐藏）
                // var speHideID = $(this).data("id");
                // $("#" + speHideID).addClass("hidden");
            });
            // 自己的tab点击
            $("#" + id).removeClass("hidden").addClass("cur");
            //$("#" + id).siblings("span").removeClass("cur");
            $('.detailPage').find('span').removeClass('cur');
            // 控制tab关联内容的显示
            var contentDIV = $("#content-" + id);
            contentDIV.siblings(".applist").addClass("hidden").removeClass("cur");
            contentDIV.removeClass("hidden").addClass("cur");
            window.location.hash = $("#" + id).data("hash");
            /*addClose.open.hide();
            addMore.ser.removeClass("up").find(".addMoreSer").removeClass("icon-up").addClass("icon-down");
            flag = true;*/
        });
        //app分类少于五个则不显示加更多
        var categoryNum = $(".detailPage>span").length;
        // logJsonText(categoryNum);
        if (categoryNum <= 4) {
            $(".addmore-panel").hide();
        } else {
            $(".addmore-panel").show();
        }
    }
    function outerHeight(element) {
        var a = [ "height", "padding-top", "padding-bottom", "margin-top", "margin-bottom" ];
        var b = 0;
        for (var i = 0, len = a.length; i < len; i++) {
            var s = element.css(a[i]).replace(/px|rem|em/g, "");
            if (s != "") {
                b += parseFloat(element.css(a[i]).replace(/px|rem|em/g, ""));
            }
        }
        return b;
    }
    // 初始化加载的时候，那个nextPart的倒三角显示更多。
    //defer(loadMore);
    function loadMore() {
        //加载和收起应用
        var container = $(".applist.cur");
        var rowsNum = Math.ceil(container.find(".selectionContent").find("span").length / 4);
        if (rowsNum > 2) {
            container.find(".nextPart").removeClass("dis-none");
            container.find(".selectionContent").height("7.15rem");
        } else {
            container.find(".nextPart").addClass("dis-none");
            container.find(".selectionContent").height("auto");
        }
        $(".applist").on("click", ".nextPart", function() {
            var btn = $(this).find(".nextIcon");
            var contentDIV = btn.parents(".applist"), selectContent = contentDIV.find(".selectionContent");
            if (btn.hasClass("down")) {
                selectContent.animate({
                    height:"auto"
                }, 80, "ease-in-out");
                btn.removeClass("down").animate({
                    transform:"rotateX(180deg)"
                });
            } else {
                selectContent.animate({
                    height:"7.15rem"
                }, 80, "ease-in-out");
                btn.addClass("down").animate({
                    transform:"rotateX(0deg)"
                });
            }
        });
    }
    
    //关闭弹出窗
    $("#occlude").click(function() {
        $("#prompt").addClass("dis-none");
    });
    
    
    $(".hr-prompt-panel").on('click','.prompt-close',function(){
    	$(".hr-prompt-panel").fadeOut();
    });
 

    //御家资讯里面的那个更多
    var newsHref = makeUrl("sys/news/mobile/?moduleName=新闻公告");
    //获取首页御家资讯部分的数据
    var newsRowSize = 5;
    // var yujiaNewsURL = "sys/news/sys_news_main/sysNewsMain.do?method=jsonNewsList&categoryId=1519f8ec85c075cdcf4180241f491a79&status=all&showDocStatus=true&nodeType=CATEGORY&rowsize="+newsRowSize;
    var yujiaNewsURL = "third/doa/doa_sys_news/sysNews.do?method=listChildrenLst&categoryId=&q.docStatus=30&orderby=fdIsTop,fdTopTime,docPublishTime&ordertype=down&rowsize=" + newsRowSize;
    //底部新闻数据拉取
    var newsData = new Vue({
        el:"#yujiaNews",
        data:{
            con:"",
            moreHref:newsHref
        },
        ready:function() {
            var newsUrl = makeUrl(yujiaNewsURL);
            commonGet(newsUrl, null, function(r) {
                newsData.con = getNewsList(r);
            }, false);
        }
    });

    //从新闻接口获取新闻数据
    function getNewsList(r) {
        for (var i = 0; i < r.data.length; i++) {
            if (typeof r.data[i].pic != "undifined" && r.data[i].pic) {
                r.data[i].imgUrl = makeUrl(r.data[i].pic);
            } else {
                r.data[i].imgUrl = "../images/apps/new/leftNews.png";
            }
            // r.data[i].content = $.trim($("<p>"+r.data[i].content+"</p>").text()).slice(0,32)+"...";
            r.data[i].content = $.trim($("<p>" + r.data[i].content+"</p>").text()).slice(0, 32) + "...";
            r.data[i].time = getLocalTime(r.data[i].time);
            r.data[i].url = makeUrl(r.data[i].url);
        }
        return r.data;
    }

});

//打开弹出窗

function aListClick(obj){
	var str = obj.href;

	if(str=="javascript:void(0)"){		
		$(".hr-prompt-panel").fadeIn();
		return false;		
	}else{		
		return true;
	}	
}