const check = document.querySelector("#check");
const move = document.querySelector("#move");
const pass = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/
const name = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+$/
const birth = /^[0-9]{8,}$/	
const phone = /^[0-9]{4,}$/
	
check.addEventListener("click", e => {
	e.preventDefault();
	if(document.form.id.value == "") {
		alert("아이디가 입력되지 않았습니다.");
		document.form.id.focus();
	}
	else if(document.form.password.value == "") {
		alert("비밀번호가 입력되지 않았습니다.");
		document.form.password.focus();
	}
	else if(pass.test(document.form.password.value) == false) {
		alert("비밀번호는 최소 8자이상, \n최소 하나의 문자와 숫자를 포함해야합니다.");
		document.form.password.focus();
	}
	else if(document.form.passcheck.value == "") {
		alert("확인 비밀번호가 입력되지 않았습니다.");
		document.form.passcheck.focus();
	}
	else if(document.form.password.value != document.form.passcheck.value) {
		alert("비밀번호와 확인 비밀번호가 일치하지 않습니다.");
	}
	else if(document.form.name.value == "") {
		alert("이름이 입력되지 않았습니다.");
		document.form.name.focus();
	}
	else if(name.test(document.form.name.value) == false) {
		alert("이름은 한글로만 입력할 수 있습니다.");
		document.form.name.focus();
	}
	else if(document.form.nickname.value == "") {
		alert("닉네임이 입력되지 않았습니다");
		document.form.nickname.focus();
	}
	else if(document.form.birth.value == "") {
		alert("생년월일이 입력되지 않았습니다.");
		document.form.birth.focus();
	}
	else if(birth.test(document.form.birth.value) == false) {
		alert("생년월일은 숫자8자리로 입력해주시기 바랍니다.\n예)20000218");
		document.form.birth.focus();
	}
	else if(document.form.phone2.value == "" || document.form.phone3.value == "") {
		alert("전화번호가 입력되지 않았습니다");
	}
	else if(phone.test(document.form.phone2.value) == false || phone.test(document.form.phone3.value) == false) {
		alert("전화번호는 숫자4자리로 입력해주시기 바랍니다.");
	}
	else if(document.form.address.value == "") {
		alert("주소가 입력되지 않았습니다.");
		document.form.address.focus();
	}
	else {
		document.form.submit();
	}
})

move.addEventListener("click", e => {
	e.preventDefault();
	location.href = "login.jsp";
})