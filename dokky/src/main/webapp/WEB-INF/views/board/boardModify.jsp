<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        	 
                            <div class="table-responsive" align="center">
	                                <form action="/boardModify" method= "post" > 
								    <input type="hidden" name="writer" value="${member.memId}" ></input>
								    <input type="hidden" name="seq" value="${board.seq}" ></input> 
									 <select name="category" id="position" class="form-control" style="width: 800px; display: inline; text-align:center;" > 
										<option value="${board.category}"  selected>
												<c:set var="ctgr" value="${board.category}"/> 
													<c:choose>
														<c:when test="${ctgr == 'tech'}"> Tech </c:when>
														<c:when test="${ctgr == 'job'}"> Job </c:when>
														<c:when test="${ctgr == 'notice'}"> 공지사항 </c:when>
														<c:when test="${ctgr == 'daily'}"> 사는얘기 </c:when>
													</c:choose>
										</option>
											<option value=""  >----커뮤니티---- </option>
												<option value="notice">공지사항</option>
												<option value="daily">사는얘기</option>
											<option value=""  >------Q/A------- </option>
												<option value="tech">Tech</option>
												<option value="job">Job</option>	
									</select><br/>
									  <br/>
								      <input type ="text" name="title"  class="form-control" style="width: 800px; display: inline;" placeholder="${board.title}"  value="${board.title}"><br/> 
									  <br/>
									<textarea cols="30" rows="10" name="content"  class="form-control" style="width: 800px; display: inline;" placeholder="${board.content}" >${board.content}</textarea><br/>
									
									
									<input type="submit" value="수정">
									
									</form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
