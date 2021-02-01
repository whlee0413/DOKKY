<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
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
	
	
	
	//파일추가.삭제
		$(document).ready(function(){
			
			$(document).on("click","#fileDel", function(){
				$(this).parent().remove();
			})
			
			fn_addFile();
			
 		function fn_addFile(){
			var fileIndex = 1;
			//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
			$("#fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:center' name='file_"+(fileIndex++)+"'>"+"<button type='button'  id='fileDelBtn' class='btn btn-warning'>"+"파일 삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
 		
 		
		});
		
		var fileNoArry = new Array();
 		var fileNameArry = new Array();
 		
 		function fn_del(value, name){
 			console.log(" 삭제 value 값은 :" + value);
 			console.log(" 삭제 name 값은 :" + name);
 			
 			fileNoArry.push(value);
 			fileNameArry.push(name);
 			$("#fileNoDel").attr("value", fileNoArry);
 			$("#fileNameDel").attr("value", fileNameArry);
 		}
</script>
<div class="row">
	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">수정</h1>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">DataTables
					Example</h6>

			</div>

			<div class="card-body">

				<div class="table-responsive" align="center">
					<form action="/boardModify" method="post" id="form" enctype="multipart/form-data">
						<table>
							<tbody>
								<tr>
									<td>
										<input type="hidden" name="writer" value="${member.memId}">
										<input type="hidden"name="seq" value="${board.seq}">
										<input type="hidden" 	id="fileNoDel" name="fileNoDel[]" value=""> 
										<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">
									</td>
								</tr>
								
								<!-- 카테고리 -->
								<tr>
									<td>
										<select name="category" id="category" class="form-control"
											style="width: 800px; display: inline; text-align: center;">
												<option value="" disabled>----커뮤니티----</option>
												<option value="notice" id="notice">공지사항</option>
												<option value="daily" id="daily">사는얘기</option>
												<option value="" disabled>------Q/A-------</option>
												<option value="tech" id="tech">Tech</option>
												<option value="job" id="job">Job</option>
										</select>
									</td>
								</tr>

								<!-- 제목 -->
								<tr>
									<td><input type="text" name="title" class="form-control"
										style="width: 800px; display: inline;"
										placeholder="${board.title}" value="${board.title}"><br />
									</td>
								</tr>

								<!-- 내용 -->
								<tr>
									<td><textarea cols="30" rows="10" name="content"
											class="form-control" style="width: 800px; display: inline;"
											placeholder="${board.content}">${board.content}</textarea><br />
									</td>
								</tr>

								<!-- 해쉬태그 -->
								<tr>
									<td><input type="text" name="tagName" class="form-control"
										style="width: 800px; display: inline;" value="${hashTag}"><br />
									</td>
								</tr>

								<!-- 첨부파일 -->
								<tr align="center">
									<td id="fileIndex">
									<c:forEach var="file" items="${file}" varStatus="var">
											<div>
												<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
												<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}" '> 
												<div style="float:left">
													<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a> (${file.FILE_SIZE}kb)
												</div>
													
												<div >
													<button id="fileDel" class="btn btn-warning"
														onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');"
														type="button" >파일 삭제</button>
												</div>	
												<br>
											</div>
										</c:forEach>
									</td>
								</tr>
								<tr align="center">
									<td>
										<button type="button" class="btn btn-info" id="fileAdd_btn" >파일 추가</button>
										<button class="btn btn-primary" type="button" onclick="modifyConfirm()">게시글 수정</button>
										<button class="btn btn-danger" type="button" onclick="deleteConfirm()">게시글 삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
