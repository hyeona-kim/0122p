<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<title>Insert title here</title>
<style>
	#staffWrap{
		width: 95%;
		padding: 10px;
		margin: 0px auto;
	}
	table#staffList{
		border-collapse: collapse;
		width: 98%;
		margin: 0px auto;
		padding: 0px;
	}
	table#staffList tbody{
		text-align: center;
	}
	table#staffList tbody th, table#staffList tbody td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	table#staffList tbody th {
		background-color: #f0f0ef;
	}
	table#staffList tbody td {
		font-size: 13px;
	}
	table#staffList caption{
		text-indent: -9999px;
		height: 0px;
	}
	table#staffList thead td{
		text-align: right;
		border: none;
		padding: 8px 0px;
	}
	div#staffList_top{
		background-color: black;
		padding: 5px;
		padding-left: 10px;
		color: white;
		font-weight: bold;
	}
	#staff_add_btn{
		background-color: #4cdbcf;
		border-radius: 3px;
		border: none;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
		text-decoration: none;
	}
	.staff_btn{
		display: inline-block;
		background-color: #cc1919;
		border-radius: 3px;
		border: none;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
		text-decoration: none;
	}
	.staff_edit_btn{ background-color: #1876c7;	}
	.staff_del_btn{ background-color: #cc1919; }
	#addForm table caption{ text-indent: -9999px; }
	#addForm table {
		width: 950px;
		height: 450px;
		border-collapse: collapse;
		position: absolute;
		
	}
	#addForm table th, #addForm table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	#addForm {
		text-align: center;
		margin: 0px auto;
		padding: 10px;
	}
	#addForm .left {
		text-align: left;
	}
	#addForm th{
		width: 20%;
	}
	#addForm .phone{
		width: 50px;
	}
	#addForm .input{
		width: 150px;
	}
	#addForm tfoot td{
		border: none;
	}
	#signature{
		border: 1px solid black;
	}
	#director{
		background-color: #e14b4b;
		border-radius: 3px;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
	}
	#faculty{
		background-color: #322eee;
		border-radius: 3px;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
	}
	#block_btn{
		background-color: #4c5bcf;
		border-radius: 3px;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
	}
</style>
</head>
<body>
	<article id="wrap">
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
		<div id="center">
		<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<!--  여기서 표시될 테이블들 가지고오기 -->
				<div id="staffWrap">
					<article>
						<%-- ========== 교직원현황 테이블 시작 ========== --%>
						<div id="staffList_top">교직원현황</div>
						<table id="staffList">
							<caption>교직원현황 테이블</caption>
							<thead>
								<%-- ===== 교직원 등록 버튼 ===== --%>
								<tr><td colspan="13"><button type="button" id="staff_add_btn">교직원 등록</button></td></tr>
							</thead>
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
									<sf:forEach items="${requestScope.ar}" varStatus="vs" var="vo">
										<tr>
											<td>${vs.index+1}</td>
											<td>${vo.sf_name}</td>
											<%-- 사용권한이 1(교수)인 사람만
												 교수코드(sf_code)를 출력 --%>
											<sf:if test="${vo.sf_code ne 'tcnull'}">
												<td>${vo.sf_code}</td>
											</sf:if>
											<sf:if test="${vo.sf_code eq 'tcnull'}">
												<td></td>
											</sf:if>
											<td>${vo.sf_job}</td>
											<td>${vo.sf_id}</td>
											<td>${vo.sf_pwd}</td>
											<td>${vo.sf_phone}</td>
											<td>${vo.sf_hire_date}</td>
											<td>${vo.sf_fire_date}</td>
											<sf:if test="${vo.rt_name ne null}">
												<td>${vo.rt_name}</td>
											</sf:if>
											<sf:if test="${vo.rt_name eq null}">
												<td></td>
											</sf:if>
											<%-- sf_link가 1인 사람만 ON 마크 표시 --%>
											<sf:if test="${vo.sf_link eq '1'}">
												<td><button type="button" id="block_btn" onclick="unblockStaff('${vo.sf_idx}')">ON</button></td>
											</sf:if>
											<sf:if test="${vo.sf_link eq '0'}">
												<td></td>
											</sf:if>
											<%-- 사용권한이 9인 사람은 총책임자, 1인 사람은 교직원 마크 표시 --%>
											<sf:if test="${vo.rt_idx eq '1'}">
												<td><span id="faculty">교직원</span></td>
											</sf:if>
											<sf:if test="${vo.rt_idx eq '9'}">
												<td><span id="director">총책임자</span></td>
											</sf:if>
											<sf:if test="${vo.rt_idx ne '9' and vo.rt_idx ne '1'}">
												<td></td>
											</sf:if>
											<td colspan="2">
												<a href="javascript:editStaffForm('${vo.sf_idx}')" class="staff_edit_btn staff_btn">수정</a>
												<a href="javascript:delStaff('${vo.sf_idx}')" class="staff_del_btn staff_btn">삭제</a>
											</td>
										</tr>
									</sf:forEach>
								</sf:if>
							</tbody>
						</table>
						<%-- ========== 교직원현황 테이블 끝 ========== --%>
					</article>
				</div>
			</div>
		</div>
		
		<%-- ========== 교직원 등록,수정 폼 시작 ========== --%>
		<div id="addForm">
			
		</div>
		<%-- ========== 교직원 등록,수정 폼 끝 ========== --%>
		
	</article>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		$(function(){
			$(".selected").removeClass("selected")
			$("#etclist").addClass("selected");
			$("#l_first").addClass("l_select");
			
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
					height : 600
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
				height : 600
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