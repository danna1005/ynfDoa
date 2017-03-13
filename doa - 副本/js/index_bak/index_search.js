$(document).ready(function() {
    var key = "";
    //搜索结果返回SUE绑定
    var searchVue = new Vue({
        el:"#searchUL",
        data:{
            apps:"",
            flows:"",
            news:"",
            keys:""
        }
    });
    //加载搜索历史的数据
    if (window.localStorage.searchKeys) {
        searchVue.keys = JSON.parse(window.localStorage.searchKeys);
    }
    //测试代码
    //输入框文字变化事件
    $(".search-input").bind("input propertychange", function() {
        searchEvent();
    });
    // 点搜索，搜索弹框
    $(".search-panel .searchPart").tap(function() {
        //近期搜索无数据则不显示
        var rencentLen = $(".rencent-block").find(".appslist").find("li").length;
        if (rencentLen < 1) {
            $(".rencent-block").addClass("dis-none");
        } else {
            $(".rencent-block").removeClass("dis-none");
        }
        $("body").css("overflow", "hidden");
        $.popup(".popup-search");
    });
    $(".popup-search").on("click", ".close-popup", function() {
        $("body").css("overflow", "auto");
    });
    // 弹出搜索框后,弹出事件,让input获取焦点
    $(document).on("opened", ".popup-search", function() {
        $("#search").val("");
        setTimeout(function() {
            $("#search").trigger("click").focus();
        }, 1e3);
    });
    //如果搜索结果被点击了，那么就把当前搜索关键字加到本地历史
    $(".result-block").on("click", "a", function(e) {
        var keysCnt = 3;
        // 如果本地存储已经存在
        if (window.localStorage.searchKeys) {
            var arr = JSON.parse(window.localStorage.searchKeys);
            if (arr.length >= keysCnt && !inArray(key, arr)) {
                //关键字大于N个而且关键字不在当前关键字里面
                arr.pop();
                arr.unshift(key);
            } else if (arr.length >= keysCnt && inArray(key, arr)) {
                //关键字大于N个而且关键字在当前关键字里面
                arr = toTop(arr, key);
            } else if (arr.length < keysCnt && !inArray(key, arr)) {
                //关键字小于N个而且关键字不在当前关键字里面
                arr.unshift(key);
            } else if (arr.length < keysCnt && inArray(key, arr)) {
                //关键字小于N个而且关键字在当前关键字里面
                arr = toTop(arr, key);
            }
            searchVue.keys = arr;
            window.localStorage.searchKeys = JSON.stringify(arr);
        } else {
            var arr = new Array();
            arr.unshift(key);
            window.localStorage.searchKeys = JSON.stringify(arr);
            searchVue.keys = arr;
        }
        $("#search").val("");
    });
    //点击近期搜索里面的关键字
    $(".appslist").on("click", "a", function(e) {
        var curKey = $(this).html();
        $("#search").val(curKey);
        searchEvent();
    });
    //搜索事件
    function searchEvent() {
        var keyWords = $.trim($("#search").val());
        if (keyWords == "") {
            //为空显示近期搜索  
            $(".record-block").removeClass("dis-none");
            $(".result-block").addClass("dis-none");
        } else if (keyWords != key) 
        {
            $(".record-block").addClass("dis-none");
            key = keyWords;
            searchData(key);
            //showSearchContentBlock();
            logJsonText("正在搜索" + key);
        }
    }
    //搜索数据
    function searchData(key) {
        var url = makeUrl("third/doa/doa_home_search/homeSearch.do?method=search&key=" + key);
        commonGet(url, null, function(r) {
            if (noError(r)) {
                searchVue.apps = r.data.apps;
                searchVue.news = r.data.news;
                searchVue.flows = r.data.procedures;
                logJsonText(searchVue.news);
                //APP的URL
                improveUrl(searchVue.apps);
                improveUrl(searchVue.news);
                improveUrl(searchVue.flows);
                //有搜索结果
                if (searchVue.apps.length + searchVue.news.length + searchVue.flows.length > 0) 
                {
                    showSearchContentBlock();
                } 
                else 
                {
                    hideSearchContentBlock();
                }
            } else {
                logJsonText(r);
            }
        }, false);
    }
    //有搜索结果的处理
    function showSearchContentBlock() {
        $(".result-block").removeClass("dis-none");
        $(".empty-block").addClass("dis-none");
    }
    //无搜索结果的处理
    function hideSearchContentBlock() {
        $(".result-block").addClass("dis-none");
        $(".empty-block").removeClass("dis-none");
    }
    //完善URL
    function improveUrl(list) {
        if (list.length > 0) {
            for (var i = 0; i < list.length; i++) {
                if (list[i].url && (!list[i].isDingDingApp || list[i].isDingDingApp == false)) {
                    list[i].url = makeUrl(list[i].url);
                }
            }
        }
    }
    //ele 是否在数组
    function inArray(ele, arr) {
        var inArr = false;
        for (var i = 0; i < arr.length; i++) {
            if (ele == arr[i]) {
                inArr = true;
                break;
            }
        }
        return inArr;
    }
    // 将key在arr里面置顶
    function toTop(arr, key) {
        var arrNew = new Array();
        arrNew.push(key);
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] != key) {
                arrNew.push(arr[i]);
            }
        }
        return arrNew;
    }
    var agent = navigator.userAgent.toLowerCase();
});