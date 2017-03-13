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
        		$.popup('.popup-new-step1'); 
        	}
        },
        onFail: function(err) 
        {
        	alert("功能出错");
        }
    });
}