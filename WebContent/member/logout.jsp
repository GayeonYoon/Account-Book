<%@ page contentType="text/html; charset=UTF-8"%>
<%
      session.invalidate();
%>
<script>
   alert('로그아웃 되었습니다.');
   location.href= "<%=request.getContextPath()%>/board/index.jsp";
</script>