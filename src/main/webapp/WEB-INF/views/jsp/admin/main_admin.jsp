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
		background-color: #154790;
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
    </script>
</body>
</html>