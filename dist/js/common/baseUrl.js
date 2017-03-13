/*
	用于处理各个接口的链接
*/

/*常量设置*/
//HR系统
function getHRDomin()
{
	if(window.location.href.indexOf("://oa.yujiahui.com") > 0)
	{
		return "http://hr.yujiahui.com";
	}
	else{
		return "http://testhr.yujiahui.com"
	}
}

//HR部分的链接
function makeHRUrl(res)
{
	return getHRDomin()+""+res;
}