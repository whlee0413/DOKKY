<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function(){    
        getBoardList();
    });        
	
	
	/** 게시판 - 상세 페이지 이동 */
    function goBoardDetail(boardSeq){                
        location.href = "/boardRead?seq="+ boardSeq;
    }
    
	 /** 게시판 - 목록 조회  */
    function getBoardList(){
        $.ajax({    
            url     :"/boardCummunity",
            data    : $("#boardForm").serialize(),
            dataType:"JSON",
            cache   : false,
            async   : true,
            type    :"POST",    
            success : function(obj) {
                getBoardListCallback(obj);         

            },           
            error     : function(xhr, status, error) {}
            
         });
    }
    
    /** 게시판 - 목록 조회  콜백 함수 */
    function getBoardListCallback(obj){
        
        var list = obj;
        var listLen = obj.length;
                
        var str = "";
        
        if(listLen >  0){
            	
            for(var a=0; a<listLen; a++){
                
            	var boardSeq		   = list[a].seq;
                var boardTitle         = list[a].title; 
                var boardWriter        = list[a].writer;
                var boardRegDate       = list[a].regdate; 
               
                str += "<tr onclick='javascript:goBoardDetail("+ boardSeq +");' style='cursor:Pointer'>";
                str += "<td  width='80px' style='color:blue;'>"+ boardTitle +"</td>";
                str += "<td width='10px' >"+ boardWriter +"</td>";
                str += "<td  width='30px'>"+ boardRegDate +"</td>";
                str += "</tr>";
                
            } 
            
        } else {
            
            str += "<tr>";
            str += "<td colspan='5'>등록된 글이 존재하지 않습니다.</td>";
            str += "<tr>";
        }
        
        $("#tbody").html(str);
    }
	
</script>
	 	<tr style=""></tr>
	 	
	 	 <style type="text/css">
					li {list-style: none; float: left; padding: 6px;}
			</style> 


                <!-- Begin Page Content -->
                <div class="container-fluid">
                         <div>
                          	  <form id="boardForm" name="boardForm">
                                <table class="table table-bordered" id="dataTable">
                            		 	<colgroup>
                                   			<col width="60"/>
                                   			<col width="20%"/>
                                   			<col width="20%"/>
                                   		</colgroup>
                            		 <tbody id="tbody">							
										
										
									</tbody>
                                </table>
                               </form>
                        </div>
            </div>
