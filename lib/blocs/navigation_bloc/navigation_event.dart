import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends NavigationEvent {
  @override
  List<Object?> get props => [];
}

class AppStartedEvent extends NavigationEvent {
  @override
  List<Object?> get props => [];
}
