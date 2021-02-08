<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
	 	 <style type="text/css">
					li {list-style: none; float: left; padding: 6px;}
			</style> 
 
 
 <script>
	

	
	
	//페이징
     $(function(){
       $('#searchBtn').click(function() {
         self.location = "/boardList" + '${pageMaker.makeQuery(1)}' 
         						+ "&searchType=" + $("select option:selected").val() 
         						+ "&keyword=" + encodeURIComponent($('#keywordInput').val()) 
         						+ "&category=" + '${scri.category}';
       });
     });   
   
</script> 


	
	
                <!-- Begin Page Content -->
                <div class="container-fluid" style="width: 1000px">

                    <!-- Page Heading -->
                   
                   
                   <h1 class="h3 mb-2 text-gray-800">
                   <c:set var="ctgr" value="${scri.category}"/> 
					<c:choose>
						<c:when test="${ctgr == 'tech'}"> Tech </c:when>
						<c:when test="${ctgr == 'job'}"> Job </c:when>
						<c:when test="${ctgr == 'notice'}"> 공지사항 </c:when>
						<c:when test="${ctgr == 'daily'}"> 사는얘기 </c:when>
						<c:when test="${ctgr == 'communityAll'}"> 커뮤니티 </c:when>
						<c:when test="${ctgr == 'qnaAll'}"> Q&A </c:when>
						<c:when test="${empty ctgr}"> 전체 게시물</c:when>
					</c:choose>
                   </h1>  
                   
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <c:set var="tag" value="${scri.tagName}"/> 
							<c:if test="${not empty tag}">
	                            <h3 class="m-0 font-weight-bold text-primary">
	                            	#${scri.tagName}
	                            </h3>
                            </c:if>
                        	<button class="create btn btn-success btn-wide pull-right" type="button" onclick="location.href='/boardInsertForm';" ><i class="fa fa-pencil"></i> 새 글 쓰기</button>
                        </div>
                       <br/>
                       
                      <!-- 검색 --> 
                        <form role="form" method="get" class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
	                        <div class="input-group">
	                        	<div>
			                        <select  name="searchType" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
			                       	<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
								      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
								      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
								      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
								      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
			                       </select>
			                       
			                        <input type="search" name="keyword"  id="keywordInput" value="${scri.keyword}"  class="form-control form-control-sm" placeholder="검색어" aria-controls="dataTable">
			                        <button id="searchBtn" type="button" class="btn btn-primary">검색</button>
	                      		</div>
	                        </div>
	                    </form>
	                    
                        <div class="card-body">
                         <div>
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable">
                                   		<colgroup>
                                   			<col width="*"/>
                                   			<col width="40%"/>
                                   			<col width="20%"/>
                                   			<col width="20%"/>
                                   			<col width="10%"/>
                                   		</colgroup>
                                    <thead>
										<tr>
											<th>No.</th>
											<th>제목</th>
											<th>작성자</th>
											<th>등록일</th>
											<th>조회수</th>
										</tr>
									</thead>
									
									<tbody>
										
											
									<c:forEach items="${list}" var="board">
										<tr onclick="location.href='/boardRead?seq=${board.seq}'" style="cursor:pointer;">
											<td>${board.seq }</td>
											<td><a href="/boardRead?seq=${board.seq}"  >${board.title}</a></td>
											<td>${board.writer }</td>
											<td>${board.regdate}</td>
											<td>${board.cnt}</td>
										</tr>
									</c:forEach>
									</tbody>
                                </table>
                         
                               		 <!-- 페이지 번호 -->	
									<div class="text-center">
										<nav aria-label="pagination">
											<ul class="pagination">
											
												<!-- prev 버튼 -->
												  <c:if test="${pageMaker.prev}">
												    	<li><a href="/boardList${pageMaker.makeSearch(pageMaker.startPage - 1)}&category=${scri.category}&tagName=${scri.tagName}">«</a></li>
												  </c:if> 
												
												
												<!-- 페이지 번호 (시작 페이지 번호부터 끝 페이지 번호까지) -->
												  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
												  	<c:set var="tag" value="${scri.tagName}"/> 
													<c:choose>
														<c:when test="${empty tag}"> <li><a href="/boardList${pageMaker.makeSearch(idx)}&category=${scri.category}">${idx}</a></li> </c:when>
														<c:when test="${not empty tag}"> <li><a href="/boardList${pageMaker.makeSearch(idx)}&category=${scri.category}&tagName=${scri.tagName}">${idx}</a></li> </c:when>
													</c:choose>
											   	  </c:forEach>
												
												<!-- next 버튼 -->
												<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
											    	<li><a href="/boardList${pageMaker.makeSearch(pageMaker.endPage + 1)}&category=${scri.category}&tagName=${scri.tagName}">»</a></li>
											    </c:if> 
											</ul>
										</nav>
									</div>
                                
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
