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
                            <div id="staffList_top" class="title">"${svo.s_title}"평가기본정보</div>
                            <div id="search_area" class="main_item">
                                <div class="align_right">
                                    <button id="add_btn" type="button" class="btn" onclick="">평가기본정보등록</button>
                                    <button type="button" class="btn" onclick="javascript:location.href='em_log?listSelect=1'">목록</button>
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
    <div id="dialog2" hidden></div>
    <div id="dialog3" hidden></div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let searchType ="";
        let numPerPage = "";
        let searchValue ="";
        let cPage = "1";
        let s_idx = "${svo.s_idx}"
        let value = 0;
        let change = true;
        let count = 0;
        let nowValue = 0;
        let es_idx = "";
        let type = "";
        
        
        $(function() { 
            $(".subSelect").removeClass("subSelect");
            $("#l_one").addClass("subSelect");
            
           
            $.ajax({
                url: "diary_ajax3",
                type:"post",
                data:"listSelect=1&cPage=1&num="+numPerPage+"&s_idx="+s_idx,
            }).done(function(result){
                console.log("s_idx="+s_idx);
                $("#courseLog_Table").html(result);
                
            });
            
            
            $("#add_btn").click(function(){
                $("#dialog").dialog("open");
                $.ajax({
                    url: "es_dialog",
                    type:"post",
                    data: "s_idx="+s_idx,
                }).done(function(result){
                    $("#dialog").html(result);
                    $("#cc_cancle").click(function(){
                        $("#dialog").dialog("close");
                    });
                    value = $("#attend").val();
                    cnt = 4; // 시작값 4
                    $("#selectType").on("change", function(){
                        type = $("#selectType").val();
                        console.log("value="+type);
                        switch(type){
                            case '1' :{
                                $("#selectType1").show();
                                $("#selectType2").hide();
                                break;
                            }
                            case '2' :{
                                $("#selectType1").hide();
                                $("#selectType2").show();
                                break;
                            }
                
                        }
                    });
                
                
                    $("#q1, #q2, #q3").change(function() {
                        console.log("type+"+type);
                        // 필답형과 단답형 값이 변경될 때마다 합산하여 총 문항수 필드에 넣기
                        if(type == "1"){
                            $('#totalQuestions').val($("#q1").val());
                        }
                        else{
                            $('#q2, #q3').on('input', function() {
                                var q2Value = parseInt($('#q2').val()); // 필답형 값
                                var q3Value = parseInt($('#q3').val()); // 단답형 값
                                var totalQuestions = q2Value + "/" + q3Value; // 두 값을 합산
                                $('#totalQuestions').val(totalQuestions); // 합산된 값을 총 문항수 필드에 넣기
                                console.log($('#totalQuestions').val());
                            });
                        }
                    });
                });
            });
            
            
        });
        
      function editEI(idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog",
                type:"post",
                data:"es_idx="+idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#dialog").html(result);
                $("#cc_cancle").click(function(){
                    $("#dialog").dialog("close");
                });
                type = $("#selectType").val();
                if(type == '1')
                    $('#totalQuestions').val($("#q1").val());
                else
                    $("#totalQuestions").val($('#q2').val() + "/" + $('#q3').val());
                console.log($("#totalQuestions").val());
                $("#selectType").on("change", function(){
                    type = $("#selectType").val();
                    switch(type){
                        case "1" :{
                            $("#selectType1").show();
                            $("#selectType2").hide();
                            break;
                        }
                        case "2" :{
                            $("#selectType1").hide();
                            $("#selectType2").show();
                            break;
                        }
            
                    }
                });
                $("#q1, #q2, #q3").change(function() {
                        console.log("type+"+type);
                        // 필답형과 단답형 값이 변경될 때마다 합산하여 총 문항수 필드에 넣기
                        if(type == "1"){
                            $('#totalQuestions').val($("#q1").val());
                        }
                        else{
                            $('#totalQuestions').val( $('#q2').val() + "/" + $('#q3').val()); // 합산된 값을 총 문항수 필드에 넣기
                            console.log($('#totalQuestions').val());

                        }
                    });
            });
        }

        $("#dialog").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });

        function delEs(es_idx){
            
			if( confirm("삭제하시겠습니까?")){
			
                location.href = "delEvaluationStatus?es_idx="+es_idx+"&s_idx="+s_idx;
			}else{
                return;
            }
		}

    </script>
</body>
</html>