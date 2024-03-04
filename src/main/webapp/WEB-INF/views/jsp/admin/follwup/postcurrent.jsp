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
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;사후관리현황</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                       
                            <div class="main_item align_center main_color bold">｜${aa.c_name} (교육기간: ${aa.start_date} ~ ${aa.end_date})</div>
                    <table id="makeTime" class="table">
                    <caption>훈련생확인서류 리스트</caption>
                        <thead>
                            <tr>
                                <th>이미지</th>
                                <th>학생코드</th>
                                <th>이름</th>
                                <th>연락처</th>
                                <th>주민번호</th>
                                <th>HRD등록</th>
                                <th>취업지원</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
            <form name="fff" method="post" action="cudel">
                <input type="hidden" name="c_idx" value="${c_idx}">
                    <c:forEach var="vo7" items="${requestScope.ar }" varStatus="vs">
                    	<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
                        <tr>
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
                            </td>
                            <td><!-- 사유및날짜 --></td>
                            <td>
                                <input type="hidden" name="tr_idx" value="${vo7.tr_idx}">
                            
                            <input type="button" id="fset" onclick="mange('${vo7.tr_idx}','${aa.c_idx}')" value="사후관리" class="btn">
                            <input type="button" id="fset" value="사후취업지원" class="btn">
                            
                            </td>
                        </tr>
                    </c:forEach>
                    </form>
                    </tbody>
                </table>
            
                </div>
				</div>
            </div> 
        </article>
    </article>
    <form action="cudel" name="frm" method="post">
		<input type="hidden" name="tr_idx" value="${vo7.tr_idx}"/>
		<input type="hidden" name="type" value=""/>
		<input type="hidden" name="cPage" value="${param.cPage}"/>
		<input type="hidden" name="c_idx" value="${vo7.c_idx}">
	</form>
	<div id="m1" hidden="hidden"></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let tr_idx = "";
        let c_idx = "";
        let select ="3";
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
			$(".subSelect").removeClass("subSelect");
			$("#l_two").addClass("subSelect");
			let ar = $(".sts");
			for(let k=0; k<ar.length;k++){
				//console.log($("#nowstatus"+k).val());
				for(let i=1;i<=10;i++){
					if($("#op"+i+k).val() ==$("#nowstatus"+k).val()){
						$("#op"+i+k).attr("selected",true);
					}
					
				}
			}

		});
		
		// form 데이터들 보내기 함수들 
		function sendData(ddd){
    		
    		ddd.submit();
		}

		function sendwrite(qqq){
			qqq.submit();
		}

		function sendDate(ddd){
			ddd.submit();

		}

		function editform(qwe){
			qwe.submit();
		}
		
		
		



	

	function couupload(tr,tr1,num,so){
		console.log(num);
		$.ajax({
            url: "couupload",
            type: "post",
            data:"tr_idx="+tr+"&c_idx="+tr1+"&ss_num="+num+"&so_idx="+so
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
			width:1000,
			height:600
		});
	}

	
	function mange(tt,tt1){
		$.ajax({
            url: "mangecard",
            type: "post",
            data:"tr_idx="+tt+"&c_idx="+tt1+"&select="+select,
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
				width:1000,
            	height:1000
		});
	}

	
	function printPage(){
        let initBody;
		window.onbeforeprint = function(){
            $("#m1").dialog("close");
            initBody = document.body.innerHTML;
			document.body.innerHTML = document.getElementById('print').innerHTML;
		};
		window.onafterprint = function(){
            document.body.innerHTML = initBody;
            traineewrite(tr_idx, c_idx);

		};
        setTimeout(function (){
			window.print();
			return false;   
        },250);
	}





    function paging(str) {
        location.href="traincurrent?cPage="+str
     }
		
		
    </script>
</body>
</html>