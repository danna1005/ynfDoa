function setDingTopMenu(){
	dd.biz.navigation.setMenu({
        backgroundColor : "#FF6600",
        items : [
            {
                "id":"4",
              "text":"关闭",
            },
            {
                "id":"5",
              "text":"新建",
            }
        ],
        onSuccess: function(data) 
        {
        	if(data.id == 4)
        	{
        		dd.biz.navigation.close({
        		    onSuccess : function(result) {
//        		       alert("您触发了关闭按钮，已经执行了关闭操作"+JSON.stringify(result));
        		    },
        		    onFail : function(err) {
        		    	
        		    }
        		})
        	}
        	if(data.id == 5)
        	{
        		//弹出popup 分类弹框，显示一级分类
        		$.popup('.popup-new');
        		$('.page-first-cate').show();
        		$('.page-second-cate').hide();
        		$('.page-second-cate').find('.catesel').removeClass('cateselected'); //清除上一次选中记录
        	}
        },
        onFail: function(err) 
        {
        	alert("功能出错");
        }
    });
}