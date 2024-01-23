<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>
   <div id="head" style="margin-bottom: 0px;">
      <h1><img alt="아이콘" src="${pageContext.request.contextPath }/image/ict_logo.png" width="200" style="margin-left: 20px;"/></h1>
      <span id="span1">서비스종료일:2024-03-03</span>
      <span id="span2">접속자:${vo.sf_name }</span>
      <a href="logout">로그아웃</a>
   </div>
   <ul id="list">
      <li class="menubar selected" id="firstmenu"><a href="menu?select=counselReceipt">상담 및 접수</a></li>
      <li class="menubar" id="secondmenu"><a href="menu?select=courseReg">과정등록</a></li>
      <li class="menubar" id="thirdmenu"><a href="menu?select=schoolRecord">학적부</a></li>
      <li class="menubar 4"><a href="menu?select=counselManage">상담관리</a></li>
      <li class="menubar 5"><a href="menu?select=trainingLog">훈련일지</a></li>
      <li class="menubar 6" id="etclist"><a href="menu?select=etcList">기타관리</a></li>
      <li class="menubar 7" id="etclist"><a href="">사전평가</a></li>
      <li class="menubar 8" id="etclist"><a href="">자기/수행평가</a></li>
      <li class="menubar 9" id="etclist"><a href="">평가관리</a></li>
      <li class="menubar 10" id="etclist"><a href="">설문관리</a></li>
      <li class="menubar 11" id="etclist"><a href="">증서관리</a></li>
      <li class="menubar 12" id="etclist"><a href="">사후관리</a></li>
      <li class="menubar 13" id="etclist"><a href="">통합관리</a></li>
      <li class="menubar 13" id="etclist"><a href="">자료함</a></li>
      <li class="menubar 13" id="etclist"><a href="">커뮤니티</a></li>
      <li class="menubar 13" id="etclist"><a href="">로그현황</a></li>
      <li class="menubar 13" id="etclist"><a href="">시스템문의</a></li>
      <li class="menubar 13" id="etclist"><a ></a></li>
   </ul>
</header>