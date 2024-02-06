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
                <header>&nbsp;&nbsp;상담관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                  <div id="staffWrap">
                     <div id="counselList_top" class="title">교육생별 상담관리 검색</div>
   
                     <form>
                        <table id="searchCounsel" class="table">
                        <caption>상담검색</caption>
                           <thead>
                              <tr>
                                 <th>검색</th>
                                 <td>
                                    <select id="numPerPage" class="select">
            
                                       <option value="5">표시개수</option>
                                       <option>5</option>
                                       <option>10</option>
                                       <option>15</option>
                                    </select>
                                    <select id="selectYear" class="select">
   
                                    </select>
                                 </td>
                                 <td>
                                    <select id="searchType" class="select">
                                       <option value="4">교육생명</option>
                                    </select>
                                    <input type="text" id="searchValue" class="text"/>
                                    <button type="button" id="search_bt" class="btn">검색</button>
                                 </td>
                              </tr>
                           </thead>
                        </table>
                     </form>
                     <div id="counsel_Table">
                     
                     </div>
                  </div>
				   </div>
            </div> 
        </article>
    </article>
    
		<form name="frm" action="counsel" method="post">
			<input type="hidden" name="type"  value=""/> 
			<input type="hidden" name="so_idx" value="" />
			<input type="hidden" name="listSelect" value="3" />
		</form>
		
		
		<div id="dialog" hidden="" title="교육생 상담일지"></div>
		<div id="dialog2" hidden="" title="상담등록"></div>
		<div id="dialog3" hidden="" title="상담수정"></div>
		
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
      	let select ="4";
         let select_year = "";
         let numPerPage = "";
         let value ="";
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
			if('${value}' != null && '${value}' != ""){
				$.ajax({
					url: "searchCounsel",
					type: "post",
					data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent('4')+"&value="+encodeURIComponent('${value}')+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('3')+"&cPage="+encodeURIComponent('${param.cPage}')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			} else {

				$.ajax({
					url: "counselMain",
					type: "post",
					data:"type="+encodeURIComponent("searchCounsel")+"&listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent('${param.cPage}')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			}	
			
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let str = "<option>년도선택</option>";
			
			for(let i=year+1; i>year-5; i--){
				str+= "<option value="+i+">"+i+"</option>";
			}
			$("#selectYear").html(str);
			
			$("#searchType").on("change",function(){
				select = this.value;
			});
			$("#selectYear").on("change",function(){
				select_year = this.value;
				$.ajax({
					url: "searchCounsel",
					type: "post",
					data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('3')+"&cPage="+encodeURIComponent('1')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			});
			$("#numPerPage").on("change",function(){
				numPerPage = this.value;
				$.ajax({
					url: "searchCounsel",
					type: "post",
					data:"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('3')+"&cPage="+encodeURIComponent('1')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			});
			
			$("#search_bt").click(function(){
				value = $("#searchValue").val();
				if(value != null && value.trim().length > 0){
               $.ajax({
                  url: "searchCounsel",
                  type: "post",
                  data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                  +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('3')+"&cPage="+encodeURIComponent('${param.cPage}')
               }).done(function(result){
                  $("#counsel_Table").html(result);
               });
            }
            else{
               alert("검색어를 입력하세요");

            }
            });	
			
			
			
			
		});
		
		function counselList(tr_idx, c_idx) {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("counselList")+"&c_idx="+encodeURIComponent(c_idx)+"&tr_idx="+encodeURIComponent(tr_idx),
         }).done(function(result){
			$("#dialog").dialog("open");
            $("#dialog").html(result);
            
            $("#cc_cancle").click(function(){
                $("#dialog").dialog("close");
            });
         });
        }  
		function counselListAdd(tr_idx, c_idx) {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("counselListAdd")+"&c_idx="+encodeURIComponent(c_idx)+"&tr_idx="+encodeURIComponent(tr_idx),
         }).done(function(result){
         $("#dialog2").dialog("open");
            $("#dialog2").html(result);
            
            $("#close").click(function(){
                $("#dialog2").dialog("close");
            });
         });
        }
		function editCounsel(so_idx, tr_idx) {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("editCounsel")+"&tr_idx="+encodeURIComponent(tr_idx)+"&so_idx="+encodeURIComponent(so_idx),
         }).done(function(result){
         $("#dialog3").dialog("open");
            $("#dialog3").html(result);
            $("#close").click(function(){
                  $("#dialog3").dialog("close");
               });
         });
        }

        function del(so_idx){
			if( confirm("삭제하시겠습니까?")){
                frm.action = "delCounsel?total=search";
                document.frm.so_idx.value =so_idx; 
                document.frm.submit();
			}
		}
		function update(frm){
         frm.submit();
      }

		function paging(cPage) {
			$.ajax({
				url: "searchCounsel",
				type: "post",
				data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('3')+"&cPage="+encodeURIComponent(cPage),
			}).done(function(result){
				$("#counsel_Table").html(result);
			});
		}

		$("#dialog").dialog({
      autoOpen: false,
            width:1200,
            modal: true,

     });
	 $("#dialog2").dialog({
      autoOpen: false,
            width:1200,
            modal: true,

     });
	 $("#dialog3").dialog({
      autoOpen: false,
            width:1200,
            modal: true,

     });
     function total_add(frm){
      frm.total.value="search";
      frm.submit();
     }
    </script>
</body>
</html>