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
                <header>&nbsp;&nbsp;평가관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <article>
                            <div id="staffList_top" class="title">편차 비교표</div>
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

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let searchType ="";
        let selectYear = "";
        let numPerPage = "";
        let searchValue ="";
        let cPage = "1";
	
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
        $(".subSelect").removeClass("subClass");
		$("#l_one").addClass("subSelect")
        $.ajax({
			url: "evalutationManageLog",
			type:"post",
			data:"listSelect=8&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&year="+selectYear,
		}).done(function(result){
			$("#courseLog_Table").html(result);
		});
		
		
		
		let now = new Date();	// 현재 날짜 및 시간22
		let year = now.getFullYear();
		let str = "<option>년도선택</option>";
		
		for(let i=year+1; i>year-5; i--){
			str+= "<option value="+i+">"+i+"</option>";
		}
		$("#selectYear").html(str);
		
		$("#selectYear").on("change",function(){
			selectYear = this.value;
			$.ajax({
				url: "trainingLog",
			    type:"post",
			    data:"listSelect=8&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&year="+selectYear,
			}).done(function(result){
				$("#courseLog_Table").html(result);
			});
		});
		$("#numPerPage").on("change",function(){
			numPerPage = this.value;
			$.ajax({
                url: "trainingLog",
			    type:"post",
			    data:"listSelect=8&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&year="+selectYear,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
		});
		$("#search_bt").click(function(){
            searchType = $("#searchType").val();
			searchValue = $("#searchValue").val();
			
			$.ajax({
                url: "trainingLog",
			    type:"post",
			    data:"listSelect=8&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&year="+selectYear,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
		});	
		
	});
	
	function paging(str) {
        cPage =str;
		$.ajax({
			url: "trainingLog",
			type:"post",
			data:"listSelect=8&cPage="+cPage+"&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&year="+selectYear,
		}).done(function(result){
			$("#courseLog_Table").html(result);
		});
	}
	function trainingDaily(c_idx){
		location.href="trainingDiary?c_idx="+c_idx;
	}
    </script>
</body>
</html>