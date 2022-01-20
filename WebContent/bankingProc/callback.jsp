<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 사용자 인증 및 토큰 받기에 사용되는 공통 callback URL

	request.setCharacterEncoding("UTF-8");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();
	String query = request.getQueryString();

	if (query.contains("code") && query.contains("scope") && query.contains("state")) {
		// 사용자 인증 후 실행 %>
		<form method="GET" name="frm" action="<%=path%>/bankingProc/authProc.jsp">
			<input type="hidden" name="query" value="<%=query%>">
		</form>
		<script>
			document.frm.submit();
		</script>
<% } else {
		// token 받은 후 실행
%>
		<form method="GET" name="frm" action="<%=path%>/bankingProc/tokenProc.jsp">
			<input type="hidden" name="query" value="<%=query%>">
		</form>
		<script>
			document.frm.submit();
		</script>
<%
	}
%>
<!-- CSS only -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

<!-- JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>


<!-- 로딩화면 -->
<div class="d-flex justify-content-center">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
