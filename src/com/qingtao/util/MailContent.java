package com.qingtao.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MailContent {
	
	/**
	 * 找回密码验证内容
	 * @param random
	 * @return
	 */
	public static String getContent(String random){
		StringBuffer sb = new StringBuffer();
		sb.append("<strong>亲爱的用户:</strong><br>");
		sb.append("您好！感谢您使用本系统，您正在进行找回密码的邮箱验证，本次请求的验证码为：<br>");
		sb.append("<span style='color:#FF9900'>" + random + "</span>");
		sb.append("<span style='color:#979797'>"
				+ "(为了保障您帐号的安全性，请在30分钟内完成验证。30分钟之后验证码失效。)" + "</span>");
		sb.append("<br><br><br><br>");
		sb.append("AndiOS工作室-吕长奇<br>");
		sb.append(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		
		return sb.toString();
	}
}
