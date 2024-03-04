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
                
            });
        }

        $("#dialog3").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });

        function addSelect(idx){
            let str = $('#selectExam'+idx).html();
            let id = "idx"+idx;
            let i =  $("input[name='"+id+"']").last().val();
            let str2 = "</br><input type='text' value='" + ++i + "' class='text' style='width: 10%' name='" + id + "' readonly />"
            + "<input type='text' name='qt_select" + idx + "' value='' class='text' style='width: 70%'  placeholder='객관식 문항" + i + "'/>"
            $("#selectExam"+idx).html(str + str2);
        }

        function addExam(idx, t, score, num){
            let v = 0;
            let id = "qt_score";
            for(let i=0;i < num; i++){
                v += Number($("input[name='"+ id +"']").eq(i).val()); // ... 정수로 변환해서 계산...
                console.log(v);
            }
            if(score != v){
                alert("총점:" + score + " 배분값:" + v);
                alert("총점보다 값이 크거나 작습니다. 점수를 다시 배분해주세요!");
                return ;
            }
            if(t == "2"){ // 객관식이 있을 경우에만 병합 실행

                id = "qt_select";
                let box = $("#box").html();
                let k ="";
                for(let i=1; i<=idx; i++ ){
                    let a = "";
                    for(let j = 0;j < $("input[name='" + id + i + "']").length;){
                        a += $("input[name='" + id + i + "']").eq(j).val();
                        if(++j < $("input[name='" + id + i + "']").length){
                            a += "│"; // 객관식 문항을 구분하기 위한 구분자이므로 잘 쓰지않는 특수기호를 골라서 사용함
                        }
                    }
                    k += "<input type='hidden' value='" + a + "' name='qt_select' />";
                }
                $("#box").html(box + k);
            } // 주관식 및 서술형의 경우 즉시 이부분으로 옴
                $("#frm").submit();
            }

    

    </script>
</body>
</html>