validInput(String val, int min, int max) {

    if (val.isEmpty) {
    return messageInputEmpty;
    
  }

  else if (val.length > max) {
    return "$messageInputMax $max";

  }

   else if (val.length < min) {
    return "$messageInputMin $min";
    
  }


  
}

const String messageInputEmpty = "All blanks must be filled in";
const String messageInputMin = "This field cannot be less than";
const String messageInputMax = "This field cannot be greater than";
