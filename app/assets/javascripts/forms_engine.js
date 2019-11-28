/* Flexible form engine that allows custom 
 * scripting of input fields via special_features
 *
 * TODO: write documentation (LOL)
 * I admit this is not easily readable
 */
const Engine = {
  START_TAB: 0,
  current_tab: 0,
  tab_history: [],
  special_features: {},
  init: function(features) {
    Engine.special_features = features;

    // Previous button functionality
    var prev_btn = document.getElementById("prev_btn");
    var next_btn = document.getElementById("next_btn");
    prev_btn.addEventListener('click', function back_button_tab() {
      if (Engine.tab_history.length > 0) {
        Engine.current_tab = Engine.tab_history.pop();
      } else {
        Engine.current_tab = Engine.START_TAB;
      }
      Engine.showTab(Engine.current_tab);
    });
    // Next button functionality
    // Note that this is NOT symmetric to prev_btn
    next_btn.addEventListener('click', function next_button_tab() {
      if (!Engine.special_features[Engine.current_tab].override_next) {
          if (_defaultValidator()) {
          Engine.tab_history.push(Engine.current_tab);
          Engine.current_tab += 1;
          Engine.showTab(Engine.current_tab);
        }
      } else {
        var val = Engine.special_features[Engine.current_tab].override_next();
        if (val !== 0) {
          Engine.tab_history.push(Engine.current_tab);
          Engine.current_tab += val;
          Engine.showTab(Engine.current_tab);
        }
      }
    });
    // Validator for submission
    document.getElementById("allForm").addEventListener('submit', function(evt) {
      evt.returnValue = _defaultValidator();
    });

    // Phone format enforcement
    var add_hyphens = function enforce_phone_number_format(evt) {
      if (evt.key === "Backspace" || evt.key === "Delete") {
        return true;
      }
      var numberValue = evt.currentTarget.value;
      if (numberValue.length === 3) {
        numberValue += "-";
      } else if (numberValue.length === 7) {
        numberValue += "-";
      }
      evt.currentTarget.value = numberValue;
    }
    var phone_inputs = document.getElementsByClassName("phone-number-input");
    for (var i = 0; i < phone_inputs.length; i += 1) {
      phone_inputs[i].setAttribute("maxlength", "12"); 
      phone_inputs[i].addEventListener('keydown', add_hyphens);
    }

    // Custom events
    for (var i = 0; i < document.getElementsByClassName("tab").length; i += 1) {
      var custom_events = Engine.special_features[i].events;
      for (var j = 0; j < custom_events.length; j += 1) {
        event_obj = custom_events[j];
        document.getElementById(event_obj.target).addEventListener(event_obj.event, event_obj.action);
      }
    }

    // Show start tab
    Engine.showTab(Engine.START_TAB);
  },
  showTab: function(tab_num) {
    // Hide all other tabs, and show current tab
    var tabs = document.getElementsByClassName("tab");
    for (var i = 0; i < tabs.length; i++) {
      tabs[i].style.display = "none";
    }
    var tabs = document.getElementsByClassName("tab");
    tabs[tab_num].style.display = "block";
    
    // Disable prev button if history is empty
    document.getElementById("prev_btn").disabled = (Engine.tab_history.length === 0);
    // Hide submit button unless on last tab
    // Show next button unless on last tab
    var on_last_tab = (tab_num === (tabs.length - 1));
    document.getElementById("sub_btn").style.display = (on_last_tab ? "inline" : "none");
    document.getElementById("next_btn").style.display = (!on_last_tab ? "inline" : "none");

  }
}

const Driver = {
  init: function(custom_list) {
    var num_tabs = document.getElementsByClassName("tab").length;
    var custom_features = {};
    for (var i = 0; i < num_tabs; i += 1) {
      custom_features[i] = {
        events: [],
      };
    }
    for (var i = 0; i < custom_list.length; i += 1) {
      entry = custom_list[i];
      if (entry.tab_num < 0) {
        entry.event_function();
        continue;
      }
      if (entry.override_next) {
        custom_features[entry.tab_num].override_next = entry.override_next;
        continue;
      }
      custom_features[entry.tab_num].events.push({
        target: entry.target_id,
        event: entry.event_type,
        action: entry.event_function
      });
    }
    Engine.init(custom_features);
  }
}

function markValidation(element, isValid) {
  if (!isValid) {
    element.classList.add("invalid");
  } else {
    element.classList.remove("invalid");
  }
}

function _defaultValidator() {
  if (Engine.special_features[Engine.current_tab].override_next) {
    return false;
  }

  var tab = document.getElementsByClassName("tab")[Engine.current_tab];
  var valid = true;
  
  valid = valid && validateRadioGroups(tab);
  valid = valid && validateTextInputs(tab);
  valid = valid && validateEmailInputs(tab);
  valid = valid && validatePhoneInputs(tab);

  return valid;
}

function validateRadioGroups(tab) {
  // Radio button validation
  // This class applied to the div surrounding the radio buttons
  var radio_groups = tab.getElementsByClassName("radio-group");
  var valid = true;
  for (var i = 0; i < radio_groups.length; i++) {
    var radio_group = radio_groups[i];
    if (!radio_group.classList.contains("required")) {
      continue;
    }
    var radios = radio_group.getElementsByTagName("input");
    var test_check = false;
    for (var j = 0; j < radios.length; j++) {
      if (radios[j].checked) {
        test_check = true;
        break;
      }
    }
    markValidation(radio_group, test_check);
    valid = valid && test_check;
  }
  return valid;
}

function validateTextInputs(tab) {
  // Textbox and Dropdown validation
  // This class applied to the input directly
  // i.e. <input class="required-text"...></input>
  var valid = true;
  var required_text_groups = tab.getElementsByClassName("required-text");
  for (var i = 0; i < required_text_groups.length; i++) {
    var test = (required_text_groups[i].value !== "");
    markValidation(required_text_groups[i], test);
    valid = valid && test;
  }
  return valid;
}

function validateEmailInputs(tab) {
  // Email validation
  // Class applied to input directly
  var valid = true;
  // This hurts my soul
  var email_regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  var email_groups = tab.getElementsByClassName("email");
  for (var i = 0; i < email_groups.length; i++) {
    var test = email_groups[i].value.match(email_regex);
    markValidation(email_groups[i], test);
    valid = valid && test;
  }
  return valid;
}

function validatePhoneInputs(tab) {
  var valid = true;
  // sigh
  var phone_regex = /^\d{3}-\d{3}-\d{4}/;
  var phone_inputs = document.getElementsByClassName("phone-number-input");
  for (var i = 0; i < phone_inputs.length; i++) {
    var test = phone_inputs[i].value.match(phone_regex) && (phone_inputs[i].value.length === 12);
    markValidation(phone_inputs[i], test);
    valid = valid && test;
  }
  return valid;
}
