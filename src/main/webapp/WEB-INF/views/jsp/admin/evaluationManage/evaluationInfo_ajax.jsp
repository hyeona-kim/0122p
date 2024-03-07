<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="7%"/>
        <col width="3%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="10%"/>
        <col width="7%"/>
        <col width="8%"/>
        <col width="30%"/>
    </colgroup>
    <thead>
        <tr>
            <th rowspan="2">평가</th>
            <th rowspan="2">능력단위명</th>
            <th rowspan="2">훈련교사</th>
            <th rowspan="2">평가일시</th>
            <th rowspan="2">평가시간</th>
            <th rowspan="2">총배점</th>
            <th rowspan="2">평가유형</th>
            <th rowspan="2">수준</th>
            <th rowspan="2">문항수</th>
            <th rowspan="2">능력단위요소</th>
            <th rowspan="2">출제여부</th>
            <th rowspan="2">채점여부</th>
            <th rowspan="2">비고</th>
        </tr>
    </thead>

	<tbody>	
        <c:if test="${esvo eq null}">
            <td colspan="13">
                등록된 평가가 존재하지않습니다.
            </td>
        </c:if>
        <c:if test="${esvo ne null}">
                <tr>
                    <td>${esvo.es_name}</td>
                    <td>능력단위명</td>
                    <td>${esvo.sf_idx}</td>
                    <td>${esvo.es_date}</td>  
                    <td>${esvo.es_time}</td>  
                    <td>${esvo.es_totalScore}</td>  
                    <td>${esvo.es_type}</td>  
                    <td>${esvo.es_level}</td>  
                    <td>${esvo.es_num_question}</td>  
                    <td>${esvo.sk_idx}</td>  
                    <td>${esvo.es_examStatus}</td>  
                    <td>${esvo.es_gradingStatus}</td>  
                    <td>
                        <button type="button" class="btn green" onclick="editEI('${esvo.es_idx}')">수정</button>
                        <input type="button" value="삭제" onclick="delEs('${esvo.es_idx}')" class="btn red" id="delEs_btn">
                        <button type="button" class="btn blue" onclick="checkExam2('${esvo.es_idx}')">응시확인</button>
                    </td>

                </tr>
           
        </c:if>
	</tbody>
</table>