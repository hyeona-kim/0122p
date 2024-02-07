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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/summernote-lite.css"/>
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
                <header>&nbsp;&nbsp;학적부</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="staffList_top" class="title">훈련생확인서류등록</div>
                        <div id="b1" class="main_item align_right">
                            <input type="button" value="확인서류등록" onclick="javascript:location.href='uploadwrite'" class="btn"/>
                        </div>
                    <table id="makeTime" class="table">
                    <caption>훈련생확인서류등록 리스트</caption>
                        <thead>
                            <tr>
                                <th>순번</th>
                                <th>서류명</th>
                                <th>첨부파일</th>
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
            
                            <c:forEach var="vo3" items="${requestScope.ar }" varStatus="vs">
                    <c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
                        <tr>
                            <td>${num-(vs.index) }</td>
                            <td>${vo3.subject }</td>
                            <td>${vo3.file_name }</td>
                            <td>
                            <input type="button" value="수정" onclick="edit('${vo3.tn_idx}')" class="btn"/>
                            <input type="button" onclick="traindel('${vo3.tn_idx}')" value="삭제" class="btn red"/>
                            <input type="button" onclick="javascript:location.href='trainuploadview?tn_idx=${vo3.tn_idx}'" value="확인서류보기" class="btn">
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
				</div>
            </div> 
        </article>
    </article>
    <form action="trainuploaddel" method="post" name="frm">
        <input type="hidden" name="type" value=""/>
        <input type="hidden" name="tn_idx" value=""/>
        <input type="hidden" name="cPage" value="${param.cPage }"/>
    </form>
    <div id="edit" hidden="hidden"></div>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="js/summernote-lite.js"></script>
    <script>
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
		$(function(){
			$(".subSelect").removeClass("subSelect");
			$("#l_three").addClass("subSelect");
		});
        function traindel(tn_idx){
			document.frm.type.value="trainuploaddel";
			document.frm.tn_idx.value=tn_idx;
			document.frm.submit();
			
		}
		function edit(ed){
			//console.log(ed);
			$.ajax({
				url:"trainuploadedit",
				type:"post",
				data:"type="+encodeURIComponent("trainuploadedit")+"&tn_idx="+ed
			}).done(function(reg){
				$("#edit").html(reg);
				
				$("#content").summernote({
					height:200,
					focus : true, /* 커서를 미리 가져다 놓는다 */
					lang : "ko-KR",
					callbacks:{
						onImageUpload:function(files, editor){
							// 이미지가 에디터에 추가 될 때마다 수행하는곳
							// 추가되어 들어온 이미지는 여러개일수 있기 때문에 files 으로 받아야함.(배열)
							// 배열로 받아야하기때문에 반복문을 돌림
							for(let i=0; i<files.length; i++)
								sendImage(files[i],editor);
							
						}
					}
				});
			$("#content").summernote("lineHeight", .7);
		});
			
			$("#edit").dialog({
				width:1000,
				maxHeight:900
			});
			
		}
		
	
		function sendData(frm){
    		let ar = frm.elements;
    	
    			let str = ar[0].dataset.str;
    			if(frm.elements[0].value==""){
    				alert(str+"를 입력하세요");
    				frm.elements[i].focus();
    				return;
    			}

    		frm.submit();
		}
		
		function paging(str) {
			location.href="trainupload?cPage="+str;
		}
    </script>
</body>
</html>