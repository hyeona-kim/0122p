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
</head>
<body>
    <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
    <article class="top">
        <div>
            <div>
                <img src="${pageContext.request.contextPath }/image/banner1.png" />
                <img src="${pageContext.request.contextPath }/image/banner2.png"/>
                <img src="${pageContext.request.contextPath }/image/banner3.png"/>
                <img src="${pageContext.request.contextPath }/image/banner4.jpg"/>
                <img src="${pageContext.request.contextPath }/image/banner5.jpg"/>
            </div>
        </div>
        <div>
            <div id="course_log">
                <!--반복문 띄우기 쿨릭시 함수주기.(c_idx가지는 )-->
                
            </div>
            <div id="trainee_diary">

            </div>
        </div>
    </article>
    <article class="list">
        <div>
            <div  onclick="list(1)">
                <div id="school">학적부<br/>관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main1.png"/></div>
            </div>
        </div>
        <div>
            <div onclick="list(2)">
                <div  >통합관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main2.png"/></div>
            </div>
        </div>
        <div>
            <div  onclick="list(3)">
                <div >평가관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main3.png"/></div>
            </div>
        </div>
        <div>
            <div onclick="list(4)">
                <div  id="school">상담 및 <br/>접수</div>
                <div> <img src="${pageContext.request.contextPath }/image/main4.png"/></div>
            </div>
        </div>
        <div>
            <div  onclick="list(5)">
                <div >상담관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main5.png"/></div>
            </div>
        </div>
    </article>
    <div id="dialog" hidden></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
       
        let c_idx = "${cvo.c_idx}"
        $(function(){	
            $.ajax({
                url:"main_course",
                type:"post",
            }).done(function(result){
                $("#course_log").html(result);
            });
        });

        function list(num){
            // 메뉴 클릭시 해당 메뉴로 이동한다.
            if(num=="1"){
                location.href="menu?select=schoolRecord";
            }else if(num =="2"){
                location.href="menu?select=totalManage";
            }else if(num =="3"){
                location.href="menu?select=trainingLog";
            }else if(num =="4"){
                location.href="menu?select=counselReceipt";
            }else if(num =="5"){
                location.href="menu?select=counselManage";
            }
        
        }
        function course_log(c_idx){

            console.log(c_idx);
            //location.href="trainingDiary?c_idx="+c_idx;

            $.ajax({
                url:"main_trainingdiary",
                type:"post",
                data: "c_idx="+c_idx,
            }).done(function(result){
                $("#trainee_diary").html(result);
            });

        }
        function paging(nowPage){
            $.ajax({
                url:"main_course",
                type:"post",
                data:"cPage="+nowPage,
            }).done(function(result){
                $("#course_log").html(result);
            });
        }
        function write_btn(c_idx){
            console.log(1+c_idx);
            $("#dialog").dialog("open");
            // /tl_dialog
            $.ajax({
                url: "tl_dialog",
                type:"post",
                data:"c_idx="+c_idx,
            }).done(function(result){
                $("#dialog").html(result);
                $("#cc_cancle").click(function(){
                    $("#dialog").dialog("close");
                });
            });
        }
        $("#dialog").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });
    </script>
</body>
</html>