/* 가입정보 다음 버튼 활성화 */
const button = document.getElementById("next-button");
const inputEmail = document.getElementById("userEmail");
const inputName = document.getElementById("userName");
const inputNickName = document.getElementById("userNickName");
const inputPhoneNum = document.getElementById("userPhoneNum");

inputEmail.addEventListener("keyup", validate);
inputName.addEventListener("keyup", validate);
inputNickName.addEventListener("keyup", validate);
inputPhoneNum.addEventListener("keyup", validate);

function validate() {
  if (!(inputEmail.value && inputName.value && inputNickName.value && inputPhoneNum.value)) {
    button.disabled = true;
    button.style.cursor = "default";
    button.classList.remove("next-buttonEnabled");
  } else {
    button.disabled = false;
    button.style.cursor = "pointer";
    button.classList.add("next-buttonEnabled");
  }
}
