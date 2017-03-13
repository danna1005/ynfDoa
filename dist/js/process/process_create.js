/*
2017.02.03
1.流程一级分类的数据
sys/category/mobile/sysCategory.do?method=cateList&categoryId=&canSelect=&getTemplate=1&modelName=com.landray.kmss.km.review.model.KmReviewTemplate&authType=02
2.流程二级分类的数据
sys/category/mobile/sysCategory.do?method=cateList&categoryId=1549d9956e1fcd738c1ccea4a98a475a&canSelect=&getTemplate=1&modelName=com.landray.kmss.km.review.model.KmReviewTemplate&authType=02
3.进入流程的创建
km/review/km_review_main/kmReviewMain.do?method=add&fdTemplateId=1549e25f90d1db810c362fe4302a6a5c
*/


$(document).ready(function(){
	getMainProCates();	
})



//拼接第二层流程分类的链接
function makeProSubCateUrl(mainCateId)
{
	var curUrl = "sys/category/mobile/sysCategory.do?method=cateList&categoryId="+mainCateId+"&canSelect=&getTemplate=1&modelName=com.landray.kmss.km.review.model.KmReviewTemplate&authType=02"
	var proSubCateUrl = makeUrl(curUrl);
	return proSubCateUrl;
}

//获取流程一级分类的数据
function getMainProCates()
{
	var proMainCateUrl = makeUrl("sys/category/mobile/sysCategory.do?method=cateList&categoryId=&canSelect=&getTemplate=1&modelName=com.landray.kmss.km.review.model.KmReviewTemplate&authType=02"); 
	commonGet(proMainCateUrl,false,function(r){
		var content = "";
		for(var i=0; i<r.length; i++)
		{
			var item = r[i];
			var html = 
			'<li class="item-content" id="'+ item.value +'">\
		        <div class="item-inner">\
		        	<div class="item-media">\
		        		<i class="iconfont icon-fenlei"></i>\
		        		<div class="item-title">'+ item.text +'</div>\
		        	</div>\
		          	<div class="item-after">\
		          		<span class="icon icon-right"></span>\
		          	</div>\
		        </div>\
	       	</li>';
	       	content +=html;
		}
		$("#proMainCate").html(content);
	},false);
}

//获取流程二级分类的数据
function getSubProCates(mainCateId)
{
	$.showPreloader();
	var subCateUrl = makeProSubCateUrl(mainCateId);
	commonGet(subCateUrl,false,function(r){
		var content = "";
		for(var i=0; i<r.length; i++)
		{
			var item = r[i];
			var html = 
			'<li class="item-content">\
   				<a data-href="'+ makeProUrl(item.value) +'" style="width:100%;">\
			        <div class="item-inner">\
			        	<div class="item-media">\
			        		<span class="iconfont icon-duigou catesel"></span>\
			        		<i class="iconfont icon-fenlei"></i>\
			        		<div class="item-title">'+item.text+'</div>\
			        	</div>\
			        </div>\
			    </a>\
	       	</li>';
	       	content += html;
		}
		$.hidePreloader();
		$("#proSubCate").html(content);
		$('.page-first-cate').hide();
		$('.page-second-cate').show();
	},false);
}

//构建流程的URL
function makeProUrl(proId)
{
	var curUrl = "km/review/km_review_main/kmReviewMain.do?method=add&fdTemplateId="+proId;
	return makeUrl(curUrl);
}

