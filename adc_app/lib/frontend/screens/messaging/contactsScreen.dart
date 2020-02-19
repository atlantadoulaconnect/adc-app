import '../common.dart';

class ContactsScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ContactsScreenConnector extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, ViewModel>(
			model: ViewModel()
		);
  }
}

class ViewModel extends BaseModel<AppState> {
	ViewModel();
	
	User currentUser;
	
	ViewModel.build({}) : super(equals:[]);
	
	@override
	ViewModel fromStore() {
		return ViewModel.build();
	}
}