<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
	function modifyConfirm(){
		  
	    if ( confirm("게시글을 수정하시겠습니까?") ) {
				form.submit();
	    } else {
	       return;
	    }
	}
	function deleteConfirm(){
			  
	        if ( confirm("게시글을 삭제하시겠습니까?") ) {
	            location.href="boardDelete?seq=${board.seq}&category=${board.category}";
	        } else {
	           return;
	        }
	    }
	
	$(function (){
		 $('#category').val("${board.category}").prop("selected", true);

		});
</script>
<div class="row">
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">수정</h1>
                   
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
		                        	
                        </div>
                      	
                        <div class="card-body">
                        	 
                            <div class="table-responsive" align="center" >
	                                <form action="/boardModify" method= "post" id="form"> 
								    <input type="hidden" name="writer" value="${member.memId}" ></input>
								    <input type="hidden" name="seq" value="${board.seq}" ></input> 
									 <select name="category" id="category" class="form-control" style="width: 800px; display: inline; text-align:center;" > 
											<option value=""  disabled >----커뮤니티---- </option>
												<option value="notice" id="notice">공지사항</option>
												<option value="daily" id="daily">사는얘기</option>
											<option value=""   disabled>------Q/A------- </option>
												<option value="tech" id="tech">Tech</option>
												<option value="job" id="job">Job</option>	
									</select><br/>
									  <br/>
								      <input type ="text" name="title"  class="form-control" style="width: 800px; display: inline;" placeholder="${board.title}"  value="${board.title}"><br/> 
									  <br/>
									<textarea cols="30" rows="10" name="content"  class="form-control" style="width: 800px; display: inline;" placeholder="${board.content}" >${board.content}</textarea><br/>
									 <input type ="text" name="tagName"  class="form-control" style="width: 800px; display: inline;" value="${hashTag}"><br/> 
									<br/>
										<button class="btn btn-primary" type="button" onclick="modifyConfirm()" >수정</button>
										<button class="btn btn-danger" type="button"  onclick="deleteConfirm()" >삭제</button>
									</form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
