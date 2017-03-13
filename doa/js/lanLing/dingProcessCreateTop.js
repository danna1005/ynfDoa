function setDingTopMenu(){
	dd.biz.navigation.setMenu({
        backgroundColor : "#FF6600",
        items : [
            {
                "id":"4",
              "text":"关闭",
            },
        ],
        onSuccess: function(data) 
        {
        	if(data.id == 4)
        	{
        		chooseToCloseCurWindow();
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

//设置左侧导航栏
function setDingTopLeft(){
	dd.biz.navigation.setLeft({
	    show: true,//控制按钮显示， true 显示， false 隐藏， 默认true
	    control: true,//是否控制点击事件，true 控制，false 不控制， 默认false
	    showIcon: true,//是否显示icon，true 显示， false 不显示，默认true； 注：具体UI以客户端为准
	    text: '返回',//控制显示文本，空字符串表示显示默认文本
	    onSuccess : function(result) {
	    	chooseToCloseCurWindow()
	    },
	    onFail : function(err) {}
	});
}

/**
 * 返回上一级或者关闭当前窗口
 */
function chooseToCloseCurWindow()
{
	if(confirm("您还有数据未提交，确定要离开页面吗？"))
	{
		dd.biz.navigation.close({
		    onSuccess : function(result) {
//		       alert("您触发了关闭按钮，已经执行了关闭操作"+JSON.stringify(result));
		    },
		    onFail : function(err) {
		    	
		    }
		});
	}
}