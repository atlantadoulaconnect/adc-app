import 'package:adc_app/frontend/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';

import '../../backend/states/appState.dart';

class HomeScreen extends StatelessWidget {
	final VoidCallback toClientApp;
	final VoidCallback toDoulaApp;
	final VoidCallback toLogin;
	
	HomeScreen({this.toClientApp, this.toDoulaApp, this.toLogin}) {
		print("${toClientApp != null} ${toDoulaApp != null} ${toLogin != null}");
	}
	//: assert(toClientApp != null && toDoulaApp != null && toLogin != null);
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text("Home")),
			body: Padding(
					padding: const EdgeInsets.all(26.0),
					child: Center(
							child: Column(children: <Widget>[
								Spacer(flex: 1),
								Text("Atlanta Doula Connect",
										textAlign: TextAlign.center,
										style: TextStyle(
											fontSize: 50.0,
											fontWeight: FontWeight.bold,
										)),
								Spacer(flex: 2),
								RaisedButton(
									shape: RoundedRectangleBorder(
										borderRadius: new BorderRadius.circular(50.0),
										side: BorderSide(color: themeColors['mediumBlue']),
									),
									onPressed: toClientApp,
									color: themeColors['mediumBlue'],
									textColor: Colors.white,
									padding: EdgeInsets.all(15.0),
									splashColor: themeColors['mediumBlue'],
									child: Text(
										"Request a Doula",
										style: TextStyle(fontSize: 20.0),
									),
								),
								Spacer(),
								RaisedButton(
									shape: RoundedRectangleBorder(
											borderRadius: new BorderRadius.circular(50.0),
											side: BorderSide(color: themeColors['lightBlue'])),
									onPressed: toDoulaApp,
									color: themeColors['lightBlue'],
									textColor: Colors.white,
									padding: EdgeInsets.all(15.0),
									splashColor: themeColors['lightBlue'],
									child: Text(
										"Apply as a Doula",
										style: TextStyle(fontSize: 20.0),
									),
								),
								Spacer(flex: 1),
								RaisedButton(
									shape: RoundedRectangleBorder(
											borderRadius: new BorderRadius.circular(50.0),
											side: BorderSide(color: themeColors['yellow'])),
									onPressed: toLogin,
									color: themeColors['yellow'],
									textColor: Colors.black,
									padding: EdgeInsets.all(15.0),
									splashColor: themeColors['yellow'],
									child: Text(
										"Log In",
										style: TextStyle(fontSize: 20.0),
									),
								),
								Spacer(),
							]))),
		);
	}
}

class HomeScreenConnector extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, ViewModel>(
				model: ViewModel(),
				builder: (BuildContext context, ViewModel vm) {
					return HomeScreen(
						toClientApp: vm.toClientApp,
						toDoulaApp: vm.toDoulaApp,
						toLogin: vm.toLogin,
					);
				});
	}
}

class ViewModel extends BaseModel<AppState> {
	ViewModel();
	
	VoidCallback toClientApp;
	VoidCallback toDoulaApp;
	VoidCallback toLogin;
	
	ViewModel.build(
			{@required this.toClientApp,
				@required this.toDoulaApp,
				@required this.toLogin});
	
	@override
	ViewModel fromStore() {
		return ViewModel.build(
				toClientApp: () => dispatch(NavigateAction.pushNamed("/clientSignup")),
				toDoulaApp: () => dispatch(NavigateAction.pushNamed("/doulaSignup")),
				toLogin: () => dispatch(NavigateAction.pushNamed("/login")));
	}
}
