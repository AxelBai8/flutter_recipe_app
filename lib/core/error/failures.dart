import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;  
  final List properties; 

  const Failure(this.message, [this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [message, properties];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Error del servidor']) 
    : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Error de caché'])
    : super(message);
}