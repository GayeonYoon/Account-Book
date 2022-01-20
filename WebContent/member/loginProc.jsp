<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String getId = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	//String url = request.getContextPath() + "/board/index.jsp";
	String url = request.getContextPath() + "/bankingProc/allTransationListProc.jsp";
	String msg = "로그인에 실패 하였습니다.";

	boolean result = mMgr.loginMember(getId, pwd);
	if (result) {
		session.setAttribute("idKey", getId);
		msg = "로그인에 성공 하였습니다.";
	}else{
		url = request.getContextPath() + "/member/member.jsp";
	}
	System.out.println("loginProd.jsp : " + getId);
	if (result == true && mMgr.getMember(getId).getAuth() == false) {
		System.out.println(getId);
		url = request.getContextPath() + "/board/registerAccount.jsp";
	}
%>
<script>
	alert("<%=msg%>");	
	location.href="<%=url%>";
</script>