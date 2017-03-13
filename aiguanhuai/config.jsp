<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp"%>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>爱关怀集成</title>
    <link rel="shortcut icon" href="//mp.51guanhuai.com/favicon.ico" type="image/x-icon">
    <style>
    body {
        font-family: "Helvetica Neue", Helvetica, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif;
        font-size: 14px;
        line-height: 1.42857143;
        color: #333;
        background-color: #fff;
    }
    
    button,
    input,
    select,
    textarea {
        font-family: inherit;
        font-size: inherit;
        line-height: inherit;
    }
    
    .table {
        width: 100%;
        max-width: 100%;
        /*font: 14px Microsoft YaHei;*/
    }
    
    table {
        background-color: transparent;
        border-spacing: 0;
        border-collapse: collapse;
    }
    
    .agh-integration {
        min-width: 786px;
        max-width: 958px;
        border: 1px solid #ddd;
        padding: 45px 50px;
    }
    
    .main tbody tr td {
        vertical-align: top;
        font-size: 12px;
    }
    
    .t-left {
        margin-bottom: 24px;
    }
    
    .t-left thead th {
        text-align: left;
        font-size: 16px;
        padding-bottom: 15px;
    }
    
    .t-left tbody tr td {
        padding-bottom: 15px;
        vertical-align: middle;
    }
    
    .t-left {
        max-width: 473px;
    }
    
    .t-left .form-lbl {
        width: 84px;
    }
    
    .t-left .input-wrap {
        width: 325px;
    }
    
    .t-left .form-ipt {
        width: 100%;
        line-height: 2.5;
        border: 1px solid #aaa;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .2);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, .2);
        padding-left:3px;
    }
    
    .t-left .ipt-r {
        padding-left: 12px;
        font-size: 19px;
        color: #c9140b;
    }
    .t-left .ua{
        color: #473fae;
        display:block;
        margin:20px 0;
        min-height: 20px;
        font-weight: 400;
        cursor: pointer;
    }
    .t-left .ua a{
        color: #473fae;
        /*text-decoration: none;*/
    }
    .t-left .btn-wrap{
        
    }
    .t-left .btn-wrap input{
        background: #cd0102;
        font-size: 14px;
        border-radius: 5px;
        padding:0 24px;
        line-height: 3;
        border:0;
        border-bottom:1px solid #840704;
        color: #fff;
        cursor:pointer;
    }
    </style>
    <script>
    	Com_IncludeFile("jquery.js");
	</script>
    
</head>

<body>
    <div class="agh-integration">
        <table class="table main">
            <tbody>
                <tr>
                    <td>
                        <form action="submit.php" method="POST">
                            <table class="table t-left">
                                <thead>
                                    <tr>
                                        <th colspan="3">企业身份登陆 :</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="form-lbl">企业标识 :</td>
                                        <td class="input-wrap">
                                            <input type="text" class="form-ipt" name="corp_id" id="uniqueFlag" value="${uniqueFlag}" placeholder="由爱关怀提供，用于识别您的身份" required>
                                        </td>
                                        <td class="ipt-r">*</td>
                                    </tr>
                                    <tr>
                                        <td class="form-lbl">企业秘钥 :</td>
                                        <td class="input-wrap">
                                            <input type="text" class="form-ipt" name="corp_key" id="hmacKey" value="${hmacKey }" placeholder="不用在意那串复杂的字符，复制粘贴就好了" required>
                                        </td>
                                        <td class="ipt-r">*</td>
                                    </tr>
                                </tbody>
                            </table>
                            <table class="table t-left">
                                <thead>
                                    <tr>
                                        <th colspan="3">待办消息设置 :</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="form-lbl">待办名称 :</td>
                                        <td class="input-wrap">
                                            <input type="text" id="userName"  class="form-ipt" name="backlog_name" value="${userName}" placeholder="用于显示待办来源，比如来自&quot;爱关怀&quot;的待办消息" required>
                                        </td>
                                        <td class="ipt-r">*</td>
                                    </tr>
                                    <tr>
                                        <td class="form-lbl">待办密码 :</td>
                                        <td class="input-wrap">
                                            <input type="text" id="password" class="form-ipt" name="backlog_PWD" value="" placeholder="格式不限，当然要输入你喜欢的" <c:if test="${password=='' }">required</c:if> >
                                        </td>
                                        <td class="ipt-r"><c:if test="${password=='' }">*</c:if></td>
                                    </tr>
                                    <c:if test='${password != ""}'>
                                    <tr><td></td><td colspan="2">如果"待办密码"保留为空，则使用原有密码；否则会修改原密码</td></tr>
                                    </c:if>
                                    <tr>
                                        <td class="form-lbl">登 录 ID :</td>
                                        <td class="input-wrap">
                                            <input type="text" class="form-ipt" name="corp_ID" value="aiguanhuai" disabled>
                                        </td>
                                        <td class="ipt-r"></td>
                                    </tr>
                                    <tr>
                                        <td class="input-wrap" colspan="2">
                                            <input type="checkbox" name="aiguanhuaiEnable" id="aiguanhuaiEnable"  <c:if test="${aiguanhuaiEnable=='true'}">checked</c:if> >启用ekp到爱关怀的组织架构推送
                                        </td>
                                        <td class="ipt-r"></td>
                                    </tr>
                                    <tr>
                                        <td class="form-lbl"> </td>
                                        <td class="input-wrap" colspan="2">
                                            <label class="ua">
                                                <input type="checkbox" name="user_agreement" id="ua_c" onclick="isaccepted()" checked>
                                                同意爱关怀<a href="http://www.51guanhuai.com" target="_blank">使用协议</a>
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="form-lbl"> </td>
                                        <td class="btn-wrap" colspan="2">
                                            <input type="button" id="agh-itg-submit" value="同步，让爱关怀为您服务" onclick="saveProPerties();">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </td>
                    <td><img src="images/agh-prompt.jpg"></td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
        function isaccepted(){  
            if(document.getElementById("ua_c").checked==true){  
                document.getElementById("agh-itg-submit").disabled = false;  
            }else{  
                document.getElementById("agh-itg-submit").disabled = true;  
            }  
        }  

        function saveProPerties(){
            var userName=$("#userName").val();
            var password=$("#password").val();
            var uniqueFlag=$("#uniqueFlag").val();
            var hmacKey=$("#hmacKey").val();
            var aiguanhuaiEnable = "false";
            var checkbox = document.getElementById("aiguanhuaiEnable");//
			//alert(checkbox.checked);
			if(checkbox.checked) {
				aiguanhuaiEnable = "true";
			}else{
				aiguanhuaiEnable="false";
			}
            var url = '<c:url value="/third/aiguanhuai/config.do?method=saveProPerties"/>'+'&userName='+userName+'&password='+password+'&uniqueFlag='+uniqueFlag+'&hmacKey='+hmacKey+'&aiguanhuaiEnable='+aiguanhuaiEnable;
            $.ajax(
        	{
        		url : url,
        		dataType : 'json',
        		data : '',
        		//jsonp : 'callback',
        		success : function(data) {
        			var result = data.isSuccess;
        			if(result=="true"){
            			alert("保存成功");
        			}else{
        				alert("保存失败");
        			}
        		},
        		error: function(XMLHttpRequest, textStatus, errorThrown){
        			alert(textStatus);
        	    }
        	});
        }
    </script>   

</body>

</html> 