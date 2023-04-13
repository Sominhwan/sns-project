/* 아이디 찾기 버튼 활성화 */
const button = document.getElementById("findIdBtn");
const inputName = document.getElementById("userName");
const inputNickName = document.getElementById("userNickName");

inputName.addEventListener("keyup", validate);
inputNickName.addEventListener("keyup", validate);

function validate() {
  if (!(inputName.value && inputNickName.value)) {
    button.disabled = true;
    button.style.cursor = "default";
    button.classList.remove("findIdBtnEnabled");
  } else {
    button.disabled = false;
    button.style.cursor = "pointer";
    button.classList.add("findIdBtnEnabled");
  }
}

