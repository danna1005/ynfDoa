/*
SMIS接口链接在下面维护

调用链接的时候，直接如下使用
makeSMISUrl(SMIS_URL_RES);

*/

//SMIS系统
function getSMISDomin()
{
	console.log(window.location.href);
	if(window.location.href.indexOf("://oa.yujiahui.com") > 0)
	{
		return "http://smis.yujiahui.com/";
	}
	else{
		return "http://10.2.1.163:8080/";
	}
}

//HR部分的链接
function makeSMISUrl(res)
{
	return getSMISDomin()+""+res;
}


/*
 * 
 */
var SMIS_URL_INVOICE_GET_LIST =  "sales/mobileOAApi";




