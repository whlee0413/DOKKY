<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                   
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">수정되었습니다!</h1>
                            </div>
                       ID:   ${member.memId}<br/>
                       Mail:   ${member.memMail}<br/>
                       Pw:   ${member.memPw}
                            <hr>
                        <a href="/">메인페이지</a>  
                        
                        </div>
                    </div>
                </div>
            </div>
   
			<!-- End of Main Content -->
		</div>
	</div>