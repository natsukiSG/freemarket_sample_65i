# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

##　usersテーブル
|Column|Type|options|
|------|----|-------|
|fist_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|nickname|string|null: false, unique: true|
|mail|string|null: false, unique: true|
|password|string|null: false|
|birth_year|integer null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|comment|text|null: false|
|phone_number|string|null: false, unique: true|
### Associatioin
has_many :buyer_products, class_name: 'Product', foreign_key: 'buyer_id'
has_many :seller_products, class_name: 'Product', foreign_key: 'seller_id'
has_many :comments, dependent: :destroy
has_many :likes, dependent: :destroy
has_one :streetaddresses
has_one :creditcards

## productsテーブル
|Column|Type|Options
|name|string|null: false, unique: true|
|comment|text|null: false|
|price|integer|null: false|
|size|string|	
|status|string|null: false|
|costcharge|string|null: false|
|delivery_way|string|null: false|
|delivery_area|string|null: false|
|delivery_date|string|null :false|
|price|integer|null: false|
|buyer_id|integer|class_name: "User"|
|seller_id|integer|class_name: "User"|
|category_id|integer|null: false,foreign_key: true|
|brand_id|integer|foreign_key: true|

