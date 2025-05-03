import 'package:autoshine/controller/add_vehicle_contrller.dart';
import 'package:autoshine/controller/address_add_controller.dart';
import 'package:autoshine/models/address_model.dart';
import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/services/address_service.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceDetailsWidgets {
  final VehicleAddController vehicleAddController = Get.find();
  final AddressAddController addressAddController = Get.put(
    AddressAddController(),
  );
  final AddressService addressService = AddressService();

  Widget buildPackageDetails(List<String> tasks) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 15),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 7),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: goldenYellow,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(tasks[index], style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildVehicleDropdown() {
    return Obx(() {
      return DropdownButtonFormField<VehicleTypeModel>(
        isExpanded: true,
        borderRadius: BorderRadius.circular(20),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: goldenYellow, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: goldenYellow, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
        validator: (value) {
          if (value == null) return 'Please select a vehicle';
          return null;
        },
        value: vehicleAddController.selectedVehicle.value,
        hint: Text('Choose your vehicle'),
        items:
            vehicleAddController.vehicles.map((vehicle) {
              return DropdownMenuItem(
                value: vehicle,
                child: Text('${vehicle.brandName}, ${vehicle.modelName}'),
              );
            }).toList(),
        onChanged: (val) => vehicleAddController.selectedVehicle.value = val,
      );
    });
  }

  void showAddressBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: StreamBuilder<List<AddressModel>>(
          stream: addressService.fetchAllAddress(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(color: goldenYellow);
            }
            final addresses = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final addr = addresses[index];
                return ListTile(
                  title: Text('${addr.firstName} ${addr.lastName ?? ''}'),
                  subtitle: Text('${addr.house}, ${addr.city}'),
                  trailing:
                      addr == addressAddController.selectedAddress.value
                          ? Icon(Icons.check, color: Colors.green)
                          : null,
                  onTap: () {
                    addressAddController.selectedAddress.value = addr;
                    Get.back();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildAddressSection() {
    return StreamBuilder<List<AddressModel>>(
      stream: addressService.fetchAllAddress(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: goldenYellow));
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No address found'));
        }

        final addresses = snapshot.data!;
        addressAddController.setDefaultAddress(addresses);

        return Obx(() {
          final selected = addressAddController.selectedAddress.value;
          if (selected == null) return SizedBox.shrink();

          return CustomContainer(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${selected.firstName} ${selected.lastName ?? ''}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      if (selected.isDefault)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: whiteColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('${selected.house}, ${selected.city}'),
                  Text(selected.pinCode),
                  if (selected.landmark != null &&
                      selected.landmark!.isNotEmpty)
                    Text('Landmark: ${selected.landmark}'),
                  SizedBox(height: 10),
                  Text(
                    '+91 ${selected.phone}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  if (selected.alternativePhone != null &&
                      selected.alternativePhone!.isNotEmpty)
                    Text('Alt: +91 ${selected.alternativePhone}'),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
