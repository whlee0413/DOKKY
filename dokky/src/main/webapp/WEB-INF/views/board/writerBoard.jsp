<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
	crossorigin="anonymous">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">
li {
	list-style: none;
	float: left;
	pahttps://www.youtube.com/watch?v=cCgOESMQe44&list=PL59LTecnGM1Mg6I4i_KbS0w5bPcDjl7oz&index=3dding: 6px;
}
</style>


<script>
	//페이징
	$(function() {
		
		$('#searchBtn').click(
				function() {
					self.location = "/boardList" + '${pageMaker.makeQuery(1)}'
							+ "&searchType="
							+ $("select option:selected").val() + "&keyword="
							+ encodeURIComponent($('#keywordInput').val());
				});
	});
</script>




<!-- Begin Page Content -->
<div class="container-fluid" style="width: 1000px">

	<!-- Page Heading -->
	<div class="card shadow mb-4">
		<div class="card-body">
			<div class="table-responsive">
			<h2>${scri.memId} 님의 활동 내역</h2>
			</div>
		</div>
	</div>



	<!-- DataTales Example -->
	<div class="card shadow mb-4">

		<!-- 검색 -->

		<div class="card-body">
			<div>
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable">


						<tbody>


							<c:forEach items="${list}" var="board">
								<c:set var="rseq" value="${board.rseq}" />
								<c:set var="ctrg" value="${board.category}" />

								<tr>
									<td>
										<div class="list-title-wrapper list-activity">
											<div class="list-activity-desc">
												<span class="list-activity-desc-text"> <c:if
														test="${rseq == 'N'}">
														<i class="fa fa-pencil " aria-hidden="true"></i>



														<span>#${board.seq } 게시물을 작성했습니다.</span>
													</c:if> <c:if test="${rseq == 'Y'}">
														<i class="fa fa-commenting-o" aria-hidden="true"></i>
														 	#${board.seq } 게시물에  댓글을 작성했습니다. 
													</c:if>
												</span> <span class="timeago">${board.regdate}</span>
											</div>
											<br />
											<div style="float: left;">
												<h5>
													<a class="btn btn-success"
														href="/boardList?category=${board.category}"> <c:if
															test="${ctrg == 'tech'}">Tech</c:if> <c:if
															test="${ctrg == 'job'}">Job</c:if> <c:if
															test="${ctrg == 'notice'}">공지사항</c:if> <c:if
															test="${ctrg == 'daily'}">사는얘기</c:if>
													</a> <a style="text-align: left"
														href="/boardRead?seq=${board.seq}">${board.title } </a>
												</h5>
											</div>

											<div style="float: right; display: inline-block;">
												<h5>${board.writer}</h5>
											</div>
										</div>
									</td>
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
									<li><a
										href="/writerBoardList${pageMaker.makeSearch(pageMaker.startPage - 1)}&memId=${scri.memId}">«</a></li>
								</c:if>


								<!-- 페이지 번호 (시작 페이지 번호부터 끝 페이지 번호까지) -->
								<c:forEach begin="${pageMaker.startPage}"
									end="${pageMaker.endPage}" var="idx">
									<li><a
										href="/writerBoardList${pageMaker.makeSearch(idx)}&memId=${scri.memId}">${idx}</a></li>
								</c:forEach>

								<!-- next 버튼 -->
								<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
									<li><a
										href="/writerBoardList${pageMaker.makeSearch(pageMaker.endPage + 1)}&memId=${scri.memId}">»</a></li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
