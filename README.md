# README
![ER図 - ERDテンプレート](https://user-images.githubusercontent.com/51071762/72677513-84018980-3ae0-11ea-98f6-95cb1d0f9456.jpeg)



## usersテーブル
|Column|Type|options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|phone_number|string|null: false, unique: true|

### Associatioin
- has_many :buyer_products, class_name: 'Product', foreign_key: 'buyer_id'
- has_many :seller_products, class_name: 'Product', foreign_key: 'seller_id'
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_one :street_addresses
- has_one :creditcards
- has_many :sns_credentials, dependent: :destroy

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|comment|text|null: false|
|status|integer|null: false, enumで管理|
|costcharge|string|null: false|
|delivery_way|string|null: false|
|delivery_area|string|null: false|
|delivery_date|string|null :false|
|price|integer|null: false|
|buyer_id|integer|class_name: "User"|
|seller_id|integer|class_name: "User"|
|category_id|references|null: false,foreign_key: true|
|size_id|references|foreign_key: true|
|brand_id|references|foreign_key: true|

### Associatioin
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- belongs_to :category
- belongs_to :size
- belongs_to :brand
- has_many :images

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|product_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|uid|string|null: false, unique: true|
|provider|string|null: false|

### Association
- belongs_to :user, optional: true

## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|card_id|integer|null: false|
|customer_id|integer|null: false|

### Association
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false,foreign_key: true|
|product_id|references|null: false,foreign_key: true|

### Associatioin
- belongs_to :user
- belongs_to :product_id

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|genre|string|null: false, unique: true|
|ancestry|string||

### Associatioin
- has_many :products
- has_many :size_categories
- has_ancestry

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Associatioin
- has_many :products
- has_many :set_brands

## street_addressテーブル
|Column|Type|Options|
|------|----|-------|
|address_first_name|string|null: false|
|address_last_name|string|null: false|
|address_first_name_kana|string|null: false|
|address_last_name_kana|string|null: false|
|post_number|string|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|address_phone_number|string||
|user_id|references|null: false,foreign_key: true|

### Associatioin
- belongs_to :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|text|null: false|
|product_id|references|null:false,foreign_key:true|

### Associatioin
belongs_to :product

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Associatioin
- has_many :products
- has_many :size_categories

## size_cotegoriesテーブル
|Column|Type|Options|
|------|----|-------|
|size_id|references|foreign_key: true|
|category_id|references|foreign_key: true|

### Association
- belongs_to :size
- belongs_to :category

## set_brandsテーブル
|Column|Type|Options|
|------|----|-------|
|brand_id|references|foreign_key: true|
|brand_category_id|references|foreign_key: true|

### Association
- belongs_to :brand
- belongs_to :brand_category

## brand_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Associatioin
- has_many :set_brands