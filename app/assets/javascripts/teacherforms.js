//global variables
var cur_tab = 0;
var array = new Array(); //history of the page traversal
var jump = 1; //unit of traversal of question flow
var time_count = 0;
var class_counter = 0;
var instrument_number = 19;

// add new class
function addClass() {

  // Generate clone of class HTML div
  var original = document.getElementsByClassName("class-group")[0];
  var cln = original.cloneNode(true);
  elements_to_change = cln.getElementsByClassName("form-control");
  ids_to_change = cln.getElementsByClassName("form-control checkbox")
  class_counter += 1;

  // Update the names
  for (i=0; i < elements_to_change.length; i++) { 
    element = elements_to_change[i];
    rest_of_name = element.name.substr(element.name.indexOf("["));
    new_name = "question" + class_counter.toString();
    element.name = new_name + rest_of_name;
    element.value = null;
  }

  // Update the checkbox id's
  for (j = 0; j < ids_to_change.length; j++) {
    element = ids_to_change[j];
    element.id = element.id.slice(0, element.id.length - 1) + class_counter.toString();
    element.checked = false;
  }

  // Remove the extra other_instrument fields
  var len = cln.getElementsByClassName("other_instrument").length;
  other_instruments = cln.getElementsByClassName("other-instruments")[0];
  while (len > 1) {
    var elem = cln.getElementsByClassName("other_instrument")[len - 1];
    other_instruments.removeChild(elem);
    len = cln.getElementsByClassName("other_instrument").length;
  }

  // Remove the extra time availability fields
  var len = cln.getElementsByClassName("time-group row").length;
  var time_list = cln.getElementsByClassName("time-groups")[0];
  while (len > 1) {
    var last_elem = cln.getElementsByClassName("time-group row 0")[len - 1];
    time_list.removeChild(last_elem);
    len -= 1;
  }

  // Update the other_instrument id
  field = cln.getElementsByClassName("form-control other_instrument")[0];
  field.id = field.id.slice(0, field.id.length - 1) + class_counter.toString();

  // Update the add instrument, remove instrument ids, and other-instruments
  other_instruments.id = other_instruments.id.slice(0, other_instruments.id.length - 1) + class_counter.toString();
  class_item = cln.getElementsByClassName("form-control other_instrument 0")[0];
  class_item.id = "other_instrument" + class_counter.toString();
  class_item.classList.remove("0");
  class_item.classList.add(class_counter.toString());
  add = cln.getElementsByClassName("btn btn-primary btn-sm add_instrument")[0];
  add.id = add.id.slice(0, add.id.length - 1) + class_counter.toString();
  remove = cln.getElementsByClassName("btn btn-primary btn-sm rem_instrument")[0];
  remove.id = remove.id.slice(0, remove.id.length - 1) + class_counter.toString();


  // Update the add time availability id's
  time_buttons = cln.getElementsByClassName("time_button");
  for (k=0; k < time_buttons.length; k++) {
    var current = time_buttons[k]
    current.id = current.id.slice(0, current.id.length - 1) + class_counter.toString();
  }
  time_item = cln.getElementsByClassName("time-group")[0];
  time_item.id = "time_item" + class_counter.toString();
  time_item.classList.remove("0");
  time_item.classList.add(class_counter.toString());
  time_groups = cln.getElementsByClassName("time-groups")[0];
  time_groups.id = "time-groups" + class_counter.toString();


  // Append the updated clone to the form and update the form
  document.getElementById("class-groups").appendChild(cln);
  if (document.getElementsByClassName("class-group").length > 1) {
    document.getElementById("rem_class").style.display = "inline-block";
  } 

  bindInstrumentButton(class_counter);
  bindTimeButton(class_counter);

}


function init() {

  //Show only the first tab and the corresponding buttons
  hide_all_tabs();
  show_tab(cur_tab);
  //Event Listener for prev, next, and submit
  var prev_btn = document.getElementById("prev_btn");
  var next_btn = document.getElementById("next_btn");
  prev_btn.addEventListener('click', prev);
  next_btn.addEventListener('click', next);
  var form = document.querySelector('form')
  form.onkeypress = checkEnter;
  form.addEventListener('submit', function(event) {
    if (!validate_form()) {
      event.preventDefault();
      return false;
    } else {
      return true;
    }
  }, true);

  //Add a hyphen to every third character in phone number form.
  var phoneNumberForm = document.getElementById("phone_number_form")
  phoneNumberForm.addEventListener("keypress", addHyphens)

  function addHyphens() {
    var numberValue = phoneNumberForm.value;
    if (numberValue.length == 3) {
      phoneNumberForm.value += "-";
    } else if (numberValue.length == 7) {
      phoneNumberForm.value += "-";
    }
  }

  bindInstrumentButton(0);
  bindTimeButton(0);

  //Event Listener for adding classes
  var add_class = document.getElementById("add_class");
  add_class.addEventListener('click', addClass);


  // Event Listener for removing classes
  document.getElementById("rem_class").style.display = "none";
  var rem_class = document.getElementById("rem_class");
  rem_class.addEventListener('click', function () {
    var len = document.getElementsByClassName("class-group").length;
    var elem = document.getElementsByClassName("class-group")[len - 1];
    document.getElementById("class-groups").removeChild(elem);
    if (document.getElementsByClassName("class-group").length <= 1) {
      document.getElementById("rem_class").style.display = "none";
    }
  });

}

//Function to bind "add instrument" button to respective section
function bindInstrumentButton(class_num) {
  var class_num_string = class_num.toString();
  var add_button = document.getElementById("add_instrument" + class_num_string);
  var rem_button = document.getElementById("rem_instrument" + class_num_string);
  var instrument_list = document.getElementById("other-instruments" + class_num_string);
  var other_instruments = document.getElementsByName("question" + class_num_string + "[instrument][]");
  // var list_of_other = document.getElementsByClassName("form-control other_instrument");
  var length = 1;

  // Bind add instrument button
  add_button.addEventListener("click", function() {

    var original = document.getElementById("other_instrument" + class_num_string);
    var cln = original.cloneNode(true);
    cln.value = "";

    instrument_list.appendChild(cln);
    length += 1;

    if (length > 1) {
      displayRemoveButton(class_num);
    }

  });

  // Hide and bind remove instrument button
  rem_button.style.display = "none";
  rem_button.addEventListener("click", function() {

    var instruments = document.getElementsByClassName("form-control other_instrument " + class_num_string);
    instrument_list.removeChild(instruments[length - 1]);
    length -= 1;

    if (length <= 1) {
      hideRemoveButton(class_num);
    }
  });
}

function bindTimeButton(class_num) {
  var class_num_string = class_num.toString();
  var add_button = document.getElementById("add_time" + class_num_string);
  var rem_button = document.getElementById("rem_time" + class_num_string);
  var time_list = document.getElementById("time-groups" + class_num_string);
  var length = 1;

  add_button.addEventListener("click", function() {

    var original = document.getElementById("time_item" + class_num_string);
    var cln = original.cloneNode(true);
    time_list.appendChild(cln);

    length += 1;
    if (length > 1) {
      displayRemoveTime(class_num);
    }

  });

  rem_button.style.display = "none";
  rem_button.addEventListener("click", function() {
    var last_elem = document.getElementsByClassName("time-group row " + class_num_string)[length -1];
    time_list.removeChild(last_elem);
    length -= 1;

    if (length <= 1) {
      hideRemoveTime(class_num);
    }
  });

}

function displayRemoveTime(class_num) {
  document.getElementById("rem_time" + class_num.toString()).style.display = "inline-block";
}

function hideRemoveTime(class_num) {
  document.getElementById("rem_time" + class_num.toString()).style.display = "none";
}

function displayRemoveButton(class_num) {
  document.getElementById("rem_instrument" + class_num.toString()).style.display = "inline-block";
}

function hideRemoveButton(class_num) {
  document.getElementById("rem_instrument" + class_num.toString()).style.display = "none";
}

//Displays the 'other' text field for custom instrument
function display_other(elem) {
  var other = elem.getElementsByClassName("instr_other")[0];
  var val = elem.getElementsByTagName("select")[0].value;
  if (val == "Others") {
    other.style.display = 'block';
  } else {
    other.style.display = 'none';
  }
}

//prevents submission through pressing 'Enter' key
function checkEnter(e){
 e = e || event;
 var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
 return txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
}

//Hides all tabs
function hide_all_tabs() {
  var tabs = document.getElementsByClassName("tab");
  for (var i = 0; i < tabs.length; i++) {
    tabs[i].style.display = "none";
  }
}
// Selectively show nth tab and hide others
function show_tab(n) {
  var tabs = document.getElementsByClassName("tab");
  tabs[n].style.display = "block";
  if (n == 0) {
    document.getElementById("prev_btn").style.display = "none";
  } else {
    document.getElementById("prev_btn").style.display = "inline";
  }
  if (n == (tabs.length - 1) || tabs[n] == document.getElementById("return_q")) {
    document.getElementById("sub_btn").style.display = "inline";
    document.getElementById("next_btn").style.display = "none";
  } else {
    document.getElementById("sub_btn").style.display = "none";
    document.getElementById("next_btn").style.display = "inline";
  }
}

function prev() {
  var tabs = document.getElementsByClassName("tab");
  tabs[cur_tab].style.display = "none";
  cur_tab = array.pop();
  show_tab(cur_tab);
}
function next() {
  if (!validate_form()) {
    return false;
  }
  var tabs = document.getElementsByClassName("tab");
  tabs[cur_tab].style.display = "none";
  array.push(cur_tab);
  //tab navigation listener
  var jump_group0 = tabs[cur_tab].querySelector("#jump-group0");
  if (jump_group0 != null) {
    var radios = jump_group0.getElementsByTagName('input');
    for (var i = 0; i < radios.length; i++) {
      if (radios[i].value == "No" && radios[i].checked) {
        jump = 2;
      }
    }
  }
  var jump_group1 = tabs[cur_tab].querySelector("#jump-group1");
  if (jump_group1 != null) {
    var radios = jump_group1.getElementsByTagName('input');
    for (var i = 0; i < radios.length; i++) {
      if (radios[i].value == "No" && radios[i].checked) {
        jump = 2;
      }
    }
  }
  var jump_group2 = tabs[cur_tab].querySelector("#jump-group2");
  if (jump_group2 != null) {
    var radios = jump_group2.getElementsByTagName('input');
    for (var i = 0; i < radios.length; i++) {
      if (radios[i].value == "New" && radios[i].checked) {
        jump = 2;
      }
    }
  }
  var jump_group3 = tabs[cur_tab].querySelector("#jump-group3");
  if (jump_group3 != null) {
    jump = 2;
  }
  cur_tab = cur_tab + jump;
  jump = 1;
  show_tab(cur_tab);
}

// Form validation
function validate_form() {
  var tab = document.getElementsByClassName("tab")[cur_tab];
  var form_groups = tab.getElementsByClassName("form-group");
  var valid = true;
  for (var i = 0; i < form_groups.length; i++) {
    var form_group = form_groups[i];
    if (!form_group.classList.contains("required")) {
      continue;
    }
    if (form_group.classList.contains("email-group")) {     //  Email validation
      var email = form_group.getElementsByTagName("input")[0].value;
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if (!email) {
        form_group.getElementsByTagName("input")[0].classList.add("invalid");
        form_group.getElementsByTagName("input")[0].placeholder = "Please fill out this field.";
        valid = false;
      } else if (!re.test(String(email).toLowerCase())) {
        form_group.getElementsByTagName("input")[0].classList.add("invalid");
        form_group.getElementsByTagName("small")[0].innerHTML = "Please enter in a valid email."
        valid = false;
      } else {
        form_group.getElementsByTagName("input")[0].classList.add("form-control");
        form_group.getElementsByTagName("input")[0].classList.remove("invalid");
        form_group.getElementsByTagName("small")[0].innerHTML = "Please enter in your email here."
      }
    } else if (form_group.classList.contains("radio-group")) {       // Radio Groups Validation
      var cnt = 0;
      var radios = form_group.getElementsByTagName("input");
      for (var j = 0; j < radios.length; j++) {
        if (radios[j].checked) {
          cnt = cnt + 1;
        }
      }
      if (cnt == 0) {
        form_group.classList.add("invalid");
        form_group.getElementsByClassName("form-text")[0].innerHTML = "Please fill out this field.";
        valid = false;
      } else {
        form_group.classList.remove("invalid");
      }
    } else if (form_group.classList.contains("checkbox-group")) {   // Checkbox validation
      var cnt = 0;
      var checkboxes = form_group.getElementsByTagName("input");
      for (var j = 0; j < checkboxes.length; j++) {
        if (checkboxes[j].checked) {
          cnt = cnt + 1;
        }
      }
      if (cnt == 0) {
        form_group.classList.add("invalid");
        form_group.getElementsByClassName("form-text")[0].innerHTML = "Please fill out this field.";
        valid = false;
      } else {
        form_group.classList.remove("invalid");
      }
    } else if (form_group.classList.contains("dropdown-group")) {   // Dropdown validation
      var elems = form_group.getElementsByTagName("select");
      for (var j = 0; j < elems.length; j++) {
        var elem = elems[j];
        if (elem.value == "") {
          elem.classList.add("invalid");
          form_group.getElementsByClassName("form-text")[0].innerHTML = "Please fill out this field.";
          valid = false;
        } else {
          elem.classList.remove("invalid");
        }
      }
    } else { //regular text input
      var input = form_group.getElementsByTagName("input")[0];
      if (input.value == "") {
        // add an "invalid" class to the field:
        if (!input.classList.contains("invalid")) {
          input.classList.add("invalid");
        }
        input.placeholder = "Please fill out this field.";
        valid = false;
      } else {
        input.classList.remove("invalid");
      }
    }
  }
  return valid;
}

// Prevent the browser from attempting to execute init before page
// finishes loading, which logs a phantom error in console
window.onload = init;
