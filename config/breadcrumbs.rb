# ルート
crumb :root do
  link "メルカリ", root_path
end

#マイページ
crumb :"users/show" do
  link "マイページ", user_path(current_user)
end

#プロフィール編集
crumb :"users/profile" do
  link "プロフィール", profile_user_path
  parent :"users/show"
end

#発送元・お届け先住所変更
crumb :"users/address" do
  link "発送元・お届け先住所変更", address_user_path
  parent :"users/show"
end


#支払い方法
crumb :"creditcards/show" do
  link "支払い方法", creditcards_path(current_user)
  parent :"users/show"
end

#クレジットカード情報入力
crumb :"creditcards/new" do
  link "クレジットカード情報入力", new_creditcard_path(current_user)
  parent :"creditcards/show"
end

#メールパスワード確認
crumb :"users/mail_password" do
  link "メール/パスワード", mail_password_user_path
  parent :"users/show"
end

#本人情報の確認
crumb :"users/preview" do
  link "本人情報の確認", preview_user_path
  parent :"users/show"
end

#電話番号の確認
crumb :"users/sms_confirmation" do
  link "電話番号の確認", sms_confirmation_user_path
  parent :"users/show"
end

#ログアウト
crumb :"users/logout" do
  link "ログアウト", logout_user_path(current_user)
  parent :"users/show"
end

#カテゴリー一覧
crumb :"categories/index" do
  link "カテゴリー一覧", categories_path
end

#親カテゴリーのshow
crumb :"categories/show" do |category|
    link "#{category.name}", category_path(category)
    parent :"categories/index"
end

#子カテゴリーのshow
crumb :"categories/root" do |category|
  link "#{category.root.name}", category_path(category.root)
  parent :"categories/index"
end

crumb :"categories/child" do |category|
  link "#{category.name}", category_path(category)
  parent :"categories/root", category
end

#孫カテゴリーのshow
crumb :"categories/parent" do |category|
  link "#{category.parent.name}", category_path(category.parent)
  parent :"categories/root", category
end

crumb :"categories/grandchild" do |category|
  link "#{category.name}", category_path(category)
  parent :"categories/parent", category
end


#ブランド一覧
crumb :"brands/index" do
  link "ブランド一覧", brands_path
end

#ブランドshow
crumb :"brands/show" do |brand|
  link "#{brand.name}", brand_path(brand)
  parent :"brands/index"
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).