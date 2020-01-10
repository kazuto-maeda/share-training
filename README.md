# share-training


## できる事
ジムでのトレーニング、自宅でのトレーニングなどをシェアできるwebサービスです

## 使用言語、技術
開発言語  
　Ruby(Ruby on Rails)、html、bootstrap  
 
データベース言語  
  Mysql(開発時)、Postgresql(本番環境)  
  
サーバー  
  heroku  

## 機能
・ログイン機能  
・プロフィール編集  
・パスワード、アカウント情報の変更  
・投稿機能  
・フォロー機能  
・いいね機能  
・コメント機能  
・画像アップロード機能　(carriawaveとストレージサービスcloudinalyを使用)  
・通知機能（作品にいいね、コメント、フォローをされた時）  

## アピールポイント
・投稿作成時、トレーニングを同時に登録できる  
・トレーニング項目は、動的にフォームを増やし投稿と1対多関連付けをして保存  

## URL
<https://share-training.herokuapp.com>

※ゲストユーザー  
　メールアドレス guest@guest.guest  
　パスワード guest  
　もしくはユーザーを新規作成してログインできます  
※ゲストユーザーの投稿、プロフィール、フォロー、いいね、は予告無く削除、変更されることがあります  
※ゲストユーザーでログインした場合、退会、パスワードの変更、メールアドレスの変更はできません。  


