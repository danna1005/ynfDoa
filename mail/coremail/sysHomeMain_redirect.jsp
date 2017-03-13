<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.util.UserUtil"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page
	import="com.landray.kmss.third.mail.coremail.LoginCoreMailAction"%>
<%
	String dnses = ResourceUtil.getKmssConfigString("kmss.appsvr.dns");
	String xphone = request.getParameter("xphone");
	if (StringUtil.isNotNull(dnses)) {
		String[] dnsInfos = dnses.split(";");
		if (dnsInfos.length > 0) {
			for (int i = 0; i < dnsInfos.length; i++) {
				String appUrlPrefix = ResourceUtil
						.getKmssConfigString("kmss.appsvr."
								+ dnsInfos[i].trim() + ".urlPrefix");
				if (appUrlPrefix.equals("http://"
						+ request.getServerName())) {
					response.sendRedirect(appUrlPrefix
									+ "/third/mail/coremail/loginCoreMail.do?method=login&xphone="+xphone+"&mailtype=" + i + "");
				}
			}
		}
	} else {
		//String appDns = ResourceUtil
		//		.getKmssConfigString("kmss.urlPrefix");
		response
				.sendRedirect(request.getContextPath()
						+ "/third/mail/coremail/loginCoreMail.do?method=login&xphone="+xphone);
	}
%>
