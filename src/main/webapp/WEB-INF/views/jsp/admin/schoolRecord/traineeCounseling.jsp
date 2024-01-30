<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

				    <table id="makeTime">
				        <caption>신상기록부</caption>
					<tbody>
						<tr>
							<th rowspan="5">이미지파일</th>
                        </tr>
                        <tr>
							<th>성명</th>
							<td>${vo11.tr_name}</td>
                        </tr>
                        <tr>
                            <th>주민등록번호</th>
							<td>${vo11.tr_rrn}</td>
						</tr>
                        <tr>
                            <th>주소</th>
                            <td>${vo11.tr_addr}</td>
					    </tr>
                        <tr>
                            <th>전화번호</th>
							<td>${vo11.tr_hp}</td>
                        </tr>
				</tbody>
			</table>
            
            <table id="makeTime">
                <tbody>
                    <tr>
                        <th>교육과정명</th>
                        <td>${cv.c_name}</td>
                        <th>교육기간</th>
                        <td>${cv.start_date}~${cv.end_date}</td>
                        <th>총상담횟수</th>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <table id="makeTime">
                <thead>
                    <tr>
                        <th>상담일</th>
                        <th>구분</th>
                        <th>상담자</th>
                        <th>상담내용</th>
                        <th>조치사항</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <div>
                <button type="button" onclick="">상담등록</button>           
                <button type="button" onclick="">엑셀</button>           
                <button type="button" onclick="">인쇄</button>           
                <button type="button" onclick="javascript:location.href='traineecurrentbt1?c_idx='+c_idx">취소</button>           
            </div>
      