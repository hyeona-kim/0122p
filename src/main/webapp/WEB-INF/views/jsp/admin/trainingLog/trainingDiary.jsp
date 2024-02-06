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
</head>
<style>
	.tr_ul{
		list-style-type: none;
		text-align: left;
	}
	.tr_li{
		display: inline-block;
		width: 80px;
	}
</style>
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
                        <article> 
                            <div id="staffList_top" class="title">"${cvo.c_name}"훈련일지</div>
                            <div id="search_area" class="main_item">
                                <div>
                                    <select id="numPerPage" class="select">						
                                        <option>표시개수</option>
                                        <option>5</option>
                                        <option>10</option>
                                        <option>15</option>
                                    </select>
                                    <select id="searchType" class="select">
                                        <option value="0">작성일</option>
                                    </select>
                                    <input type="date" id="searchValue" class="text" style="width: 10%;"/>
                                    <button type="button" id="search_bt" class="btn">검색</button>
                                </div>
                                <div class="align_right">
                                    <button type="button" class="btn" onclick="javascript:location.href='t_log?listSelect=1'">목록</button>
                                    <button type="button" class="btn blue">훈련일지 일괄출력</button>
                                    <button type="button" class="btn" id="write_btn">훈련일지 등록</button>
                                </div>
                            </div>
                            <div id="courseLog_Table">
                                <!--비동기 통신으로 가져올 내용 -->
                            </div>
                        </article>
                    </div>
				</div>
            </div> 
        </article>
    </article>
    <div id="dialog" hidden></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let searchType ="";
        let numPerPage = "";
        let searchValue ="";
        let cPage = "1";
        let c_idx = "${cvo.c_idx}"
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
        $.ajax({
            url: "diary_ajax",
            type:"post",
            data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
        }).done(function(result){
            $("#courseLog_Table").html(result);
        });

        $("#numPerPage").on("change",function(){
            numPerPage = this.value;
            $.ajax({
                url: "diary_ajax",
                type:"post",
                data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });

        });
        $("#search_bt").click(function(){
            searchType = $("#searchType").val();
            searchValue = $("#searchValue").val();
            $.ajax({
                url: "diary_ajax",
                type:"post",
                data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
            
        });	
        $("#write_btn").click(function(){
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
        });

        });

        function paging(str) {
			cPage =str;
			$.ajax({
				url: "diary_ajax",
				type:"post",
				data:"listSelect=1&cPage="+cPage+"&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
			}).done(function(result){
				$("#courseLog_Table").html(result);
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