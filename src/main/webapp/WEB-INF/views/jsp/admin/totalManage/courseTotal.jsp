<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
                <header>&nbsp;&nbsp;통합관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <article>
                            <div id="staffList_top" class="title">과정별시간표만들기</div>
                            <table id="searchCourse" class="table">
                            <caption>과정검색</caption>
                                <thead>
                                    <tr>
                                        <th>검색</th>
                                        <td>
                                            <select id="numPerPage" class="select">
                                                
                                                <option>표시개수</option>
                                                <option>5</option>
                                                <option>10</option>
                                                <option>15</option>
                                            </select>
                                            <select id="selectYear" class="select">
                                            </select>
                                        </td>
                                        <td>
                                            <select id="searchType" class="select">
                                                <option value="1">훈련강사</option>
                                                <option value="2">과정타입</option>
                                                <option value="3">과정명</option>
                                            </select>
                                            <input type="text" id="searchValue" class="text"/>
                                            <button type="button" id="search_bt" class="btn">검색</button>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                            <div id="courseLog_Table">
                                
                            </div>
                        </article>
                    </div>
				</div>
            </div> 
        </article>
    </article>
    <div id="dialog" hidden title="액셀등록"></div>
	<div id="dialog2" hidden title="주별 시간표 보기"></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let select_num="";
		let selectYear="";
		let searchType="";
		let searchValue="";
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
    $(function() {
		$(".subSelect").removeClass("subSelect");
		$("#l_one").addClass("subSelect");
        let now = new Date();	// 현재 날짜 및 시간
        let year = now.getFullYear();
        let str = "<option>년도선택</option>";
        
        for(let i=year+1; i>year-5; i--){
            str+= "<option value="+i+">"+i+"</option>";
        }
        $("#selectYear").html(str);
    

        $.ajax({
            url: "courseList",
            type: "post",
            data:"listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent('1')+"&year=&num=",
        }).done(function(result){
            $("#courseLog_Table").html(result);
        });


        
        $("#numPerPage").change(function(){
            select_num=$("#numPerPage").val();
            
            $.ajax({
                url: "courseList",
                type: "post",
                data:"listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent('1')+"&year="+selectYear+"&num="+select_num+"&select="+searchType+"&value="+searchValue
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
        });

        $("#selectYear").change(function(){
            selectYear= $("#selectYear").val();

            $.ajax({
                url: "courseList",
                type: "post",
                data:"listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent('1')+"&year="+selectYear+"&num="+select_num+"&select="+searchType+"&value="+searchValue
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
            
        });
        
        $("#search_bt").click(function(){
            searchType = $("#searchType").val();
            searchValue = $("#searchValue").val();
            $.ajax({
                url: "courseList",
                type: "post",
                data:"listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent('1')+"&year="+selectYear+"&num="+select_num+"&select="+searchType+"&value="+searchValue
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });

        });

	});
	
	function paging(cPage){
		$.ajax({
			url: "courseList",
			type: "post",
			data:"listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent(cPage)+"&year="+selectYear+"&num="+select_num+"&select="+searchType+"&value="+searchValue
		}).done(function(result){
			$("#courseLog_Table").html(result);
		});

	}
    </script>
</body>
</html>