<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/fullcalendar2.css"/>
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
                <header>&nbsp;&nbsp;상담관리</header>
                <div> 
                    <ul>
                        <jsp:include page="../leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right" >
                    <div id="staffWrap">
                        <div id="calendar2">

                        </div>
                    </div>
				</div>
            </div> 
        </article>
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
    <script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
    <script>
        $(".subSelect").removeClass("subSelect");
        $("#l_four").addClass("subSelect");

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

        document.addEventListener('DOMContentLoaded', function() {  
            var calendarEl = document.getElementById('calendar2');    
            var calendar = new FullCalendar.Calendar(calendarEl,{  
                monthYearFormat: 'MMMM YYYY',
                height:"98%",  
                headerToolbar:{
                    right:'today,prev,next',
                    center:'title',
                    left:'listMonth,dayGridMonth'
                },
                locale: "ko",                  
                dayMaxEventRows: 2,         
                googleCalendarApiKey: 'AIzaSyCy-89GuDIuHHF68AJMQUc_Z0A7ZUogmkE',        
         
                showNonCurrentDates:false,      
                eventSources: [           
                {             
                    googleCalendarId: "ko.south_korea#holiday@group.v.calendar.google.com",        
                    className: 'korea_holiday',             
                    color: 'white',
                    textColor:'red',           
                    editable: false,
                },           
                ],
                events:[
                {
                    title : "이력서접수기간", color : "#FF0000", textColor : "#FFFF00", start : "2024-05-02", end : "2024-05-06T10:00:00" 
                },  
                {
                    title : "학원 조기 종료", color : "#FF0000", textColor : "#FFFF00", start : "2024-02-02", end : "2024-02-06T10:00:00" 
                },
                {  title : "발길향하는 공간"  , url : "http://www.wickedmiso.com/"  , start : "2016-05-25" } 
                ],
                editable: true,
                //droppable을 사용할때 droppable true 드롭이벤트
                droppable: true,
                dateClick: function(info) { 

                    //날짜 클릭 시 발생할 이벤트

                    //info에서 console 찍어보면 편함
                    console.log(info);
                },
                eventClick: function(info) {
                    // 일정 클릭 시 발생할 이벤트
                    //클릭한 일정 Id
                    var id = info.event._def.defId;
                },
                drop: function(info) {
                //드래그 드롭 후 이벤트
                console.log(info);
                },
                select: function (info){
                    console.log(info);
                },
                eventDrop: function(info) {
                    console.log(info);
                },
                eventResize: function(info) {
                //일정 크기를 변경했을떄 이벤트
                }                
                
                
            });
            calendar.render();
        });
    </script>
</body>
</html>