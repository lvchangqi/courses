package com.qingtao.util;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

@SuppressWarnings("all")
public class ExcelExport {

	public static void export() {
		// 创建Excel文件
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 创建sheet
		HSSFSheet sheet = workbook.createSheet("工作簿1");
		// 设置默认列宽
		sheet.setDefaultColumnWidth(15);
		// 创建字体
		HSSFFont font = workbook.createFont();
		font.setFontName("Verdana"); // 设置字体
		font.setFontHeight((short) 400);// 字体大小
		font.setColor(HSSFColor.BLACK.index);// 黑色

		// 创建样式
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平居中
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直居中
		// 设置边框(细边框)
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		//注入字体
		style.setFont(font);
		
		//创建行
		HSSFRow row = sheet.createRow(0);
		row.setHeight((short) 500);
		//创建单元格
		row.createCell(0);
		
		
	}
}
