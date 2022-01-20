function inputCheck() {

	var chkboolean = false;

	var idcheck = document.getElementById("idCheck");
	if (!idcheck.innerHTML.includes("사용가능")) {
		alert("사용 불가 입니다.");
		document.regFrm.id.focus();
		return false;
	}

	// 이름 체크
	if (document.regFrm.name.value == "") {
		alert("이름을 입력해주세요.");
		document.regFrm.name.focus();
		return;
	}
	// 비밀번호 및 비밀번호 확인 체크
	if (document.regFrm.pwd.value == "") {
		alert("비밀번호를 입력하세요")
		document.regFrm.pwd.focus();
		return;
	}
	if (document.regFrm.repwd.value == "") {
		alert("비밀번호를 확인하세요");
		document.regFrm.repwd.focus();
		return;
	}
	if (document.regFrm.pwd.value != document.regFrm.repwd.value) {
		alert("비밀번호가 일치하지 않습니다.");
		document.regFrm.repwd.value = "";
		document.regFrm.repwd.focus();
		return;
	}
	// 이메일 체크
	if (document.regFrm.email.value == "") {
		alert("이메일을 입력해주세요.");
		document.regFrm.email.focus();
		return;
	}
	var str = document.regFrm.email.value;
	var atPos = str.indexOf('@');
	var atLastPos = str.lastIndexOf('@');
	var dotPos = str.indexOf('.');
	var spacePos = str.indexOf(' ');
	var commaPos = str.indexOf(',');
	var eMailSize = str.length;
	if (atPos > 1 && atPos == atLastPos && dotPos > 3 && spacePos == -1
			&& commaPos == -1 && atPos + 1 < dotPos && dotPos + 1 < eMailSize)
		;
	else {
		alert('E-mail형식을 지켜주세요');
		document.regFrm.email.focus();
		return;
	}

	document.regFrm.submit();
}

function win_close() {
	self.close();
}