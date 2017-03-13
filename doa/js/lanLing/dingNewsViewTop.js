/*
 * 通用的dingTop菜单，只带一个关闭按钮
 */
function setDingTopMenu(){
	dd.biz.navigation.setMenu({
        backgroundColor : "#FFFFCC",
        items : [
            {
              "id":"4",
              "text":"关闭"
            },
            {
               "id":"5",
               "text":"评价"
            },
            {
                "id":"6",
                "text":"收藏"
            },
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
        	else if(data.id == 5)
        	{
        		//评价        	
        		var evaUrl = $("#evaluate li").data("href");
        		window.location.href = makeUrl(evaUrl); 
        	}
        	else if(data.id == 6)
        	{
        		$("#collect i.muiBookmarkTabButton").trigger("click");
        	}
        },
        onFail: function(err) 
        {
        	alert("功能出错");
        }
    });
}


