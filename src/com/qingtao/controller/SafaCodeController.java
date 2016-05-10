package com.qingtao.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 验证码Controller
 * 
 */
@Controller
@RequestMapping("/safecode")
public class SafaCodeController {
	/**
	 * 将safecode的字符串放入session
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/create_sc", method = RequestMethod.GET)
	public void validSafeCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 设置响应头 Content-type类型
		response.setContentType("image/jpeg");
		// 以下三句是用于设置页面不缓存
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.setDateHeader("Expires", 0);

		OutputStream os = response.getOutputStream();
		int width = 60, height = 20;
		// 建立指定宽、高和BufferedImage对象
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

		Graphics g = image.getGraphics(); // 该画笔画在image上
		Color c = g.getColor(); // 保存当前画笔的颜色，用完画笔后要回复现场
		g.fillRect(0, 0, width, height);
		// 设定字体
		g.setFont(new Font("Times New Roman", Font.PLAIN, 18));

		char[] ch = "abcdefghjkmnpqrstuvwxyz23456789".toCharArray(); // 随即产生的字符串
		int length = ch.length; // 随即字符串的长度
		String sRand = ""; // 保存随即产生的字符串
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			String rand = new Character(ch[random.nextInt(length)]).toString();
			sRand += rand;
			// 将认证码显示到图象中
			g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
			// 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
			g.drawString(rand, 13 * i + 6, 16);
		}
		g.setColor(c); // 将画笔的颜色再设置回去
		g.dispose();

		// 将验证码记录到session
		request.getSession().setAttribute("safecode", sRand);
		// 输出图像到页面
		ImageIO.write(image, "JPEG", os);
	}

	/**
	 * Ajax判断用户输入的验证码是否有效
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/check_sc", method = RequestMethod.POST)
	public void safeCodeCheck(HttpServletRequest request, HttpServletResponse response) {
		// 指定输出内容类型和编码
		response.setContentType("text/html;charset=utf-8");
		// 获取到用户通过ajax传过来的验证码
		String safecode = request.getParameter("safecode").toLowerCase();
		try {
			PrintWriter out = response.getWriter(); // 获取输出流
			boolean isValid = false; // 验证码是否有效标识
			if (request.getSession().getAttribute("safecode").equals(safecode)) {
				isValid = true;
			}
			out.print(isValid);// 返回结果
			out.flush();
			out.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
