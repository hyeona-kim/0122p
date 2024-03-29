<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <form action="s_Traineewrite_ajax" method="post" name="qqq">
    <div id="print">

                <table id="makeTime" class="table">
                    <caption>신상기록부</caption>
                    <colgroup>
                        <col width="20%"/>
                        <col width="10%"/>
                        <col width="30%"/>
                        <col width="10%"/>
                        <col width="30%"/>
                    </colgroup>
					<tbody>
						<tr>
							<!-- <td rowspan="5" id="img"><img alt="logo" 
                                src="${pageContext.request.contextPath }/upload_file/${vo12.file_name}" width="200" height="200"></td> -->
                                <!-- <td rowspan="5" id="img" width="200px" height="200px" style="background-image: url(../upload_file/${vo12.file_name}); 
                                object-fit: cover;"></td> -->
                                 <td rowspan="5" id="img" width="200px" height="300px" >
                                    <div style="border:1px solid #ababab; width: 180px; height: 200px; margin: auto;">
                                        <c:if test="${vo12.file_name ne null}">
                                            <img src="${pageContext.request.contextPath }/upload_file/${vo12.file_name}" alt="" style="display: inline-block; width: 180px; height: 200px;" />
                                        </c:if>
                                    </div>
                                    <!-- <div><img alt="logo" src="${pageContext.request.contextPath }/upload_file/${vo12.file_name}" width="200" height="200"></div>  -->
                                </td> 
                                <!-- <div>
                                    <td rowspan="5" id="img" width="200px" height="200px" 
                                    style="border:1px solid red; background-image: url(../upload_file/${vo12.file_name}); object-fit: cover;"></td>
                                </div> -->
                        </tr>
                        <tr>    
							<th>성명</th>
							<td>${vo12.tr_name}</td>
							<th>교육과정</th>
							<td>${cc.c_name}</td>
                        </tr>
                        <tr>
                            <th>교육타입</th>
							<td>${ctvo.ct_name}</td>
                            <th>교육기간</th>
							<td>${cc.start_date}~${cc.end_date}</td>
						</tr>
                        <tr>
                            <th>주민등록번호</th>
							<td>${vo12.tr_rrn}</td>
                            <th>주소</th>
							<td>${vo12.tr_addr}</td>
					    </tr>
                        <tr>
                            <th>본인휴대폰</th>
							<td>${vo12.tr_hp}</td>
                            <th>집전화</th>
							<td>${vo12.tr_phone}</td>
                        </tr>
				</tbody>
			</table>
            <table id="makeTime" class="table">
                    <tbody>
                        <tr>
                            <th rowspan="4">사업장</th>
                        </tr>
                        <tr>
                            <th>업체명</th>
							<td><input type="text" class="text" value="${bvo.bs_name}" name="bs_name"></td>
                            <th>직종</th>
							<td><input type="text" class="text" value="${bvo.bs_job}" name="bs_job"></td>
                            <th>대표자</th>
							<td><input type="text" class="text" value="${bvo.bs_re}" name="bs_re"></td>
                        </tr>
                        <tr>
                            <th>근무부서</th>
							<td><input type="text" class="text" value="${bvo.bs_workdpt}" name="bs_workdpt"></td>
                            <th>직위</th>
							<td><input type="text" class="text"  value="${bvo.bs_position}" name="bs_position"></td>
                            <th>전화번호</th>
							<td><input type="text" class="text" value="${bvo.bs_phone}" name="bs_phone"></td>
                        </tr>
                        <tr>
                            <th>소재지</th>
							<td colspan="5"><input type="text" class="text" value="${bvo.bs_location}" name="bs_location"></td>
                        </tr>
                    </tbody>
            </table>
            <table id="makeTime" class="table">
                <tbody>
                    <tr>
                        <th colspan="2">훈련신청사유</th>
                        <td colspan="4"><input type="text" class="text" value="${vo12.tr_memo}" name="tr_memo"></td>
                    </tr>
                </tbody>
            </table>
            <table id="makeTime" class="table">
                    <tr>
                        <th rowspan="2">최종학력</th>
                        <th>학교명</th>
                        <th>졸업년도</th>
                        <th>전공</th>
                    </tr>
                    <tr>
                        
                        <td><input type="text" class="text" value="${tfvo.tf_name}" name="tf_name"></td>
                        <td><input type="text" class="text"  value="${tfvo.tf_year}" name="tf_year"></td>
                        <td><input type="text" class="text" value="${tfvo.tf_major}" name="tf_major"></td>
                    </tr>
                    
            </table>
            <table id="makeTime" class="table">
                <thead>
                   <tr>
                        <th colspan="3">면허 및 자격사항</th>
                        <th colspan="4">근 무 경 력</th>
                   </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>자격명</th>
                        <th>취득일(필수항목)</th>
                        <th>발행처</th>
                        <th>회사명</th>
                        <th>근무기간</th>
                        <th>담당업무</th>
                        <th>직급</th>
                    </tr>
                <c:forEach var="qvo" items="${ar}" varStatus="vs">
                    <tr>
                        <input type="hidden" name="qc_idx" value="${qvo.qc_idx}">
                        <input type="hidden" name="qc_tridx" value="${vs.index+1}">
                        <td><input type="text" class="text" value="${qvo.qc_name}" name="qc_name"></td>
                        <td><input type="date" value="${qvo.qc_date}" name="qc_date"></td>
                        <td><input type="text" class="text" value="${qvo.qc_place}" name="qc_place"></td>
                        <td><input type="text" class="text" value="${qvo.qc_cname}" name="qc_cname"></td>
                        <td><input type="text" class="text" value="${qvo.qc_day}" name="qc_day"></td>
                        <td><input type="text" class="text" value="${qvo.qc_job}" name="qc_job"></td>
                        <td><input type="text" class="text" value="${qvo.qc_position}" name="qc_position"></td>
                    </tr>
                </c:forEach>
                <c:if test="${length < 3}">
                <c:forEach begin="${length+1}" end="3" var="i">
                    <tr>
                        <input type="hidden" name="qc_tridx" value="${i}">
                        <td><input type="text" class="text" name="qc_name"></td>
                        <td><input type="date" name="qc_date"></td>
                        <td><input type="text" class="text" name="qc_place"></td>
                        <td><input type="text" class="text" name="qc_cname"></td>
                        <td><input type="text" class="text" name="qc_day"></td>
                        <td><input type="text" class="text" name="qc_job"></td>
                        <td><input type="text" class="text" name="qc_position"></td>
                    </tr>
                </c:forEach>
                </c:if>
                    
                </tbody>
             </table>
             <table id="makeTime" class="table">
                <tr>
                    <th >메모</th>
                </tr>
                <tr>
                    <td><textarea rows="10" name="tr_etc" class="textarea">${vo12.tr_etc}</textarea></td>
                </tr>
             </table>
        </div>
             <div class="main_item align_center">
                <input type="button" value="저장" onclick="sendwrite(this.form)" class="btn">
                <input type="button" value="인쇄" onclick="printPage('${pageContext.request.contextPath }/upload_file/${vo12.file_name}')" class="btn print" id="print">
                <input type="button" value="취소" id="writec_btn" class="btn">
            </div>
        
            <input type="hidden" name="c_idx" value="${cc.c_idx}">
            <input type="hidden" name="tr_idx" value="${vo12.tr_idx}">
            <input type="hidden" name="tm_idx" value="${tmvo.tm_idx}">
            <input type="hidden" name="tf_idx" value="${tfvo.tf_idx}">
            <input type="hidden" name="bs_idx" value="${bvo.bs_idx}">
        </form>
	