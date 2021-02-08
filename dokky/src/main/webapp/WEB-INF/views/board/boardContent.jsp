<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <script>
	function modifyFocus(rseqParam) {
		var rseqVal = $('input[name='+rseqParam+']').val();
		var replyArea = document.getElementById('replyContent');
		var seqData = ${board.seq};
			$.ajax({
				url : '/boardReplySelect',
				type : 'get',
				data : {seq:seqData, rseq:rseqVal},
				success : function(datas){
					console.log(datas.content)
					replyArea.innerHTML = datas.content ;
					replyArea.focus();
					datas.content = "";
					$('#replyInsertButton').html('수정');
					document.getElementById("replyInsert").action = "/boardReplyModify?seq="+datas.seq+"&rseq="+datas.rseq;
					
					
				},
				error:function(request,status,error){
				    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
			})
	} 
	
	function replyDelete(rseqParam) {
		var rseqVal = $('input[name='+rseqParam+']').val();

		if(confirm("댓글을 삭제하시겠습니까?")){
			location.href="/boardReplyDelete?seq=${board.seq}&rseq="+ rseqVal;
		} else {
			return;
		}
		
	} 
	
	function replyCheck(){
		if(replyInsert.replyContent.value == ""){
			alert("내용을 입력하세요.")
			replyInsert.replyContent.focus();
			
		}else{
			if($('#replyInsertButton').html() == '수정'){
				if(confirm("댓글을 수정하시겠습니까?")){
					replyInsert.submit();					
				}else{
					return;
				}
					
			}else{
				if(confirm("댓글을 등록하시겠습니까?")){
					replyInsert.submit();					
				}else{
					return;
				}
			}			
		}
		
	}

	function boardDelete(){
		  
        if ( confirm("게시글을 삭제하시겠습니까?") ) {
            location.href="boardDelete?seq=${board.seq}&category=${board.category}";
        } else {
           return;
        }
    }
	
	//파일다운로드
	function fn_fileDown(fileNo){
		var formObj = $("form[name='readForm']");
		$("#FILE_NO").attr("value", fileNo);
		formObj.attr("action", "/fileDown");
		formObj.submit();
	}
	
	
</script> 
<div class="row" >
	<!-- Begin Page Content -->
	<div class="container-fluid" style="width: 1000px">

		<!-- Page Heading -->

		<!-- DataTales Example -->
		<div class="card shadow mb-4">



			<div class="card-body">
				<div class="table-responsive">
					<div class="panel-heading clearfix">
						<div class="avatar clearfix avatar-medium pull-left">
							<div class="avatar-info">
								<h3><a href="/writerBoardList?memId=${board.writer}">${board.writer}</a></h3>
								
								<div class="date-created">
									<span class="timeago">${board.regdate}</span> 작성

									<!-- 수정항목 출력 조건 -->
									<c:set var="writer" value="${board.writer}" />
									<c:set var="memId" value="${login.memId}" />
									<c:set var="modidate" value="${board.modidate}" />
									<c:choose>
										<c:when test="${writer == memId}">
											<span class="date-saperate">∙</span>
											 <a href="/boardModifyForm?seq=${board.seq}">
											  
											<span class="timeago">${board.modidate }</span> 
												<c:choose>
													<c:when test="${empty modidate }"> 수정 </c:when>
													<c:when test="${!empty modidate }"> 수정됨 </c:when>
												</c:choose>
											</a>
										</c:when>
										<c:when test="${writer != memId }">
											<c:if test="${!empty modidate }">
												<span class="date-saperate">∙</span>
														${board.modidate } 수정됨
													 </c:if>
										</c:when>
									</c:choose>
									<!-- 수정항목 출력 조건 끝  -->

								</div>
							</div>
						</div>
						<!-- 조회수  -->
						<div class="content-identity pull-right">
							<div class="content-identity-count">
								<i class="fa fa-comment"></i> ${replyCount}
							</div>
							<div class="content-identity-count">
								<i class="fa fa-eye"></i> ${board.cnt}
							</div>
							<c:set var="memId" value="${login.memId}" />
							<c:set var="writer" value= "${board.writer}" />
							<c:if test="${memId == writer}">
								<div>
									<a href="javascript:void(0);" onclick="boardDelete();" ><i class="fa fa-trash" aria-hidden="true"></i>삭제</a>
								</div>
							</c:if>
						</div>
					</div>
					<!-- 내용 -->
					<div class="content-container clearfix">
						<div id="content-body" class="panel-body content-body pull-left">
							<div class="content-tags">
								<span class="list-group-item-text article-id">#${board.seq}</span>
								<a href="/boardList?category=${board.category}"
									class="list-group-item-text item-tag label label-info"> <i
									class="fa fa-database"></i> ${board.category}
								</a>
							</div><br/>
							<h2 class="panel-title">${board.title}</h2>
							<hr>
							<article class="content-text" itemprop="articleBody">
								${board.content}
							</article><br/><br/><br/>
						<c:set var="file" value="${file }"></c:set>
						<c:if test="${!empty file}">
						<span>첨부파일 목록</span></c:if>
							<div class="form-group" style="border: 1px solid #dbdbdb;">
								<c:forEach var="file" items="${file}">
									<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
								</c:forEach>
							</div>
						<!-- 파일다운로드 -->
						<form name="readForm" role="form" method="post">
							<input type="hidden" id="FILE_NO" name="FILE_NO" value="">
						</form>
						
						<!-- 해쉬태그 -->
							<c:forEach items="${hashTagList}" var="hashTag" >
							<a href="/boardList?tagName=${hashTag.tagName}">#${hashTag.tagName} </a>
							</c:forEach>
						</div>

						
					</div>
					<!-- 내용 끝-->
				</div>
			</div>
		</div>

		<!-- 댓글리스트 -->
		<div class="card shadow mb-4">
			<div class="card-body">
				<div class="table-responsive">
					<div class="panel-heading clearfix">

						
						<div id="reply">
						댓글(${replyCount}) 
							<ol class="replyList">
								<c:forEach items="${replyList}" var="replyList" varStatus="status">
										
										<br/><li style="border-bottom: 1px solid grey;">
											${replyList.writer}<br/>
											
											${replyList.regdate} 
											<c:set var="writer" value="${replyList.writer}" />
											<c:set var="memId" value="${login.memId}" />
												<c:if test="${writer == memId}">
													
													
													<a href="javascript:void(0);" onclick="replyDelete(${status.index});" > 
														<i class="fa fa-trash" aria-hidden="true">삭제</i>
													</a>
													
													
													<input type="hidden" value="${replyList.rseq }" name="${status.index}">
													
													<a href="javascript:void(0);" onclick="modifyFocus(${status.index});" id="sendRseq">
													수정
													</a>
												 
												</c:if>
										
										<p>${replyList.content}</p><br/>
										<input type="hidden" id="content" value="${replyList.content}">
									</li>
								</c:forEach>
					
						<!--  댓글 달기 -->
						<br/>
						<h4>${login.memId }</h4>
						<form id="replyInsert" action="/boardReplyInsert" method= "post" > 
						    <input type="hidden" name="memId" value="${login.memId}" ></input>
						    <input type="hidden" name="seq" value="${board.seq}" ></input>
	   						<c:choose>
		   						<c:when test="${empty memId }">
			   						<textarea id="replyContent" cols="30" rows="10" name="content"  class="form-control" style="width: 800px; display: inline;" placeholder="로그인 해주세요." readonly></textarea>
								</c:when>
								<c:when test="${!empty memId }">
		   							<textarea id="replyContent" cols="30" rows="10" name="content"  class="form-control" style="width: 800px; display: inline;" placeholder="내용을 입력하세요."></textarea>
		   						</c:when>
	   						</c:choose>
							<button class="btn btn-primary" id="replyInsertButton" type="button" onclick="replyCheck()" >등록</button>
							</form>	
											
							</ol>
						</div>
					</div>
				</div>
				
			</div>
		</div>
			<!-- 댓글리스트 끝-->
			
					
			
	</div>
</div>



