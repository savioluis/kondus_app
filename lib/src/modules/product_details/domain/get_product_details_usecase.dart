import 'package:kondus/src/modules/product_details/domain/product_details_model.dart';
import 'package:kondus/src/modules/product_details/domain/product_details_viewmodel.dart';

final class GetProductDetailsUsecase {
  final _lorem20Words =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce porta pretium sem ac molestie. Sed venenatis massa orci, eu interdum.";
  final _lorem100Words =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel ultricies risus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec a tempus lorem. Ut facilisis metus quis enim lacinia feugiat. Vestibulum sed sapien ut risus malesuada sagittis eget at purus. Donec malesuada ex in ante suscipit maximus. Sed eget orci rutrum, dictum sapien in, ullamcorper tortor. Sed nec quam non orci pretium pellentesque. Praesent in lectus sapien. Mauris dictum dolor sit amet nibh aliquam, ac efficitur est fringilla. Maecenas interdum tincidunt arcu, vitae posuere augue semper id. Phasellus ipsum ligula, consequat vel nisl in.";

  Future<ProductDetailsState> call() async {
    return ProductDetailsSuccessState(
      data: ProductDetailsModel(
          name: "Bolo de laranja",
          owner: ProductDetailsOwnerModel(
            name: "Teresa Maria",
            complement: "Bloco B - Apartamento 1",
          ),
          imageUrls: [
            for(final idx in List.generate(5, (i)=>i))
              "https://picsum.photos/400?random=$idx"
          ],
          description: _lorem100Words),
    );
  }
}
