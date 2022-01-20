<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<%
	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();
	String currentPage = request.getRequestURI().split("/")[3];
	System.out.println("현재페이지 : " + currentPage);
%>
<!DOCTYPE html>
<html lang="kor">

<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>가계부</title>
<!-- JQuery -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="<%=request.getContextPath()%>/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">
<link
	href="<%=request.getContextPath()%>/vendor/simple-line-icons/css/simple-line-icons.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="<%=request.getContextPath()%>/css/stylish-portfolio.min.css"
	rel="stylesheet">

<!-- FontAwsome -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<!-- Login Script -->
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.id.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.id.focus();
			return;
		}
		if (document.loginFrm.pwd.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.pwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
</script>

<!-- 회원가입 member.jsp Script -->
<script src="<%=request.getContextPath()%>/js/script.js"></script>
<script type="text/javascript">
	function idCheck(id) {
		var idcheck = document.getElementById("idCheck");
		if (id.length < 8) {
			idcheck.innerHTML = "8자리로 만들어라";
		} else {
			idcheckOfServer(id);
		}
		url = "idCheck.jsp?id=" + id;
		console.log("<%=request.getContextPath()%>");
	}

	function idcheckOfServer(id) {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function(){
			var idcheck = document.getElementById("idCheck");
			if(this.readyState == 4 && this.status == 200){
				var str = this.responseText;
				idcheck.innerHTML=str;
				return str;
			}
		};
		var params = "?id="+encodeURIComponent(id);
		xhttp.open("GET", "<%=path%>/nohead/idCheck.jsp" + params, true);
		xhttp.send();
	}
</script>
</head>

<body id="page-top bg-light">
	<!-- Navigation -->
	<%
		if (id != null) {
	%>
	<div class="sticky-top bg-light text-center"><!-- d-flex justify-content-center  -->
		<nav class="navbar navbar-expand-lg navbar-light justify-content-center"
			style="height: 5em; color: black;">
			<a id="index" class="nav-link col col-lg-2" href="<%=request.getContextPath()%>/board/index.jsp">
				<i class="fa fa-home fa-2x"></i><br> 홈</a>
			<a class="nav-link col col-lg-2" href="<%=request.getContextPath()%>/bankingProc/accountListProc.jsp">
				<i class="fa fa-piggy-bank fa-2x"></i><br> 내 계좌</a>
			<a class="nav-link col col-lg-2"  href="<%=request.getContextPath()%>/board/myAnalytics.jsp">
				<i class="far fa-chart-bar fa-2x"></i><br> 지출 통계</a>
			<a id="myPage" class="nav-link col col-lg-2" href="<%=request.getContextPath()%>/board/myPage.jsp">
				<i class="fa fa-user fa-2x"></i><br> My Page</a>
		</nav>
	</div>
	<%
		}
	%>