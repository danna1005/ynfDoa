(function() {
    $(function() {
        // var message = '欢迎进入悦工作',
        //     $logo = $('#logo-icon'),
        //     $tipMsg = $('#_tipmsg'),
        //     $tipsBox = $('.tips-box');
        
        var $succDiv = $('#succ-div'),
            $failDiv = $('#fail-div');

        var doRequire = function(url) {
            var $btn = $('.come-btn'),
                flag = window.open(url, '', '');

            if (flag) {
                $succDiv.show();
                $btn.remove();
            } else {
                $failDiv.show();

                $btn.one('click', function() {
                    window.open(url);
                    
                    $failDiv.hide();

                    $succDiv.show();

                    $btn.remove();               
                    
                });

            }
        };

        var getRequireData = function() {
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: Com_Parameter.ContextPath + "third/ywork/yworkSso.do?method=postBaseInfor2YWork",
                // beforeSend: function() {
                //     $tipMsg.html("正在进入悦工作，请稍等...");
                // },
                success: function(resultJson) {
                    var retJson = eval("(" + resultJson + ")");
                    var codeValue = retJson.code;
                    if (codeValue == 'success') {
                        url = retJson.data.url;
                        doRequire(url);
                    } else {
                        var msg = '系统繁忙，请稍后再试';
                        if (retJson.data && typeof retJson.data != 'undefined') {
                            msg = retJson.data;
                        }

                        alert(msg);

                        console.error(retJson.data);
                    }
                },
                complete: function() {},
                error: function(data) {}
            });
        };

        getRequireData();
    });
})();
