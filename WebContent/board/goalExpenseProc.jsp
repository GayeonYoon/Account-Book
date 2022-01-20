<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int cost = Integer.parseInt(request.getParameter("cost"));
	String url = request.getContextPath() + "/bankingProc/allTransationListProc.jsp";
	String msg = "로그인에 실패 하였습니다.";

	boolean result = mMgr.updateGoalExpense(id, cost);
	if (result) {
		msg = "목표지출을 설정하였습니다.";
	}
%>
<script>
	alert("<%=msg%>");	
	location.href="<%=url%>";
</script>
<!-- 로딩화면 -->
<div class="mt-5 d-flex justify-content-center">
	<div class="spinner-border" role="status">
		<span class="sr-only">Loading...</span>
	</div>
</div>