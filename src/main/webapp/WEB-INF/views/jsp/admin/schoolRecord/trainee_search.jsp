<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<style>
table tfoot ol.page {
	    list-style:none;
	    width: 300px;
	    margin: auto;
	}
	
	table tfoot ol.page li {
	    float:left;
	    margin-right:8px;
	}
	
	table tfoot ol.page li a {
	    display:block;
	    padding:3px 7px;
	    color:gray;
	    font-weight:bold;
	    text-decoration: none;
	}
	
	table tfoot ol.page li a:hover {
		color:black;
	    font-weight:bold;
	}
	.disable {
	    padding:3px 7px;
	    color:white;
	}
	
	.now {
	   padding:3px 7px;
	    color:#46ade1;
	    font-weight:bold;
	}
	#staffWrap{
		width: 95%;
		margin: auto;
		margin-top: 20px;
	}
	#staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
        
	}
	
	#searchTime, #makeTime{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	#searchTime td, #searchTime th, #makeTime td, #makeTime th{
		border: 1px solid #ddd;
		height: 40px;
		padding-left: 10px;
	}
	#searchTime th, #makeTime th{background-color: #ddd;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
    .t1{
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .t1 caption{
       text-indent: -9999px;
       height: 0;
    }
    .t1 td,.t1 th{
        border: 1px solid #ababab;
        padding: 5px;
        height: 35px;
    }
    .t1 tfoot td{
        border: none;
    }
    .t1 th {
        background-color: #dedede;
    }
    .btn{
        padding:5px 11px;
        border-radius: 3px 3px;
        border: none;
        color: white;
        background-color: #00acac;
        margin-left: 2px;
    }
    .red{background-color:  #d43f3a}
	.blue{ background-color: #2e6da4;}
	.yellow{background-color: #eea236;}
	.green{background-color: #5cb85c;}
    .gray{background-color: #e5e5e5;}
    .mint{background-color: #46ade1;}
    #search_area{
        margin-top: 20px;
    }
</style>

</head>
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
                <div  id="staffWrap">
                    <div id="staffList_top">훈련생 현황</div>
                    <div id="search_area">
                        <table class="t1">
                            <tr>
                                <th>검색</th>
                                <td>
                                    <select id="searchType">
                                        <option>훈련생명</option>
                                    </select>
                                    <input type="text" id="searchValue"/>
                                    <button type="button" class="btn" id="search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div>
                        <table class="t1">
                            <caption>훈련생확인서류 리스트</caption>
                                <thead>
                                    <tr>
            
                                        <th>번호</th>
                                        <th>이미지</th>
                                        <th>학생코드</th>
                                        <th>이름</th>
                                        <th>연락처</th>
                                        <th>주민번호</th>
                                        <th>상태</th>
                                        <th>사유 및 날짜</th>
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
                    <form name="fff" method="post" action="cudel">
                        <input type="hidden" name="c_idx" value="${c_idx}">
                                    <c:forEach var="vo7" items="${requestScope.ar }" varStatus="vs">
                            <c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
                                <tr>
                                    <td>${num-vs.index}</td>
                        
                                    <c:if test="${vo7.file_name eq null}">
                                        <td></td>
                                    </c:if>
                                    <c:if test="${vo7.file_name ne null}">
                                    <td><img src="${pageContext.request.contextPath }/upload_file/${vo7.file_name}" width="100" height="100"></td>
                                    </c:if>
                                    <td>${vo7.s_code}</td>
                                    <td>${vo7.tr_name }</td>
                                    <td>${vo7.tr_hp }</td>
                                    <td>${vo7.tr_rrn }</td>
                                    <td><!-- 상태 -->
                                        <input type="hidden" id="nowstatus${vs.index}" value="${vo7.tr_nowstatus}" class="sts"/>
                                            <select name="nowstatus" id="">
                                                <option id="op1${vs.index}" value="0" >접수</option>
                                                <option id="op2${vs.index}" value="1" >예정</option>
                                                <option id="op3${vs.index}" value="2" >수강</option>
                                                <option id="op4${vs.index}" value="3" >조기수료</option>
                                                <option id="op5${vs.index}" value="4" >조기취업</option>
                                                <option id="op6${vs.index}" value="5" >수료</option>
                                                <option id="op7${vs.index}" value="6" >수강포기</option>
                                                <option id="op8${vs.index}" value="7" >미수료</option>
                                                <option id="op9${vs.index}" value="8" >제적</option>
                                                <option id="op10${vs.index}" value="9" >취소</option>
                                            </select>
                                    </td>
                                    <td><!-- 사유및날짜 --></td>
                                    <td>
                                        <input type="hidden" name="tr_idx" value="${vo7.tr_idx}">
                                    <input type="button" id="fset"  onclick="javascript:location.href='traineeEdit?tr_idx=${vo7.tr_idx}&c_idx=${vo7.cvo.c_idx}'" value="정보수정"  class="btn blue"/>
                                    <input type="button" id="fset"  onclick="traineewrite('${vo7.tr_idx}','${vo7.cvo.c_idx}')" value="신상기록부"  class="btn red">
                                    <input type="button" id="fset"  onclick="" value="서류관리"  class="btn mint">
                                    <input type="button" id="fset"  onclick="counseling('${vo7.tr_idx}','${vo7.cvo.c_idx}')" value="상담일지"  class="btn green">
                                    <input type="button" id="fset"  onclick="mange('${vo7.tr_idx}','${vo7.cvo.c_idx}')" value="사후관리"  class="btn yellow">
                                    <input type="button" id="fset"  onclick="" value="면접평가표"  class="btn gray">
                                    </td>
                                </tr>
                            </c:forEach>
                            </form>
                            </tbody>
                        </table>
                    </div>
                </div>
			</div>
		</div>

        
        <div id="m1" hidden></div>

    </article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_second").addClass("l_select");

            let ar = $(".sts");
			for(let k=0; k<ar.length;k++){
				//console.log($("#nowstatus"+k).val());
				for(let i=1;i<=10;i++){
					if($("#op"+i+k).val() ==$("#nowstatus"+k).val()){
						$("#op"+i+k).attr("selected",true);
					}
					
				}
			}
			
            
			$("#search").click(function(){
                let value =$("#searchValue").val();
                location.href="trainee_name?value="+value
            });

		});
			
        function mange(tt,tt1){
            $.ajax({
                url: "mangecard",
                type: "post",
                data:"tr_idx="+tt+"&c_idx="+tt1
            }).done(function(result){
                $("#m1").html(result);
            });
            
            $( "#m1" ).dialog({
                width:1000,
                height:1000
            });
        }

        function counseling(str,str1){
		$.ajax({
            url: "counseling",
            type: "post",
            data:"tr_idx="+str+"&c_idx="+str1
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
            width:1000,
            height:600
		});

	} 

    function traineewrite(str1, str2){
        console.log(str1,str2);
		$.ajax({
            url: "traineewrite",
            type: "post",
            data:"tr_idx="+str1+"&c_idx="+str2
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
            width:1600,
            height:1000
		});

	} 
		
	</script>
</body>

</html>