<% String doaVersion = request.getParameter("v")!=null?request.getParameter("v"):"1.0.3"; %>
<!doctype html>
<html style="overflow-x:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<meta http-equiv="expires" content="-1"/>
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" href="../css/sui/sm.min.css?v=<%=doaVersion %>">
<link rel="stylesheet" href="../css/common/common.css?v=<%=doaVersion %>">  
<link rel="stylesheet" href="../css/index.css?v=<%=doaVersion %>">  
</head>
<body data-version="<%=doaVersion %>">
	<div id="rel_div" style=" position:fixed;z-index:999;right:20px;bottom:20px; float:right;">
		<a href="apps/info/discontent.html?v=<%=doaVersion %>" class="openLink-true">
			<span class="feedback-icon"></span>
		</a>
	</div>
<!-- 顶部搜索 -->
	<div class="index-body">
		<div class="search-panel bar-nav">
	        <img src="../images/apps/new/headerBg.png" class="search-img"/>
	        <img src="../images/apps/new/yjh.png" alt="御家汇" class="yjh-logo">
	        <a class="searchPart popup-search">
	            <input type="text" name="searchKey"  placeholder="请输入关键词" disabled="true" />
	            <i class="icon icon-search" title="搜索"></i>
	        </a>
	    </div>			
<!-- 上面部分4个快捷入口 -->
	    <div class="row no-gutter commonFn">
	        <!-- 考勤打卡 -->
	        <p class="col-25">
	        	<a class="openLink-true" 
	        	href="dingtalk://dingtalkclient/action/switchtab?index=2&name=work&scene=1&corpid=dingaa4af3a17a318947&appid=158">
	                <span class="imgpanel">
	                    <span class="icon location-icon" alt="K"></span>
	                    <strong class="hidden">0</strong>
	                </span>
	               	<em>考勤打卡</em>
	            </a>
	            <!-- 用于新手指引 -->
	            <span class="apps-highlight">	
		            <span class="imgpanel">
		               <span class="icon location-icon" alt="K"></span>
		               <strong class="hidden">0</strong>
		            </span>
		            <em>考勤打卡</em>
	          	</span>
	        </p>
	        <!-- 待办事宜 -->
	        <p class="col-25">          
	            <a id="" href="apps/restWork/rest-work.html?v=<%=doaVersion %>" class="openLink-true">
	                <span class="imgpanel">
	                	<span class="icon restwork-icon" alt="D"></span>
	                    <strong class="hidden">0</strong>
	                </span>
	                <em>待办事宜</em>
	            </a>
	            <!-- 用于新手指引 -->
	            <span class="apps-highlight">	
		            <span class="imgpanel">
		            	<span class="icon restwork-icon" alt="D"></span>
		               <strong class="hidden" >0</strong>
		            </span>
		            <em>待办事宜</em>
	          	</span>
	        </p>
	        <!-- 钉邮 -->
	        <p class="col-25">          
	            <a href="#">
	                <span class="imgpanel">
	                	<span class="icon dingmail-icon" alt="D"></span>
	                    <strong class="hidden">0</strong>
	                </span>
	                <em>钉邮</em>
	            </a>
	            <!-- 用于新手指引 -->
	            <span class="apps-highlight">	
		            <span class="imgpanel">
		               <span class="icon dingmail-icon" alt="D"></span>
		               <strong class="hidden" >0</strong>
		            </span>
		            <em>钉邮</em>
	          	</span>
	        </p>
	        <!-- IT服务 -->
	        <p class="col-25">          
	            <a id="itService" href="third/apps/it/support.html?v=<%=doaVersion %>" class="openLink-true">
	                <span class="imgpanel">
	                    <span class="icon it-icon" alt="I"></span>
	                    <strong class="hidden">0</strong>
	                </span>
	                <em>IT服务</em>
	            </a>
	            <!-- 用于新手指引 -->
	            <span class="apps-highlight">	
		            <span class="imgpanel">
		            	<span class="icon it-icon" alt="I"></span>
		               <strong class="hidden" >0</strong>
		            </span>
		            <em>IT服务</em>
	          	</span>
	        </p>
	        <!-- 没了 你还想要什么！！！？ -->
	    </div>
<!-- 中间部分APP -->

	    <div class="graybg"></div>
	    <div class="detailFn">
	        <div class="detailContent">
	            <!-- 主分类 -->
	            <div class="detailSelection">
	                <span class="addmore-panel"><span class="icon icon-down addMoreSer"></span></span>
	                 <div class="detailPage ">
	                    <span class="cur" id="分类名" data-hash="序号">
	                        <b>分类名</b>
	                        <i></i>
	                    </span>
	                </div>
	            </div>
	            <!-- APP内容 -->
	            <div class="appItems">
	                <div class="row no-gutter applist" id="content-{{key}}">
	                	<div class="selectionContent">
	    	                <span v-for="item in val.list" class="col-25 {{item.class}}" >
	    	                    <a href="item.url" calss= "a1" data-anchor="{{item.icon}} " onclick="aListClick(this)">
	    	                        <img v-bind:src='item.icon' alt="#">
	    	                        <b v-text="item.name">APP_NAME</b>
	    	                    </a>
	    	                </span>
	                    </div>
	                </div>
	            </div>            
	        </div>        
	    </div>
	    <div class="graybg"></div>
	    <!-- 系统通知 -->
	    <div id="homeNoticeNews" class="msg-remind-panel">
			<i class="pull-left icon-tongzhi"></i>
			<span class="split"></span>
			<div class="msg-remind-list">
				<table > 
					<tr><td>关于新邮箱系统正式上线通知</td></tr>
					<tr><td>OA移动御家办公已更新，如遇问题请联系汤米,或者在首页吐槽区吐槽哦~~</td></tr>
					<tr><td>关于聘任致远为湖南御家汇科技有限公司生产管理学院院长的通知</td></tr>
				</table>
			</div>
			<i class="pull-right icon-guanbi"></i>
		</div>
		<!-- 下面的部分御家资讯  -->
		<div id="yujiaNews" class="news">
			<div class="newsTitle">
				<span class="ynfNewsInfo">
					<b></b>
					御家资讯
				</span>	
				<a class="moreNews openLink-true" id="newsMoreHref" href="#">
					更多
					<span class="icon icon-right"></span>
				</a>
			</div>
	        <div class="newsItems">
	    		<div class="speNews" >
	                <a  href="#">
	                    <div class="speNewsLeft">
	                        <img src="../images/apps/new/leftNews.png" onerror='this.src="../images/apps/new/leftNews.png"'>
	                    </div>
	                    <div class="speNewsRight">
	                    	<i class="iconfont icon-new1"></i>
	                        <h2>新闻标题</h2>
	        				<p>新闻简介</p>
	        				<span class="newsTime">新闻时间</span>
	                    </div>
	        			<div class="speNewsBg lastBg"></div>
	                </a>
	    		</div>
	        </div>
		</div>
		
		<!-- 新手指引 -->
	    <div class="doa-guide dis-none" id="guide1">
	    	<div class="prompt-panel">
				<div class="prompt-guide-mask"></div>
				<div class="prompt-guide">
					<ul>
						<!-- 考勤异常 -->
						<li class="cur">					
							<img src="../images/index/guide/clock.png" class="guide-clock next-step"/>
						</li>
						<!-- 代办事宜 -->
						<li>
							<img src="../images/index/guide/restwork.png" class="guide-restwork next-step"/>
						</li>
						<!-- 钉邮 -->
						<li>
							<img src="../images/index/guide/email.png" class="guide-email next-step"/>
						</li>
						<!-- it服务 -->
						<li>
							<img src="../images/index/guide/server.png" class="guide-server next-step"/>
						</li>
						<!-- 我的流程 -->
						<li>
							<img src="../images/index/guide/process.png" class="guide-process next-step"/>
						</li>
						<!-- 切换版本 -->
						<li>
							<img src="../images/index/guide/change.png" class="guide-change next-step"/>
						</li>
					</ul>
					<!-- 分页 -->
					<div class="guide-page-no">
						<span class="cur"></span>
						<span></span>
						<span></span>
						<span></span>
						<span></span>
						<span></span>
					</div>
				</div>		
			</div>
	    </div>
    </div>
    <!-- 人力资源提示框开始-->
    <div class="prompt-panel hr-prompt-panel">
		<div class="prompt-mask"></div>
		<div class="prompt-content">
			<span class="prompt-close">×</span>
			<div class="content-padded">      
				<div class="list-block">
					<div class="card-header" style="text-align:center;"><img src="../images/apps/unnameed/developing.png" style="width: 5rem;margin:0.5rem auto 0;"></div>
					<div class="card-content-inner" style="text-align:center;font-size:0.7rem;" >正在努力开发中，敬请期待...</div>
				</div>					
			</div>
		</div>
	</div>
    <!-- 人力资源提示结束 -->
    <!--搜索弹框-->
    <div class="popup popup-search">
        <div class="bar">
            <div class="searchbar">
                <a href="#" class="searchbar-cancel close-popup">取消</a>
                <div class="search-input">
                  <label class="icon icon-search" for="search"></label>
                  <input type="search" id="search" placeholder='应用名称、流程主题、公告标题'/>
                </div>
            </div>
        </div>    
        <div class="content" id="searchUL">
            
            <!--近期搜索-->     
            <div class="record-block" >
                <div class="list-block rencent-block">
                    <div class="item-inner content-block-title" style="font-size:0.75rem">近期搜索{{title}}</div>
                    <ul class="appslist">
                        <li v-for="key in keys">
                            <a href="#" class="apps" v-text="key"></a>
                        </li>
                    </ul>
                </div>
                <div class="list-block search-more-block">
                	<div class="title"><span>在这里可以搜索到</span></div>
                	<div class="list">
                		<span><i class="icon-app"></i>应用</span>
                		<span><i class="icon-process"></i>流程</span>
                		<span><i class="icon-news"></i>新闻公告</span>
                	</div>
                </div>
            </div>
            <!--搜索结果-->
            <div class="result-block dis-none">
                <!-- 功能 -->
                <div class="list-block">
                    <div class="subsidiary-title-container" style="padding: 0rem 0rem;" >
		       			<div class="subsidiary-title-flag">┃</div>
		       			<div class="subsidiary-title" style="color: #888888;">应用</div>
		       		</div>
                    <ul>
                        <li v-for="app in apps">
                            <a href="{{app.url}}" class="aaa openLink-true" >
                                <div class="item-inner">
                                  <div class="item-title" v-text="app.name"></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="graybg"></div>
                <!-- 流程 -->
                <div class="list-block">
                    <div class="subsidiary-title-container" style="padding: 0rem 0rem;" >
		       			<div class="subsidiary-title-flag">┃</div>
		       			<div class="subsidiary-title" style="color: #888888;">流程</div>
		       		</div>
                    <ul>
                        <li v-for="flow in flows">
                            <a href="{{flow.url}}" class="openLink-true">
                                <div class="item-inner">
                                  <div class="item-title" v-text="flow.title"></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="graybg"></div>
                <!-- 资讯 -->
                <div class="list-block">
                    <div class="subsidiary-title-container" style="padding: 0rem 0rem;" >
		       			<div class="subsidiary-title-flag">┃</div>
		       			<div class="subsidiary-title" style="color: #888888;">资讯</div>
		       		</div>
                    <ul>
                        <li v-for="news_ in news">
                            <a href="{{news_.url}}" class="openLink-true">
                                <div class="item-inner">
                                  <div class="item-title" v-text="news_.title"></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <!--无搜索结果则removeClass(dis-none)-->
            <div class="empty-block dis-none">
                <img src="../images/common/empty.png" class="empty-img"/>
                <p>没有搜索到您想要的结果</p>
            </div>
        </div>
    </div>
    <!-- 系统更新的通知 -->
	<div class="prompt-panel sys-prompt-panel" id="sysUpdateNotice">
		<div class="prompt-mask"></div>
		<div class="prompt-content" style="top:2.2rem;">
			<span class="prompt-close">×</span>
			<header class="prompt-header"></header>
			<div class="content-padded"></div>
		</div>
	</div>
    <link rel="stylesheet" href="//at.alicdn.com/t/font_dr3una4blqnf80k9.css?v=<%=doaVersion %>">
	<script src="../js/zepto/zepto.js?v=<%=doaVersion %>"></script>
	<script src="../js/vue/vue.min.js?v=<%=doaVersion %>"></script>
	<script src="../js/common/base.js?v=<%=doaVersion %>"></script>
	<script src="../js/index/index_req.js?v=<%=doaVersion %>"></script>
	<script src="../js/index/index_func.js?v=<%=doaVersion %>"></script>
	<script src="../js/index/index_search.js?v=<%=doaVersion %>"></script>		
	<script type="text/javascript" src="http://g.alicdn.com/dingding/open-develop/0.8.4/dingtalk.js?v=<%=doaVersion %>"></script>
	<script type="text/javascript" src="../js/index/dingTopIndex.js?v=<%=doaVersion %>"></script>
	<script type="text/javascript" src="../js/common/dingBase.js?v=<%=doaVersion %>"></script>
	<script>
		var iconfontJs = document.createElement('script');
		iconfontJs.src="//at.alicdn.com/t/font_1t9xm4x8oofg8pvi.js?v=<%=doaVersion %>";
		document.getElementsByTagName('head')[0].appendChild(iconfontJs);
		
		var s1 = document.createElement('script'); 
		 s1.src = '../js/sm/sm.min.js?v=<%=doaVersion %>'; 
		 document.getElementsByTagName('head')[0].appendChild(s1);
		 
		 var s2 = document.createElement('script'); 
		 s2.src = '../js/sm/sm-extend.min.js?v=<%=doaVersion %>'; 
		 document.getElementsByTagName('head')[0].appendChild(s2);		 
		 // $('.detailContent').on('click','a[data-anchor="icon-shuju"]',function(e){			 
			//  e.preventDefault();
			//  var url = 'http://dss.yujiahui.com/ReportServer?op=fs';
			//  openLink(url);
		 // });
	</script> 
</body>
</html>
