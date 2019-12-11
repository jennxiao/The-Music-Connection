var length = 1;
document.getElementById("rem_instrument").style.display = "none";

var events = [
  {
    tab_num: 0,
    target_id: "add_time",
    event_type: 'click',
    event_function: function() {
      var original = document.getElementsByClassName("time-holder")[0];
      var cln = original.cloneNode(true);
      document.getElementById("all-times-holder").appendChild(cln);
      if (document.getElementsByClassName("time-holder").length > 1) {
        document.getElementById("rem_time").style.display = "inline-block";
      }
    }
  },  
  {
    tab_num: 0,
    target_id: "rem_time",
    event_type: 'click',
    event_function: function() {
      var times = document.getElementsByClassName("time-holder");
      if (times.length <= 1) {
        return;
      }
      var holder = document.getElementById("all-times-holder");
      holder.removeChild(holder.lastChild);
      if (times.length <= 1) {
        document.getElementById("rem_time").style.display = "none";
      }
    }
  },  
  {
    tab_num: 1,
    target_id: "add_instrument",
    event_type: 'click',
    event_function: function() {
      var original = document.getElementById("other_instrument");
      var cln = original.cloneNode(true);
      cln.value = "";

      document.getElementById("other-instruments").appendChild(cln);
      length += 1;

      if (length > 1) {
        document.getElementById("rem_instrument").style.display = "inline-block";
      }
    }
  },  
  {
    tab_num: 1,
    target_id: "rem_instrument",
    event_type: 'click',
    event_function: function() {

      var instrument_list = document.getElementById("other-instruments");
      instrument_list.removeChild(instrument_list.lastChild);
      length -=1

      if (length <= 1) {
        document.getElementById("rem_instrument").style.display = "none";
      }
    }
  },
  {
    tab_num: 4,
    override_next: function() {
      var a = document.getElementById("Member Commitment Policy");
      var b = document.getElementById("Attendance Policy");
      var valid = 1;
      if (!a.checked) {
        document.getElementById("mandatory-commitment-holder").classList.add("invalid");
        valid = 0;
      } else {
        document.getElementById("mandatory-commitment-holder").classList.remove("invalid");
      }
      if (!b.checked) {
        document.getElementById("attendance-holder").classList.add("invalid");
        valid = 0;
      } else {
        document.getElementById("attendance-holder").classList.remove("invalid");
      }
      return valid;
    }      
  },
  {
    tab_num: 5,
    override_next: function() {
      var a = document.getElementById("radio-returning");
      var b = document.getElementById("radio-new");
      if (!a.checked && !b.checked) {
        document.getElementById("radio-returning-jump").classList.add("invalid");
        return 0;
      }
      document.getElementById("radio-returning-jump").classList.remove("invalid");
      if (b.checked) {
        return 2;
      }
      return 1;
    }      
  },
];

Driver.init(events);
