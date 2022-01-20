<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cliendId" class="openBanking.apiClient" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>
   function auth() {
      var tmpWindow = window.open('about:black');
      tmpWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
            + "response_type=code&"
            + "client_id=<%=cliendId.getId()%>&"
            + "redirect_uri=<%=path%>/bankingProc/callback.jsp&"
			+ "scope=login transfer inquiry&"
			+ "state=12345678901234567890123456789012&" + "auth_type=0";
	}
</script>

<body>
	<div class="masthead d-flex pt-4"
		style="background: linear-gradient(90deg, rgba(255, 255, 255, 0.2) 0%, rgba(255, 255, 255, 0.2) 100%), URL(<%=path%>/img/bg-regAccount.png); background-repeat: no-repeat; background-position: center bottom; background-size: contain;">
		<div class="container text-center my-auto">
			<h1 class="mb-5" style="font-size: 3.5rem;">등록된 계좌가 없습니다.</h1>
			<button type="button" class="btn btn-primary btn-lg" onclick="auth()">계좌등록</button>
		</div>
	</div>
</body>
<div class="overlay"></div>