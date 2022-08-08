FROM ubuntu:22.04

LABEL de.mindrunner.android-docker.flavour="ubuntu-standalone"

ENV ANDROID_SDK_HOME /opt/android-sdk-linux
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
ENV ANDROID_HOME /opt/android-sdk-linux
ENV ANDROID_SDK /opt/android-sdk-linux

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yqq && apt-get install -y \
  curl \
  expect \
  git \
  make \
  libc6 \
  libgcc1 \
  libncurses5 \
  libstdc++6 \
  zlib1g \
  openjdk-11-jdk \
  wget \
  unzip \
  vim \
  openssh-client \
  locales \
  libarchive-tools \
  sudo \
  python3 \
  ruby ruby-dev \
  build-essential \
  && apt-get clean

RUN gem install google-api-client
RUN gem install fastlane -NV
RUN gem install fastlane-plugin-appicon fastlane-plugin-android_change_string_app_name fastlane-plugin-humanable_build_number
RUN gem install fastlane-plugin-firebase_app_distribution

ENV LANG en_US.UTF-8

RUN groupadd android && useradd -d /opt/android-sdk-linux -g android -u 1000 android

COPY tools /opt/tools

COPY licenses /opt/licenses

WORKDIR /opt/android-sdk-linux

RUN /opt/tools/entrypoint.sh built-in

CMD /opt/tools/entrypoint.sh built-in