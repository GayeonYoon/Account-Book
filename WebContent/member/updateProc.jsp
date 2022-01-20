<jsp:useBean id="bean" class="member.MemberDTO"/>
<jsp:setProperty property="*" name="bean"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String url = request.getContextPath() + "/member/update.jsp";
	String msg = "회원정보수정에 실패하였습니다.";

	boolean result = mMgr.updateMember(bean);
	if (result) {
		msg = "회원정보를 수정하였습니다.";
		url = request.getContextPath() + "/board/index.jsp";
	}
%>
<script>
	alert("<%=msg%>");	
	location.href="<%=url%>";
</script>