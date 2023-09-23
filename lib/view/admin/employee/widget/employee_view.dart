import 'package:attendance/theme/app_colors.dart';
import 'package:attendance/utils/date_converter.dart';
import 'package:attendance/utils/toast.dart';
import 'package:attendance/view/admin/employee/logic.dart';
import 'package:attendance/view/auth/sign_up/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes.dart';
import '../../../../model/EmployeeModel.dart';
import '../../../../repository/employee_repository.dart';
import '../../../../utils/assets.dart';
import '../../../common/punching/view.dart';
import '../../../other/widget/custom_button.dart';
import '../../../other/widget/custom_image.dart';

class EmployeeView extends StatefulWidget {
  final EmployeeModel? model;
  const EmployeeView({super.key,this.model});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {

  bool onDelete = false;
  bool onApprove = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(
            onTap: (){
          //    print("KKKKK ${widget.model?.toJson()}");
              Get.toNamed(rsEditProfilePage,arguments: { 'user' : widget.model?.toJson() });
            },
            child: Row(
              children: [

                CustomImage(imageUrl: "",
                assetPlaceholder: widget.model?.gender == Gender.female.name ? appFemaleProfile : appMaleProfile,
                height: 55,
                width: 55,
                  radius: 40,
                ),

                const SizedBox(width: 15,),

                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.model?.name}",
                      maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),),

                      const SizedBox(height: 5,),
                      Text("${widget.model?.email}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,),
                      const SizedBox(height: 5,),
                      Row(
                        children: [

                          const Icon(Icons.phone,size: 18,),
                          const SizedBox(width: 5,),
                          Text("${widget.model?.phone}"),
                          const SizedBox(width: 15,),
                          const Icon(Icons.account_circle,size: 18,),
                          const SizedBox(width: 5,),
                          Text("${widget.model?.gender}".toCapitalizeFirstLetter(),
                            style: TextStyle(
                                color: AppColors.blackColor()
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5,),

          const Divider(),

          const SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              // Container(
              //     decoration: BoxDecoration(
              //       color: AppColors.greenColor(),
              //       borderRadius: const BorderRadius.all(Radius.circular(25))
              //     ),
              //     height: 30,
              //     padding: const EdgeInsets.symmetric(horizontal: 25),
              //     child: Center(
              //       child: Text('Approve',
              //       style: TextStyle(
              //         color: AppColors.whiteColor()
              //       ),),
              //     )),

              CustomButton(
                text: widget.model?.approved == 1 ? "Inactive" : "Approve",
                height: 30,
                onTap: (){
                  setState((){
                    onApprove = true;
                  });
                  Get.find<EmployeeRepository>().approveUser({
                    "id": widget.model?.id,
                    "approve": widget.model?.approved == 1 ? 0 : 1
                  }).then((value) => {
                    if(value.body['success']){
                      Toast.show(toastMessage: value.body['message']??"Successfully Approved"),
                      Get.find<EmployeeLogic>().getUsersList(),
                    }else{
                      Toast.show(toastMessage: value.body['message']??"Failed")
                    }
                  }).whenComplete(() => {
                    setState((){
                      onApprove = false;
                    })
                  });
                },
                isLoading: onApprove,
                fontColor: AppColors.whiteColor(),
                color: widget.model?.approved == 1 ? AppColors.contentColorOrange : AppColors.greenColor(),
              ),

              CustomButton(
                text: "Delete",
                height: 30,
                onTap: (){
                  setState((){
                    onDelete = true;
                  });
                  Get.find<EmployeeRepository>().deleteUser({
                    "id": widget.model?.id
                  }).then((value) => {
                    if(value.body['success']){
                      Toast.show(toastMessage: value.body['message']??"Successfully Deleted"),
                      Get.find<EmployeeLogic>().getUsersList(),
                    }else{
                      Toast.show(toastMessage: value.body['message']??"Failed")
                    }
                  }).whenComplete(() => {
                    setState((){
                      onDelete = false;
                    })
                  });
                },
                isLoading: onDelete,
                fontColor: AppColors.whiteColor(),
                color: AppColors.redColor(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
