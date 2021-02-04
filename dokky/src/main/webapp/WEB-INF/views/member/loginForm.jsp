<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

<!-- 아이디 영문입력 -->
<script>
function onlyAlphabet(ele) {
	  ele.value = ele.value.replace(/[^\\!-z]/gi,"");
}
	
	
	


</script>

<form action="/login" method="post" >
    <div class="container" style="width: 1000px">

        <div class="card o-hidden border-0 shadow-lg my-5" style="width: 500px"   >
 <div class="card-body"  >

                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Welcome!</h1>
                                    </div>
                                    
                                        <!-- 아이디 -->
                                        <div class="form-group ">
                                        
                                            <input type="text" class="form-control form-control-user"
                                                id="exampleInputEmail" 
                                                placeholder="Enter ID..." name="memId" onkeydown="onlyAlphabet(this)">
                                                ${wrongId}
                                        </div>
                                        
                                        <!-- 패스워드 -->
                                        <div class="form-group ">
                                            <input type="password" class="form-control form-control-user"
                                                id="exampleInputPassword" placeholder="Password" name="memPw">
                                                ${wrongPw}
                                        </div>
                                      	
                                      	 <button type="submit" class="btn btn-primary btn-user btn-block">로그인</button>
                                      	
                                        <!-- <a type="submit" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </a> -->
                                        <hr>
                                       
                                    
                                    <hr>
                               
                                    <div class="text-center">
                                        <a class="small" href="joinForm">회원가입</a>
                                    </div>
                                </div>
                        </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="../resources/vendor/jquery/jquery.min.js"></script>
    <script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../resources/js/sb-admin-2.min.js"></script>
</form>
