package com.ict.project.util;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.ict.project.vo.CourseVO;
import com.ict.project.vo.TimeVO;

import jakarta.servlet.ServletContext;

public class ExelFileReader {
    // 액셀을 받아 정보를 띄어주는 ..
    public static List<TimeVO> exel(CourseVO cvo, ServletContext application) {
        List<TimeVO> list = new ArrayList<TimeVO>();
        String realPath = application.getRealPath("time_Exel");
        // 액셀에서 전체 리스트를 받아서 list에 추가해주기
        try {
            File f = new File(realPath, cvo.getC_timeExel());
            FileInputStream fis = new FileInputStream(f.getAbsolutePath());
            IOUtils.setByteArrayMaxOverride(Integer.MAX_VALUE);
            XSSFWorkbook workbook = new XSSFWorkbook(fis);
            XSSFSheet sheet = workbook.getSheetAt(0);

            Iterator<Row> it = sheet.iterator();

            while (it.hasNext()) {
                Row row = it.next();
                // 첫번째 행은 머릿글이므로 제외
                if (row.getRowNum() == 0)
                    continue;
                // cell들을 한번에 반복자로 얻어낸다.
                Iterator<Cell> it2 = row.cellIterator();
                TimeVO vo = new TimeVO();
                int i = 0;
                while (it2.hasNext()) {
                    // 하나의 cell을 얻어낸다
                    Cell cell = it2.next();
                    String val = null;
                    // System.out.println("cell.getCellType():"+cell.getCellType());
                    switch (cell.getCellType()) {
                        case NUMERIC:
                            val = String.valueOf(cell.getNumericCellValue());
                            break;
                        case STRING:
                            val = cell.getStringCellValue();
                            break;
                        case BLANK:
                            val = null;
                        default:
                            val = null;
                            break;
                    }// switch문의 끝
                     // 훈련일자.,훈련시작시간,훈련종료시간,시작시간,시간구분,방학여부,훈련강사코드,교육장소코드,교과목능력단위코드
                     // private String training_date, training_starttime, training_endtime,
                     // start_time, end_time, r_name, s_name;

                    switch (i) {
                        case 0:
                            vo.setTraining_date(val);
                            break;
                        case 1:
                            vo.setTraining_starttime(val);
                            break;
                        case 2:
                            vo.setTraining_endtime(val);
                            break;
                        case 3:
                            vo.setStatus(val);
                            break;
                        case 4:
                            vo.setStart_time(val);
                            break;
                        case 5:
                            vo.setTime_split(val);
                            break;
                        case 6:
                            vo.setR_name(val);
                            break;
                        case 7:
                            vo.setS_name(val);
                            break;
                        default:
                            break;
                    }
                    i++;
                } // 열반복의 끝
                boolean b = false;

                if (vo.getTraining_date() != null && isNumberic(vo.getTraining_date()))
                    list.add(vo); // 리스트에 저장

            }

            fis.close();
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 숫자인지 확인하는 함수
    public static boolean isNumberic(String str) {
        return str.chars().allMatch(Character::isDigit);
    }
}
