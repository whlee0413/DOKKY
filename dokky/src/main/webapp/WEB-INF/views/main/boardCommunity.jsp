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
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        
        if ((day+"").length < 2) {       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
            day = "0" + day;
        }
        if ((month+"").length < 2) {     
            month = "0" + month;
        }

        var getToday = month+"-"+day;
        
        var getThisMonth = parseInt(getToday.substring(0,2));
        var getThisDay = parseInt(getToday.substring(3,5)); 
		
       
        
        var list = obj;
        var listLen = obj.length;
                
        var str = "";
        
        
        if(listLen >  0){
            	
            for(var a=0; a<listLen; a++){
                
               var boardSeq		   	  = list[a].seq;
               var boardTitle         = list[a].title; 
               var boardWriter        = list[a].writer;
               var boardRegDate       = list[a].regdate; 
                
               var regMonth = parseInt(boardRegDate.substring(5,7));
               var regDay = parseInt(boardRegDate.substring(8,10));
               
               var monthGap =  getThisMonth-regMonth;
               var dayGap =  getThisDay-regDay;
               var dateGap = "";
               
              
               if(monthGap == 0 && dayGap == 0 ){
            	   dateGap = "오늘";
               }else if(monthGap == 0 && (dayGap > 0 && dayGap <31) ){
            	   dateGap = dayGap + "일전";
            	   
               }else if(monthGap >1 ){
            	   dateGap = monthGap + "개월전";
               }else if(monthGap =1 ){
            	   dateGap = "지난달";
               }
                
                str += "<tr onclick='javascript:goBoardDetail("+ boardSeq +");' style='cursor:Pointer'>";
                str += "<td  width='80px' style='color:blue;'>"+ boardTitle +"</td>";
                str += "<td width='10px' >"+ boardWriter +"</td>";
                str += "<td  width='30px'>"+ dateGap +"</td>";
                str += "</tr>";
            } 
        } 
        $("#tbody").html(str);
    }
	
</script>
	 	
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
                            		 <tbody id="tbody" >							
										
										
									</tbody>
                                </table>
                               </form>
                        </div>
            </div>
