module ProductsHelper
    def converting_to_jpy(price)
      "#{@product.price.to_s(:delimited, delimiter: ',')}円"
    end
  end
