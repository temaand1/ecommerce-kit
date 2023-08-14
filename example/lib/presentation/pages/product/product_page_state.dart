class ProductPageState {
  final bool isFavorite;
  final int itemCount;

  const ProductPageState({
    required this.isFavorite,
    required this.itemCount,
  });

  ProductPageState copyWith({
    bool? isFavorite,
    int? itemCount,
  }) {
    return ProductPageState(
      isFavorite: isFavorite ?? this.isFavorite,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
