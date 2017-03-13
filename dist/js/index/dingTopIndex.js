/*
 * 通用的dingTop菜单，只带一个关闭按钮
 */
function setDingTopMenu(){
	dd.biz.navigation.setMenu({
        backgroundColor : "#FF6600",
        items : [
           
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
        	else{
        		alert("您点击了"+data.id+"号按钮");
        	}
        },
        onFail: function(err) 
        {
        	alert("功能出错");
        }
    });
}


