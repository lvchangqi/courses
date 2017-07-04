package com.qingtao.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * 本类对Jmail实现调用封装
 * 可内嵌html标签
 * @Filed subject jmail 标题
 * @Filed content jmail 内容
 * @Filed toAddress jmail 发送对象
 * @author 吕长奇
 *
 */

public class Mail implements Runnable{
	private String subject;
	private String content;
	private String toAddress;

	public void setToAddress(String toAddress) {
		this.toAddress = toAddress;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Mail() {
		super();
	}

	public Mail(String subject, String content, String toAddress) {
		super();
		this.subject = subject;
		this.content = content;
		this.toAddress = toAddress;
	}

	public void sendMail() throws Exception {
		Properties pro = new Properties();
		//协议服务商
		pro.setProperty("mail.smtp", "smtp.sina.com.cn");
		//邮件协议
		pro.setProperty("mail.transport.protocol", "smtp");
		//用户验证
		pro.setProperty("mail.smtp.auth", "true");
		//创建session
		Session session = Session.getInstance(pro);
		session.setDebug(true);
		//得到transport对象
		Transport transport = session.getTransport();
		//连接服务商
		transport.connect("smtp.qq.com","account", "password");
		//创建邮件
		Message message = createMail(session);
		//发送邮件
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}
	
	/**
	 * 类内部调用
	 * @param session
	 * @return
	 * @throws Exception
	 */
	private synchronized MimeMessage createMail(Session session) throws Exception{
		//邮件对象
		MimeMessage mime = new MimeMessage(session);
		//发件人
		mime.setFrom(new InternetAddress("account"));
		//收件人
		mime.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
		//标题
		mime.setSubject(subject);
		//内容
		mime.setContent(content, "text/html;charset=UTF-8");
		return mime;
	}

	@Override
	public void run() {
		try {
			this.sendMail();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
