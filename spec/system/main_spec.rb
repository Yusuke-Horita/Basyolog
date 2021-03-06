require 'rails_helper'

describe "アクセス権限のテスト", type: :system do
	let(:user) { create(:user) }
	let(:admin) { create(:user) }
	subject { current_path }
	context "管理者がログインしていない場合" do
		before do
			visit new_user_session_path
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
			click_button "ログイン"
		end
		it "会員一覧画面に遷移できない" do
			visit admins_users_path
			is_expected.to eq new_admin_session_path
		end
		it "管理者側の記事一覧画面に" do
			visit admins_posts_path
			is_expected.to eq new_admin_session_path
		end
	end
	context "会員がログインしていない場合" do
		before do
			visit new_admin_session_path
			fill_in "admin[email]", with: admin.email
			fill_in "admin[password]", with: admin.password
			click_button "ログイン"
		end
		it "新規投稿画面に遷移できない" do
			visit new_post_path
			is_expected.to eq new_user_session_path
		end
	end
end
