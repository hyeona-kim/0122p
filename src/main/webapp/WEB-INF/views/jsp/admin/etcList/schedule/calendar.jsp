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
                        <div id="calendar2" class="main_item">

                        </div>
                    </div>
				</div>
            </div> 
        </article>
    </article>
    <div id="dialog2" class="main_item align_center" hidden>
        <br/>
        <input type="button" value="수정" class="btn" onclick="edit()"/>
        <input type="button" value="삭제" class="btn red2" onclick="del()"/>
    </div>
    <div id="dialog" hidden>
        <div class="title" id="dialogTitle">일정추가</div>
        <table class="table">
        <colgroup>
            <col width="20%"/>
            <col width="80%"/>
        </colgroup>
            <tbody>
                <tr>
                    <th>일정명</th>
                    <td><input type="text" name="title" class="text" id="title"/></td>
                </tr>
                <tr>
                    <th>시간</th>
                    <td id="addStr">
                        <input type="date" class="text" id="startdate" style="width: 30%;"/>~
                        <input type="date" class="text" id="enddate" style="width: 30%;"/>
                        <input type="button" value="시간추가" class="btn" onclick="timeAdd()"/>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="2">
                        <input type="button" value="추가" class="btn" id="write_btn"/>
                        <input type="button" value="수정" class="btn" id="update_btn" hidden/>
                        <input type="button" value="취소" class="btn" onclick="cancle()" />
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
    <script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
    <script>
        let i = 0;
        let clickInfo ;
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
        let events_ar = [];
        let calendarEl =null;
        let calendar = null;
        
        document.addEventListener('DOMContentLoaded', function() {  
            $.ajax({
                url :"http://localhost:5000/list",
                type:"get",
                dataType:"json"
            }).done(function(data){
                //console.log(data);
                ar = data;
                for(let i=0; i<ar.length; i++){
                    if(ar[i].status == 0){
                        events_ar.push(ar[i])
                    }
                }
                calendarEl = document.getElementById('calendar2');    
                calendar = new FullCalendar.Calendar(calendarEl,{  
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
                    color: '#dedede',
                    textColor:'red',           
                },                   
                ],
                events: events_ar,
                editable: true,
                //droppable을 사용할때 droppable true 드롭이벤트
                droppable: true,
                dateClick: function(info) { 
                    //날짜 클릭 시 발생할 이벤트
                    //info에서 console 찍어보면 편함
                    //console.log(info.dateStr);
                    $("#startdate").val(info.dateStr);
                    $("#enddate").val(info.dateStr);
                    if(confirm("일정을 추가하시겠습니까?")){
                        $("#write_btn").attr("hidden",false);
                        $("#update_btn").attr("hidden",true);
                        $("#dialogTitle").html("일정 등록");
                        $("#dialog").dialog({
                            width: 500,
                            modal: true,
                        });
                        clickInfo = info;
                    }
                },
                eventClick: function(info) {
                    // 일정 클릭 시 발생할 이벤트
                    //클릭한 일정 Id
                    clickInfo =info
                    $("#dialog2").dialog({
                        modal: true,
                        height:150,
                    });
                },
                eventDrop: function(info) {
                    if(confirm("일정을 수정하시겠습니까?")){
                        $("#dialogTitle").html("일정 수정");
                        $("#dialog").dialog({
                            width: 500,
                            modal: true,
                        });
                        $("#startdate").val(info.event.startStr.substring(0,10));
                        $("#enddate").val(info.event.endStr.substring(0,10));
                        $("#title").val(info.event._def.title);
                    }else{
                        location.reload(true);
                    }
                },      
                });
            calendar.render();
            });  
        });
        $(function(){
            $("#write_btn").click(function(){
                console.log("write")
                let title =$("#title").val();
                let startdate= $("#startdate").val();
                let enddate = $("#enddate").val();
                console.log(title+"/"+startdate+"/"+enddate);
                
                $.ajax({
                    url :"http://localhost:5000/write?title="+title+"&startdate="+startdate+"&enddate="+enddate,
                    type:"get",
                    dataType:"json"
                }).done(function(data){
                    
                });
                location.reload(true);
            });
            $("#update_btn").click(function(){

                let title =$("#title").val();
                let startdate= $("#startdate").val();
                let enddate = $("#enddate").val();
                console.log(title+"/"+startdate+"/"+enddate);
                
                $.ajax({
                    url :"http://localhost:5000/update?title="+title+"&startdate="+startdate+"&enddate="+enddate+"&id="+clickInfo.event._def.extendedProps.pyid,
                    type:"get",
                    dataType:"json"
                }).done(function(data){
                    console.log(data);
                });
                location.reload(true);
            });
        });
        function timeAdd(){ 
            let str = $("#startdate").val();

            $("#addStr").html(change2());
            $("#startdate").val(str);
          
        }

        function change2(){
            let str = "<input type='date' class='text' id='startdate' style='width: 30%;'/>"+
            "&nbsp;<input type='time' class='text' style='width: 25%;'/>~<input type='time' class='text' style='width: 25%;'/><br/>"+
            "종일<input type='checkbox' onchange='change()'/>"
            return str;
        }
        function change3(){
            let str = "<input type='date' class='text' id='startdate' style='width: 30%;'/>"+
            "~<input type='date' class='text' style='width: 30%;' id='enddate'/><br/>"+
            "종일<input type='checkbox' onchange='change()' checked/>"
            return str;
        }
        function change(){
            let str = $("#startdate").val();
            if( i%2 ==0){
                $("#addStr").html(change3());
                $("#startdate").val(str);
                $("#enddate").val(str);
            }else{
                $("#addStr").html(change2());
                $("#startdate").val(str);
            }
            i++;
        }
        function edit(){
            $("#write_btn").attr("hidden",true);
            $("#update_btn").attr("hidden",false);
            $("#dialogTitle").html("일정 수정");
            $("#dialog").dialog({
                width: 500,
                modal: true,
            });
            
            $("#startdate").val(clickInfo.event.startStr.substring(0,10));
            $("#enddate").val(clickInfo.event.endStr.substring(0,10));
            $("#title").val(clickInfo.event._def.title);
        }
        function del(){
            console.log(clickInfo.event._def.extendedProps.pyid);
            if(confirm("정말 삭제하시겠습니까?")){
                $.ajax({
                    url :"http://localhost:5000/del?id="+clickInfo.event._def.extendedProps.pyid,
                    type:"get",
                    dataType:"json"
                }).done(function(data){
                    console.log(data);
                });
                location.reload(true);
            }
        }
        function cancle(){
           $("#dialog").dialog("close");
           location.reload(true);
        }
    </script>
</body>
</html>