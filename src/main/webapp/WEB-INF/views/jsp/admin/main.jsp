<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main.css"/>
</head>
<body>
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="top">
        <div>
            <img src="${pageContext.request.contextPath }/image/top_main4.jpg"/>
        </div>
        <div>
            <div id="course_log">
                <!--반복문 띄우기 쿨릭시 함수주기.(c_idx가지는 )-->
                
            </div>
            <div>

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
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
      
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
            location.href="trainingDiary?c_idx="+c_idx;
            //
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
    </script>
</body>
</html>