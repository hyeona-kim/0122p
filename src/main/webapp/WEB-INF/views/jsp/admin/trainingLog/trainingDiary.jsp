<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        let value = 0;
        let change = true;
        let count = 0;
        let nowValue = 0;
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
                value = $("#attend").val();
                cnt = 4; // 시작값 4
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

        function setCount(num, i){
            let val = $(".chk" + i + ":checked").length; // 클래스가 같은값들은 같은사람
            console.log(nowValue + "/" + (value - count));
            if(val > 1 && nowValue != (value - count))
                change = false;
            else{
                console.log(1);
                change = true;
            }
            
            if(num == null || num.length < 1){
                return;
            }
            if(num == 1){
                count = $("input:checkbox[name=chk1]:checked").length;
                $("#absence").val(count);
                if(change == true)
                    nowValue = $("#attend").val(value - count);
            }
            if(num == 2){
                count = $("input:checkbox[name=chk2]:checked").length;
                $("#tardy").val(count);
                if(change == true)
                    nowValue = $("#attend").val(value - count);
            }
            if(num == 3){
                count = $("input:checkbox[name=chk3]:checked").length;
                $("#earlyLeave").val(count);
                if(change == true)
                    nowValue = $("#attend").val(value - count);
            }
        }
        
        function addList(){

            var row = "<tr>";
                row += "<td><input type='text' value=";
                row += ++cnt; 
                row += " class='text'/></td>";
                row += "<td><input type='text' class='text'/></td>";
                row += "<td><input type='text' class='text'/></td>";
                row += "<td><input type='text' class='text'/></td>";
                row += "</tr>";
               

	        $('#diaryTable').append(row); // 동적으로 row를 추가한다.

        }
    </script>
</body>
</html>