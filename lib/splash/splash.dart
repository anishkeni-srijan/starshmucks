import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freerasp/talsec_app.dart';
import 'package:freerasp/talsec_callback.dart';
import 'package:freerasp/talsec_config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '/common_things.dart';
import '/splash/bloc/splash_bloc.dart';
import '/splash/bloc/splash_events.dart';
import '../signin/signin.dart';
import 'bloc/splash_states.dart';

import 'dart:async';
import 'dart:io';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class ThreatType {
  /// Threat constructor.
  ThreatType(this._text);

  final String _text;
  bool _isSecure = true;

  /// Update state.
  void threatFound() => _isSecure = false;

  /// Return current state.
  String get state => '$_text: ${_isSecure ? "Secured" : "Detected"}\n';
}

class _SplashState extends State<Splash> {
  final ThreatType _root = ThreatType('Root');
  final ThreatType _emulator = ThreatType('Emulator');
  final ThreatType _tamper = ThreatType('Tamper');
  final ThreatType _hook = ThreatType('Hook');
  final ThreatType _deviceBinding = ThreatType('Device binding');
  final ThreatType _untrustedSource =
      ThreatType('Untrusted source of installation');

  /// ThreatTypes to hold current state (iOS)
  final ThreatType _signature = ThreatType('Signature');
  final ThreatType _jailbreak = ThreatType('Jailbreak');
  final ThreatType _runtimeManipulation = ThreatType('Runtime Manipulation');
  final ThreatType _simulator = ThreatType('Simulator');
  final ThreatType _deviceChange = ThreatType('Device change');
  final ThreatType _deviceId = ThreatType('Device ID');
  final ThreatType _unofficialStore = ThreatType('Unofficial Store');
  final ThreatType _passcode = ThreatType('Passcode');
  final ThreatType _missingSecureEnclave = ThreatType('Missing secure enclave');

  /// ThreatTypes to hold current state (common)
  final ThreatType _debugger = ThreatType('Debugger');

  /// Getter to determine which states we care about
  List<Widget> get overview {
    if (Platform.isAndroid) {
      return [
        Text(_root.state),
        Text(_debugger.state),
        Text(_emulator.state),
        Text(_tamper.state),
        Text(_hook.state),
        Text(_deviceBinding.state),
        Text(_untrustedSource.state),
      ];
    }
    return [
      Text(_signature.state),
      Text(_jailbreak.state),
      Text(_debugger.state),
      Text(_runtimeManipulation.state),
      Text(_passcode.state),
      Text(_simulator.state),
      Text(_missingSecureEnclave.state),
      Text(_deviceChange.state),
      Text(_deviceId.state),
      Text(_unofficialStore.state)
    ];
  }

  /// Override initState of the "highest" widget in order to start freeRASP
  /// as soon as possible.
  @override
  void initState() {
    super.initState();
    initSecurityState();
  }

  Future<void> initSecurityState() async {
    /// Provide TalsecConfig your expected data and then use them in TalsecApp
    final config = TalsecConfig(
      /// For Android
      androidConfig: AndroidConfig(
        expectedPackageName: 'com.example.starshmucks',
        expectedSigningCertificateHashes: [
          'IeGzNncF55vbtV+8D2a/GmK4xNzsjJTAiDT/tlHjTd0='
        ],
      ),


      watcherMail: 'sanish.aukhale@srijan.net',
    );

    /// Callbacks thrown by library
    final callback = TalsecCallback(
      /// For Android
      androidCallback: AndroidCallback(
        onRootDetected: () => _updateState(_root),
        onEmulatorDetected: () => _updateState(_emulator),
        onHookDetected: () => _updateState(_hook),
        onTamperDetected: () => _updateState(_tamper),
        onDeviceBindingDetected: () => _updateState(_deviceBinding),
        onUntrustedInstallationDetected: () => _updateState(_untrustedSource),
      ),

      /// For iOS
      iosCallback: IOSCallback(
        onSignatureDetected: () => _updateState(_signature),
        onRuntimeManipulationDetected: () => _updateState(_runtimeManipulation),
        onJailbreakDetected: () => _updateState(_jailbreak),
        onPasscodeDetected: () => _updateState(_passcode),
        onSimulatorDetected: () => _updateState(_simulator),
        onMissingSecureEnclaveDetected: () =>
            _updateState(_missingSecureEnclave),
        onDeviceChangeDetected: () => _updateState(_deviceChange),
        onDeviceIdDetected: () => _updateState(_deviceId),
        onUnofficialStoreDetected: () => _updateState(_unofficialStore),
      ),

      /// Debugger is common for both platforms
      onDebuggerDetected: () => _updateState(_debugger),
    );

    final app = TalsecApp(
      config: config,
      callback: callback,
    );

    /// Turn on freeRASP
    app.start();

    if (!mounted) return;
  }

  void _updateState(ThreatType type) {
    setState(type.threatFound);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashScreenBloc, SplashScreenState>(
        builder: (context, state) {
      BlocProvider.of<SplashScreenBloc>(context).add(LoginStatusCheckEvent());
      return Scaffold(
        backgroundColor: HexColor("#175244"),
        body: SplashScreenView(
          duration: const Duration(milliseconds: 1500),
          imageSrc: "images/shmucks.png",
          navigateRoute: state is UserExistsState ? BottomBar() : SigninPage(),
        ),
      );
    });
  }
}
