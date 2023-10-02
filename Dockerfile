FROM python:slim
WORKDIR /source
COPY requirements.txt ./
COPY app.py ./
RUN pip install --no-cache-dir -r requirements.txt
ENV STREAMLIT_SERVER_PORT=80
EXPOSE 80
ENTRYPOINT [ "streamlit", "run", "app.py" ]