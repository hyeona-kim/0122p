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
                <header>&nbsp;&nbsp;성적관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <article> 
                            <div id="staffList_top" class="title">"${svo.s_title} 과목 ≫ ${esvo.es_name}" 채점 리스트</div>
                            <div id="search_area" class="main_item">
                                <div class="align_left">
                                    훈련교사명: ${sfvo.sf_name}
                                </div>
                                <hr/>
                                <div class="align_right">
                                    <button type="button" class="btn" onclick="javascript:location.href='em_log?listSelect=1'">목록</button>
                                </div>
                            </div>
                            <div id="courseLog_Table">

                            </div>
                        </article>
                    </div>
				</div>
            </div> 
        </article>
    </article>
    
    <div id="dialog" hidden>
        
    </div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let cPage = "1";
        let s_idx = "${svo.s_idx}";
        let es_idx = "${esvo.es_idx}";
        let c_idx = "${svo.c_idx}";
        let listSelect = "";
        
        
        $(function() { 
            $(".subSelect").removeClass("subSelect");
            $("#l_one").addClass("subSelect");
            
           
            $.ajax({
                url: "list_ajax",
                type:"post",
                data:"c_idx="+c_idx + "&es_idx="+es_idx + "&listSelect=2",
            }).done(function(result){
                $("#courseLog_Table").html(result);

            });
        });

        function grading(idx){
            location.href = "grading?tr_idx="+idx+"&es_idx="+idx;
        }

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