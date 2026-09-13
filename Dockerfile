# ==========================================
# Aşama 1: Builder & Varlık Doğrulama (Multi-stage pattern)
# ==========================================
FROM alpine:3.20 AS builder

WORKDIR /app
COPY index.html ./

# Temel HTML varlık kontrolü
RUN test -s index.html || (echo "Hata: index.html dosyası bulunamadı veya boş!" && exit 1)

# ==========================================
# Aşama 2: Runtime (OCI ARM64 ve AMD64 Uyumlu Minimal Nginx)
# ==========================================
FROM nginx:alpine

# Güvenlik Standardı: Non-root kullanıcı ve grup tanımlama (UID/GID 10001)
RUN addgroup -g 10001 -S appgroup && \
    adduser -u 10001 -S appuser -G appgroup && \
    mkdir -p /tmp/client_temp /tmp/proxy_temp_path /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp && \
    chown -R 10001:10001 /tmp /var/cache/nginx /var/log/nginx /etc/nginx

# Non-root ve optimize Nginx yapılandırmasını kopyala
COPY nginx.conf /etc/nginx/nginx.conf

# Statik varlıkları kopyala ve izinlerini ayarla
COPY --from=builder --chown=10001:10001 /app/index.html /usr/share/nginx/html/index.html

# Çalışma zamanında root yetkisini kaldır
USER 10001

# Non-root bağlantı noktası
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]