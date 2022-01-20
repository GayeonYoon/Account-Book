<%@page import="account.AllTransationListJSON"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();
	String msg = "탈퇴 되었습니다.";
	String url = "/board/index.jsp";
	if(mMgr.deleteMember(id)){
		session.invalidate();
		AllTransationListJSON.getInstance().setJson("");
	}else{
		msg = "탈퇴 실패!";
		url = "/board/index.jsp";
	}
%>
<script>
	alert('<%=msg%>');
	location.href = "<%=path + url %>";
</script>