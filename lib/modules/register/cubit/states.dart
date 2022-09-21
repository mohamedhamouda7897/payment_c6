
import 'package:payment_c6/modules/register/cubit/cubit.dart';

abstract class PaymentStates{}

class PaymentInitState extends PaymentStates{}
class getFirstTokenLoadingState extends PaymentStates{}

class getFirstTokenSuccessState extends PaymentStates{}

class getFirstTokenErrorState extends PaymentStates{}

class getOrderIdLoadingState extends PaymentStates{}

class getOrderIdSuccessState extends PaymentStates{}

class getOrderIdErrorState extends PaymentStates{}

class getFinalTokenLoadingState extends PaymentStates{}

class getFinalTokenSuccessState extends PaymentStates{}

class getFinalTokenErrorState extends PaymentStates{}

class getFinalTokenKIOSKLoadingState extends PaymentStates{}

class getFinalTokenKIOSKSuccessState extends PaymentStates{}

class getFinalTokenKIOSKErrorState extends PaymentStates{}

class getRefCodeLoadingState extends PaymentStates{}

class getRefCodeSuccessState extends PaymentStates{}

class getRefCodeErrorState extends PaymentStates{}
