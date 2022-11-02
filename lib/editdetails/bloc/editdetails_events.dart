abstract class EditdetailsEvent {}

class EditdetailsemailChangedEvent extends EditdetailsEvent {
  String emailvalue = '';


  EditdetailsemailChangedEvent(this.emailvalue);

}
class EditdetailsNumberChangedEvent extends EditdetailsEvent {
  String phnvalue = '';


  EditdetailsNumberChangedEvent(this.phnvalue);
}
class EditdetailsNameChangedEvent extends EditdetailsEvent {
  String namevalue = '';


  EditdetailsNameChangedEvent(this.namevalue);
}

class EditdetailsSumittedEvent extends EditdetailsEvent {
  String? email;
  String? phnvalue;
  String? namevalue;

  EditdetailsSumittedEvent(
      this.email,
      this.namevalue,
      this.phnvalue,
      );
}
