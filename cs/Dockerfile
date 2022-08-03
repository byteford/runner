ARG IMAGE_TAG
FROM mcr.microsoft.com/dotnet/sdk:${IMAGE_TAG}

RUN apt-get update
RUN apt-get -y install make

COPY /src /make