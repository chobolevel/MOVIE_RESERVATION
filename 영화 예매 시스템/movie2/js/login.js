const login = document.querySelector("button");

login.addEventListener("click", e => {
	e.preventDefault();
	if(document.form.id.value == "") {
		alert("아이디가 입력되지 않았습니다.");
		document.form.id.focus();
	}
	else if(document.form.password.value == "") {
		alert("비밀번호가 입력되지 않았습니다.");
		document.form.password.focus();
	}
	else {
		document.form.submit();
	}
})