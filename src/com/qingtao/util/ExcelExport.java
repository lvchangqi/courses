package com.qingtao.util;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

@SuppressWarnings("all")
public class ExcelExport {

	/**
	 * 生成excel表
	 * 
	 * @param entityList
	 *            实体类数组
	 * @param file
	 *            excel表
	 * @throws Exception
	 */
	public <T> void excel(List<T> entityList, File file ,HttpSession session) throws Exception {
		String path = session.getServletContext().getRealPath("/") + "/WEB-INF/file/template/";
		InputStream in = new FileInputStream(new File(path+"Template.xls"));
		HSSFWorkbook workbook = new HSSFWorkbook(in);
		HSSFSheet sheet = workbook.getSheet("Sheet1");
		
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平居中
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直居中
		// 设置边框(细边框)
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		//style.setLocked(true);

		List<String> list = null;
		int active = sheet.getRow(0).getLastCellNum();

		for (int i = 1; i <= entityList.size(); i++) {
			HSSFRow row = sheet.createRow(i);
			list = this.reflect(entityList.get(i - 1));
			for (int j = 0; j < active; j++) {
				HSSFCell cell = row.createCell(j);
				cell.setCellStyle(style);
				cell.setCellValue(list.get(j));
			}
		}
		OutputStream out = new FileOutputStream(file);
		workbook.write(out);

		in.close();
		out.close();
		workbook.close();
	}

	/**
	 * 反射读取实体类的属性值
	 * 
	 * @param t
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws IntrospectionException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 */
	private <T> List<String> reflect(T t) throws InstantiationException, IllegalAccessException, IntrospectionException,
			IllegalArgumentException, InvocationTargetException {
		Class entity = t.getClass();
		Field[] fileds = entity.getDeclaredFields();
		List<String> list = new ArrayList<>();
		for (Field f : fileds) {
			PropertyDescriptor pd = new PropertyDescriptor(f.getName(), entity);
			Method get = pd.getReadMethod();
			Object v = get.invoke(t, new Object[] {});
			String value = String.valueOf(v);
			list.add(value);
		}

		return list;
	}
}
