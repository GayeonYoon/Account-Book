<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	boolean result = mMgr.checkId(id);

	if (result) {
		out.println("이미 존재하는 ID입니다.");
	} else {
		out.println("사용가능 합니다");
	}
%>
