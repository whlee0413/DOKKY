<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function(){    
		getBoardHashTagList();
    });        
	
	
	/** 게시판 - 상세 페이지 이동 */
    function goHashTagList(tagName){                
        location.href = "/boardList?tagName="+ tagName;
    }
    
	 /** 게시판 - 목록 조회  */
    function getBoardHashTagList(){
        $.ajax({    
            url     :"/boardHashTags",
            data    : $("#boardHashTagForm").serialize(),
            dataType:"JSON",
            cache   : false,
            async   : true,
            type    :"POST",    
            success : function(obj) {
                getBoardHashTagListCallback(obj);
            },           
            error     : function(xhr, status, error) {
            	console.log(xhr, status, error);
            }
            
         });
    }
    
    /** 게시판 - 목록 조회  콜백 함수 */
    function getBoardHashTagListCallback(obj){
        
        var list = obj;
        var listLen = obj.length;
                
        var str = "";
        
        if(listLen >  0){
            	
            for(var a=0; a<listLen; a++){
                
            	var tagName		   = list[a].tagName;
            	var tagId		   = list[a].tagId;
               
            	
            	
                str += "<h3 >";
                str +=	'<a href="javascript:void(0);" onclick="javascript:goHashTagList(' +'\''  +tagName + '\'' + ')">' +'#'+tagName+ '</a>';
            	str += "</h3 >";
            } 
        } else {
            
            str += "<tr>";
            str += "<td colspan='5'>등록된 글이 존재하지 않습니다.</td>";
            str += "<tr>";
        }
        
        $("#tbody3").html(str);
    }
	
</script>
	 	<tr style=""></tr>
	 	
	 	 <style type="text/css">
					li {list-style: none; float: left; padding: 6px;}
			</style> 


                <!-- Begin Page Content -->
                <div class="container-fluid">
                         <div>
                          	  <form id="boardHashTagForm" name="boardHashTagForm">
                                <table class="table " id="dataTable3">
                            		 <tbody id="tbody3">							
										
										
									</tbody>
                                </table>
                               </form>
                        </div>
            </div>
