<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<jsp:useBean id="apiClient" class="member.MemberDAO" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();
	boolean result = mMgr.updateAuth(id);
	String msg = "인증실패하였습니다.";
	String url = path + "/board/auth.jsp";
	if (result) {
		msg = "인증되었습니다.";
		url = path + "/board/goalExpense.jsp";
	}

	// 여기에서 파라미터를 받는다.
	String redirectUri = path + "/bankingProc/callback.jsp";
	System.out.println("authProc.jsp : \n" + request.getParameter("query"));
	String query[] = request.getParameter("query").split("&");
	String code = query[0].split("=")[1];
	String scope = query[1].split("=")[1].replaceAll("%20", " ");
	String state = query[2].split("=")[1];
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

<form method="post" name="postFrm" action="tokenProc.jsp">
	<input type="hidden" name="path" value="/oauth/2.0/token?">
	<input type="hidden" name="code" value="<%=code%>">
	<input type="hidden" name="redirect_uri" value="<%=redirectUri%>">
	<input type="hidden" name="grant_type" value="authorization_code">
</form>
<script>
	this.document.postFrm.submit();
</script>