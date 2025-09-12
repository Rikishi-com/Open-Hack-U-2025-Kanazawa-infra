# ベースイメージ
FROM python:3.12-slim

# 環境変数の設定 (Pythonのログが即座に表示され、.pycファイルが生成されなくなる)
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# 作業ディレクトリ
WORKDIR /app

# システムパッケージを先にインストール (もしあれば)
# COPY install-packages.sh /tmp/install-packages.sh
# RUN chmod +x /tmp/install-packages.sh
# RUN /tmp/install-packages.sh

# Pythonパッケージを先にインストールする (ソースコードの変更で再インストールが走らないようにするため)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# wait-for-it.shスクリプトをコピーして実行権限を付与
COPY ./wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

# アプリケーションの全ファイルをコピー
# この時点では、ローカルで開発したコードがコンテナにコピーされる
COPY . .

# ★★★ この行をコメントアウト（または削除）しました ★★★
# これにより、ローカルのソースコードが上書きされる問題が解決します。
# RUN django-admin startproject hackathon .

# ポートを公開
EXPOSE 8000

# コンテナ起動時に実行されるデフォルトのコマンド
# docker-compose.ymlのcommandで上書きされるため、こちらは保険のようなもの
CMD [ "python","manage.py","runserver","0.0.0.0:8000" ]

