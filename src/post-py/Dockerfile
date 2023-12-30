FROM python:3.6-alpine3.6
WORKDIR /app
COPY . /app
RUN apk add --update --no-cache build-base=0.5-r0 gcc=6.3.0-r4 && pip install --no-cache-dir -r /app/requirements.txt
ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts
CMD ["python3", "post_app.py"]
