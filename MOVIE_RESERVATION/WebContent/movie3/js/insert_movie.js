const bth = document.querySelector("button");
const c_box = document.getElementsByName("seat");

function change() {
	document.form.submit();
}
function count() {
	let cnt = 0;
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].checked == true) {
			cnt++;
		}
	}
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].disabled == true) {
			cnt--;
		}
	}
	document.querySelector("#total").innerHTML = "총 " + cnt + "명  " + cnt * Number(document.querySelector("#m_price").innerHTML) + "원";
}
function check() {
	let cnt = 0;
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].checked == true) {
			cnt++;
		}
	}
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].disabled == true) {
			cnt--;
		}
	}
	if(cnt == 0) {
		alert("최소 1자리 이상 선택해주시기 바랍니다!");
	}
	else {
		form.action = "insert_movieProcess.jsp";
		document.form.submit();
	}
}