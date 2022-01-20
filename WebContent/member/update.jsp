<%@page import="member.MemberDTO"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDTO mem = mMgr.getMember(id);
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<head>
<script>
	function updateInputCheck() {

		var chkboolean = false;

		// 비밀번호 및 비밀번호 확인 체크
		if (document.updateFrm.pwd.value == "") {
			alert("비밀번호를 입력하세요")
			document.updateFrm.pwd.focus();
			return;
		}
		if (document.updateFrm.repwd.value == "") {
			alert("비밀번호를 확인하세요");
			document.updateFrm.repwd.focus();
			return;
		}
		if (document.updateFrm.pwd.value != document.updateFrm.repwd.value) {
			alert("비밀번호가 일치하지 않습니다.");
			document.updateFrm.repwd.value = "";
			document.updateFrm.repwd.focus();
			return;
		}
		// 이메일 체크
		if (document.updateFrm.email.value == "") {
			alert("이메일을 입력해주세요.");
			document.updateFrm.email.focus();
			return;
		}
		var str = document.updateFrm.email.value;
		var atPos = str.indexOf('@');
		var atLastPos = str.lastIndexOf('@');
		var dotPos = str.indexOf('.');
		var spacePos = str.indexOf(' ');
		var commaPos = str.indexOf(',');
		var eMailSize = str.length;
		if (atPos > 1 && atPos == atLastPos && dotPos > 3 && spacePos == -1
				&& commaPos == -1 && atPos + 1 < dotPos
				&& dotPos + 1 < eMailSize);
		else {
			alert('E-mail형식을 지켜주세요');
			document.updateFrm.email.focus();
			return;
		}

		document.updateFrm.submit();
	}

	function win_close() {
		self.close();
	}
</script>
</head>
<div class="container">
	<table class="table table-light table-borderless rounded-lg">
		<tr>
			<td>
				<form name="updateFrm" method="post"
					action="<%=path%>/member/updateProc.jsp">
					<input type="hidden" name="id" value="<%=mem.getId()%>">
					<table class="table table-striped table-light" width="70%">
						<thead>
							<tr>
								<th class="pl-4 align-middle pt-4" scope="col" colspan="2"><h3>회원정보수정</h3></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="pl-4 align-middle"><label for="id"><b>아이디</b></label></td>
								<td><strong><%=mem.getId()%></strong></td>
							</tr>
							<tr>
								<td class="pl-4 align-middle"><label for="inputName"><b>이름</b></label></td>
								<td><strong><%=mem.getName()%></strong></td>
							</tr>
							<tr>
								<td class="pl-4 align-middle"><label for="inputPassword1"><b>비밀번호</b></label></td>
								<td><input type="password"
									class="form-control form-control-lg col-md-8"
									id="inputPassword1" name="pwd"></td>
							</tr>
							<tr>
								<td class="pl-4 align-middle"><label for="inputPassword2"><b>비밀번호
											확인</b></label></td>
								<td><input type="password"
									class="form-control form-control-lg col-md-8"
									id="inputPassword2" name="repwd"></td>
							</tr>
							<tr>
								<td class="pl-4 align-middle"><label for="inputEmail"><b>이메일</b></label></td>
								<td><input type="email"
									class="form-control form-control-lg col-md-8" id="inputEmail"
									placeholder="name@example.com" name="email"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									<button type="button" class="btn btn-primary btn-lg active"
										onclick="updateInputCheck()">회원수정</button>
									<button type="reset" class="btn btn-light btn-lg active">다시쓰기</button>
									<button type="button" class="btn btn-light btn-lg active"
										onclick="history.go(-1)">수정취소</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</td>
		</tr>
	</table>
</div>