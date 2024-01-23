<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions"  %>

   <h2>과정타입 등록/수정</h2>
   
  <form action="Controller" method="post" name="fm">
     <input type="hidden" name="type"  value="addCourseType"/>
         <table id="t1">
            <colgroup>
               <col width="80px"/>
               <col width="*/2"/>
               <col width="80px"/>
               <col width="*/2"/>
            </colgroup>
            <tbody>
            <c:if test="${c_ar ne null}">
               <c:forEach var="tvo" items="${c_ar }">
               <tr>
                  <td class="num" >${tvo.ct_idx }</td>
                  
                  <td>
                     <input type="text" name="name"  value="${tvo.ct_name }"/>
                  </td>
                  <td class="color">색상</td>
                  <td>
                     <input type="text"  name ="text" value="${tvo.ct_color }"/>
                     <input type="color"  name ="color" class="ccol" value="${tvo.ct_color }"/>
                  </td>
               </tr>
               </c:forEach>
            <c:forEach var="i" begin="${f:length(c_ar)+1}" end="7">
               <tr>
                  <td class="num">${i}</td>
                  <td>
                     <input type="text" name="name" />
                  </td>
                  <td class="color">색상</td>
                  <td>
                     <input type="text"  name ="text"/>
                     <input type="color"  name ="color" class="ccol"/>
                  </td>
            
               </tr>
            </c:forEach>
            </c:if>
            <c:if test="${c_ar eq null }">
            <c:forEach var="i" begin="1" end="7">
               <tr>
                  <td class="num" >${i}</td>
                  <td>
                     <input type="text"  name="name" />
                  </td>
                  <td class="color">색상</td>
                  <td>
                     <input type="text"  name ="text"/>
                     <input type="color"  name ="color"  class="ccol"/>
                  </td>
               </tr>
            </c:forEach>
            </c:if>
            </tbody>
			<tfoot>
				<tr>
					<td colspan="4">
					  	<input type="submit" value="저장" />
    	    			 <input type="button" value="취소" id="cancel"/>
					</td>
				</tr>
	       
    	    </tfoot>
         </table>
      </form>
  
