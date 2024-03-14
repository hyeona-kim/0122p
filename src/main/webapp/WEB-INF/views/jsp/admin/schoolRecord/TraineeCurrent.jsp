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
                <header>&nbsp;&nbsp;학적부</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="staffList_top" class="title">훈련생 현황</div>
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
                                                    <option value="4">훈련생명</option>
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
                        <tbody>
            
                            <c:forEach var="vo2" items="${requestScope.ar }" varStatus="vs">
                    <c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
                        <tr>
                            <td>${num-(vs.index)}</td>
                            <td>${vo2.c_name}</td>
                            <%-- 강사 코드에따른 강사를 가져오는 Bean을 만든다 --%>
                            <td>${vo2.svo.sf_name}</td>
                            <td>${vo2.start_date }</td>
                            <td>${vo2.end_date }</td>
                            <td>${vo2.c_day}</td>
                            <td>${vo2.c_round_num }</td>
                            <td>${vo2.c_peo_num}</td>
                            <td>
                                <input type="button" onclick="bt1('${vo2.c_idx}')" value="과정별 훈련생 현황" class="btn">
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
                </div>
				</div>
            </div> 
        </article>
    </article>
    <form action="traineecurrentbt1" method="post" name="fff">
		<input type="hidden" name="type" value=""/>
		<input type="hidden" name="c_idx" value=""/>
		<input type="hidden" name="cPage" value="${param.cPage}"/>
	</form>
	
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let searchType="1";
		let searchValue="";
		let searchnum="";
		let searchyear="";
        let ar_length = '${param.ar_length}'
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
            if(ar_length == 'null'){
                alert("해당과정에 훈련생이 존재하지 않습니다.")
            }
			$(".subSelect").removeClass("subSelect");
			$("#l_two").addClass("subSelect");
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let str = "<option>년도선택</option>";
			
			for(let i=year+1; i>year-5; i--){
				str+= "<option value="+i+">"+i+"</option>";
			}
			$("#searchyear").html(str);
			
			$("#searchnum").change(function(){
				searchnum = $("#searchnum").val();
				console.log(searchnum);


				$.ajax({
					url: "tcsearch",
					type:"post",
					data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",

				}).done(function(result){
					$("#result").html(result);

					
				});	
			});

			$("#searchyear").change(function(){
				searchyear = $("#searchyear").val();

				$.ajax({
					url: "tcsearch",
					type:"post",
					data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",


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
						url: "tcsearch",
						type:"post",
						data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",
					}).done(function(result){
						$("#result").html(result);

					});
				}
			});

		});
		
		function paging(str) {

			$.ajax({
				url: "tcsearch",
				type:"post",
				data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage="+str,
			}).done(function(result){
				$("#result").html(result);
			});
			
		}

		function bt1(c_idx){
			//console.log(c_idx);
			document.fff.type.value="traineecurrentbt1";
			document.fff.c_idx.value=c_idx;
			//console.log(document.fff.type.value);
			document.fff.submit();

		}
		
    </script>
</body>
</html>