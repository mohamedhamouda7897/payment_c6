import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_c6/modules/register/cubit/states.dart';
import 'package:payment_c6/shared/network/remote/dio.dart';

import '../../../shared/common/constants.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future getFirstToken(String firstName,String lastName,String email,String phone,String amount) async {
    emit(getFirstTokenLoadingState());
    await DioHelper.postData(endPoint: 'auth/tokens', data: {"api_key": APIKEY})
        .then((value) {
      print(value);
      PAYMENT_FIRST_TOKEN = value.data['token'];
      print('first token');
      print('$PAYMENT_FIRST_TOKEN');
      emit(getFirstTokenSuccessState());
      getOrderId(firstName,lastName,email,phone,amount);
    }).catchError((error) {
      print(error.toString());
      emit(getFirstTokenErrorState());
    });
  }

  Future getOrderId(String firstName,String lastName,String email,String phone,String amount) async {
    emit(getOrderIdLoadingState());
    await DioHelper.postData(endPoint: 'ecommerce/orders',
        data: {
          "auth_token": PAYMENT_FIRST_TOKEN,
          "delivery_needed": "false",
          "amount_cents": "100",
          "currency": "EGP",
          "items": [
          ]
        })
        .then((value) {
      PAYMENT_ORDER_ID = value.data['id'].toString();
      print('order id');
      print('$PAYMENT_ORDER_ID');
      emit(getOrderIdSuccessState());
      getFinaltokenCardVisa(firstName,lastName,email,phone,amount);
      getFinaltokenKiosk(firstName,lastName,email,phone,amount);
    }).catchError((error) {
      print(error.toString());
      emit(getOrderIdErrorState());
    });
  }

  Future getFinaltokenCardVisa(String firstName,String lastName,String email,String phone,String amount) async {
    emit(getFinalTokenLoadingState());
    await DioHelper.postData(endPoint: 'acceptance/payment_keys',
        data: {
    "auth_token": PAYMENT_FIRST_TOKEN,
    "amount_cents": amount,
    "expiration": 3600,
    "order_id": PAYMENT_ORDER_ID,
    "billing_data": {
    "apartment": "NA",
    "email": email,
    "floor": "NA",
    "first_name": firstName,
    "street": "NA",
    "building": "NA",
    "phone_number": phone,
    "shipping_method": "NA",
    "postal_code": "NA",
    "city": "NA",
    "country": "NA",
    "last_name": lastName,
    "state": "NA"
    },
    "currency": "EGP",
    "integration_id": INTGRATION_ID_VISACARD
    })
        .then((value) {
      PAYMENT_FINAL_TOKEN_VISA = value.data['token'];
      print('final token card ');
      print('$PAYMENT_FINAL_TOKEN_VISA');
      emit(getFinalTokenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getFinalTokenErrorState());
    });
  }
  Future getFinaltokenKiosk(String firstName,String lastName,String email,String phone,String amount)
  async {
    emit(getFinalTokenKIOSKLoadingState());
    await DioHelper.postData(endPoint: 'acceptance/payment_keys',
        data: {
          "auth_token": PAYMENT_FIRST_TOKEN,
          "amount_cents": amount,
          "expiration": 3600,
          "order_id": PAYMENT_ORDER_ID,
          "billing_data": {
            "apartment": "NA",
            "email":email,
            "floor": "NA",
            "first_name": firstName,
            "street": "NA",
            "building": "NA",
            "phone_number": phone,
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": lastName,
            "state": "NA"
          },
          "currency": "EGP",
          "integration_id": INTGRATION_ID_KIOSK
        })
        .then((value) {
      PAYMENT_FINAL_TOKEN_KIOSK = value.data['token'];
      print('final token kiosk ');
      print('$PAYMENT_FINAL_TOKEN_KIOSK');
      emit(getFinalTokenKIOSKSuccessState());
      getRefrenceCode();
    }).catchError((error) {
      print(error.toString());
      emit(getFinalTokenKIOSKErrorState());
    });
  }


  Future getRefrenceCode() async {
    emit(getRefCodeLoadingState());
    await DioHelper.postData(endPoint: 'acceptance/payments/pay',
        data: {
          "source": {
            "identifier": "AGGREGATOR",
            "subtype": "AGGREGATOR"
          },
          "payment_token": PAYMENT_FINAL_TOKEN_KIOSK
        })
        .then((value) {
      REFCODE = value.data['id'].toString();
      print('REF code');
      print('$REFCODE');
      emit(getRefCodeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getRefCodeErrorState());
    });
  }

}
