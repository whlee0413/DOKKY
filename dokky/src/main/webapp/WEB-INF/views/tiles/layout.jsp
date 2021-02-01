<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="en">

<head>
<style>
	label{display:inline-block; width:120px;}
</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>DOKKY</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet"	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper" class="sidebar-menu">

        <!-- Sidebar	 -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar"  >

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
                   <i class='fas fa-star' style='font-size:30px'></i>
                <span style="font-size : 35px;"> DOKKY</span> 
            </a>
			
              
         <!-- Divider -->
            <hr class="sidebar-divider"  >
		<c:if test="${empty login}">
			<div>
				<div align="center">
				 	<button class="btn btn-primary" type="button" onclick="location.href ='/loginForm'">
	                   로그인  
	             	</button> 
	             	 <button class="btn btn-primary" type="button" onclick="location.href ='/joinForm'">
	                   회원가입  
	             	</button> 
				</div>
			</div>
			</c:if>	
			
		<c:if test="${!empty login}">
			<div>
				<div align="center">
					<div style="color: white;">
						<span style="font-size: 30px">${login.memId}</span>&nbsp; 님
					</div> 
				</div><br/>
				<div align="center">
					<div style="color: white;">
						<span onclick="location.href='/modifyForm'"><i class="fas fa-fw fa-cog" ></i>&nbsp;회원수정</span> 
					</div> 
				</div>
				<div align="center">
					<div style="color: white;">
						<span  onclick="location.href='/logout'" ><i class="fas fa-sign-out-alt"></i>&nbsp; 로그아웃 </span>
					</div> 
				</div>
			</div>
			<br/>
		</c:if>	
					
 			

            <!-- Divider -->
            <hr class="sidebar-divider"  >

         
            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
					<i class="fa fa-comments-o" aria-hidden="true"></i>
                    <span>커뮤니티</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header" href="/boardList">커뮤니티:</h6>
                        
                        <a class="collapse-item" href="/boardList?category=communityAll">All</a>
                        <a class="collapse-item" href="/boardList?category=notice">공지사항</a>
                        <a class="collapse-item" href="/boardList?category=daily">사는얘기</a>
                    </div>
                </div>
            </li>

          <!--  Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
					<i class="fa fa-question-circle-o" aria-hidden="true"></i>
                    <span>Q&amp;A</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                      <h6 class="collapse-header">Q&amp;A:</h6>
                        <a class="collapse-item" href="/boardList?category=qnaAll">All</a>
                        <a class="collapse-item" href="/boardList?category=tech">Tech</a>
                        <a class="collapse-item" href="/boardList?category=job">Job</a>
                	</div>
                </div>
            </li> 

            <!-- Divider -->
            <hr class="sidebar-divider">

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Begin Page Content -->
                <div class="container-fluid">
      

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Content Column -->
                        <div class="col-lg-6 mb-4">

                        </div>

                        <div class="col-lg-6 mb-4">

                           

                        </div>
                    </div>
				<!-- 컨텐츠영역  -->
				<tiles:insertAttribute name="content"/>
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
           
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>


</body>

</html>