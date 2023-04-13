/* 비밀번호 찾기 다음 버튼 활성화 */
const button = document.getElementById("findPwdBtn");
const inputEmail = document.getElementById("userEmail");

inputEmail.addEventListener("keyup", validate);

function validate() {
  if (!(inputEmail.value)) {
    button.disabled = true;
    button.style.cursor = "default";
    button.classList.remove("findPwdBtnEnabled");
  } else {
    button.disabled = false;
    button.style.cursor = "pointer";
    button.classList.add("findPwdBtnEnabled");
  }
}

