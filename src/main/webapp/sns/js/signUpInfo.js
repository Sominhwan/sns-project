/*  비밀번호 숨기기 보이기 기능 */
$("#password").on("keyup", function(event) {
    if (event.keyCode === 13) {
      event.preventDefault();
      /* $("#checkKey").triggerHandler("click"); */
    } else {
      if (this.value) {
        $("#keyShow").css("display", "inline-block");
      } else {
        $("#keyShow").hide();
      }
    }
  });
  
  $("#keyShow").on("click", function() {
    if ($("#password").attr("type") == "password") {
      $("#password").attr("type", "text");
      $("#keyShow > img").attr({ src: "https://velog.velcdn.com/images/thalsghks/post/728ced01-321e-44a1-bb1e-b1810a4b86a0/image.svg" });
    } else {
      $("#password").attr("type", "password");
      $("#keyShow > img").attr({ src: "https://velog.velcdn.com/images/thalsghks/post/7910658e-94d5-4e16-b24a-a19ad98f6e70/image.svg" });
    }
  });
  

/* 가입정보 다음 버튼 활성화 */
const button = document.getElementById("next-button");
const inputEmail = document.getElementById("userEmail");
const inputName = document.getElementById("userName");
const inputNickName = document.getElementById("userNickName");
const inputPhoneNum = document.getElementById("userPhoneNum");
const inputPw = document.getElementById("password");

inputEmail.addEventListener("keyup", validate);
inputName.addEventListener("keyup", validate);
inputNickName.addEventListener("keyup", validate);
inputPhoneNum.addEventListener("keyup", validate);
inputPw.addEventListener("keyup", validate);

function validate() {
  if (!(inputEmail.value && inputName.value && inputNickName.value && inputPhoneNum.value && inputPw.value)) {
    button.disabled = true;
    button.style.cursor = "default";
    button.classList.remove("next-buttonEnabled");
  } else {
    button.disabled = false;
    button.style.cursor = "pointer";
    button.classList.add("next-buttonEnabled");
  }
}

/*function changePage() {
  alert("오류");
  location.href('http://127.0.0.1:5500/signUpOk.html');
}
*/