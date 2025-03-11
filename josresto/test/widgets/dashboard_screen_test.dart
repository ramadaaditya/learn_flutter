import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:josresto/data/model/restaurant_list_response.dart';
import 'package:josresto/provider/restaurant_list_provider.dart';
import 'package:josresto/screen/dashboard/dashboard_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../api_service_mock.dart';

void main() {
  group('DashboardScreen Widget Test', () {
    late MockApiService mockApiService;
    late RestaurantListProvider provider;

    setUp(() {
      mockApiService = MockApiService();
      provider = RestaurantListProvider(mockApiService);

      registerFallbackValue(RestaurantListResponse(
        error: false,
        message: "Success",
        count: 0,
        restaurants: [],
      ));
    });

    testWidgets('Menampilkan loading indicator saat data sedang dimuat',
        (WidgetTester tester) async {
      when(() => mockApiService.getRestaurantList()).thenAnswer(
        (_) async => Future.delayed(
            const Duration(milliseconds: 500),
            () => RestaurantListResponse(
                  error: false,
                  message: "Success",
                  count: 0,
                  restaurants: [],
                )),
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<RestaurantListProvider>.value(
                value: provider),
          ],
          child: const MaterialApp(home: DashboardScreen()),
        ),
      );
      provider.fetchRestaurantList();
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('Menampilkan pesan error saat terjadi kesalahan',
        (WidgetTester tester) async {
      when(() => mockApiService.getRestaurantList())
          .thenThrow(Exception("Gagal memuat data"));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<RestaurantListProvider>.value(
            value: provider,
            child: const DashboardScreen(),
          ),
        ),
      );
      provider.fetchRestaurantList();
      await tester.pumpAndSettle(); // Tunggu sampai UI diperbarui
      expect(find.textContaining("Gagal memuat data"), findsOneWidget);
    });
  });
}
