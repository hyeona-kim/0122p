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
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="top">
        <div>
            <img src="${pageContext.request.contextPath }/image/top_main4.jpg"/>
        </div>
        <div>
            <div id="course_log">
                <!--반복문 띄우기 쿨릭시 함수주기.(c_idx가지는 )-->
                
            </div>
            <div id="trainee_diary">

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
            </article>
        </div>    
        <div id="menu">
            원하시는 관리메뉴를 선택해주세요 
        </div>
    </article>
    <div id="dialog" hidden></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
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
    </script>
</body>
</html>