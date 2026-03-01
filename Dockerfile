FROM golang:1.23 AS build
WORKDIR /app

COPY go.mod ./
COPY main.go ./
COPY templates ./templates

RUN CGO_ENABLED=0 go build -o app .


FROM scratch
WORKDIR /app

COPY --from=build /app/app /app/app
COPY --from=build /app/templates /app/templates

EXPOSE 8080
CMD ["/app/app"]
