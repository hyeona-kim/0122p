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
                            <div id="staffList_top" class="title">"${svo.s_title}"평가별 시험출제정보</div>
                            <div id="search_area" class="main_item">
                                <h2>능력 단위명 : ${svo.s_title} 훈련교사 : ${svo.sf_name} </h2>
                                <hr/>
                                <div class="align_right">
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
        let es_idx = "${esvo.es_idx}";
        let type = "";
        let cnt = "";
        let cnt2 = "";

        $(function() { 
            $(".subSelect").removeClass("subSelect");
            $("#l_one").addClass("subSelect");
            
           
            $.ajax({
                url: "diary_ajax3",
                type:"post",
                data:"listSelect=2&cPage=1&num="+numPerPage+"&s_idx="+s_idx+"&es_idx="+es_idx,
            }).done(function(result){
                console.log("s_idx="+s_idx);
                $("#courseLog_Table").html(result);
                
            });
            
            
            
            
        });
        
      function addEvidence(){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2",
                type:"post",
                data:"listSelect=1",
            }).done(function(result){
                $("#dialog").html(result);
             
            });
        }

        $("#dialog").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });

        function viewExam(es_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2",
                type:"post",
                data:"listSelect=2&es_idx="+es_idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#dialog").html(result);
             
            });
        }

        $("#dialog2").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });

        function examFill(es_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2",
                type:"post",
                data:"listSelect=3&es_idx="+es_idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#dialog").html(result);

                cnt = $("#idx").val();
                cnt2 = 0;
                
            });
        }

        $("#dialog3").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });

        function addExamFill() {
            let str = $("#examFill_tbody").html();
            let str2="<tr><th rowspan='6'><label><input type='text' name='' class='text'/></label></th>"+
            "</tr><tr><td><input type='text' name='' placeholder='문항' class='text'/>"+
                "</td></tr><tr><td><textarea cols='80' rows='4' placeholder='문제 내용' class='textarea'></textarea>"+
                "</td></tr><tr><td id='selectExam"+ ++cnt2 +"'>"+
                    "<input type='text' value="+ ++cnt +" id='idx"+ cnt +"' readonly class='text' style='width: 10%;'/>"+
                    "<input type='text' name='' value='' class='text' style='width: 70%'/>"+
                "</td></tr><tr><td><input type='button' value='추가' onclick='addSelect()' class='btn'>"+
                "</td></tr><tr><td> 정답 : <input type='text' class='text'/>"+
                "</td></tr>";
            $("#examFill_tbody").html(str+str2);
        }

        function addSelect(){
            let str3 = ++cnt2;
            let str = $('#selectExam'+str3).html();
            let str2 = "</br><input type='text' value="+ ++cnt + " readonly class='text' style='width: 10%;'/>"+
            "<input type='text' name='' value='' class='text' style='width: 70%'/>"
            $("#selectExam"+str3).html(str + str2);
        }


    

    </script>
</body>
</html>