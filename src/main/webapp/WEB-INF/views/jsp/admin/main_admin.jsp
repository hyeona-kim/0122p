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
                <div id="time"></div>
                <div id="day"></div>
                <div style="border-bottom:1px solid white;"></div>
                <div>
                    <select class="select" id="day_select">
                        <option>오늘</option>
                        <option>일주일</option>
                        <option>한달</option>
                    </select>
                    <article>
                        <div class="content">문의 :(0)건</div>
                        <div class="content">상담 :(0)건</div>
                        <div class="content">등록 :(0)건</div>
                        <div class="content">결재 총액:(0)₩</div>
                    </article>
                </div>
            </div>
            <div>
                <div>훈련일지 결재</div>
                <select class="select" id="dialy_select">
                    <option>미결재</option>
                    <option>결재</option>
                    <option>전체</option>
                </select>
            </div>
        </div>
        <div id="calendar_wrap">
            <div class="title">&nbsp;&nbsp;&nbsp;&nbsp;일정관리</div>
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
   
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
	<script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
    <script>
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
            dayMaxEventRows: true,         
            googleCalendarApiKey: 'AIzaSyCy-89GuDIuHHF68AJMQUc_Z0A7ZUogmkE',        
            buttonsStyling: false,    
            showNonCurrentDates:false,      
            eventSources: [  
                {
                    googleCalendarId: 'lke829@naver.com',             
                    className: 'ict',             
                    color: 'red',
                },           
                {
                    googleCalendarId : '9705f4b043bcea4005de8b1cabb6331b88539cb26aa94e220e350032009c076b@group.calendar.google.com',              
                    textColor: 'red',
                    color:"#ababab", 
                },
                {
                    googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com', 
                    color: '#ababab',             
                    textColor: 'black' , 
                }
            ],
        });
        calendar.render();
        let ar = $(".fc-daygrid-day-number");
        for(let i=0; i<ar.length;i++){
            ar[i].innerHTML= i+1;
        }
        $(".fc-daygrid-day-number").css("color","#ababab");
        $(".fc-daygrid-day-frame").css("background-color","#fff");
        $(".fc-daygrid-day-frame").css("border","1px solid #ababab");

        $(".fc-button").click(function(){
            console.log($(".fc-daygrid-day-number").length)
            let ar = $(".fc-daygrid-day-number");
            for(let i=0; i<ar.length;i++){
                ar[i].innerHTML= i+1;
            }
            $(".fc-daygrid-day-number").css("color","#ababab");
            $(".fc-daygrid-day-frame").css("border","1px solid #ababab");
            $(".fc-daygrid-day-frame").css("background-color","#fff");
        });
        var week = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        
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
                hours = "오후"+a_hours;
            }
            var minutes = date.getMinutes();
            minutes = (minutes < 10)?"0"+minutes: minutes;

            var seconds = date.getSeconds();
            seconds=(seconds < 10)?"0"+seconds:seconds;
            $("#day").html(years+"-"+month+"-"+ clockDate+"  "+(week[day]));
            $("#time").html(hours+"시"+minutes+"분"+seconds+"초");
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
    </script>
</body>
</html>