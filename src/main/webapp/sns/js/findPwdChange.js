/* 비밀번호 찾기 다음 버튼 활성화 */
const button = document.getElementById("findPwdCheckBtn");
const inputPassword = document.getElementById("userNewPwd");
const inputPassword2 = document.getElementById("userNewPwdCheck");

inputPassword.addEventListener("keyup", validate);
inputPassword2.addEventListener("keyup", validate);

function validate() {
  if (!(inputPassword.value && inputPassword2.value)) {
    button.disabled = true;
    button.style.cursor = "default";
    button.classList.remove("findPwdCheckBtnEnabled");
  } else {
    button.disabled = false;
    button.style.cursor = "pointer";
    button.classList.add("findPwdCheckBtnEnabled");
  }
}

