$(document).ready(function(){
	//新建的时候扫码
	$(".mail-new-form .dingScan").click(function(e){
		e.preventDefault();
		dingScanCode("barCode",function(data){
			$("#expressCode").val(data.text);
		},
		function(e){
			scanError(e);
		});
	});
	//已审核有按钮的扫码
	$("body").on("click","li .dingScan",function(){
		var id = $(this).data("id");
		dingScanCode("barCode",function(data){
			//扫码保存函数
			updateExpressCode(id,data.text);
		},
		function(e){
			scanError(e);
		});
	});
	
	//扫码失败的处理
	function scanError(e){
		alert(toString(e));
	}
})