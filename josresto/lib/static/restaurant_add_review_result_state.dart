sealed class RestaurantAddReviewResultState {}

class RestaurantAddReviewNoneState extends RestaurantAddReviewResultState {}

class RestaurantAddReviewLoadingState extends RestaurantAddReviewResultState {}

class RestaurantAddReviewEmptyState extends RestaurantAddReviewResultState {}

class RestaurantAddReviewErrorState extends RestaurantAddReviewResultState {
  final String error;
  RestaurantAddReviewErrorState(this.error);
}

class RestaurantAddReviewSuccessState extends RestaurantAddReviewResultState {
  final String message;

  RestaurantAddReviewSuccessState(this.message);
}
