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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/fullcalendar.css"/>
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
            <!-- 
                전체적인 관리 페이지 ( view용 )
                오늘날짜 O
                최근문의 
                지원자수 (결재금액)
                공지사항 
            -->
            <div>
                <div id="today">TODAY</div>
                <div>
                    <div id="time"></div>
                    <div id="day"></div>
                    <select class="select" id="day_select">
                        <option value="0">오늘</option>
                        <option value="1">일주일</option>
                        <option value="2">한달</option>
                    </select>
                    <article>
                        <table>
                            <caption>접수내역</caption>
                            <colgroup>
                                <col width="33.3%"/>
                                <col width="33.3%"/>
                                <col width="33.3%"/>
                            </colgroup>
                            <tr>
                                <th>문의</th>
                                <th>상담</th>
                                <th>등록</th>
                            </tr>
                            <tr>
                                <td>(0)건</td>
                                <td>(0)건</td>
                                <td>(0)건</td>
                            </tr>
                            <tr>
                                <th colspan="3">결제 총액 (0)원</th>
                            </tr>
                        </table>
                    </article>
                </div>
            </div>
            <div>
                <div id="today">훈련일지 결재</div>
                <div>
                    <article>
                        <select class="select" id="daily_select">
                            <option value="0">미결재</option>
                            <option value="1">결재</option>
                            <option value="2">전체</option>
                        </select>     
                    </article>
                </div>
            </div>
        </div>
        <div id="calendar_wrap">
            <span>
                <a href="calendar">일정관리</a>
            </span>
            <div class="calendar" id="calendar">

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
    <script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
	<script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
    <script>
        let f = "";
        let i = '${sessionScope.vo.sf_idx}';
        let t = '${sessionScope.vo.sf_tmgr}';
        let m = '${sessionScope.vo.sf_mgr}'; 

    document.addEventListener('DOMContentLoaded', function() {   
        init();    
        var calendarEl = document.getElementById('calendar');       
        var calendar = new FullCalendar.Calendar(calendarEl,{    
            headerToolbar:{
                right:'prev,next',
                center:'title',
                left:'today'
            },
            locale: "ko",                  
            dayMaxEventRows: 0,         
            googleCalendarApiKey: 'AIzaSyCy-89GuDIuHHF68AJMQUc_Z0A7ZUogmkE',        
     
            showNonCurrentDates:false,      
            eventSources: [           
            {             
                googleCalendarId: "ko.south_korea#holiday@group.v.calendar.google.com",        
                className: 'korea_holiday',             
                color: 'white',
                textColor:'red',           
            },           
            ],
            events:[
            {
                title : "빨강색 배경 & 글자색 노랑색", color : "#FF0000", textColor : "#FFFF00", start : "2024-05-02", end : "2024-05-06T10:00:00" 
            }
            
            ]
            
        });
        calendar.render();
       
        
    });
        function clock() {
            var date = new Date();
            var years = date.getFullYear();
            var month = Number(date.getMonth())+1;
            month = (month<10)?"0"+month:month;
            var clockDate = date.getDate();
            var day = date.getDay();
            var week = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            var hours = date.getHours();
            hours = (hours < 10)? "0"+hours:hours;
            var a_hours = hours-12;
            if(a_hours>0){
                hours = "PM "+a_hours;
            }else{
                hours = "AM "+ hours;
            }

            
            var minutes = date.getMinutes();
            minutes = (minutes < 10)?"0"+minutes: minutes;

            var seconds = date.getSeconds();
            seconds=(seconds < 10)?"0"+seconds:seconds;
            $("#day").html(years+"-"+month+"-"+ clockDate+"  "+(week[day]));
            $("#time").html(hours+":"+minutes+":"+seconds+"");
        }
        function init() {
            clock();
            setInterval(clock, 1000);
        }

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
            $("#day_select").change(function(){
                console.log("날짜가 바뀌는 영역"+this.value)
                ///////////////////////////수정 예정
            });
            $("#daily_select").change(function(){
                console.log("결재 미결재 내용 "+this.value)
                ///////////////////////////수정 예정
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
					alert("파일이 저장되었습니다.");
					$("#certi_sign").hide();
				});
			}
			
		}
    </script>
</body>
</html>