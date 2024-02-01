<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
 
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
	#searchTime th, #makeTime th{background-color: #F5F7F9;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
	#b1{
		 float: right;
		 padding-top: 10px;
		 margin-bottom: 10px;
	}
</style>

</head>
<c:if test="${tvo eq null }">
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">훈련생현황</div>
					<table id="searchTime">
						<caption>훈련생확인서류검색</caption>
							<thead>
								
								<tr>
									<th>｜${aa.c_name} (교육기간: ${aa.start_date} ~ ${aa.end_date})</th>
								</tr>
							
							</thead>
						</table>
					<table>
						<thead>
							<tr>
								<td><input type="button" value="면접평가표등록"></td>
								<td><input type="button" value="교육생일괄삭제" onclick="javascript:cudel()" ></td>
								<td><input type="button" value="교육생상태 일괄수정" onclick="alledit()"></td>
						</tr>
						</thead>
					</table>
				<table id="makeTime">
				<caption>훈련생확인서류 리스트</caption>
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheckBox" onclick="allChecked()"/>선택</th>
							<th>번호</th>
							<th>이미지</th>
							<th>학생코드</th>
							<th>이름</th>
							<th>연락처</th>
							<th>주민번호</th>
							<th>상태</th>
							<th>사유 및 날짜</th>
							<th>관리</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<td colspan="10">
								<ol class="page">
				<c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
				<li class="disable">&lt;</li>
			</c:if>	
	
			<c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
				<li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
			</c:if>

			<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
				<c:if test="${vs.index eq page.nowPage }">
					<li class="now">${vs.index }</li>
				</c:if>
				<c:if test="${vs.index ne page.nowPage }">
					<li><a onclick="paging('${vs.index}')">${vs.index}</a></li>
				</c:if>
			</c:forEach>
	
			<c:if test="${page.endPage < page.totalPage }">
				<li><a href="javascript:paging('${page.startPage + page.pagePerBlock }')">&gt;</a></li>
			</c:if>
			<c:if test="${page.endPage >= page.totalPage }">
				<li class="disable">&gt;</li>	
			</c:if>
                              </ol>
                          </td>
						</tr>
					</tfoot>
					<tbody>
		<form name="fff" method="post" action="cudel">
			<input type="hidden" name="c_idx" value="${c_idx}">
						<c:forEach var="vo7" items="${requestScope.ar }" varStatus="vs">
				<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
					<tr>
						<td><label class="checkbox-inline"><input type="checkbox" name="chk" class="chk" onclick="chkClicked('${vo7.tr_idx}')" value="${vo7.tr_idx}"></label></td>
						<!-- 학생에 대한 정보 입력  -->
						<td>${num-(vs.index)-2 }</td>
						<c:if test="${vo7.file_name eq null}">
							<td></td>
						</c:if>
						<c:if test="${vo7.file_name ne null}">
						<td><img src="${pageContext.request.contextPath }/upload_file/${vo7.file_name}" width="100" height="100"></td>
						</c:if>
						<td>${vo7.s_code}</td>
						<td>${vo7.tr_name }</td>
						<td>${vo7.tr_hp }</td>
						<td>${vo7.tr_rrn }</td>
						<td><!-- 상태 -->
							<input type="hidden" id="nowstatus${vs.index}" value="${vo7.tr_nowstatus}" class="sts"/>
								<select name="nowstatus" id="">
									<option id="op1${vs.index}" value="0" >접수</option>
									<option id="op2${vs.index}" value="1" >예정</option>
									<option id="op3${vs.index}" value="2" >수강</option>
									<option id="op4${vs.index}" value="3" >조기수료</option>
									<option id="op5${vs.index}" value="4" >조기취업</option>
									<option id="op6${vs.index}" value="5" >수료</option>
									<option id="op7${vs.index}" value="6" >수강포기</option>
									<option id="op8${vs.index}" value="7" >미수료</option>
									<option id="op9${vs.index}" value="8" >제적</option>
									<option id="op10${vs.index}" value="9" >취소</option>
								</select>
						</td>
						<td><!-- 사유및날짜 --></td>
						<td>
							<input type="hidden" name="tr_idx" value="${vo7.tr_idx}">
						<input type="button" id="fset"  onclick="javascript:location.href='traineeEdit?tr_idx=${vo7.tr_idx}&c_idx=${aa.c_idx}'" value="정보수정"/>
						<input type="button" id="fset"  onclick="traineewrite('${vo7.tr_idx}','${aa.c_idx}')" value="신상기록부">
						<input type="button" id="fset"  onclick="" value="서류관리">
						<input type="button" id="fset"  onclick="counseling('${vo7.tr_idx}','${aa.c_idx}')" value="상담일지">
						<input type="button" id="fset"  onclick="" value="사후관리">
						<input type="button" id="fset"  onclick="" value="면접평가표">
						</td>
					</tr>
				</c:forEach>
				</form>
				</tbody>
			</table>
		
			</div>
		</div>
	
	</div>
	
	<form action="cudel" name="frm" method="post">
		<input type="hidden" name="tr_idx" value="${vo7.tr_idx}"/>
		<input type="hidden" name="type" value=""/>
		<input type="hidden" name="cPage" value="${param.cPage}"/>
		<input type="hidden" name="c_idx" value="${vo7.c_idx}">
	</form>
	<div id="m1" hidden="hidden"></div>
	
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

	



	<script>
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_four").addClass("l_select");
			let ar = $(".sts");
			for(let k=0; k<ar.length;k++){
				//console.log($("#nowstatus"+k).val());
				for(let i=1;i<=10;i++){
					if($("#op"+i+k).val() ==$("#nowstatus"+k).val()){
						$("#op"+i+k).attr("selected",true);
					}
					
				}
			}

		});
		
		// form 데이터들 보내기 함수들 
		function sendData(ddd){
    		
    		ddd.submit();
		}

		function sendwrite(qqq){
			qqq.submit();
		}


		function alledit(){
		//체크박스 체크된 항목
		//console.log(tr_idx);
		let query = 'input[name="chk"]:checked'
        let selectedElements = document.querySelectorAll(query)
		
        //체크박스 체크된 항목의 개수
        let selectedElementsCnt = selectedElements.length;

        if(selectedElementsCnt == 0){
            alert("수정할 항목을 선택해주세요.");
            return false;
        } else if(confirm("수정하시겠습니까?")) {
			
			document.fff.action = "alledit";

			document.fff.submit();
		}

			
		}

		function allChecked(target){

			let checkbox = document.getElementById('allCheckBox');
			let is_checked = checkbox.checked;

			if(is_checked){
				chkAllChecked()
			}else{
				chkAllUnChecked()
			}


		}


		function chkClicked(tr_idx){
			console.log(tr_idx);
			//체크박스 전체개수
			let allCount = document.querySelectorAll(".chk").length;

			//체크된 체크박스 전체개수
			let query = 'input[name="chk"]:checked'
			let selectedElements = document.querySelectorAll(query)
			let selectedElementsCnt = selectedElements.length;

			//체크박스 전체개수와 체크된 체크박스 전체개수가 같으면 전체 체크박스 체크
			if(allCount == selectedElementsCnt){
				document.getElementById('allCheckBox').checked = true;
			}

			//같지않으면 전체 체크박스 해제
			else{
				document.getElementById('allCheckBox').checked = false;
			}
		}


		/* 전체 체크  */
		function chkAllChecked(){
			document.querySelectorAll(".chk").forEach(function(v, i) {
            v.checked = true;
        });
    }

		/* 전체 체크 해제 */
		function chkAllUnChecked(){
			document.querySelectorAll(".chk").forEach(function(v, i) {
            v.checked = false;
        });
    }
		
	function cudel(){
        //체크박스 체크된 항목
		//console.log(tr_idx);
       	let query = 'input[name="chk"]:checked'
        let selectedElements = document.querySelectorAll(query)

        //체크박스 체크된 항목의 개수
        let selectedElementsCnt = selectedElements.length;

        if(selectedElementsCnt == 0){
            alert("삭제할 항목을 선택해주세요.");
            return false;
        } else if(confirm("정말로 삭제하시겠습니까?")) {
			//배열생성
			// let arr = new Array(selectedElementsCnt);

			// document.querySelectorAll('input[name="chk"]:checked').forEach(function(v, i) {
			//     arr[i] = v.value;
			// 	//console.log(v.value); idx
			// });

			
			document.fff.submit();
		}
        
    }


	

		
	function counseling(str,str1){
		$.ajax({
            url: "counseling",
            type: "post",
            data:"tr_idx="+str+"&c_idx="+str1
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
				width:1000,
            	height:600
		});

	} 

	function sendDate(ddd){
		ddd.submit();   
	}

	function traineewrite(str1, str2){
		$.ajax({
            url: "traineewrite",
            type: "post",
            data:"tr_idx="+str1+"&c_idx="+str2
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
				width:1600,
            	height:1000
		});

	} 

	function couupload(tr,tr1,num,so){
		console.log(num);
		$.ajax({
            url: "couupload",
            type: "post",
            data:"tr_idx="+tr+"&c_idx="+tr1+"&ss_num="+num+"&so_idx="+so
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
				width:1000,
            	height:600
		});
	}



    function paging(str) {
        location.href="traincurrent?cPage="+str
     }
		
		
		
	</script>
</body>
</c:if>

</html>