package com.ict.project.util;

import java.io.File;

public class FileRenameUtil {
	public static String checkSameFileName(String filename,String path) {
		String fname= null;

		int period = filename.lastIndexOf(".");// test12.txt -> 6;
		fname = filename.substring(0, period);
		
		String suffix = filename.substring(period);
		
		String saveFilePath = path+System.getProperty("file.separator")+filename;
		File f = new File(saveFilePath);
		int idx=1;
		while(f!= null && f.exists()){
			StringBuffer sb = new StringBuffer();
			sb.append(fname);
			sb.append(idx++);
			sb.append(suffix);
			filename = sb.toString();
			
			saveFilePath = path+System.getProperty("file.separator")+filename;
			f = new File(saveFilePath);
		}
		return filename;
	}
}
