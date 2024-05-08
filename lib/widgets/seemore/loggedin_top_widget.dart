import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/account/account_controller.dart';
import 'package:testapp/utils/api_config.dart';


class LoggedinTopWidget extends StatelessWidget {
  const LoggedinTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _accountController = Get.find<AccountController>();
    return Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    backgroundImage:
                        _accountController.profileImageId.isNotEmpty
                  
                            ? NetworkImage('${ApiConfig.attachmentApiEndpointUri}/${_accountController.profileImageId}')
                                as ImageProvider
                            : const AssetImage('assets/images/default_profile.png')
                                as ImageProvider,
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/myinfo');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    _accountController.nickname,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}