FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["playing-around.csproj", "./"]
RUN dotnet restore "playing-around.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "playing-around.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "playing-around.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "playing-around.dll"]
