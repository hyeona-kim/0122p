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
                            <div id="staffList_top" class="title">"${svo.s_title}"과목별 채점결과보기</div>
                            <div id="search_area" class="main_item">
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
                data:"listSelect=4&cPage=1&num="+numPerPage+"&s_idx="+s_idx,
            }).done(function(result){
                console.log("s_idx="+s_idx);
                $("#courseLog_Table").html(result);
                
            });
            
            
        });

        function chcekTraineeScoreList(idx){
            location.href = "chcekTraineeScoreList?s_idx="+s_idx+"&es_idx="+idx;
        }
        
     

     
      

    </script>
</body>
</html>