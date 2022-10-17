class ValidatorTextField{
  empty(val){
    if(val!.isEmpty){
      return "this field can't be empty";
    }
    else{
      return null;
    }
  }
}