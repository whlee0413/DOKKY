<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
		// ID 유효성검사
		function checkId(){
			$('#user_id').blur(function(){
			 var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
		        if( !idReg.test( $('#user_id').val() ) ) {
		        	 $('#chkMsg').html("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");  
		            return;
		        }
			})
			
		    var id = $('#user_id').val();
		    $.ajax({
		        url:'/idCheck',
		        type:'post',
		        data:{memId:id},
		        success:function(data){
		            if($.trim(data)==0){
		                $('#chkMsg').html("사용가능");                
		            }else{
		                $('#chkMsg').html("이미 존재하는 ID입니다.");
		            }
		        },
		        error:function(request,status,error){
		            console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		        },


		    });
			
		};
		
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

  		<div class="container" style="width: 1000px">					
  <div class="card o-hidden border-0 shadow-lg my-5" style="width: 500px"  >
            <div class="card-body"  >
                <!-- Nested Row within Card Body -->
                <div class="row "  style="text-align: center"  >
                   
                        <div class="p-5 ">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                            </div>
                          
                            <form class="user" action="join" method="post" id="joinFrm">
		<!-- 아이디 -->             
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
       	                                        <input type="text" class="form-control form-control-user" 
       	                                        id="user_id"   placeholder="ID" name="memId" oninput="checkId()">
                                    </div>
                                    <p id = "chkMsg"></p>
                                     
                                </div>
                                
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="email"
                                        placeholder="Email Address" name="memMail">
                                </div>

		 <!--비밀번호-->
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="pw" placeholder="Password" name="memPw" required>
                                    </div>
                                  
                                     <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="pwCheck" placeholder="Password Check"  required>
                                    </div>
                                </div>
                              
                                <input type="submit" value="계정생성" class="btn btn-primary btn-user btn-block" id="userInfoCheck" >
                                <hr>
                               
                            </form>
                            <hr>
                           
                        
                        </div>
                    </div>
                </div>
            </div>
  </div> 
			<!-- End of Main Content -->
	