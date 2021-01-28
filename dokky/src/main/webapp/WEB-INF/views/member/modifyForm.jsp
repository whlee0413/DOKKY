<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	function accountDelete(){
		  
	        if ( confirm("계정을 삭제하시겠습니까?") ) {
	            location.href="/remove?memId=${member.memId}";
	        } else {
	           return;
	        }
	    }
	
	function accountModify(){
		  
        if ( confirm("회원정보를 수정하시겠습니까?") ) {
				document.getElementById('form').submit();
        } else {
           return;
        }
    }
	
	//비밀번호 확인
	$(function(){
			$('#pwCheck').blur(function(){
			   if($('#pw').val() != $('#pwCheck').val()){
			    	if($('#pwCheck').val()!=''){
				    alert("비밀번호가 일치하지 않습니다.");
			    	    $('#pwCheck').val('');
			          $('#pwCheck').focus();
			       }
			    }
			})  	   
		});

</script>
<div class="container">	
        <div class="card o-hidden border-0 shadow-lg my-5" style="width: 500px"  >
            <div class="card-body"  >
                <!-- Nested Row within Card Body -->
                <div class="row "  style="text-align: center"  >
                   
                        <div class="p-5 ">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원정보 수정</h1>
                            </div>
                            
                            <form id="form" class="user" action="modify" method="post">
                              
                                        <input type="text" class="form-control form-control-user" id="exampleFirstName"
                                            placeholder="ID" name="memId" value="${member.memId}" readonly> 
                              
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="exampleInputEmail"
                                        placeholder="Email Address" name="memMail" value="${member.memMail}">
                                </div>
                                <div class="form-group row">
                                
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="pw" placeholder="Password" name="memPw" value="${member.memPw}">
                                    </div>
                                    
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="pwCheck" placeholder="Password Check"  required>
                                    </div>
                            
                                </div>
                              
                                <input type="button" value="회원정보 수정" class="btn btn-primary btn-user btn-block" onclick="accountModify()">
                                <input type="button" value="회원 탈퇴" class="btn btn-danger btn-user btn-block" onclick="accountDelete()">
                                <hr>
                               
                            </form>
                            <hr>
                           
                        
                        </div>
                    </div>
                </div>
            </div>
   
			<!-- End of Main Content -->
		</div>
