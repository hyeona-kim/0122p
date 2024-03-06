<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

</head>
<body>
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;학적부관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="staffList_top" class="title">훈련생 현황</div>
                    <form action="traineeEdit" method="post" encType="multipart/form-data" name="fff">
					<div class="main_color main_item bold">｜훈련생정보수정</div>	
                    <table id="makeTime" class="table">
                    <caption>확인서류등록 리스트</caption>

                                <tbody>
                                    <tr>
                                        <th><label>학생코드</label></th>
                                        <td colspan="3"></td>
                                    </tr>
                                    <tr>
                                        <th>이름</th>
                                        <td><input type="text" class="text" value="${vo9.tr_name}" name="tr_name"></td>
                                        <th>주민번호</th>
                                        <td>
                                            <input type="text" class="text" value="${fn:substring(vo9.tr_rrn,0,6)}" name="tr_rrn" style="width: 40%;">-
                                            <input type="text" class="text" value="${fn:substring(vo9.tr_rrn,7,14)}" name="tr_rrn" style="width: 40%;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><label>휴대폰번호</label></th>
                                        <td>
                                            <input type="text" class="text"  value="${fn:substring(vo9.tr_hp,0,3)}" name="tr_hp" style="width: 20%;">-
                                            <input type="text" class="text"  value="${fn:substring(vo9.tr_hp,4,8)}" name="tr_hp" style="width: 20%;">-
                                            <input type="text" class="text" value="${fn:substring(vo9.tr_hp,9,13)}" name="tr_hp" style="width: 20%;">
                                        </td>
                                        <th><label>과정명</label></th>
                                        <td>${vo2.c_name}</td>
                                    </tr>
                                    <tr>
                                        <th><label>집전화</label></th>
                                        <td>
                                            <input type="text" class="text" value="${fn:substring(vo9.tr_phone,0,2)}" name="tr_phone" style="width: 20%;">-
                                            <input type="text" class="text" value="${fn:substring(vo9.tr_phone,3,6)}" name="tr_phone" style="width: 20%;">-
                                            <input type="text" class="text" value="${fn:substring(vo9.tr_phone,7,11)}" name="tr_phone" style="width: 20%;">						
                                        </td>
                                        <th><label>HRD등록일</label></th>
                                        <td><input type="text" class="text"></td>
                                    </tr>
                                    <tr>
                                        <th><label>현재상태</label></th>
                                        <td>
                                            <input type="hidden" id="nowstatus" value="${vo9.tr_nowstatus}"/>
                                            <select name="status" class="select">
                                                <option id="op1" value="0" >접수</option>
                                                <option id="op2" value="1" >예정</option>
                                                <option id="op3" value="2" >수강</option>
                                                <option id="op4" value="3" >조기수료</option>
                                                <option id="op5" value="4" >조기취업</option>
                                                <option id="op6" value="5" >수료</option>
                                                <option id="op7" value="6" >수강포기</option>
                                                <option id="op8" value="7" >미수료</option>
                                                <option id="op9" value="8" >제적</option>
                                                <option id="op10" value="9" >취소</option>
                                            </select>
                                        </td>
                                        <th><label>수료일</label></th>
                                        <td><input type="text" class="text" value="${vo2.end_date}"></td>
                                    <tr>
                                        <th><label>수강포기(제적,취소)일</label></th>
                                        <td><input type="text" class="text" name="tr_cancel_date" vaule="${vo9.tr_cancel_date}"></td>
                                        <th><label>수강포기(제적,취소)사유</label></th>
                                        <td><input type="text" class="text" name="tr_cancel_text" value="${vo9.tr_cancel_text}"></td>
                                    </tr>
                                    
                                    <tr>
                                        <th><label>사진(210*210)</label></th>
                                        <td>
											<img id="preview" width="210" height="210" />
                                            <input type="file" onchange="readURL(this);" name="file" class="text"> 
                                        </td>
                                        <th><label>환불금액</label></th>
                                        <td><input type="text" class="text"><div id="box">(* ,없이 숫자로만 입력해주세요)</div></td>
                                    <tr>
                                        <th><label>이직전직장명</label></th>
                                        <td><input type="text" class="text"></td>
                                        <th><label>담당직무</label></th>
                                        <td><input type="text" class="text"></td>
                                    </tr>
                                    
                                        <tr>
                                        <th><label>전체교육비</label></th>
                                        <td>
                                            <input type="text" class="text"/><div id="box">(*,없이 숫자로만 입력해주세요)</div>
                                        </td>
                                        <th><label>카드유형</label></th>
                                        <td>
                                            <select id="tr_card" name="tr_card" class="select">
                                                <c:if test="${vo9.tr_card eq null}" >
                                                    <option value="취성패1" >취성패1</option>
                                                    <option value="취성패2">취성패2</option>
                                                    <option value="내일배움">내일배움</option>
                                                </c:if>
                                                <c:if test="${vo9.tr_card eq '취성패1'}" >
                                                    <option value="취성패1" selected>취성패1</option>
                                                    <option value="취성패2">취성패2</option>
                                                    <option value="내일배움">내일배움</option>
                                                </c:if>
                                                <c:if test="${vo9.tr_card eq '취성패2'}" >
                                                    <option value="취성패1" >취성패1</option>
                                                    <option value="취성패2" selected>취성패2</option>
                                                    <option value="내일배움">내일배움</option>
                                                </c:if>
                                                <c:if test="${vo9.tr_card eq '내일배움'}" >
                                                    <option value="취성패1" >취성패1</option>
                                                    <option value="취성패2">취성패2</option>
                                                    <option value="내일배움" selected>내일배움</option>
                                                </c:if>
                                            </select>
                                        </td>
                                    <tr>
                                        <th><label>지원경로</label></th>
                                        <td colspan="3">
                                            <input type="checkbox" name="t_path" value="인터넷">인터넷
                                            <input type="checkbox" name="t_path" value="전단지">전단지
                                            <input type="checkbox" name="t_path" value="현수막">현수막
                                            <input type="checkbox" name="t_path" value="생활정보지">생활정보지
                                            <input type="checkbox" name="t_path" value="고용지원센터">고용지원센터
                                            <input type="checkbox" name="t_path" value="직접내방">직접내방
                                            <input type="checkbox" name="t_path" value="지인소개">지인소개
                                            <input type="checkbox" name="t_path" value="HRD">HRD
                                            <input type="checkbox" name="t_path" value="기타">기타
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <th><label>주소</label></th>
                                        <td colspan="3" style="text-align: left;">
                                            <input type="text" class="text" name="tr_pos_code" id="sample6_postcode" placeholder="우편번호" style="width: 10%; margin-bottom: 5px; margin-left: 10px;">
                                            <input type="button" onclick="checkPost()" value="우편번호 찾기" class="btn"><br>
                                            <input type="text" class="text" name="tr_addr" id="sample6_address" placeholder="주소" style="width: 20%; margin-bottom: 5px;margin-left: 10px;"><br>
                                            <input type="text" class="text" name="tr_addr" id="sample6_detailAddress" placeholder="상세주소" style="width: 10%; margin-bottom: 5px;margin-left: 10px;">
                                            <input type="text" class="text" name="tr_addr" id="sample6_extraAddress" placeholder="참고항목" style="width: 10%; margin-bottom: 5px;">
                                        </td>
                                    <tr>
                                        <th><label>상담내용</label></th>
                                        <td colspan="3">
                                            <table class="table ">
                                                <tbody>
                                                    <tr>
                                                        <td>상담일</td>
                                                        <td>상담자</td>
                                                        <td>상담내용</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">상담내용이 없습니다.</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4" class="main_color">
                                            <label>* 교육시간, 교시, 요일은 시간표 만들때 사용됩니다. 시간표를 만들려면 꼭 입력해주세요</label><br/>
                                            <label>* 총 교육일수는 훈련일지에서 사용됩니다.</label>
                                        </td>
                                    </tr>
                                </tfoot>
                                    
                </table>
				<div class="main_item align_center">
					<button type="button" onclick="sendData(this.form)" class="btn">등록</button>
					<button type="button" onclick="javascript:location.href='traineecurrentbt1?c_idx=${vo2.c_idx}'" class="btn">목록</button>
					<input type="hidden" name="tr_idx" value="${vo9.tr_idx}">
					<input type="hidden" name="c_idx" value="${c_idx}">
				</div>
                </form>
                </div>
				</div>
            </div> 
        </article>
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        $(".sub_manu").mouseover(function(){
            $(this).css("display","block");
        });
        $(".menu1").mouseover(function(){
            $(this).next().css("display","block");
        });
        $(".menu1").mouseout(function(){
            $(this).next().css("display","none");
        });
        $(".sub_manu").mouseout(function(){
            $(this).css("display","none");
        });
        $(function() {
			$(".subSelect").removeClass("subSelect");
			$("#l_two").addClass("subSelect");
            for(let i=1;i<=10;i++){
                //console.log($("#op"+i).val());
                if($("#op"+i).val() ==$("#nowstatus").val()){
                    $("#op"+i).attr("selected",true);
                }
                
            }
    
            });
    
    
             function sendData(fff){
    
                    fff.submit();
                    
                }	
    
                
            
                function readURL(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function(e) {
                        document.getElementById('preview').src = e.target.result;
                        };
                        reader.readAsDataURL(input.files[0]);
                    } else {
                        document.getElementById('preview').src = "";
                    }
                }
    
            function checkPost() {
                new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수
    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
    
                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("sample6_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>
</body>
</html>