<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误提示信息</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<style type="text/css">
    .errror-box {
        width: 300px;
        height: 100px;
        position: absolute;
        left: 0;
        top: -15%;
        bottom: 0;
        right: 0;
        margin: auto;
        text-align: center;
        vertical-align: middle;
    }

    img {
        vertical-align: middle;
    }

    p {
        font-size: 18px;
        color: #222;
        line-height: 20px;
        text-align: center;
        display: inline-block;
        vertical-align: middle;
    }
</style>

<body>
    <div class="errror-box">
        <img src="<%=request.getContextPath()%>/third/ywork/images/welcome-fail.png" />
        <p id="msg">${info==null? "非常抱歉!请联系管理员" : info}</p>
    </div>
</body>
</html>