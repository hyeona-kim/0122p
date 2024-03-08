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
                <header>&nbsp;&nbsp;전체 취업생 현황</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="staffList_top" class="title">전체 취업생 현황</div>
                        <table id="searchTime" class="table">
                            <caption>과정검색</caption>
                                <thead>
                                    <tr>
                                        <th>검색</th>
                                        <td>
                                            <select id="searchType" class="select">
                                                    <option value="3">과정명</option>
                                            </select>
                                            <input type="text" id="searchValue" class="text"/>
                                            <button type="button" id="search" class="btn">검색</button>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                            <div id="result">
                    <table id="makeTime" class="table">
                    <caption>훈련현황 리스트</caption>
                        <thead>
                            <tr>
                                <th>순번</th>
                                <th>이름</th>
                                <th>취업처</th>
                                <th>과정명</th>
                                <th>연락처</th>
                                <th>주민번호</th>
                                <th>취업일</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td colspan="7">
                                    <ol class="page">
                <c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
                    <li class="disable">&lt;</li>
                </c:if>	
        
                <c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
                    <li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
                </c:if>
    
                <c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
                    <c:if test="${vs.index eq page.nowPage }">
                        <li class="now">${vs.index }</li>
                    </c:if>
                    <c:if test="${vs.index ne page.nowPage }">
                        <li><a onclick="paging('${vs.index}')">${vs.index}</a></li>
                    </c:if>
                </c:forEach>
        
                <c:if test="${page.endPage < page.totalPage }">
                    <li><a href="javascript:paging('${page.startPage + page.pagePerBlock }')">&gt;</a></li>
                </c:if>
                <c:if test="${page.endPage >= page.totalPage }">
                    <li class="disable">&gt;</li>	
                </c:if>
                                  </ol>
                              </td>
                            </tr>
                        </tfoot>
                       
                </table>
                </div>
                </div>
				</div>
            </div> 
        </article>
    </article>
	
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let searchType="1";
		let searchValue="";
        let listSelect="${listSelect}";

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
			//$().removeClass("selected");
			$(".subSelect").removeClass("subSelect");
			$("#l_six").addClass("subSelect");

		
			$("#search").click(function(){
				searchType = $("#searchType").val();
				searchValue = $("#searchValue").val();
			

					$.ajax({
						url: "current",
						type:"post",
						data:"&select="+searchType+"&value="+searchValue+"&cPage=1&listSelect="+listSelect,
					}).done(function(result){
						$("#result").html(result);

					});
				
			});
            
            $.ajax({
                url: "current",
                type:"post",
                data: "&select="+searchType+"&value="+searchValue+"&cPage=1&listSelect="+listSelect,
            }).done(function(result){
                $("#result").html(result);

            });

		});
		
		function paging(str) {

			$.ajax({
				url: "current",
				type:"post",
				data:"&select="+searchType+"&value="+searchValue+"&cPage="+str+"&listSelect="+listSelect,
			}).done(function(result){
				$("#result").html(result);
			});
			
		}


    </script>
</body>
</html>