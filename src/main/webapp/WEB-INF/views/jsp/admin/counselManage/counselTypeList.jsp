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
                <header>&nbsp;&nbsp;상담관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                  <div id="staffWrap">
                     <div id="counselList_top" class="title">상담 관리</div>
                     <div id="ttop" class="main_item align_right">
                        <button type="button" onclick="set()" class="btn">상담파일등록</button>   
                        <button type="button" onclick="location.href='../../sample2.xlsx'" class="btn">상담파일등록 샘플</button>
                     </div>
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
                                       <option value="1">훈련강사</option>
                                       <option value="2">상담일</option>
                                       <option value="3">과정명</option>
                                       <option value="4">훈련생</option>
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
   </form>
   
   
   <div id="dialog" hidden="" title="상담파일등록">   
   </div>
   
   <div id="dialog2" hidden="" title="상담결과보고">
   </div>
     
     <div id="dialog3" hidden="" title="상담결과보고">
   </div>

   <div id="dialog4" hidden="" title="상담결과보고서"></div>
   <div id="dialog5" hidden="" title="상담결과보고서 수정"></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
         let select ="1";
         let select_year = "";
         let numPerPage = "";
         let value ="";
         let list = "";
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
            $("#l_one").addClass("subSelect");
         $.ajax({
            url: "counselMain",
            type: "post",
            data:"listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent('${param.cPage}')
         }).done(function(result){
            $("#counsel_Table").html(result);
         });
         
      
         let now = new Date();   // 현재 날짜 및 시간
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
               +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('1')+"&cPage="+encodeURIComponent('1')
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
               +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('1')+"&cPage="+encodeURIComponent('1')
            }).done(function(result){
               $("#counsel_Table").html(result);
               
            });
         });
         
         $("#search_bt").click(function(){
            value = $("#searchValue").val();
            select = $("#searchType").val();
            if(select == "1" || select == "3")
               list = "1";
            else if(select == "2")
               location.href='counselDateSearch?value='+value;
            else
               location.href='counselTraineeSearch?value='+value;
            if(value != null && value.trim().length > 0){
               
               $.ajax({
                  url: "searchCounsel",
                  type: "post",
                  data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                  +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent(list)+"&cPage="+encodeURIComponent('${param.cPage}')
               }).done(function(result){
                  $("#counsel_Table").html(result);
               });
            } else {
               alert("검색어를 입력하세요");
               $('#searchValue').focus();
            }

         });   
               
      });
      
      function set() {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"select="+encodeURIComponent("addCounselFile")
         }).done(function(result){
            $("#dialog").html(result);
            
            $("#cc_cancle").click(function(){
                $("#dialog").dialog("close");
            });
         });
            $("#dialog").dialog("open");
      }
      function set2(c_idx) {
         $.ajax({
            url:"counselAddMain",
            type:"post",
            data:"&select="+encodeURIComponent("counselAddMain")+"&c_idx="+c_idx,
         }).done(function(result){
            $("#dialog2").html(result);
            
            $("#cc_cancle").click(function(){
                $("#dialog2").dialog("close");

            });
         });
            $("#dialog2").dialog("open");
      }

      function counselA(c_idx){
         $("#dialog2").dialog("close");
         $.ajax({
             url:"counselA",
             type:"post",
             data:"type="+encodeURIComponent("ss_dialog")+"&select="+encodeURIComponent("counselA")+"&c_idx="+c_idx,
         }).done(function(result){
         $("#dialog3").html(result);
         
         $("#cc_close").click(function(){
             $("#dialog3").dialog("close");
         });
      });
         $("#dialog3").dialog("open");
      }
      function viewCounselAdd(ss_idx){
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("viewCounselAdd")+"&ss_idx="+encodeURIComponent(ss_idx),
         }).done(function(result){
            $("#dialog4").dialog("open");
            $("#dialog4").html(result);

            $("#close").click(function(){
                $("#dialog4").dialog("close");
            });
         });
        }
        function editCounselAdd(ss_idx){
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("editCounselAdd")+"&ss_idx="+encodeURIComponent(ss_idx),
         }).done(function(result) {
            $("#dialog5").dialog("open");
            $("#dialog5").html(result);

            $("#close").click(function(){
                $("#dialog5").dialog("close");
            });
         })
        } 

      $( "#dialog" ).dialog({
         autoOpen: false,
         width:700,
         modal: true,
      });
      
      $( "#dialog2" ).dialog({
            autoOpen: false,
            width: 1200,
            modal: true,
 
        });
        
        $( "#dialog3" ).dialog({
            autoOpen: false,
            width:1200,
            modal: true,
   
        });
        
        $( "#dialog4" ).dialog({
            autoOpen: false,
            width:1200,
            modal: true,
    
        });
        
        $( "#dialog5" ).dialog({
            autoOpen: false,
            width:1200,
            modal: true,
     
        });
        

      function paging(str) {
         select = $("#searchType").val();
         if(select == "1" || select == "3")
            list = "1";
         else if(select == "2")
            list = "2";
         else
            list = "3";
         $.ajax({
            url: "searchCounsel",
            type: "post",
            data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
               +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent(list)+"&cPage="+encodeURIComponent(str),
         }).done(function(result){
            $("#counsel_Table").html(result);
         });
         
      }

      function del(ss_idx){
			if( confirm("삭제하시겠습니까?")){
               frm.action = "delCounselAdd?ss_idx="+ss_idx;
               frm.submit();
			}
		}
    </script>
</body>
</html>