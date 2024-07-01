<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 펀딩 컨펌</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/fundingConfirm.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="./adminMenu.jsp"%>
		<div class="content">
			<div>${funding}</div>
			<div class="button-group">
				<button class="confirm-button" onclick="f_confirmBtnClick()">승인하기</button>
				<button class="reject-button">반려하기</button>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
	
	<!-- 승인 모달창 -->
	<div class="confirm-modal-box">
		<h2>펀딩 승인</h2>
		<p>이 펀딩을 승인하시겠습니까?</p>
		<div class="modal-button-group">
			<button class="cancel-button" onclick="f_modalCancelBtnClick()">취소</button>
			<button class="confirm-button" onclick="f_modalConfirmBtnClick()">확인</button>
		</div>
	</div>
	
	<!-- 승인 완료 모달창 -->
	<div class="confirm-result-modal-box">
		<h2>승인 완료</h2>
		<p>승인이 완료되었습니다.</p>
		<button class="confirm-button" onclick="location.href='${path}/admin/fundingList.do'">확인</button>
	</div>
	
	<!-- 반려 모달창 -->
	<div class="reject-modal-box">
	
	</div>
	
	<div class="modal_bg"></div>
	
	<script>
	$(function() {
		menuInit();
		
	});
	
	function menuInit() {
		var currentUrl = window.location.href;
		
		if (currentUrl.includes("funding")) {
			$("#fundingMenu").addClass("active");
		}
	}
	
	function f_confirmBtnClick() {
		$(".confirm-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
		
		$("body").addClass("scrollLock");
	}
	
	function f_modalCancelBtnClick() {
		$(".confirm-modal-box").fadeOut(500);
		$(".modal_bg").fadeOut(500);
		
		$("body").removeClass("scrollLock");
	}
	
	function f_modalConfirmBtnClick() {
		$(".confirm-modal-box").fadeOut(500);
		
		var funding_id = ${funding.funding_id};
		$.ajax({
			url: "${path}/admin/fundingConfirm.do",
			type: "post",
			data: {funding_id: funding_id},
			success: function(responseData){
				console.log(responseData);
				if(responseData === "1") {
					$(".confirm-result-modal-box").fadeIn(500);
					$("body").addClass("scrollLock");
				} else {
					alert("승인중 오류가 발생하였습니다. 다시 시도해주세요.");
					$(".modal_bg").fadeOut(500);
				}
			}
		});
	}
</script>
</body>
</html>