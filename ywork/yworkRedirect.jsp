<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp"%>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>欢迎来到悦工作</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/third/ywork/css/main.css?v=20160422" />
    <script>Com_IncludeFile("jquery.js");</script>
	<script type="text/javascript" src="${KMSS_Parameter_ContextPath}third/ywork/js/ywork.js?v=20160422"></script>
</head>

<body>
    <div id="succ-div" class="con-box" style="display: none;">
        <img src="<%=request.getContextPath()%>/third/ywork/images/welcome-happly.png" alt="悦工作欢迎页面">
        <button class="come-btn">进入悦工作</button>
    </div>
    <div id="fail-div" style="display: none;">
        <div class="con-fail">
            <img src="<%=request.getContextPath()%>/third/ywork/images/welcome-fail.png" alt="悦工作错误页面" />
            <p>请先暂时关闭浏览器的拦截弹框功能!</p>
            <button class="come-btn">进入悦工作</button>
        </div>
        <div class="text-con">
            <p>温馨提示: 如果在点击 "悦工作" 时,没有开启一个新窗口,请点击浏览器的右上角进行弹窗设置。</p>
            <ul>
                <li><span>谷歌浏览器</span>: 点击 "设置"->"隐私设置" 中的内容设置,在弹窗式窗口设置中,管理例外情况,将主机名哪里的禁止,设置为 允许。</li>
                <li><span>火狐浏览器</span>: 点击右上角弹窗的 "选项", 设置为允许该网址弹窗窗口</li>
                <li><span>IE浏览器</span>: 点击底部弹窗的提示，点击总是允许。或者点击右上角的"Internet选项"->"安全"->"受信任的站点",点击站点，将该站点网址添加进去。</li>
            </ul>
        </div>
    </div>
</body>
</html>
