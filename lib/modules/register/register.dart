import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_c6/modules/register/cubit/cubit.dart';
import 'package:payment_c6/modules/register/cubit/states.dart';
import 'package:payment_c6/shared/common/components.dart';

import '../payment/toggle.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  var firstNameController=TextEditingController();
   var lastNameController=TextEditingController();
   var emailController=TextEditingController();
   var phoneController=TextEditingController();
   var amountController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>PaymentCubit(),
      child: BlocConsumer<PaymentCubit,PaymentStates>(
        listener: (context, state) {
          if(state is getFirstTokenLoadingState){

          }
          if(state is getFirstTokenSuccessState){

          }
          if(state is getFirstTokenErrorState){

          }
          if(state is getRefCodeSuccessState){
            NavigateTo(context, ToggleScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text('Payment'),),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  defaultFormField(controller: firstNameController,
                      type: TextInputType.name,
                      validate: (text){

                      },
                      label: 'First name',
                      prefix: Icons.person),
                  SizedBox(
                    height: 25,
                  ),
                  defaultFormField(controller: lastNameController,
                      type: TextInputType.name,
                      validate:  (text){

                      },
                      label: 'Last name',
                      prefix: Icons.person),  SizedBox(
                    height: 25,
                  ),
                  defaultFormField(controller: emailController,
                      type: TextInputType.emailAddress,
                      validate:  (text){

                      },
                      label: 'Email',
                      prefix: Icons.email),  SizedBox(
                    height: 25,
                  ),
                  defaultFormField(controller: phoneController,
                      type: TextInputType.phone,
                      validate:  (text){

                      },
                      label: 'phone',
                      prefix: Icons.phone),  SizedBox(
                    height: 25,
                  ),
                  defaultFormField(controller: amountController,
                      type: TextInputType.number,
                      validate:  (text){
                      },
                      label: 'Amount',
                      prefix: Icons.money),  SizedBox(
                    height: 25,
                  ),
                  defaultButton(function: (){

                    PaymentCubit.get(context).getFirstToken(firstNameController.text,
                        lastNameController.text, emailController.text,
                        phoneController.text, amountController.text);
                  }, text: 'GO TO PAY',radius: 12,width: 160)
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
