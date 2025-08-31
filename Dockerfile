# ベースイメージ
FROM python:3.12-slim

# 環境変数の設定
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 作業ディレクトリ
WORKDIR /app

# 依存ライブラリの設定
COPY requirements.txt .
COPY install-packages.sh /tmp/install-packages.sh

RUN pip install --no-cache-dir -r requirements.txt

# スクリプトに実行権限を付与
RUN chmod +x /tmp/install-packages.sh

# スクリプトを実行
RUN /tmp/install-packages.sh



# コピー
COPY . .

# コンテナ実行コマンド
CMD ["python","main.py"]


