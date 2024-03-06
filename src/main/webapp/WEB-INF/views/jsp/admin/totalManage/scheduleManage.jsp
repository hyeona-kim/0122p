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
                        <a href="https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/calendar.readonly&access_type=offline&include_granted_scopes=true&response_type=code&state=state_parameter_passthrough_value&redirect_uri=http://localhost:8080/schedual&client_id=1031580706945-bo0vmi9mp8dmikaj6fa2as1ff4tu7gei.apps.googleusercontent.com">클릭</a>
                    </div>
				</div>
            </div> 
            <c:if test="${code ne null}">
                <form id="acform" action="https://oauth2.googleapis.com/token" method="post"
                    enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="code" id="code" value="${code}">
                    <input type="hidden" name="client_id" id="client_id" value="1031580706945-bo0vmi9mp8dmikaj6fa2as1ff4tu7gei.apps.googleusercontent.com">
                    <input type="hidden" name="client_secret" id="client_secret" value="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">
                    <input type="hidden" name="redirect_uri" id="redirect_uri" value="http://localhost:8080/schedual">
                    <input type="hidden" name="grant_type" id="grant_type" value="authorization_code">
                </form>
            </c:if>
        </article>
    </article>
    <div id="dialog"></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
	<script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
    <script>
        let list =[];
        let access_token = '';
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
        $(function(){
            if(access_token.length >0){
                
            }
        });

        if('${code} ne null'){
            let code =$("#code").val();
            let id =$("#client_id").val();
            let pw =$("#client_secret").val();
            let uri=$("#redirect_uri").val();
            let type=$("#grant_type").val();
            $.ajax({
                url:'https://oauth2.googleapis.com/token',
                type:'post',
                data:{
                    "code":code,
                    "client_id": id,
                    "client_secret": pw,
                    "redirect_uri": uri,
                    "grant_type": type,
                 }
            }).done(function(res){
                //console.log(res.access_token);
                //location.href="https://www.googleapis.com/calendar/v3/calendars/9705f4b043bcea4005de8b1cabb6331b88539cb26aa94e220e350032009c076b@group.calendar.google.com/events?access_token="+res.access_token;
               access_token = res.access_token;
               $.ajax({
                    url:'https://www.googleapis.com/calendar/v3/calendars/9705f4b043bcea4005de8b1cabb6331b88539cb26aa94e220e350032009c076b@group.calendar.google.com/events',
                    type:'get',
                    data:'access_token='+access_token
                }).done(function(data){
                    list = data.items;
                    console.log(list);
                    let calendarEl = document.getElementById("calendar");
                    let calendar = new FullCalendar.Calendar(calendarEl,{
                        initialView:'dayGridMonth',
                        locale: "ko",                  
                        dayMaxEventRows: true,                     
                        events: [
                            list
                        ]
                    });
                    calendar.render();
                });
            });
        }
      
    </script>
</body>
</html>