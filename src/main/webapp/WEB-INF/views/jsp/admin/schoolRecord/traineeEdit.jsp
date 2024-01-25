<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/summernote-lite.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<style>
table tfoot ol.page {
	    list-style:none;
	    width: 300px;
	    margin: auto;
	}
	
	table tfoot ol.page li {
	    float:left;
	    margin-right:8px;
	}
	
	table tfoot ol.page li a {
	    display:block;
	    padding:3px 7px;
	    color:gray;
	    font-weight:bold;
	    text-decoration: none;
	}
	
	table tfoot ol.page li a:hover {
		color:black;
	    font-weight:bold;
	}
	.disable {
	    padding:3px 7px;
	    color:white;
	}
	
	.now {
	   padding:3px 7px;
	    color:#46ade1;
	    font-weight:bold;
	}
	#staffWrap{
		width: 95%;
		margin: auto;
		margin-top: 20px;
	}
	#staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
	}
	
	#searchTime, #makeTime{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	#searchTime td, #searchTime th, #makeTime td, #makeTime th{
		border: 1px solid #ddd;
		height: 40px;
		padding-left: 10px;
	}
	#searchTime th, #makeTime th{background-color: #EBF7FF;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
	.ck.ck-editor {
    	max-width: 100%;
    	padding: 8px;
    	
	}
	.ck-editor__editable {
	    min-height: 300px;
	}
	
	#t2{
		margin-top:10px;
		border-collapse: collapse;
		width: 99%;
		margin-bottom: 10px;
	}
	
	#t2 th{
	width: 100px;
	background-color: #EBF7FF;
	
	}
	
</style>

</head>
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">훈련생 현황</div>
				<form action="traineeEdit" method="post" encType="multipart/form-data">
				<table id="makeTime" >
				<caption>확인서류등록 리스트</caption>
					<tble>
						<thead>
							<tr>
								<td colspan="4">
									｜훈련생정보수정
								</td>
							</tr>
						</thead>
							<tbody>
								<tr>
									<th><label>학생코드</label></th>
									<td colspan="3"></td>
								</tr>
								<tr>
									<th>이름</th>
									<td><input type="text"></td>
									<th>주민번호</th>
									<td>
										<input type="text">-<input type="text">
									</td>
								</tr>
								<tr>
									<th><label>휴대폰번호</label></th>
									<td>
										<input type="text" name="ph">-<input type="text" name="ph">-<input type="text" name="ph">
									</td>
									<th><label>과정명</label></th>
									<td></td>
								</tr>
								<tr>
									<th><label>집전화</label></th>
									<td>
										<input type="text" name="hph">-
										<input type="text" name="hph">-
										<input type="text" name="hph">						
									</td>
									<th><label>HRD등록일</label></th>
									<td><input type="text"></td>
								</tr>
								<tr>
									<th><label>현재상태</label></th>
									<td><select>
											<option value="수강">수강</option>
											<option value="비수강">비수강</option>
										</select>
									</td>
									<th><label>수료일</label></th>
									<td><input type="text"></td>
								<tr>
									<th><label>수강포기(제적,취소)일</label></th>
									<td><input type="text" name="ch"></td>
									<th><label>수강포기(제적,취소)사유</label></th>
									<td><input type="text" name="ch"></td>
								</tr>
								
								<tr>
									<th><label>사진(210*210)</label></th>
									<td>
										<input type="file"/>
									</td>
									<th><label>환불금액</label></th>
									<td><input type="text"><div id="box">(* ,없이 숫자로만 입력해주세요)</div></td>
								<tr>
									<th><label>이직전직장명</label></th>
									<td><input type="text"></td>
									<th><label>담당직무</label></th>
									<td><input type="text"></td>
								</tr>
								
									<tr>
									<th><label>전체교육비</label></th>
									<td>
										<input type="text"/><div id="box">(*,없이 숫자로만 입력해주세요)</div>
									</td>
									<th><label>카드유형</label></th>
									<td>
										<select>
											<option value="취성패1">취성패1</option>
											<option value="취성패2">취성패1</option>
											<option value="내일배움">내일배움</option>
										</select>
									</td>
								<tr>
									<th><label>지원경로</label></th>
									<td colspan="3">
										<input type="checkbox" name="ch1" value="인터넷">인터넷
										<input type="checkbox" name="ch2" value="전단지">전단지
										<input type="checkbox" name="ch3" value="현수막">현수막
										<input type="checkbox" name="ch4" value="생활정보지">생활정보지
										<input type="checkbox" name="ch5" value="고용지원센터">고용지원센터
										<input type="checkbox" name="ch6" value="직접내방">직접내방
										<input type="checkbox" name="ch7" value="지인소개">지인소개
										<input type="checkbox" name="ch8" value="HRD">HRD
										<input type="checkbox" name="ch9" value="기타">기타
									</td>
								</tr>
								
								<tr>
									<th><label>주소</label></th>
									<td colspan="3"><input type="text" id="postcode" name="zipcode" size="5" readonly>
										<input type="button" value="우편번호검색" onclick="checkPost()"><br>
										<input type="text" id="address" name="addr1" size="50" placeholder="주소" readonly><br>
										<input type="text" id="detailAddress" name="addr2" size="50" placeholder="상세주소"></td>
									</td>
								</tr>
								<tr>
									<th><label>상담내용</label></th>
									<td colspan="3">
										<table>
											<tbody>
												<tr>
													<th>상담일</th>
													<th>상담자</th>
													<th>상담내용</th>
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
									<td colspan="4" align="left">
										<label>* 교육시간, 교시, 요일은 시간표 만들때 사용됩니다. 시간표를 만들려면 꼭 입력해주세요</label><br/>
										<label>* 총 교육일수는 훈련일지에서 사용됩니다.</label>
									</td>
								</tr>
							</tfoot>
								
			</table>
			<button type="button" onclick="sendData()">등록</button>
			<button type="button" onclick="javascript:location.href='traineecurrentbt1'">목록</button>
			</form>
			</div>
		</div>
	</div>
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script>
	 	function sendData(){
        		let ar = document.forms[0].elements;
        	
        			let str = ar[0].dataset.str;
        			if(document.forms[0].elements[0].value==""){
        				alert(str+"를 입력하세요");
        				document.forms[0].elements[i].focus();
        				return;
        			}
        	
        		document.forms[0].submit();
        		
        	}
	</script>


<script>
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