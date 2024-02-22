<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
    <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>

    <article class="top">
        <div>
            <div>
                <img src="${pageContext.request.contextPath }/image/banner1.png" alt="1"/>
                <img src="${pageContext.request.contextPath }/image/banner2.png" alt="2"/>
                <img src="${pageContext.request.contextPath }/image/banner3.png" alt="3"/>
                <img src="${pageContext.request.contextPath }/image/banner4.jpg" alt="4"/>
                <img src="${pageContext.request.contextPath }/image/banner5.jpg" alt="5"/>
            </div>
        </div>
        <div id="calendar_wrap">
            <div class="title">&nbsp;&nbsp;&nbsp;&nbsp;일정관리</div>
            <div class="calendar">

            </div>
        </div>
    </article>
    <article class="staff">
        <div>
            <div class="title">관리메뉴</div>
            <article>
                <div class="select" id="1">교직원 관리</div>
                <div class="select" id="2">입학상담관리</div>
                <div class="select" id="3">사후관리</div>
                <div class="select" id="4">전체메뉴보기</div>
            </article>
        </div>    
        <div id="menu">
            <div class="first">
                <span>원하시는 관리메뉴를 선택해주세요 </span>
            </div>
        </div>
    </article>
    <%-- ========== 교직원 등록,수정 폼 시작 ========== --%>
    <div id="addForm" type="hidden">
        
    </div>
    <%-- ========== 교직원 등록,수정 폼 끝 ========== --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let i = '${sessionScope.vo.sf_idx}';
        let t = '${sessionScope.vo.sf_tmgr}';
        let m = '${sessionScope.vo.sf_mgr}'; 
        $(function(){
           

            $(".select").click(function(){
                $(".selected").removeClass("selected");
                $(this).addClass("selected");
                let select = $(this).attr('id');
                if(select == "1"){
                    $.ajax({
                        url :"staffList",
                        type:"post",
                        data:"main=admin&cPage=1"
                    }).done(function(res){
                        $("#menu").html(res);
                    });
                }else if(select =="2"){
                    $("#menu").html("입학상담관리");
                }else if( select =="3"){
                    $("#menu").html("사후관리");
                }else if( select =="4"){
                    $.ajax({
                        url :"staffList",
                        type:"post",
                        data:"main=admin"
                    }).done(function(res){
                        $("#menu").html(res);
                    });

                }
            });
        });
        function paging(cPage){
            $.ajax({
                url :"staffList",
                type:"post",
                data:"main=admin&cPage="+cPage
            }).done(function(res){
                $("#menu").html(res);
            });
        }
        function unblockStaff(idx) {
			if(confirm("해제하시겠습니까?")){
				location.href="unblockStaff?sf_idx="+idx+"&main=ok";
			}else{
				return false;
			};
		};
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
					data: "sf_idx="+idx + "&place=1"
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
            for(let i=0 ; i<ar.length-10; i++){
                console.log(ar[10+i].value);
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
            for(let i=9 ; i<ar.length-6; i++){
                if(ar[i].value.trim().length != '4'){
                    alert(ar[i].dataset.str+"을 입력하세요");
                    ar[i].focus();
                    return; // 수행 중단
                };
            };

            if(t == '1' && ar[11].value == '3' && idx != i){
                if(confirm("권한을 이전하시겠습니까?(이전 시 로그아웃 됩니다)")){
                    document.forms[0].submit();
                } else {
                    return false;
                }
            } else {
                if(confirm("수정 하시겠습니까?")){
                    document.forms[0].submit();
                } else {
                    return false;
                }
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
    </script>
</body>
</html>