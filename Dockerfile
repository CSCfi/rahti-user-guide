FROM python:3-alpine

WORKDIR /usr/src/docs

COPY . .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

ENTRYPOINT ["sh", "-c", "./make_config.sh && mkdocs serve -a 0.0.0.0:8000"]
