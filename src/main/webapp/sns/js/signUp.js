
/* 약관 동의 체크박스 */
const form = document.querySelector('#form_wrap');
const checkAll = document.querySelector('.terms_check_all input');
const checkBoxes = document.querySelectorAll('.input_check input');
const submitButton = document.querySelector('button');

const agreements = {
  termsOfService: false,
  privacyPolicy: false,
  allowPromotions: false,
};

form.addEventListener('submit', (e) => e.preventDefault()); // 새로고침(submit) 되는 것 막음

checkBoxes.forEach((item) => item.addEventListener('input', toggleCheckbox));

function toggleCheckbox(e) {
  const { checked, id } = e.target;  
  agreements[id] = checked;
 
  this.parentNode.classList.toggle('next-buttonDisabled');
  checkAllStatus();
  toggleSubmitButton();
}

function checkAllStatus() {
  const { termsOfService, privacyPolicy, allowPromotions } = agreements;

  if (termsOfService && privacyPolicy && allowPromotions) {
    checkAll.checked = true;
  } else {
    checkAll.checked = false;
  }
}

function toggleSubmitButton() {
  const { termsOfService, privacyPolicy } = agreements;
  if (termsOfService && privacyPolicy) {
    submitButton.disabled = false;
    submitButton.style.cursor = "pointer";
    submitButton.classList.add("next-buttonDisabled");
  } else {
    submitButton.disabled = true;
    submitButton.style.cursor = "default";
    submitButton.classList.remove("next-buttonDisabled");
  }
}

checkAll.addEventListener('click', (e) => {
  const { checked } = e.target;
  if (checked) {
    checkBoxes.forEach((item) => {
      item.checked = true;
      agreements[item.id] = true;
      item.parentNode.classList.add('next-buttonDisabled');
    });
  } else {
    checkBoxes.forEach((item) => {
      item.checked = false;
      agreements[item.id] = false;
      item.parentNode.classList.remove('next-buttonDisabled');
    });
  }
  toggleSubmitButton();
});

/* 약관동의 팝업 이벤트 */
function show () {
    document.querySelector(".background").className = "background show";
}
  
function close () { 
    document.querySelector(".background").className = "background";
}

function check () { 
  document.querySelector(".background").className = "background";
}

document.querySelector("#show").addEventListener('click', show);
document.querySelector("#close").addEventListener('click', close);
document.querySelector("#check").addEventListener('click', check);

/* 개인정 동의 팝업 이벤트 */
function show2 () {
  document.querySelector(".background2").className = "background2 show2";
}

function close2 () { 
  document.querySelector(".background2").className = "background2";
}

function check2 () { 
document.querySelector(".background2").className = "background2";
}

document.querySelector("#show2").addEventListener('click', show2);
document.querySelector("#close2").addEventListener('click', close2);
document.querySelector("#check2").addEventListener('click', check2);



