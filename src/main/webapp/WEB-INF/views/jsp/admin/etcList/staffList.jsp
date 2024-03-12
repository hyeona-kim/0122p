<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="sf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/summernote-lite.css">
<style>
	#faculty{
		display: inline-block;
		padding: 6px 6px;
		border: none;
		border-radius: 5px 5px;
		background-color: #a2caf8;
		color: white;
	}
	#director{
		display: inline-block;
		padding: 6px 6px;
		border: none;
		border-radius: 5px 5px;
		background-color: #F55944;
		color: white;
	}
    #manager{
        display: inline-block;
		padding: 6px 6px;
		border: none;
		border-radius: 5px 5px;
		background-color: #154790;
		color: white;
    }
</style>
</head>
<body>
    <article>
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
	</article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;기타관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <article>
                            <%-- ========== 교직원현황 테이블 시작 ========== --%>
                            <div id="staffList_top" class="title">교직원현황</div>
							<div class="main_item align_right">
								<%-- ===== 교직원 등록 버튼 ===== --%>
							<sf:if test="${sessionScope.vo.sf_mgr eq '1' or sessionScope.vo.sf_tmgr eq '1'}">
								<button type="button" id="staff_add_btn" class="btn">교직원 등록</button>
							</sf:if>
							</div>
                            <table id="staffList" class="table" style="font-weight: bold;">
                                <caption>교직원현황 테이블</caption>
                                <tbody>
                                    <%-- ===== 출력할 교직원 항목 ===== --%>
                                    <tr>
                                        <th>번호</th>
                                        <th>성명</th>
                                        <th>교수코드</th>
                                        <th>직급</th>
                                        <th>아이디</th>
                                        <th>암호</th>
                                        <th>연락처</th>
                                        <th>입사일</th>
                                        <th>퇴사일</th>
                                        <th>사용권한</th>
                                        <th>차단여부</th>
                                        <th>책임자</th>
                                        <th colspan="2">관리</th>
                                    </tr>
                                    <%-- ===== 교직원 목록 출력 ===== --%>
                                    <sf:if test="${vo ne null}"> <%-- vo는 로그인 정보 --%>
                                        <sf:forEach items="${requestScope.ar}" varStatus="vs" var="vo2">
                                            <tr>
                                                <td>${vs.index+1}</td>
                                                <td>${vo2.sf_name}</td>
                                                <%-- 사용권한이 1(교수)인 사람만
                                                     교수코드(sf_code)를 출력 --%>
                                                <sf:if test="${vo2.sf_code ne 'tcnull'}">
                                                    <td>${vo2.sf_code}</td>
                                                </sf:if>
                                                <sf:if test="${vo2.sf_code eq 'tcnull'}">
                                                    <td></td>
                                                </sf:if>
                                                <td>${vo2.sf_job}</td>
                                                <td>${vo2.sf_id}</td>
                                                <td>${vo2.sf_pwd}</td>
                                                <td>${vo2.sf_phone}</td>
                                                <td>${vo2.sf_hire_date}</td>
                                                <td>${vo2.sf_fire_date}</td>
												<sf:if test="${vo2.sf_mgr eq '1' or vo2.sf_tmgr eq '1'}">
													<td>관리자그룹</td>
												</sf:if>
												<sf:if test="${vo2.sf_tmgr eq '0'}">
													<sf:if test="${vo2.sf_mgr eq '0' and vo2.sf_tcr eq '1'}">
														<td>교강사그룹</td>
													</sf:if>
													<sf:if test="${vo2.sf_mgr eq '0' and vo2.sf_tcr eq '0'}">
														<td></td>
													</sf:if>
												</sf:if>
                                                <%-- sf_link가 1인 사람만 ON 마크 표시 --%>
                                                <sf:if test="${vo2.sf_link eq '1'}">
                                                    <td><button type="button" id="block_btn" onclick="unblockStaff('${vo2.sf_idx}')" class="btn red2">ON</button></td>
                                                </sf:if>
                                                <sf:if test="${vo2.sf_link eq '0'}">
                                                    <td></td>
                                                </sf:if>
												<sf:if test="${vo2.sf_tmgr eq '1'}"> <%-- 권한을 여러개 갖을 수 있으므로, 가장 높은 권한부터 순차적으로 확인하여 출력 --%>
													<td><span id="director">최고 관리자</span></td>
												</sf:if>
												<sf:if test="${vo2.sf_tmgr eq '0'}">
													<sf:if test="${vo2.sf_mgr eq '1'}">
														<td><span id="manager">관리자</span></td>
													</sf:if>
													<sf:if test="${vo2.sf_mgr eq '0'}">
														<sf:if test="${vo2.sf_tcr eq '1'}">
															<td><span id="faculty">교직원</span></td>
														</sf:if>
														<sf:if test="${vo2.sf_tcr eq '0'}">
															<td></td>
														</sf:if>
													</sf:if>
												</sf:if>
                                                <td colspan="2">
													<sf:if test="${sessionScope.vo.sf_mgr eq '1' or sessionScope.vo.sf_tmgr eq '1'}">
													<a href="javascript:addCareerForm('${vo2.sf_idx}')" class="btn" style="text-decoration: none;">소개추가</a>
													<a href="javascript:editStaffForm('${vo2.sf_idx}')" class="btn" style="text-decoration: none;">수정</a>
                                                    <a href="javascript:delStaff('${vo2.sf_idx}', '${vo2.sf_tcr}', '${vo2.sf_mgr}', '${vo2.sf_tmgr}')" class="btn red" style="text-decoration: none;">삭제</a>
												</sf:if>
                                                </td>
                                            </tr>
                                        </sf:forEach>
                                    </sf:if>
                                </tbody>
                            </table>
                        </article>
				</div>
            </div> 
        </article>
    </article>
    <%-- ========== 교직원 등록,수정 폼 시작 ========== --%>
    <div id="addForm" type="hidden">
        
    </div>
    <%-- ========== 교직원 등록,수정 폼 끝 ========== --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="js/summernote-lite.js"></script>
	<script src="js/lang/summernote-ko-KR.js"></script>
    <script>
		let f = "";
		let i = '${sessionScope.vo.sf_idx}';
		let t = '${sessionScope.vo.sf_tmgr}';
		let m = '${sessionScope.vo.sf_mgr}'; 

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
        $(function(){
			$(".subSelect").removeClass("subSelect");
			$("#l_one").addClass("subSelect");
			/* [교직원등록]버튼을 클릭했을 때
			 비동기통신을 이용해 dialog를 띄우는 기능 */
			$("#staff_add_btn").bind("click", function() {
				$.ajax({
					url: "staffAddForm",
					type: "post",
				}).done(function(result){
					$("#addForm").dialog("open");
					$("#addForm").html(result);
					$("#cc_btn").click(function(){
						$("#addForm").dialog("close");
					});
				});
				
				$("#addForm").dialog({
					title : '교직원등록',
					modal : true,
					width : 1000,
					maxHeight:800,
				});
			});
		});
		
		/* 교직원현황 - [수정]버튼을 클릭했을 때
		 비동기통신을 이용해 dialog를 띄우는 기능 */
		function editStaffForm(idx) {
			// 오직 자기 자신의 정보만 수정이 가능하게 해야하므로 로그인한 사람의 idx와 비교

			if(i != idx && t == '0')
				alert("권한이 없습니다.");
			else{

				$.ajax({
					url: "staffEditForm",
					type: "post",
					data: "sf_idx="+idx
				}).done(function(result){
					$("#addForm").dialog("open");
					$("#addForm").html(result);
					$("#cc_btn").click(function(){
						$("#addForm").dialog("close");
					});
				});
				
				$("#addForm").dialog({
					title : '교직원수정',
					modal : true,
					width : 1000,
					maxHeight : 800
				});
			}
		};
			
			/* 교직원수정 폼에서 [수정]버튼을 클릭했을 때 수행하는 곳 */
			function editStaff(idx) {
				// 이름, 직급, 아이디, 암호, 입사일 유효성 검사
				// 퇴사일은 값이 없어도 Controller에서 처리함
				let ar = document.forms[0].elements;
				for(let i=0 ; i<ar.length-12; i++){
					
					if(ar[i].value ==""){
						alert(ar[i].dataset.str+"을 입력하세요");
						ar[i].focus();
						return; // 수행 중단
					};
				};

			// 연락처 맨 앞자리 유효성 검사
			if(ar[8].value.trim().length != '3'){
				alert(ar[8].dataset.str+"을 입력하세요");
				ar[8].focus();
				return; // 수행 중단
			};

			// 연락처 가운데, 뒷자리 유효성 검사
			for(let i=9 ; i<ar.length-8; i++){
				if(ar[i].value.trim().length != '4'){
					alert(ar[i].dataset.str+"을 입력하세요");
					ar[i].focus();
					return; // 수행 중단
				};
			};
			if(confirm("수정하시겠습니까?")){
				if($("#authority").val() == '3' && t == '1' && idx != i){
					if(!confirm("권한 양도시 열람 및 수정의 제한이 생기실 수 있습니다. 정말로 양도하시겠습니까?")){
						return;
					}
				}
				$("#sf_fname").val(f);
				alert("수정되었습니다");
				$("#frm2").submit();
			} else {
				return;
			}
		};
		
		/* 교직원현황 - [삭제]버튼을 클릭했을 때 data를 삭제하는 곳
			 교직원의 status를 0->1 로 변경해서 보이지 않게 한다 */
		function delStaff(idx, tcr, mgr, tmgr) { // 관리자는 교강사를, 최고관리자는 관리자, 강사 모두를 삭제 가능하다
			// 교강사는 관리자체가 불가능하므로 관리자 이상급의 권한만 확인한다.
			let chk = false;
			if(tmgr != '1'){ // 최고 관리자는 삭제될 수 없으므로 비교
				if(t == '1') {
					chk = true;
				} else if(m == '1' && mgr == '0') { // 로그인한 사람이 관리자이고 삭제하려는 직급이 강사일때
					chk = true;
				} else { // 관리자가 관리자를 삭제하려 했을 때
					alert("권한이 없습니다.");
				}
			} else {
				alert("최고 관리자는 삭제가 불가능합니다.");	
			}

			if (chk){
				if(confirm("삭제하시겠습니까?")){
					location.href="delStaff?sf_idx="+idx;
				}else{
					return false;
				}
			}
		};
		
		/* 교직원등록에서 인증선택의 option을 변경할 때 수행하는 곳 */
		function changeCertifi() {
			/* option에서 선택된 값을 value에 저장 */
			let value = $("#certification").val();
			
			switch(value){
				case "none":{
					$("#certi_image").hide();
					$("#certi_sign").hide();				
				}
				break;
				case "image":{
					$("#certi_image").show();
					$("#certi_sign").hide();			
				}
				break;
				case "sign":{
					$("#certi_image").hide();
					$("#certi_sign").show();
					
					let canvas = $("#signature")[0];
					let signature = new SignaturePad(canvas, {
									minWidth : 2,
									maxWidth : 2,
									penColor : "rgb(0, 0, 0)"
					});
					
					/* 교직원등록에서 전자서명패드를 clear하는 기능 */
					$("#clear_btn").bind("click", function() {
						signature.clear();
					});
				}
				break;
			};
		};
			
		/* 교직원등록에서 [저장]버튼을 눌렀을 때 수행하는 곳 */
		/* 또는 교직원수정에서 [수정]버튼을 눌렀을 때 수행하는 곳 */
		function addStaff() {
			// 이름, 직급, 아이디, 암호, 입사일 유효성 검사
			let ar = document.forms[0].elements;
			for(let i=0 ; i<ar.length-11; i++){
				if(ar[i].value.trim().length == 0){
					alert(ar[i].dataset.str+"을 입력하세요");
					ar[i].focus();
					return; // 수행 중단
				};
			};

			// 연락처 맨 앞자리 유효성 검사
			if(ar[5].value.trim().length != '3'){
					alert(ar[5].dataset.str+"을 입력하세요");
					ar[5].focus();
					return; // 수행 중단
			};

			// 연락처 가운데, 뒷자리 유효성 검사
			for(let i=7 ; i<ar.length-8; i++){
				if(ar[i].value.trim().length != '4'){
						alert(ar[i].dataset.str+"을 입력하세요");
						ar[i].focus();
						return; // 수행 중단
				};
			};

			if(confirm("추가 하시겠습니까?")){
				if($("#authority").val() == '3' && t == '1'){
					if(!confirm("권한 양도시 열람 및 수정의 제한이 생기실 수 있습니다. 정말로 양도하시겠습니까?")){
						return;
					}
				}
				$("#sf_fname").val(f);
				alert("성공적으로 추가되었습니다");
				$("#frm1").submit();
			} else {
				return;
			}
			

		};

		/* 교직원현황에서 차단여부 [ON]버튼을 눌렀을 때 수행하는 곳 */
		function unblockStaff(idx) {
			if(confirm("해제하시겠습니까?")){
				location.href="unblockStaff?sf_idx="+idx;
			}else{
				return false;
			};
		};

		function addSign(){
			if( $("#certification").val() == "sign"){

				let canvas = document.getElementById("signature");

				let fdata = new FormData();

			  
				let imgDataUrl = canvas.toDataURL('image/png');
				let binaryData = atob(imgDataUrl.split(',')[1]); // base54 데이터 디코딩
				let array = [];
			  
				for (let i = 0; i < binaryData.length; i++) {
					array.push(binaryData.charCodeAt(i)); // 하나의 파일로 만들기 위해 모든 값들을 배열에 집어넣음
				}
			  
				let file = new File([new Uint8Array(array)], {type: 'image/png'}); // 이미지파일 만들기

				fdata.append("s_file", file);

				$.ajax({
					url: "addSign",
					data: fdata,
					type: "POST",
					contentType: false, // 파일 첨부시 필요한 속성들
					processData: false,
					cache: false,
					dataType: "json", // 서버에서 보내오는 자원의 타입
				}).done(function(data) {
					f = data.f_name
					alert("저장되었습니다.");
					$("#certi_sign").hide();
				});
			}
			
		}

		// 교직원현황 - [소개추가]를 눌렀을 때 dialog 띄우는 곳
		function addCareerForm(idx) {
			// 여기서 dialog를 띄우고 [등록] 버튼을 누르면 그때 DB에 접근
			$.ajax({
				url: "addCareerForm",
				type: "get",
				data: "sf_idx="+idx,
			}).done(function(result) {
				$("#addForm").dialog({
					title : '강사 소개 등록',
					modal : true,
					width : 1000,
					maxHeight : 800
				});
				$("#addForm").dialog("open");
				$("#addForm").html(result);
				$("#sf_career").summernote({
					height: 200,
					focus: true,
					lang: "ko-KR",
					dialogsInBody: true,
				});
				$("#sf_career").summernote("lineHeight", 0.7);

				$("#cc_btn").click(function(){
					$("#addForm").dialog("close");
				});

			});
		}

		function addCareer(form) {
			form.submit();
		}
    </script>
</body>
</html>