<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="member.MemberDAO" />
<jsp:useBean id="bean" class="member.MemberDTO" />
<jsp:setProperty property="*" name="bean" />
<%
	boolean result = mgr.insertMember(bean);
	String msg = "회원가입 실패!";
	String location = "member.jsp";
	if (result) {
		msg = "회원가입 되었습니다. 로그인을 해주세요.";
		location = path + "/board/index.jsp";
	}
%>
<script>
	alert('<%=msg%>');
	location.href="<%=location%>";
</script>