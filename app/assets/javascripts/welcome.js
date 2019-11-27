window.onload = init;

function init() {
  var text = ["Connecting .People", "Through |Music"];
  var text_index = 0;
  var char_index = 0;
  var typeInterval = setInterval(typeWriter, 200);
  var element = document.querySelector(".motto");
  var green = false;
  var red = false;

  function typeWriter() {
    var elem = element.children[text_index];
    if (elem) {
      if (text[text_index].charAt(char_index) == ".") {
        char_index += 1;
        green = true;
      } else if (text[text_index].charAt(char_index) == "|") {
        char_index += 1;
        red = true;
      }
      if (green){
        elem.innerHTML += "<span class='green-underline'>" + text[text_index].charAt(char_index) + "</span>";
      } else if (red) {
        elem.innerHTML += "<span class='red-underline'>" + text[text_index].charAt(char_index) + "</span>";
      } else {
        elem.innerHTML += text[text_index].charAt(char_index);
      }
      char_index += 1;
      if (char_index == text[text_index].length) {
        char_index = 0;
        element.children[text_index].style.paddingBottom = "0";
        element.children[text_index].classList.remove("typewriter");
        text_index += 1;
        if (text_index <= text.length - 1) {
          element.children[text_index].classList.add("typewriter");
          green = false;
          red = false;
        }
      }
    } else {
      clearInterval(typeInterval);
    }
  }

  var scroll_btn = document.getElementById("scroll_btn");
  scroll_btn.addEventListener('click', function(){
    var elem = document.querySelector(".row");
    elem.scrollIntoView({
      behavior: 'smooth'
    });
  });
}
