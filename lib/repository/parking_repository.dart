import 'package:flutter/material.dart';
import 'package:supabase_carparking_app/main.dart';
import 'package:supabase_carparking_app/repository/adapter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParkingRepository extends Adapter {
  /////////////////////// Create Account //////////////////////////

  @override
  Future<dynamic> createAccount(String email, BuildContext context) async {
    try {
      final data = await supabase.from('profile').insert({
        'email_address': email,
      }).select();

      if (data.isNotEmpty) {
        if (context.mounted) {
          supabaseProvider.setUserId(data[0]['id']);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully')),
          );
          Navigator.pushNamed(context, "/emailVerification");
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create account')),
          );
        }
      }
    } on PostgrestException catch (e) {
      if (context.mounted) {
        switch (e.code) {
          case '23505':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email already exists')),
            );
            break;
          case '42501':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Unauthorized: You are not authorized to perform this action')),
            );
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.message}')),
            );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      }
    }
  }

  /////////////////////// Add User Profile //////////////////////////

  @override
  Future<dynamic> updateUserProfile(
      String name,
      String phoneNumber,
      String carModel,
      String carNumber,
      String carColor,
      BuildContext context) async {
    try {
      final data = await supabase
          .from('profile')
          .update({
            'name': name,
            'phone_number': phoneNumber,
          })
          .eq('id', supabaseProvider.getUserId)
          .select();

      if (data.isNotEmpty) {
        if (context.mounted) {
          addCarProfile(carModel, carNumber, carColor, context);
        }
      }
    } on PostgrestException catch (e) {
      if (context.mounted) {
        switch (e.code) {
          case '23505':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email already exists')),
            );
            break;
          case '42501':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Unauthorized: You are not authorized to perform this action')),
            );
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.message}')),
            );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      }
    }
  }

  /////////////////////// Create Account //////////////////////////
  @override
  Future<dynamic> addCarProfile(String carModel, String carNumber,
      String carColor, BuildContext context) async{
    try{
      final data = await supabase.from('vehicle').insert({
        'car_model': carModel,
        'car_number': carNumber,
        'car_color': carColor,
        'user_id': supabaseProvider.getUserId
      }).select();

      if (data.isNotEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile created successfully')),
          );
          Navigator.pushNamed(context, "/");
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to create profile')),
          );
        }
      }

    }
    on PostgrestException catch (e) {
      if (context.mounted) {
        switch (e.code) {
          case '23505':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email already exists')),
            );
            break;
          case '42501':
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Unauthorized: You are not authorized to perform this action')),
            );
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.message}')),
            );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      }
    }
  }

  @override
  Future<dynamic> getAllBookings(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getAvailableSlots(BuildContext context, int parkingAreaId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getFloorsByParkingLot(
      BuildContext context, int parkingAreaId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getMyFavorites(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getMyNotifications() {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getMyVehicles(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getParkingareas(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getSlotsbyParkingFloor(
      BuildContext context, int parkingFloorId, int parkingAreaId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getSpecificSlot(BuildContext context, int slotId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getSpecificVehicle(BuildContext context, int vehicleId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getTotalFee(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getUserProfile(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> removeFavourite(BuildContext context, int id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> saveAsFavorite(int parkingArea, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> saveParkingDetail(
      BuildContext context,
      String parkingDate,
      String entryTime,
      int durationInHours,
      String exitTime,
      Map<String, dynamic> parkingarea,
      int vehicleId,
      int parkingSlotId) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> searchFavourite(BuildContext context, String searchWord) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> searchParkingArea(BuildContext context, String searchWord) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> signInUser(String email, BuildContext context) {
    throw UnimplementedError();
  }

  @override
  updateSlotAvailability(int parkingSlotId) {
    throw UnimplementedError();
  }
}
