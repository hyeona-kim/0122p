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
<style>
    .table td{
        font-size: 12px;
        font-weight: bold;
    }
    #t2{
        display: flex;
        position: relative;
        padding-top: 25px;
        height: 150px;
    }
    #t2>span{
        position: absolute;
        display: inline-block;
        top: 0; 
        color: #154790;
    }
    #t2>span:first-child{
        left: 0;
        top:29px;
        font-size: 13px;
        font-weight: bold;
    }
    #t2>span#t3{
        right: 0;
    }
    #t2>span#nowDate{
        right: 0;
        top:52px;
    }
    #t2 table#top_table{
        width: 60%;
        position: absolute;
        left: 0;
        bottom: 0;
        margin: 0;
    }
    #t2 table#top_table td,#t2 table#top_table th{
        font-size: 13px;
        padding: 2px;
    }
    #t2 table#right_table{
        width: 20%;
        position: absolute;
        right: 0;
        bottom: 0;
        margin: 0;
    }
</style>
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
                <header>&nbsp;&nbsp;사후관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">

                    <!--  여기서 표시될 테이블들 가지고오기 -->
                        <div id="staffWrap">
                            <div id="courseList_top" class="title">
                                <!--자바스크립트 -->
                                <h1>취업 현황 보고서</h1>
                            </div>
                            <div id="counselReceipt_Table">
                                <!--과정에 대한 정보 가져오기 -->
                            </div>
                        </div>
                    </div>
            </div> 
        </article>
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
        $(function(){
            $(".subSelect").removeClass("subSelect");
            $("#l_two").addClass("subSelect");
            
			$.ajax({
				url: "jobsituation",
				type: "post",
				data:"selectList=2&c_idx=&ct_idx=0&",
			}).done(function(result){
				$("#counselReceipt_Table").html(result);
			});

		});
        
    </script>
</body>
</html>