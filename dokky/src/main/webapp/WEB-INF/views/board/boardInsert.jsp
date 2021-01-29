<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	function check(){
		if(form.category.value == ""){
			alert("게시판 종류를 선택해주세요.");
			form.category.focus();
			return;
		}
		if(form.title.value == ""){
			alert("제목을 입력해주세요.");
			form.title.focus();
			return;
		}
		if(form.content.value == ""){
			alert("내용을 입력해주세요.");
			form.content.focus();
			return;
		}
		form.submit();
	}
	
</script>

<div class="row">
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                   
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
		                        	<a class="create btn btn-success btn-wide pull-right" href="boardInsertForm">
		                        		<i class="fa fa-pencil"></i> 새 글 쓰기
		                        	</a>
                        </div>
                      	
                        <div class="card-body">
                        	 
                            <div class="table-responsive" align="center">
	                              
	                              
	                                <form action="/boardInsert" method= "post" id="form"> 
								   <input type="hidden" name="writer" value="${login.memId}" readonly></input> 
									<div>
									 
									 <select name="category" id="category" class="form-control" style="width: 800px; display: inline; text-align:center;" > 
										<option value=""  selected>게시판을 선택해 주세요. </option>
											<option value=""  disabled>----커뮤니티---- </option>
												<c:set var="loginID" value="${login.memId}"/> 
												<c:if test="${loginID == 'admin'}">  
												<option value="notice">공지사항</option>
												</c:if>
												<option value="daily">사는얘기</option>
											<option value=""  disabled>------Q/A------- </option>
												<option value="tech">Tech</option>
												<option value="job">Job</option>	
									</select>
									</div><br/>
								      <input type ="text" name="title" id="title" class="form-control" style="width: 800px; display: inline;" placeholder="제목을 입력하세요." ><br/>
									<textarea cols="30" rows="10" name="content" id="content"  class="form-control" style="width: 800px; display: inline;" placeholder="내용을 입력하세요."></textarea><br/>
									 <input type ="text" name="tagName"  class="form-control" style="width: 800px; display: inline;" placeholder="해쉬태그를 입력하세요.    ex) #ajax, #spring..." ><br/> 
									  <br/>
									  
									  
									   
									<button class="btn btn-primary" type="button" onclick="check()" >등록</button>
									
									</form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
