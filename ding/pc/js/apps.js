
/**
 * _config comes from server-side template. see views/index.jade
 */
DingTalkPC.config({
    appId: _appId,
    corpId: _config.corpId,
    timeStamp: _config.timeStamp,
    nonceStr: _config.nonceStr,
    signature: _config.signature,
    jsApiList: [
        'device.notification.confirm',
        'device.notification.alert',
        'device.notification.prompt',
		'runtime.permission.requestAuthCode',
		'biz.util.openLink'
	]
});

DingTalkPC.ready(function(res) {
    logger.i('dd.ready rocks!');

    DingTalkPC.runtime.permission.requestAuthCode({
        corpId: _config.corpId,
        onSuccess: function (info) {
            logger.i('authcode: ' + info.code);
			_scode=info.code;
            $.ajax({
                url: _ctx+'/third/ding/jsapi.do?method=userinfo&from=dingpc&code=' + info.code,
                type: 'GET',
                success: function (data, status, xhr) {
                    var info = JSON.parse(data);
					if (info.errcode === 0) {
                        logger.i('user id: ' + info.userid);
 						dingOpen();
						//history.back();
                   }
                    else {
                        logger.e('auth error: ' + data);
						//history.back();
                    }
                },
                error: function (xhr, errorType, error) {
                    logger.e(errorType + ', ' + error);
                }
            });
        },
        onFail: function (err) {
            logger.e('fail: ' + JSON.stringify(err));
        }

    });
});

DingTalkPC.error(function(err) {
   logger.e('dd error: ' + JSON.stringify(err));
});
