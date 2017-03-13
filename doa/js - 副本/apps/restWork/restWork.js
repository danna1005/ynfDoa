$(document).ready(function(){	
	var initialized = false;
	//请求的页码
	var reqPage = 1;	
	//是否还有数据
	var dataWait = true;	
	var vue = new Vue({
		el:"#restWorkData",
		data:{
			results:new Array(),
			dataClass:'empty-block'
		},
		methods:{
			appendData:function(arr)
			{		
				for(var i=0;i<arr.length;i++){
					vue.results.push(arr[i]);
				}
				if(vue.results.length<1){
					$('.empty-block').removeClass('dis-none');
				}else{					
					$('.empty-block').addClass('dis-none');
				}
			}
		}
	});
	

	$('.dropload-content').dropload({
        scrollArea : window,
        loadDownFn : function(me)
        {
    		var url = makeRestWorkDataUrl(reqPage);
			commonGet(url,null,function(r){
				if(noError(r))
				{
					logJsonText("init page : " + reqPage);
					vue.appendData(improveAjaxData(r.data.toDoItems.list));
					fillTotalToDo(r.data.toDoItems.totalRows);
					initialized = true;
					if(parseInt(r.data.toDoItems.pageNo) < parseInt(r.data.toDoItems.endPageNo))
					{
						reqPage = parseInt(reqPage) + 1;
					}
					else
					{
						// 锁定
 		                me.lock(); 
         		        // 无数据
                 		me.noData();
					}
					setTimeout(function(){
                        // 每次数据插入，必须重置
                        me.resetload();
             		},30);
				}
				else
				{
					logJsonText(r);
				}
			},logJsonText);      	

        }
    });
	
	//应用帮助
	$('.page').on('click','.help-icon',function(){
		$('.prompt-panel').fadeIn('slow');		
	});
	
	$('.prompt-panel').on('click','.prompt-close',function(){
		$('.prompt-panel').fadeOut();		
	});
	
});


//获取待办的异步请求链接
function makeRestWorkDataUrl(reqPage)
{
	var p = "/third/doa/doa_systodo/sysToDo.do?method=index&oprType=doing&fdType=13&rowsize=5&pageno="+reqPage;
	return makeUrl(p);
}

//对数据进行处理
function improveAjaxData(list)
{
	var liuChengPic = "..\\..\\..\\images\\apps\\restWork\\liucheng.png";
	var xiaoXiPic = "..\\..\\..\\images\\apps\\restWork\\xiaoxi.png";
	for(var i=0; i<list.length; i++)
	{
		if(list[i].title == "消息相关"){
			list[i].img = xiaoXiPic;
		}
		else
		{
			list[i].img = liuChengPic;
		}
		list[i].link = makeUrl(list[i].fdLink);
		list[i].fdSubject = list[i].fdSubject.slice(0,15)+"...";
	}
	return list;
}

//对一共多少个待办的处理
function fillTotalToDo(num)
{
	$("#toDoCnt").html(num);
}