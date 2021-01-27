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
				document.getElementById("replyInsertButton").value = "수정";
				var contentVal = $("#replyContent").val();
				document.getElementById("replyInsert").action = "/boardReplyModify?seq="+datas.seq+"&rseq="+datas.rseq;
				
			},
			error:function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}

		})
} 
</script> 
<div class="row">
	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->

		<!-- DataTales Example -->
		<div class="card shadow mb-4">



			<div class="card-body">
				<div class="table-responsive">
					<div class="panel-heading clearfix">
						<div class="avatar clearfix avatar-medium pull-left">
							<div class="avatar-info">
								<h3>${board.writer}</h3>
								
								<div class="date-created">
									<span class="timeago">${board.regdate}</span> 작성

									<!-- 수정항목 출력 조건 -->
									<c:set var="writer" value="${board.writer}" />
									<c:set var="memId" value="${login.memId}" />
									<c:set var="modidate" value="${board.modidate}" />
									<c:choose>
										<c:when test="${writer == memId}">
											<span class="date-saperate">∙</span>
											<a href="/boardModifyForm?seq=${board.seq}"> <span
												class="timeago">${board.modidate }</span> <c:choose>
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
								<a href="boardDelete?seq=${board.seq}&category=${board.category}"><i class="fa fa-trash" aria-hidden="true"></i>삭제</a>
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
													<a href="/boardReplyDelete?seq=${board.seq}&rseq=${replyList.rseq}">
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
						<form id="replyInsert" action="/boardReplyInsert?seq=${board.seq }" method= "post" > 
						    <input type="hidden" name="memId" value="${login.memId}" ></input>
	   						<c:choose>
		   						<c:when test="${empty memId }">
			   						<textarea id="replyContent" cols="30" rows="10" name="content"  class="form-control" style="width: 800px; display: inline;" placeholder="로그인 해주세요." readonly></textarea>
								</c:when>
								<c:when test="${!empty memId }">
		   							<textarea id="replyContent" cols="30" rows="10" name="content"  class="form-control" style="width: 800px; display: inline;" placeholder="내용을 입력하세요."></textarea>
		   						</c:when>
	   						</c:choose>
							<input id="replyInsertButton" type="submit" value="등록">
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



