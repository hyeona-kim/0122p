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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/fullcalendar.css"/>
</head>
<body>
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;통합관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="calendar" class="main_item align_center"></div>
                    </div>
				</div>
            </div> 
        </article>
    </article>
    <div id="dialog"></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
	<script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
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
        var events = null;
        $(function(){
            $(".subSelect").removeClass("subSelect");
            $("#l_three").addClass("subSelect");
 
        }); 
        document.addEventListener('DOMContentLoaded', function(){
            /*let calendarEl = document.getElementById("calendar");
            let calendar = new FullCalendar.Calendar(calendarEl,{
                initialView:'dayGridMonth',
                locale: "ko",                  
                dayMaxEventRows: true,        
                dayGridMonth: {
                dayMaxEventRows: 6
                },
                googleCalendarApiKey: 'AIzaSyCy-89GuDIuHHF68AJMQUc_Z0A7ZUogmkE',                  
                eventSources: [
                    {
                    googleCalendarId: 'lke829@gmail.com',  
                    className: 'g_event', 
                    color: '#159258',          
                    },          
                    { 
                    googleCalendarId :'9705f4b043bcea4005de8b1cabb6331b88539cb26aa94e220e350032009c076b@group.calendar.google.com',
                    color: 'white', 
                    textColor: 'white' , 
                    backgroundColor:'#154790'
                    },
                    // 대한민국의 공휴일                
                    {googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com", 
                    className : "koHolidays" , 
                    color : "#FF0000", 
                    textColor : "#FFFFFF"
                    }
                ],
                eventClick: function(info){
                    console.log(info.event._def.defId);
                    
                },
                dateClick: function(info){
                    console.log(info);
                },
                drop:function(info){
                    console.log(info);
                }
            });
            calendar.render();*/
            $.ajax({
                url:"calendar"
            }).done(function(result){
                console.log(result)
            });
        });

    </script>
</body>
</html>