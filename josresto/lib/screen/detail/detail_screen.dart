import 'package:flutter/material.dart';
import 'package:josresto/component/detail_widget.dart';
import 'package:josresto/data/api/api_service.dart';
import 'package:josresto/main.dart';
import 'package:josresto/provider/restaurant_add_review_provider.dart';
import 'package:josresto/provider/restaurant_detail_provider.dart';
import 'package:josresto/static/restaurant_detail_result_state.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context
            .read<RestaurantDetailProvider>()
            .fetchDetailRestaurant(widget.restaurantId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        centerTitle: true,
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RestaurantAddReviewProvider(
              context.read<ApiService>(),
            ),
          ),
        ],
        child: Consumer2<RestaurantDetailProvider, RestaurantAddReviewProvider>(
          builder: (context, detailProvider, reviewProvider, child) {
            final state = detailProvider.resultState;

            if (state is RestaurantDetailLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RestaurantDetailLoadedState) {
              final restaurant = state.data;

              return DetailRestaurantWidget(
                restaurant: restaurant,
                onAddReview: (name, review) async {
                  try {
                    await reviewProvider.addRestaurantReview(
                      id: restaurant.id,
                      name: name,
                      review: review,
                    );

                    // Refresh restaurant details after adding review
                    await detailProvider
                        .fetchDetailRestaurant(widget.restaurantId);

                    // Menampilkan SnackBar dengan scaffoldMessengerKey
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      const SnackBar(
                          content: Text("Review added successfully!")),
                    );
                  } catch (e) {
                    // Menangani error
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(content: Text("Failed to add review: $e")),
                    );
                  }
                },
              );
            } else if (state is RestaurantDetailErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
