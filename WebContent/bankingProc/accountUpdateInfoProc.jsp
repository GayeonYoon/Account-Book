<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<%
	request.setCharacterEncoding("UTF-8");
	String fintechUseNum = request.getParameter("fintechUseNum");
	String accountAlias = request.getParameter("accountAlias");

	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7)) + request.getContextPath();
	String token = mMgr.getMember(id).getAccess_token();
%>
<script>//CROS 방식으로 넘김.
	var json = {fintech_use_num : '<%=fintechUseNum%>', account_alias : '<%=accountAlias%>'};
	var useJson = JSON.stringify(json);
	
	var xhr = new XMLHttpRequest();
	xhr.open('POST', 'https://testapi.openbanking.or.kr/v2.0/account/update_info',true);
	xhr.setRequestHeader('Accept', 'application/json');
	xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
	xhr.setRequestHeader('Content-type', 'application/json; charset=UTF-8');
	xhr.setRequestHeader('Authorization', 'Bearer <%=token%>');
	xhr.send(useJson);
		
	xhr.onreadystatechange = function (e) {
		// readyState = 1, 2, 3
		if (xhr.readyState != XMLHttpRequest.DONE){
			return;
		}
		// readyState = 4
		if(xhr.status == 200) {
			alert("수정되었습니다.")
		} else {
			console.log("Error!");
		}
	};

	location.href='<%=path%>/bankingProc/accountListProc.jsp';
</script>