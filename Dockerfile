ARG PY=3.5
ARG BASE="python:${PY}-slim"

FROM $BASE

WORKDIR /src

RUN set -x \
      && apt-get update \
      && apt-get install -y \
          gcc \
          libgirepository1.0-dev \
          libcairo2-dev \
          pkg-config \
          gir1.2-gtk-3.0 \
          python3-dev \
          python3-gst-1.0 \
          gstreamer1.0-plugins-good \
          gstreamer1.0-plugins-bad \
          gstreamer1.0-plugins-ugly \
          gstreamer1.0-tools \
          liquidsoap \
          silan \
      && apt-get clean

COPY requirements.txt /src
COPY test-requirements.txt /src
COPY man-requirements.txt /src
RUN pip install -r requirements.txt \
      && pip install -r test-requirements.txt \
      && pip freeze

ENTRYPOINT ["/src/tests.sh"]
