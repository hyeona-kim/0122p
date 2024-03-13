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
                <header>&nbsp;&nbsp;기타관리</header>
                <div> 
                    <ul>
                        <jsp:include page="../leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
					<div id="staffWrap">
                        <div id="bookList" style="margin-top: 20px;">
                            
                        </div>
                    </div>
                </div>
            </div> 
        </article>
    </article>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>

        $(function(){
            $(".subSelect").removeClass("subSelect");
			$("#l_five").addClass("subSelect");

			// 처음 메인 페이지로 왔을때
			// 비동기식 통신을 이용해 전체목록을 출력한다
			$.ajax({
				url: "bookList_ajax",
				type: "post",
			}).done(function(result) {
				$("#bookList").html(result);
			});

        });

        function paging(cPage) {
			$.ajax({
				url: "bookList_ajax",
				type: "post",
				data: "cPage="+cPage
			}).done(function(result){
				$("#bookList").html(result);
			});
		};
    </script>
</body>
</html>