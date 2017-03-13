//流程类型筛选 全部 OA HR
$('.category-tab').on('click','a',function(e){
	e.preventDefault();
	$(this).addClass('active').siblings("a").removeClass('active');
	//切换一级分类的时候需要清空tab的内容
	$(".process-list-block>.tab").html("");
	//默认显示第一个分类的内容
	$(".second-category-tab>a").eq(0).tap();
	//HR 没有待阅和已办
	var curBtn = $(this);
	if(curBtn.hasClass("hrProcess")){
		loadHrMyApply()
		$(".doingBtn").addClass("hidden");
		$(".doneBtn").addClass("hidden");
	}
	else{
		$(".doingBtn").removeClass("hidden");
		$(".doneBtn").removeClass("hidden");
		if(curBtn.hasClass("oaProcess")){
			loadOaMyApply();
		}
		else{
			loadOaAndHrMyApply();
		}
	}
	$(".myApplyBtn").addClass("active").siblings().removeClass("active");
	$("#myApplyBtn").addClass("active").siblings().removeClass("active");
});


$(".second-category-tab>a").click(function(){
	$(".process-list-block>div>ul>li").each(function(){
		$(this).removeClass("hidden");
	});
	$("#search").val();
});

//设置列表的高度 自适应
var filterHeight = $('.salary-list-block').height(),
	contHeight = $('.m-content').height(),
	listHeight = contHeight -filterHeight;
$('.process-list-block').css('height',listHeight);

//列表滚动加载
// $('.process-list-block').bind('scroll',function(){
// 	if($(this).scrollTop() + $(this).outerHeight()>=$(this)[0].scrollHeight) {
// 		//加载
// 		$.showPreloader();
// 		setTimeout(function () {
// 	        $.hidePreloader();
// 	    }, 500);
//     }	
// })


//新建
$('.m-header-container').on('click','a.button-new',function(){
	//弹出popup 分类弹框，显示一级分类
	$.popup('.popup-new');
	$('.page-first-cate').show();
	$('.page-second-cate').hide();
	$('.page-second-cate').find('.catesel').removeClass('cateselected'); //清除上一次选中记录
});

//到第二级分类
$('.page-first-cate').on('click','li',function(){
	var mainCate = $(this).attr("id");
	getSubProCates(mainCate);
});

//返回上一级
$('.m-category-header').on('click','a.goback',function(){
	$('.page-second-cate').hide();
	$('.page-first-cate').show();
	$('.page-second-cate').find('.catesel').removeClass('cateselected'); //返回上级后清除选中记录
});
$('.page-second-cate').on('click','li',function(){
	//选中二级分类后关闭弹层
	$(this).find('.catesel').toggleClass('cateselected');
	$.closeModal('.popup-new');
});