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
<style>
	#faculty{
		display: inline-block;
		padding: 6px 6px;
		border: none;
		border-radius: 5px 5px;
		background-color: #154790;
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
								<button type="button" id="staff_add_btn" class="btn">교직원 등록</button>
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
                                                <sf:if test="${vo2.rt_name ne null}">
                                                    <td>${vo2.rt_name}</td>
                                                </sf:if>
                                                <sf:if test="${vo2.rt_name eq null}">
                                                    <td></td>
                                                </sf:if>
                                                <%-- sf_link가 1인 사람만 ON 마크 표시 --%>
                                                <sf:if test="${vo2.sf_link eq '1'}">
                                                    <td><button type="button" id="block_btn" onclick="unblockStaff('${vo2.sf_idx}')" class="btn red2">ON</button></td>
                                                </sf:if>
                                                <sf:if test="${vo2.sf_link eq '0'}">
                                                    <td></td>
                                                </sf:if>
                                                <%-- 사용권한이 9인 사람은 총책임자, 1인 사람은 교직원 마크 표시 --%>
                                                <sf:if test="${vo2.rt_idx eq '1'}">
                                                    <td><span id="faculty">교직원</span></td>
                                                </sf:if>
                                                <sf:if test="${vo2.rt_idx eq '9'}">
                                                    <td><span id="director">총책임자</span></td>
                                                </sf:if>
                                                <sf:if test="${vo2.rt_idx ne '9' and vo2.rt_idx ne '1'}">
                                                    <td></td>
                                                </sf:if>
                                                <td colspan="2">
                                                    <a href="javascript:editStaffForm('${vo2.sf_idx}')" class="btn" style="text-decoration: none;">수정</a>
                                                    <a href="javascript:delStaff('${vo2.sf_idx}')" class="btn red" style="text-decoration: none;">삭제</a>
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
    <div id="addForm">
        
    </div>
    <%-- ========== 교직원 등록,수정 폼 끝 ========== --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
					$("#addForm").html(result);
				});
				
				$("#addForm").dialog({
					title : '교직원등록',
					modal : true,
					width : 1000,
					maxHeight:800,
				});
				$("#cc_btn").click(function(){
					$("#addForm").dialog("close");
				});
			});
		});
		
		/* 교직원현황 - [수정]버튼을 클릭했을 때
		 비동기통신을 이용해 dialog를 띄우는 기능 */
		function editStaffForm(idx) {
			$.ajax({
				url: "staffEditForm",
				type: "post",
				data: "sf_idx="+idx
			}).done(function(result){
				$("#addForm").html(result);
			});
			
			$("#addForm").dialog({
				title : '교직원수정',
				modal : true,
				width : 1000,
				maxHeight : 800
			});
		};

		/* 교직원수정 폼에서 [수정]버튼을 클릭했을 때 수행하는 곳 */
		function editStaff(idx) {
			// 이름, 직급, 아이디, 암호, 입사일 유효성 검사
			// 퇴사일은 값이 없어도 Controller에서 처리함
			let ar = document.forms[0].elements;
			for(let i=0 ; i<ar.length-8; i++){
				if(ar[i].value ==""){
					alert(ar[i].dataset.str+"을 입력하세요");
					ar[i].focus();
					return; // 수행 중단
				};
			};

			// 연락처 맨 앞자리 유효성 검사
			if(ar[7].value.trim().length != '3'){
					alert(ar[7].dataset.str+"을 입력하세요");
					ar[7].focus();
					return; // 수행 중단
			};

			// 연락처 가운데, 뒷자리 유효성 검사
			for(let i=8 ; i<ar.length-4; i++){
				if(ar[i].value.trim().length != '4'){
					alert(ar[i].dataset.str+"을 입력하세요");
					ar[i].focus();
					return; // 수행 중단
				};
			};

			document.forms[0].submit();
		};
		
		/* 교직원현황 - [삭제]버튼을 클릭했을 때 data를 삭제하는 곳
			 교직원의 status를 0->1 로 변경해서 보이지 않게 한다 */
		function delStaff(idx) {
			if(confirm("삭제하시겠습니까?")){
				location.href="delStaff?sf_idx="+idx;
			}else{
				return false;
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
					
					var canvas = $("#signature")[0];
					var signature = new SignaturePad(canvas, {
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
			for(let i=0 ; i<ar.length-8; i++){
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
			for(let i=6 ; i<ar.length-5; i++){
				if(ar[i].value.trim().length != '4'){
						alert(ar[i].dataset.str+"을 입력하세요");
						ar[i].focus();
						return; // 수행 중단
				};
			};

			document.forms[0].submit();
		};

		/* 교직원현황에서 차단여부 [ON]버튼을 눌렀을 때 수행하는 곳 */
		function unblockStaff(idx) {
			if(confirm("해제하시겠습니까?")){
				location.href="unblockStaff?sf_idx="+idx;
			}else{
				return false;
			};
		};

		// 서명저장 --후에 수정후 사용하거나 다른 프로그램 사용
		/*  (function(obj){
			 obj.init();
			 $(obj.onLoad);
			 })((function(){    
			var canvas = $("#canvas");      
			var div = canvas.parent("div");
			 var ctx = canvas[0].getContext("2d");      
			 var drawble = false;
			 function canvasResize(){        
				 canvas[0].height = div.height();        
				 canvas[0].width = div.width();      }
			 }
			 function draw(e){        
				 function getPosition(){          
					 return {            
						 X: e.pageX - canvas[0].offsetLeft,             
						 Y: e.pageY - canvas[0].offsetTop         
						 }        
					 }        
				 switch(e.type){          
				 case "mousedown":{           
					 drawble = true;            
					 ctx.beginPath();            
					 ctx.moveTo(getPosition().X, getPosition().Y);          
					 }          
				 break;          
				 case "mousemove":{           
					 if(drawble){              
						 ctx.lineTo(getPosition().X, getPosition().Y);              
						 ctx.stroke();           
						 }         
					 }     
				 break;    
				 case "mouseup":  
					 case "mouseout":{       
						 drawble = false;      
						 ctx.closePath();       
						 }     
					 break; 
						 }    
				 }
		
			 return {      
				 init: function(){
					 $(window).on("resize", canvasResize);                   
					 canvas.on("mousedown", draw);    
					 canvas.on("mousemove", draw);    
					 canvas.on("mouseup", draw);      
					 canvas.on("mouseout", draw);
					 canvas.on("touchstart", touchdraw);         
					 canvas.on("touchend", touchdraw);     
					 canvas.on("touchcancel", touchdraw);  
					 canvas.on("touchmove", touchdraw);
					 $("#save").on("click", function(){          
						 // a 태그를 만들어서 다운로드를 만듭니다.    
						 var link = document.createElement('a');        
						 // base64데이터 링크 달기       
						 link.href = canvas[0].toDataURL("image/png");         
						 // 다운로드시 파일명 지정    
						 link.download = "image.png";      
						 // body에 추가       
						 document.body.appendChild(link);    
						 link.click();   
						 document.body.removeChild(link);       
						 // 다운로드용 a 태그는 다운로드가 끝나면 삭제합니다.       
						 form.remove();     
						 });  
					 },    
					 onLoad: function(){     
						 // 캔버스 사이즈 조절     
						 canvasResize();      
						 }  
					 }  
			 })()); */
    </script>
</body>
</html>