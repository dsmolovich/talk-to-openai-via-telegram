FROM python:3.11-slim-buster as base
COPY ./requirements.txt /
RUN pip install -r /requirements.txt
COPY ./src /src
WORKDIR /src
CMD [ "python", "app.py" ]


########### DEBUGGER ###########
FROM base as debug
COPY ./requirements.dev.txt /
RUN pip install -r /requirements.dev.txt
USER nobody
#CMD [ "watchmedo", "auto-restart", "--pattern='*.py'", "--recursive", "python", "--", "-m", "debugpy", "--listen", "0.0.0.0:5678", "app.py"]
CMD [ "watchmedo", "auto-restart", "--recursive", "python", "--", "-m", "debugpy", "--listen", "0.0.0.0:5678", "app.py" ]