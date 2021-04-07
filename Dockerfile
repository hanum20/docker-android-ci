FROM gradle:jdk8-openj9

RUN dpkg --add-architecture i386 && \
    apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && \
    apt-get install -y libc6:i386 libgcc1:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 vim


ARG ANDROID_SDK_VERSION=6858069
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip && \
    unzip *tools*linux*.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/tools && \
    rm *tools*linux*.zip

RUN yes|${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin/sdkmanager --licenses

RUN ${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin/sdkmanager "cmdline-tools;latest"
RUN ${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin/sdkmanager "build-tools;30.0.2"
RUN ${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin/sdkmanager "platforms;android-29"
RUN ${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin/sdkmanager "extras;android;m2repository"

RUN yes|${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin/sdkmanager --licenses
