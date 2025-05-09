import 'package:autoshine/functions/custom_snack_bar.dart';
import 'package:autoshine/models/address_model.dart';
import 'package:autoshine/screens/profile/add_address_screen.dart';
import 'package:autoshine/services/address_service.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:autoshine/widget/titled_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressService addressService = AddressService();

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          TitledAppbar(title: 'Saved Address'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: () => Get.to(() => AddAddressScreen()),
                        child: CustomContainer(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_rounded, size: 23),
                              const SizedBox(width: 10),
                              Text(
                                'Add Address',
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    //---- Here StreamBuilder to show addresses
                    StreamBuilder<List<AddressModel>>(
                      stream: addressService.fetchAllAddress(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(color: deepAmber),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No address found'));
                        }

                        final addresses = snapshot.data!;

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            final address = addresses[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${address.firstName} ${address.lastName ?? ''}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              if (address.isDefault)
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    'Default',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: whiteColor,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),
                                          Text(
                                            '${address.house}, ${address.city}',
                                          ),
                                          Text(address.pinCode),
                                          if (address.landmark != null &&
                                              address.landmark!.isNotEmpty)
                                            Text(
                                              'Landmark: ${address.landmark}',
                                            ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '+91 ${address.phone}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (address.alternativePhone !=
                                                  null &&
                                              address
                                                  .alternativePhone!
                                                  .isNotEmpty)
                                            Text(
                                              'Alt: +91 ${address.alternativePhone}',
                                            ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: button(
                                            () => Get.to(
                                              () => AddAddressScreen(
                                                existingAddress: address,
                                              ),
                                            ),
                                            'Edit',
                                            editButton,
                                            BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: button(
                                            () async {
                                              bool success =
                                                  await addressService
                                                      .deleteAddress(
                                                        address.id,
                                                      );
                                              if (success) {
                                                successSnackBar(
                                                  'Address Deleted...!',
                                                );
                                              } else {
                                                errorSnackBar(
                                                  'Cannot Delete Default Address',
                                                );
                                              }
                                            },
                                            'Delete',
                                            removeButton,
                                            BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector button(
    VoidCallback navigation,
    String name,
    Color color,
    BorderRadius radius,
  ) {
    return GestureDetector(
      onTap: navigation,
      child: CustomContainer(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: color, borderRadius: radius),
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
