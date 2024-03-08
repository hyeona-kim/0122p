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
                <header>&nbsp;&nbsp;사후관리 현황표</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="staffList_top" class="title">사후관리 현황표</div>
                        <table id="searchTime" class="table">
                            <caption>과정검색</caption>
                                <thead>
                                    <tr>
                                        <th>검색</th>
                                        <td>
                                            <select id="searchnum" class="select">
                                                <%-- 이값에따라 page.numPerPage값을 수정 해 주어야한다 --%>
                                                <option>표시개수</option>
                                                <option>5</option>
                                                <option>10</option>
                                                <option>15</option>
                                            </select>
                                            <select id="searchyear" class="select">
                                    
                                            </select>
                                        </td>
                                        <td>
                                            <select id="searchType" class="select">
                                                    <option value="1">담당교수</option>
                                                    <option value="2">과정타입</option>
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
                                <th>번호</th>
                                <th>과정명</th>
                                <th>담당교수</th>
                                <th>개강일</th>
                                <th>종료일</th>
                                <th>요일</th>
                                <th>회차</th>
                                <th>모집인원</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td colspan="10">
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
		let searchnum="";
		let searchyear="";
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
			$("#l_four").addClass("subSelect");
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let str = "<option>년도선택</option>";
			
			for(let i=year+1; i>year-5; i--){
				str+= "<option value="+i+">"+i+"</option>";
			}
			$("#searchyear").html(str);
			
			$("#searchnum").change(function(){
				searchnum = $("#searchnum").val();



				$.ajax({
					url: "ex_post",
					type:"post",
					data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1&listSelect="+listSelect,

				}).done(function(result){
					$("#result").html(result);

					
				});	
			});

			$("#searchyear").change(function(){
				searchyear = $("#searchyear").val();

				$.ajax({
					url: "ex_post",
					type:"post",
					data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1&listSelect="+listSelect,


				}).done(function(result){
					$("#result").html(result);


				});
								
			});
			$("#search").click(function(){
				searchType = $("#searchType").val();
				searchValue = $("#searchValue").val();
				if(searchType == "4"){
					location.href="trainee_name?value="+searchValue
				
				}else{
					$.ajax({
						url: "ex_post",
						type:"post",
						data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1&listSelect="+listSelect,
					}).done(function(result){
						$("#result").html(result);

					});
				}
			});
            
            $.ajax({
                url: "ex_post",
                type:"post",
                data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1&listSelect="+listSelect,
            }).done(function(result){
                $("#result").html(result);

            });

		});
		
		function paging(str) {

			$.ajax({
				url: "ex_post",
				type:"post",
				data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage="+str+"&listSelect="+listSelect,
			}).done(function(result){
				$("#result").html(result);
			});
			
		}

        function bt1(c_idx){
			location.href="current?c_idx="+c_idx+"listSelect="+listSelect;
		}
		
    </script>
</body>
</html>