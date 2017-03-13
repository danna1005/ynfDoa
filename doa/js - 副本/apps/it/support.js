//进页面就加载
		var url = null;
		var seatColumn11 = null;
		var seatRow11 = null;
		//var word = null;
		var	s1 = "御家汇大楼";
		var	s2 = "1";
		var	s3 = "前台";
		var flag = 0;
		var locationId2 = null;
		var typeId ="";
		var zw = "";
		
		
		
		$(document).ready(function() {	
			//应用帮助
			$('.page').on('click','.help-icon',function(){
				$('.prompt-panel').show();		
			});
			
			$('.prompt-panel').on('click','.prompt-close',function(){
				$('.prompt-panel').hide();		
			});
			getAddress();
			getType();
			getProblem();
			getItKnowledge();
			
			$("#userLocation").click(function() {
				
				if($("#userLocation").text()=="选择"){
					getLocation(flag,null);
				}else{
					getLocation1(flag,null);
				}
				
			});
			
			
	 
		});
		
		$(function(){
		    
		     
		     $(document).on('click','.open-location', function() {
//		    	var winHeight = $(window).height();
//		    	$('.popup').css('top',winHeight-290);
	    	   $.popup('.popup-location');
	    	 });
		     
		     $(document).on('click','.building', function() {
		    	 $("#column").html("");
				 $("#yrow").html("");
				 $("#zwh").html("");
		    	 s1 = $(this).text();
		    	 //word = $(this).text();
		    	 flag = 1;
		    	  getLocation(flag,$(this).text());
		    	 $('.building').removeClass('selectedDiv');
		    	 $(this).addClass('selectedDiv');		    	
		    	 setUserLocation($(this).text(),0);
		    	
	    });
		     
		     $(document).on('click','.type', function() {
		    	 $('.type').removeClass('selectedDiv');
		    	 typeId = $(this).find("input").eq(0).val();
		    	 /* $('.type').css("border","1px solid #dedede"); */
		    	 $(this).addClass('selectedDiv');		    	 
	    	 });
		     
		     $(document).on('click','.floor', function() {
		    	 $("#column").html("");
				 $("#yrow").html("");
				 $("#zwh").html("");
		    	 s2 = $(this).text().substr(0,$(this).text().length-1);
		    	// word = $(this).text().substr(0,$(this).text().length-1);
		    	 flag = 2;
		    	
		    	  getLocation(flag,$(this).text().substr(0,$(this).text().length-1));
		    	 $('.floor').removeClass('selectedDiv');
		    	 $(this).addClass('selectedDiv');
		    
		    	 setUserLocation($(this).text(),1);
		    	
	    	 });
		     
		     $(document).on('click','.area', function() {
		    	 s3 = $(this).text();
		    	 //word = $(this).text();
		    	 flag = 3;
		    	 getLocation(flag,$(this).text());
		    	 $('.area').removeClass('selectedDiv');
		    	 $(this).addClass('selectedDiv');
		    	
		    	 //logJsonText("aaaa"+$(this).attr('data-locationId1'));
		    	 setUserLocation($(this).text(),2);
		    	
	    	 });
		     
		     $(document).on('click','.yrow', function() {
		    	 $('.yrow').removeClass('selectedDiv');	
		    	
		    	 $(this).addClass('selectedDiv');
		    	 setUserLocation($(this).text(),3);
	    	 });
		     
		     $(document).on('click','.column', function() {
		    	 $('.column').removeClass('selectedDiv');
		    	 $(this).addClass('selectedDiv');
		    	
		    	
		    	 seatColumn = $(this).text().substr(0,1);
		    	 setUserLocation($(this).text(),4);
	    	 });
		     
		     $(document).on('change','#seat', function() {
		    	 setUserLocation($(this).val()+"号",5);
	    	 });
		     
		     $(document).on('click','#enterUserLocation', function() {
		    	 var tempUserLocation = $('#tempUserLocation').text();
		    	 tempUserLocation = tempUserLocation.replace(/,/g, "");
		    	 $('#userLocation').text(tempUserLocation);
		    	 $.closeModal('.popup-location');
				
		    	
	    	 });
		     $("#img1").click(function() {
				 	$("#score").value="1";
					$("#img1").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img2").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
					$("#img3").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
					$("#img4").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
					$("#img5").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
				});

				$("#img2").click(function() {
					$("#score").value="2";
					$("#img1").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img2").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img3").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
					$("#img4").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
					$("#img5").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
				});
				$("#img3").click(function() {
					$("#score").value="3";
					$("#img1").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img2").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img3").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img4").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
					$("#img5").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
				});
				$("#img4").click(function() {
					$("#score").value="4";
					$("#img1").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img2").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img3").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img4").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img5").attr('src',"..\\..\\..\\images\\apps\\it\\star1.png");
				});
				$("#img5").click(function() {
					$("#score").value="5";
					$("#img1").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img2").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img3").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img4").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");
					$("#img5").attr('src',"..\\..\\..\\images\\apps\\it\\star.png");			 
				});
				
		     
		    
		});
		 function setUserLocation(value,i){
			
	    	 var currentLocation = $('#tempUserLocation').text();
	    	 var splitLocations = currentLocation.split(',');
	    	
	    	
	    	 splitLocations.splice(i,1,value);
			 var userLocationStr = splitLocations.join(',');
	    	 $('#tempUserLocation').text(userLocationStr);
	    	
	    	 
	    	
	    	 
	    	 
	     }

			//问题类型获取
			function getType(){
				url = makeUrl("third/doa/doa_problem_type/doaProblemType.do?method=jsonData");
				$.getJSON(url, function(data) {					
					 $("#question").html(""); 
					 $.each(data.data, function(i, item) {
						 var id =item.fdId;
						if(i==0){
							typeId = item.fdId;
							$("#question").append('<div class="round type selectedDiv" style="margin:0.25rem 0rem 0.25rem 0.25rem;font-size:0.6rem;float:left">'+item.name+'<input type="hidden" value="'+id+'"/></div>');
						}else{
							$("#question").append('<div class="round type waitDiv" style="margin:0.25rem 0rem 0.25rem 0.25rem;font-size:0.6rem;float:left">'+item.name+'<input type="hidden" value="'+id+'"/></div>');
						}
					    					    	
					 });
				});	
			}
			
			//个人地址获取
			function getAddress(){
				url = makeUrl("third/doa/doa_person_location/doaPersonLocation.do?method=queryAddress");
				$.getJSON(url, function(data) {										
					if(data.data==undefined||data.data==""){
						
					}else{						
						 $("#userLocation").text(data.data);
						 var arrUserLocation = data.data.replace(/\s+/g, ' ').split(" ");
						 for ( var i = 0; i < arrUserLocation.length;i++) {
							
							setUserLocation(arrUserLocation[i],i);
							
						}
						
					}
					
					 
				});	
			}
			
			//问题列表获取
			function getProblem(){	
				$("#questionList").html("");	
				url = makeUrl("third/doa/doa_problem/doaProblem.do?method=getMyProblem&handler=false");
				$.getJSON(url,function(data) {					
					//logJsonText(data.data); 
					
					if(data.data.list==""||data.data.list==undefined){
						$("#questionList").append('<div class="empty-block" id="dis-none"><img src="../../../images/common/empty.png" class="empty-img"/><p id="tips">还没有提交问题</p></div>');
					}else{		 
						 $.each(data.data.list, function(i, item) {	
							 //
						    	if(item.status==1||item.status==2){
						    		var fid = "'"+item.fdId+"'";
						    		var typeName = "'"+item.typeName+"'";
						    		var description = "'"+item.description+"'";
						    		var handleResult = "'"+item.handleResult+"'";
						    		var status = "'"+item.status+"'";
						    		$("#questionList").append('<li><a class="open-question" id="open-question" onclick="itemClick('+fid+','+typeName+','+description+','+handleResult+','+status+')"><div class="item-content m-item-content"><div class="item-media m-item-media"><img src="..\\..\\..\\images\\apps\\it\\ask.png" class="m-list-img"></div><div class="item-inner"><div class="m-item-inner"><div class="item-title-row"><div class="item-title m-list-main-txt" >'+item.description+'</div></div><div class="m-list-subtitle-txt">问题由系统分配至'+item.currentHandlerName+'处理</div></div></div><div class="item-after m-item-after m-list-main-txt">待接单</div></div></a></li>');														    		
						    		
						    	}else if(item.status==0){
						    		var fid = "'"+item.fdId+"'";
						    		var typeName = "'"+item.typeName+"'";
						    		var description = "'"+item.description+"'";
						    		var handleResult = "'"+item.handleResult+"'";
						    		var status = "'"+item.status+"'";
						    		$("#questionList").append('<li><a class="open-question" id="open-question" onclick="itemClick('+fid+','+typeName+','+description+','+handleResult+','+status+')"><div class="item-content m-item-content"><div class="item-media m-item-media"><img src="..\\..\\..\\images\\apps\\it\\ask.png" class="m-list-img"></div><div class="item-inner"><div class="m-item-inner"><div class="item-title-row"><div class="item-title m-list-main-txt" >'+item.description+'</div></div><div class="m-list-subtitle-txt">问题由系统分配至'+item.currentHandlerName+'处理</div></div></div><div class="item-after m-item-after m-list-main-txt" >处理中</div></div></a></li>');														    		
						    		
						    	}else if(item.status==3){
						    		// "<li><a class='open-question'id='open-question' onclick='itemClick("+item.fdId+")'><div class='item-content m-item-content'><div class='item-media m-item-media'><img src='..\\..\\..\\images\apps\it\ask.png' class='m-list-img'></div><div class='item-inner'><div class='m-item-inner'><div class='item-title-row'><div class='item-title m-list-main-txt' >"+item.description+"</div></div><div class='m-list-subtitle-txt'>问题由系统分配至"+item.currentHandlerName+"处理</div></div></div><div class='item-after m-item-after m-list-main-txt' style='color:#f36920;'>待评价</div></div></a></li>" 
						    		var fid = "'"+item.fdId+"'";
						    		var typeName = "'"+item.typeName+"'";
						    		var description = "'"+item.description+"'";
						    		var handleResult = "'"+item.handleResult+"'";
						    		var status = "'"+item.status+"'";
						    		$("#questionList").append('<li><a class="open-question" id="open-question" onclick="itemClick('+fid+','+typeName+','+description+','+handleResult+','+status+')"><div class="item-content m-item-content"><div class="item-media m-item-media"><img src="..\\..\\..\\images\\apps\\it\\ask.png" class="m-list-img"></div><div class="item-inner"><div class="m-item-inner"><div class="item-title-row"><div class="item-title m-list-main-txt" >'+item.description+'</div></div><div class="m-list-subtitle-txt">问题由系统分配至'+item.currentHandlerName+'处理</div></div></div><div class="item-after m-item-after m-list-main-txt" style="color:#f36920;">待评价</div></div></a></li>');														    		
						    		
						    		
						    	}else if(item.status==4){
						    		var fid = "'"+item.fdId+"'";
						    		var typeName = "'"+item.typeName+"'";
						    		var description = "'"+item.description+"'";
						    		var handleResult = "'"+item.handleResult+"'";
						    		var status = "'"+item.status+"'";
						    		$("#questionList").append('<li><a class="open-question" id="open-question" onclick="itemClick('+fid+','+typeName+','+description+','+handleResult+','+status+')"><div class="item-content m-item-content"><div class="item-media m-item-media"><img src="..\\..\\..\\images\\apps\\it\\ask.png" class="m-list-img"></div><div class="item-inner"><div class="m-item-inner"><div class="item-title-row"><div class="item-title m-list-main-txt" >'+item.description+'</div></div><div class="m-list-subtitle-txt">问题由系统分配至'+item.currentHandlerName+'处理</div></div></div><div class="item-after m-item-after m-list-main-txt" ">已结束</div></div></a></li>');														    		
						    		
						    	}
	    			    	
						    });
						}
					});	
			}
			//评价
			function itemClick(fid,typeName,description,handleResult,status){
				$('#popupQuestion').css('top','0');
	 				$.popup('.popup-question');
	 				if(status==3){
	 				
	 					$("#questionId").val(fid);
		    			$("#roundDiv2").html(typeName);
		    			$("#problemDescription").html(description);
		    			$("#handleResult").html(handleResult);
		    			$("#evaluate").html("待评价");
		    			$("#evaluation").removeClass("hide");
		    			$("#buttonList").removeClass("hide");
	 				}else if(status==1||status==2){
	 					$("#roundDiv2").html(typeName);
		    			$("#problemDescription").html(description);
		    			$("#handleResult").html("网络工程师还未接单");
		    			$("#evaluate").html("待接单");
		    			$("#evaluation").addClass("hide");
		    			$("#buttonList").addClass("hide");
		    			
	 				}else if(status==0){
	 					$("#roundDiv2").html(typeName);
		    			$("#problemDescription").html(description);
		    			$("#handleResult").html("网络工程师正在处理中");
		    			$("#evaluate").html("处理中");
		    			$("#evaluation").addClass("hide");
		    			$("#buttonList").addClass("hide");
	 				}else if(status==4){
	 					$("#roundDiv2").html(typeName);
		    			$("#problemDescription").html(description);
		    			$("#handleResult").html(handleResult);
		    			$("#evaluate").html("已结束");
		    			$("#evaluation").addClass("hide");
		    			$("#buttonList").addClass("hide");
	 				}
	 				
    		}
			
			//IT知识获取
			function getItKnowledge(){
				 $("#knowledgeList").html("");
				url = makeUrl("third/doa/doa_it_knowledge/doaItKnowledge.do?method=list");
				$.getJSON(url, function(data) {					
					
					if(data.data.list==""||data.data.list==undefined){
						$("#knowledgeList").append('<div class="empty-block" id="dis-none"><img src="../../../images/common/empty.png" class="empty-img"/><p id="tips">IT知识库没有内容</p></div>');
					}else{
						 $.each(data.data.list, function(i, item) {
								var fid = "'"+item.fdId+"'";					    		
						    	 $("#knowledgeList").append('<li><a class="open-detail" onclick="listClick('+fid+')" ><div class="item-content m-list-block"><div class="item-media"><img src="..\\..\\..\\images\\apps\\it\\file.png" class="img2"></div><div class="item-inner"><div class="my-item-inner"><div class="item-title-row"><div class="item-title m-list-main-txt ">'+item.description+'</div></div><div class="item-subtitle"><img src="..\\..\\..\\images\\apps\\it\\type.png" class="img1"/><span class="hostSpan m-list-subtitle-txt">'+item.typeName +'</span><img src="..\\..\\..\\images\\apps\\it\\good.png" class="img1"/><span class="praiseSpan m-list-subtitle-txt">'+item.totalGood+'</span></div></div></div></div></a></li>' );				    					    	
						 });
					}
				});	
			}
			
			//详细资料
			function listClick(fid){
					//alert("2322");
				 var url = makeUrl("third/doa/doa_it_knowledge/doaItKnowledge.do?method=view&fdId="+fid);
			   				  
				    $.getJSON(url, function(data) {
				    	
				    	$('#popupDetail').css('top','0');
		 				$.popup('.popup-detail');	 					 			
		 				$("#totalGoodId").val(data.data.fdId);
		    			$("#roundDiv1").html(data.data.typeName);
		    			$("#pDetails").html(data.data.description);
		    			$("#resolve").html(data.data.handleResult);
		    			$("#thumbUp").html(data.data.totalGood);
				            	
				           
				          
			       		});
				
	 				  				
    		}
			
			function locationIdClick(locationId){
				locationId2 = locationId;
			}
			
			//提交新问题
			$("#big-button").click(function() {	
				url = makeUrl("third/doa/doa_problem/doaProblem.do?method=save");
				var description = $("#description").val();
				
				if(description==null||description==""){
					 $.toast("请输入问题描述");
				}else if(description.length>200){
					 $.toast("请输入两百字以内的问题描述");
				}else{
					 // $.ajax({			            
				  //           type:"POST",	 
				  //           url:url,			            
				  //           data:{description:$("#description").val(),typeId:typeId}, 
				  //           datatype: "json",
				  //           success:function(data){
				  //           	console.log("test:"+JSON.stringify(data));
				  //           	if(!data.chatId){
				  //           		data = JSON.parse(data);
				  //           	}
				  //           	$.toast(data.title);
				  //           	getProblem();
				  //           	switchTab();

				  //           	wakeChat(data.chatId);
				  //           },
				  //           error: function(){
				  //           	 $.toast("提交失败，系统异常");
				  //           }         
			   //       });
			   		var para = new Object();
			   		para.description = $("#description").val();
			   		para.typeId = typeId;
			   		commonPost(url,para,function(data){
			   			logJsonText(data);
			   			// $.toast(data.title);
			   			$("#description").val("");
			   			$('.type').removeClass('selectedDiv');
			   			$($("#question").children("div").get(0)).addClass('selectedDiv');
		            	getProblem();
		            	// switchTab();
		            	$.modal({
		            		title:"提示",
		            		text: data.title,//+"<br><a data-chat-id='"+data.chatId+"'>打开钉钉消息进行实时沟通</a>",
		            		buttons:[
		            			{
		            				text:"打开",
		            				onClick:function()
		            				{
		            					wakeChat(data.chatId);
		            					switchTab();
		            				}
		            			},
		            			{
		            				text:"取消",
		            				onClick:function(){
		            					switchTab();
		            				}
		            			}
		            		]
		            	});

			   		},false);
			 
				}
			});
			
			$('#description').on('propertychange input', function(event) {
				if($(this).val().length>200){
					$.toast("请输入两百字以内的问题描述");
					$(this).css("background-color","#EEB4B4");
				}else{
					$(this).css("background-color","#FFFFFF");
				}
			});
			
			//评价问题
			$("#enterUserLocation1").click(function() {	
				url = makeUrl("third/doa/doa_problem/doaProblem.do?method=update");
				 $.ajax({			            
			            type:"POST",	 
			            url:url,			            
			            data:{fdId:$("#questionId").val(),status:4,comment:$("#score").value}, 
			            datatype: "html",
			            success:function(data){
			            	 $.toast("提交成功");
			            	 
			            	 getProblem();
			            	 
			            },
			            error: function(){
			            	 $.toast("提交失败，系统异常");
			            }         
		         });
				 getProblem();
			});
			//重新提交问题
			$("#enterUserLocation4").click(function() {	
				url = makeUrl("third/doa/doa_problem/doaProblem.do?method=update");
				 $.ajax({			            
			            type:"POST",	
			            //contentType: "application/json;charset=utf-8", 
			            url:url,			            
			            data:{fdId:$("#questionId").val(),status:2}, 
			            datatype: "html",
			            success:function(data){
			            	 $.toast("提交成功"); 
			            	 getProblem();
			            },
			            error: function(){
			            	 $.toast("提交失败，系统异常");
			            }         
		         });
					
			});
			
			//点赞加一
			$("#enterUserLocation2").click(function() {	
				url = makeUrl("third/doa/doa_it_knowledge/doaItKnowledge.do?method=addGood");
				var n = $("#totalGoodId").val();
				 $.ajax({			            
			            type:"POST",	
			            //contentType: "application/json;charset=utf-8", 
			            url:url,			            
			            data:{fdId:n}, 
			            datatype: "json",
			            success:function(data){
			            	listClick(n);
			            	 $.toast("提交成功，点赞+1"); 
			            	 getItKnowledge();
			            },
			            error: function(){
			            	 $.toast("提交失败，系统异常"); 
			            }         
		         });			
			});
			//搜索IT知识库；
			$("#search").bind('input propertychange', function() {					
				
					if($("#search").val()==""){
						getItKnowledge();
					}else{
						searchIt($("#search").val());
					} 
				 				
			});
		
			//通过关键字搜索
			function searchIt(keyWord) {
				url = makeUrl("third/doa/doa_it_knowledge/doaItKnowledge.do?method=search&keyword="+keyWord);
				$.getJSON(url, function(data) {		            
					 $("#knowledgeList").html("");	 
					 if(data.data.list==""||data.data.list==undefined){
							$("#knowledgeList").append('<div class="empty-block" id="dis-none"><img src="../../../images/common/empty.png" class="empty-img"/><p id="tips">没有搜索到想要的结果</p></div>');
						}else{
							 $.each(data.data.list, function(i, item) {
									var fid = "'"+item.fdId+"'";
						    		var typeName = "'"+item.typeName+"'";
						    		var description = "'"+item.description+"'";
						    		var handleResult = "'"+item.handleResult+"'";
							    	 $("#knowledgeList").append('<li><a class="open-detail" onclick="listClick('+fid+','+typeName+','+description+','+handleResult+')" ><div class="item-content m-list-block"><div class="item-media"><img src="..\\..\\..\\images\\apps\\it\\file.png" class="img2"></div><div class="item-inner"><div class="my-item-inner"><div class="item-title-row"><div class="item-title m-list-main-txt ">'+item.typeName+'</div></div><div class="item-subtitle"><img src="..\\..\\..\\images\\apps\\it\\type.png" class="img1"/><span class="hostSpan m-list-subtitle-txt">主机</span><img src="..\\..\\..\\images\\apps\\it\\good.png" class="img1"/><span class="praiseSpan m-list-subtitle-txt">'+item.totalGood+'</span></div></div></div></div></a></li>' );				    					    	
							 });
						}
	         
				           
				                  
			    });			
			}
			
			$("#helpDetails").click(function() {
				url = makeUrl("third/doa/doa_problem/doaProblem.do?method=update");
				 $.ajax({			            
			            type:"POST",	
			            url:url,			            
			            data:{fdId:$("#questionId").val,status:2}, 
			            datatype: "json",
			            success:function(data){
			            	 $.toast("提交成功"); 
			            },
			            error: function(){
			            	 $.toast("提交失败，系统异常");
			            }         
		         });			
			});
			
			//位置更新
			$("#enterUserLocation").click(function() {
					var arr = ($("#tempUserLocation").text()).split(",");
						
					if(arr.length>3){
						arr[4]= arr[4].substr(0,arr[4].length-1);
						arr[3]= arr[3].substr(0,arr[3].length-1);
					}
					
					url = makeUrl("third/doa/doa_person_location/doaPersonLocation.do?method=save");
										
						 $.ajax({			            
					            type:"POST",	
					            url:url,			            
					            data:{locationId:locationId2,seatColumn:arr[4],seatRow:arr[3],seatNum:$("#seat").val()}, 
					            datatype: "json",
					            success:function(data){	
					            	
					            	 $.toast("位置更新成功");   
					            },
					            error: function(){
					            	 $.toast("提交失败，系统异常");
					            }         
				         });
				
			});
			
			
			
			//位置获取
			function getLocation1(flag1,word){
				
				var arr = ($("#tempUserLocation").text()).split(",");
			
				
								
				url = makeUrl("third/doa/doa_location/doaLocation.do?method=jsonData");
							
				 $.getJSON(url, function(data) {				
					var item = data.data;
					var obj = null;
					var objChild = null;
					
												
					
						 $("#building").html("");
						obj = getBuilding1(item, arr[0]);
										
				
						$("#floor").html("");
						
						objChild = getFloor1(obj, arr[1].substr(0,arr[1].length-1));
						
					
					if(arr.length<4){
						
						 $("#area").html("");
						 $("#zwh").html("");
						 $("#column").html("");
						 $("#yrow").html("");						
						getArea1(objChild,arr[2],null,null);
				
					
					}else{
						$("#area").html("");
						getArea1(objChild, arr[2],arr[4].substr(0,arr[4].length-1),arr[3].substr(0,arr[3].length-1));
					}
					
					if(arr.length>5){
						 $("#zwh").html("");
						 $("#zwh").append('<input type="number" min="0" id="seat" class="highlight" value="'+arr[5].substr(0,arr[5].length-1)+'" /><div class="highlight">(餐厅->窗户)</div>');

					}
					
					
				
					 
				 });
				
				
			}  
			//得到大楼与下一层对象
			function getBuilding1(item,word){
				var obj = null;
				for(var key in item){
					if(word==null){	
						
					}else{
						
						if(key==word){
							
							$("#building").append('<div class="round building selectedDiv" style="float:left;font-size:0.6rem;"  >'+key+'</div>');
						}else{
							
							$("#building").append('<div class="round building" style="float:left;font-size:0.6rem;"  >'+key+'</div>');
							
						}
						obj = item[word];
					}	
				}
				
				return obj;
				
			}
			//得到楼层与下一级对象;
			function getFloor1(item,word){
				 
				var i = 0;
				var obj = null;
				
			
				for(var key in item){
					
					if(word==null){
					
						
					}else{
						if(key==word){
							s2 = word;
							$("#floor").append('<div class="round floor selectedDiv" style="float:left;font-size:0.6rem;"  >'+key+'楼</div>');
						}else{
							//$("#tempUserLocation").text() = $("#tempUserLocation").text()+word+",";
							$("#floor").append('<div class="round floor" style="float:left;font-size:0.6rem;"  >'+key+'楼</div>');
							
						}
						obj = item[word];
					}	
				}
				//logJsonText(obj);
				return obj;
				
			}
			//得到房间与下一级对象;
			function getArea1(item,word,column,row){
				//var obj = null;
				
				 $.each(item, function(i, obj) {
					 
					if(word==null){
						
					}else{
					
						if(obj.roomName==word){
							
							$("#area").append('<div class="round area selectedDiv" style="float:left;font-size:0.6rem;"  >'+obj.roomName+'</div>');
						}else{
							//$("#tempUserLocation").text() = $("#tempUserLocation").text()+word+",";
							$("#area").append('<div class="round area" style="float:left;font-size:0.6rem;"  >'+obj.roomName+'</div>');
							
						}
						
						
					
				
					}
					
					
					
				});
				 
				 $.each(item, function(i, obj) {
				
					 if(obj.roomName=="大厅"){
							Column1(obj,column,row);
					 }
				 
				 });
				
			}
			function Column1(obj,column,row){

				logJsonText(obj);
					locationIdClick(obj.locationId);
					var seatColumn= new Array(); 
					 seatColumn=(obj.seatColumn).split(",");
					 $("#column").html("");
					 for ( var j = 0; j < seatColumn.length; j++) {				
						 if(seatColumn[j]==column){
							$("#column").append('<div class="round column selectedDiv" >'+seatColumn[j]+'列</div>'); 
						 }else{
							$("#column").append('<div class="round column " >'+seatColumn[j]+'列</div>');
							//$($("#column").children("div").get(0)).addClass('selectedDiv');
						 }
					
					}						
					 seatColumn=(obj.seatRow).split(",");
					 $("#yrow").html("");
					 for ( var j = 0; j < seatColumn.length; j++) {

						 if(seatColumn[j]==row){
							 $("#yrow").append('<div class="round yrow selectedDiv" >'+seatColumn[j]+'排</div>'); 
						 }else{
							 $("#yrow").append('<div class="round yrow " >'+seatColumn[j]+'排</div>');
							//$($("#yrow").children("div").get(0)).addClass('selectedDiv');
						 }
						
					}
					

					 $("#column").append('<div class="highlight">(楼梯口>会议室)</div>');
					 $("#yrow").append('<div class="highlight">(楼梯口>会议室)</div>');
					
					
			}
				
		
			
			//aadd
			function getLocation(flag1,word){
				
				url = makeUrl("third/doa/doa_location/doaLocation.do?method=jsonData");
				
				 $.getJSON(url, function(data) {
				
					var item = data.data;
					//logJsonText(item);
					var obj = null;
					var objChild = null;
					var objGrandson = null;
					
					if(flag1<1){
					
						 $("#building").html("");
						obj = getBuilding(item, null);
						
					}else{
						obj = getBuilding(item, s1);
					}
					
					if(flag1<2){
						 $("#floor").html("");
						 
						objChild = getFloor(obj, null);
						
					}else{
						objChild = getFloor(obj, s2);
					}
					
					if(flag1<3){
						 $("#area").html("");
						 getArea(objChild, null);
						
					}else{
						getArea(objChild, s3);
					}
					if(word=="大厅"){
						
						locationIdClick(objChild[word].locationId);
					}
					
				
					
					 
				 });
				
				 flag=0;
			}  
			//得到大楼与下一层对象
			function getBuilding(item,word){
				var obj = null;
				var i = 0;
				for(var key in item){
					if(word==null){	
						if(i==0){
							setUserLocation(key,0);
							obj = item[key];
							i++;
						}
						$("#building").append('	<div class="round building"  style="float:left;font-size:0.6rem;"  >'+key+'</div>');
						$($("#building").children("div").get(0)).addClass('selectedDiv');
						
						//$("#tempUserLocation").text() = key+",";
						
					}else{
						
						obj = item[s1];
						//$("#tempUserLocation").text() = s1+",";
					}	
				}
				
				return obj;
				
			}
			//得到楼层与下一级对象;
			function getFloor(item,word){
				var i = 0;
				var obj = null;
				
				//logJsonText(item);
				for(var key in item){
					
					if(word==null){
						if(i==0){
							setUserLocation(key+"楼",1);
							obj = item[key];
							i++;
						}
						$("#floor").append('<div class="round floor" style="float:left;font-size:0.6rem;"  >'+key+'楼</div>');
						$($("#floor").children("div").get(0)).addClass('selectedDiv');
						//setUserLocation(key,1);
						//obj = item[key];
						//logJsonText(obj);
						//$("#tempUserLocation").text() = $("#tempUserLocation").text()+key+",";
						
					}else{
						//$("#tempUserLocation").text() = $("#tempUserLocation").text()+word+",";
						
						obj = item[word];
						
					}	
				}
				//logJsonText(obj);
				logJsonText(obj);
				return obj;
				
			}
			//得到房间与下一级对象;
			function getArea(item,word){
				var obj = null;
				seatColumn11="";
				seatRow11="";
				
				 $.each(item, function(i, obj) {
					if(i==0){
						locationIdClick(obj.locationId);
						
					}
						
						
					
						
					if(word==null){
						var locationId1= "'"+obj.locationId+"'";
						//logJsonText(locationId1);
					
						$("#area").append('<div class="round area " onclick="locationIdClick('+locationId1+')">'+obj.roomName+'</div>');						
						$($("#area").children("div").get(0)).addClass('selectedDiv');
						
						if(i==0){
							setUserLocation(obj.roomName,2);
							if(obj.roomName=="大厅"){								
								Column(obj,"keyi");
								
							}
							
							
						}
						if(obj.roomName!="大厅"&&i==0){
							
							 var str = $('#tempUserLocation').text().split(",");
							 $('#tempUserLocation').html(str[0]+","+str[1]+","+str[2]);
							
							
							
						}
						
						
							
						
				
						
					}else{
						if(word==obj.roomName){
							locationIdClick(obj.locationId);
						}
						
						
						if(word=="大厅"||obj.roomName=="大厅"){					
							Column(obj,"keyi");
						}else if(word!=="大厅"){
							$("#zwh").html("");
							 var str = $('#tempUserLocation').text().split(",");
							$('#tempUserLocation').html(str[0]+","+str[1]+","+str[2]); 
							$("#column").html("");
							 $("#yrow").html("");
						}
						
					}	
				});
				
				
				
			}
			
			function Column(item,word){
				 setUserLocation("1排",3);
				 setUserLocation("1列",4);
				
				logJsonText(item);
				 					
				var seatColumn= new Array(); 
				 seatColumn=(item.seatColumn).split(",");
				 $("#column").html("");
				 $("#zwh").html("");
				 seatColumn11 = seatColumn[0];
				 for ( var j = 0; j < seatColumn.length; j++) {
					 
					$("#column").append('<div class="round column " >'+seatColumn[j]+'列</div>');
					
						
					
					
				
				}
				 $("#zwh").append('<input type="number" min="0" id="seat" class="highlight" /><div class="highlight">(餐厅->窗户)</div>');
				
					$($("#column").children("div").get(0)).addClass('selectedDiv');
				 $("#column").append('<div class="highlight">(楼梯口>会议室)</div>');
				
				 var seatRow=(item.seatRow).split(",");
				 $("#yrow").html("");
				 for ( var j = 0; j < seatRow.length; j++) {
					
					$("#yrow").append('<div class="round yrow " >'+seatRow[j]+'排</div>');
				
					
					
				}
				 seatRow11 =seatRow[0];
				
				 
				$($("#yrow").children("div").get(0)).addClass('selectedDiv');
			 	$("#yrow").append('<div class="highlight">(楼梯口>会议室)</div>');
				$("#zwh").removeClass("hide");
			}
			
			function switchTab(){
				$("#tab1").removeClass("active");
				$("#tab2").addClass("active");
				$("#taba1").removeClass("active");
				$("#taba2").addClass("active");
			}
			
			
			$("#seat").bind('input propertychange', function() {
				
				var re = new RegExp("^(0[1-9]|[1-9][0-9])$");
				 
				  if(re.exec($("#seat").val()) ){
					  zw = $("#seat").val();
				  }else{
					  alert("请输入0到99的整数");
					  
				  }
				
			
				
			 				
		});