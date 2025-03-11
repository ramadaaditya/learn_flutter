import 'package:josresto/data/model/menu.dart';
import 'package:josresto/data/model/restaurant.dart';
import 'package:josresto/data/model/restaurant_list_response.dart';
import 'package:josresto/provider/restaurant_list_provider.dart';
import 'package:josresto/static/restaurant_list_result_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../api_service_mock.dart';

void main() {
  group('RestaurantListProvider Test', () {
    late MockApiService mockApiService;
    late RestaurantListProvider provider;

    setUp(() {
      mockApiService = MockApiService();
      provider = RestaurantListProvider(mockApiService);
    });

    test('State awal provider harus didefinisikan sebagai NoneState', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('State harus berubah menjadi Loading sebelum data berhasil dimuat',
        () async {
      final mockRestaurantList = RestaurantListResponse(
          error: false,
          message: "Success",
          count: 1,
          restaurants: [
            Restaurant(
                id: "1",
                name: "Restaurant Coba Coba",
                description: "Best Restaurant on Medan",
                pictureId: "1",
                city: "Medan",
                address: "Jl.Pegangsaan",
                categories: [],
                menus: Menus(food: [], drinks: []),
                rating: 4.5,
                customerReviews: [])
          ]);
      registerFallbackValue(mockRestaurantList);
      when(() => mockApiService.getRestaurantList()).thenAnswer((_) async {
        await Future.delayed(Duration(milliseconds: 100));
        return mockRestaurantList;
      });
      final future = provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantListLoadingState>());
      await future;
      expect(provider.resultState, isA<RestaurantListLoadedState>());
    });

    test(
        'Harus mengembalikan daftar restoran ketika pengambilan data API berhasil',
        () async {
      final mockRestaurantList = RestaurantListResponse(
        error: false,
        message: "Success",
        count: 2,
        restaurants: [
          Restaurant(
            id: "1",
            name: "Restaurant A",
            description: "Best food",
            pictureId: "1",
            city: "Jakarta",
            address: "Jl. Sudirman",
            categories: [],
            menus: Menus(food: [], drinks: []),
            rating: 4.5,
            customerReviews: [],
          ),
          Restaurant(
            id: "2",
            name: "Restaurant B",
            description: "Delicious meals",
            pictureId: "2",
            city: "Bandung",
            address: "Jl. Asia Afrika",
            categories: [],
            menus: Menus(food: [], drinks: []),
            rating: 4.2,
            customerReviews: [],
          ),
        ],
      );

      registerFallbackValue(mockRestaurantList);

      when(() => mockApiService.getRestaurantList())
          .thenAnswer((_) async => mockRestaurantList);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
      final state = provider.resultState as RestaurantListLoadedState;
      expect(state.data.length, 2);
      expect(state.data.first.name, "Restaurant A");
    });
    test(
        'State harus berubah menjadi Loading sebelum Error saat terjadi kegagalan',
        () async {
      when(() => mockApiService.getRestaurantList()).thenAnswer((_) async {
        await Future.delayed(Duration(milliseconds: 100)); // Simulasi delay API
        throw Exception('Gagal memuat data');
      });

      // Jalankan fetch
      final future = provider.fetchRestaurantList();

      // Pastikan state berubah menjadi LoadingState terlebih dahulu
      expect(provider.resultState, isA<RestaurantListLoadingState>());

      // Tunggu proses fetch selesai
      await future;

      // Pastikan setelah selesai, state berubah menjadi ErrorState
      expect(provider.resultState, isA<RestaurantListErrorState>());
      final state = provider.resultState as RestaurantListErrorState;
      expect(state.error, contains('Gagal memuat data'));
    });

    test('Harus mengembalikan kesalahan ketika pengambilan data API gagal',
        () async {
      when(() => mockApiService.getRestaurantList())
          .thenThrow(Exception('Gagal memuat data'));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      final state = provider.resultState as RestaurantListErrorState;
      expect(state.error, contains('Gagal memuat data'));
    });
  });
}
