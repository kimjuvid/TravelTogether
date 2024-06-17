<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/fundingList.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
$.ajax({
	url:"fundingListItem.do",
	type:"get",
	data: "selectOption=selectAllByDate",
	success:function(data) {
		$(".items").html(data);
	}
});  

window.onload=()=>{
    document.querySelector('.dropbtn_click').onclick = ()=>{
      dropdown();
    }
    document.getElementsByClassName('fastfood').onclick = ()=>{
      showMenu(value);
    };
    dropdown = () => {
      var v = document.querySelector('.dropdown-content');
      var dropbtn = document.querySelector('.dropbtn')
      v.classList.toggle('show');
    }

    showMenu=(value)=>{
      $(".dropbtn_content").text(value);
      var selectOption = "";
      if(value=="최신순") {
    	  selectOption = "selectAllByDate"
      }
      else if(value=="높은금액순") {
    	  selectOption = "selectAllByPriceDesc"
      }
      else if(value=="낮은금액순") {
    	  selectOption = "selectAllByPriceAsc"
      }
      else if(value=="조회순") {
    	  selectOption = "selectAllByViews"
      }
      $.ajax({
    		url:"fundingListItem.do",
    		type:"get",
    		data: "selectOption="+selectOption,
    	  success:function(responseData) {
    		  $(".items").html(responseData); 
    	  }
      })
      
      
    }
  }
  window.onclick= (e)=>{
    if(!e.target.matches('.dropbtn_click')){
      var dropdowns = document.getElementsByClassName("dropdown-content");

      var dropbtn_icon = document.querySelector('.dropbtn_icon');
      var dropbtn_content = document.querySelector('.dropbtn_content');
      var dropbtn_click = document.querySelector('.dropbtn_click');
      var dropbtn = document.querySelector('.dropbtn');

      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }
</script>
</head>
<body>
	<div class="content_wrapper">
		<h1 class="pageTitle">Funding List</h1>
		<form class="search_wrapper">
			제목 : <input type="text" name="serarch_title"><br> 
			지역 : <input type="text" name="serarch_area"> 
			카테고리 : <input type="text" name="serarch_category"><br> 
			출발일 : <input type="date" name="search_start"> 
			도착일 : <input type="date" name="search_end"> 
			<input type="submit" value="검색">
		</form>
	
	  <div class="dropdown">
	    <button class="dropbtn">
	      <span class="dropbtn_content">최신순</span>
	      <span class="dropbtn_click" style="font-family: Material Icons; font-size : 16px; color : #3b3b3b; float:right;"
	        onclick="dropdown()">V</span>
	    </button>
	    <div class="dropdown-content">
	      <div class="fastfood" onclick="showMenu(this.innerText)">최신순</div>
	      <div class="fastfood" onclick="showMenu(this.innerText)" >높은금액순</div>
	      <div class="fastfood" onclick="showMenu(this.innerText)" >낮은금액순</div>
	      <div class="fastfood" onclick="showMenu(this.innerText)" >조회순</div>
	    </div>
	  </div>
		
		<hr>
		<div class="items">
		
		</div>
	</div>
</body>
</html>