# syntax=docker/dockerfile:1
# Build context is the SOLUTION ROOT: docker build -f SocialMauiApp.Api/Dockerfile .

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

COPY ["SocialMauiApp.Api/SocialMauiApp.Api.csproj", "SocialMauiApp.Api/"]
COPY ["SocialMediaMaui.Shared/SocialMediaMaui.Shared.csproj", "SocialMediaMaui.Shared/"]
RUN dotnet restore "SocialMauiApp.Api/SocialMauiApp.Api.csproj"

COPY ["SocialMauiApp.Api/", "SocialMauiApp.Api/"]
COPY ["SocialMediaMaui.Shared/", "SocialMediaMaui.Shared/"]
RUN dotnet publish "SocialMauiApp.Api/SocialMauiApp.Api.csproj" \
    -c $BUILD_CONFIGURATION \
    -o /app/publish \
    /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080

COPY --from=build /app/publish .

# wwwroot/uploads giữ ảnh upload, Data giữ SQLite cache -> phải ghi được bởi user non-root.
RUN mkdir -p /app/wwwroot/uploads /app/Data && chown -R $APP_UID /app/wwwroot /app/Data

USER $APP_UID
ENTRYPOINT ["dotnet", "SocialMauiApp.Api.dll"]
