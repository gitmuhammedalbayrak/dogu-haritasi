# Hafif bir web sunucusu olan Nginx kullanıyoruz
FROM nginx:alpine

# Senin HTML dosyanı sunucunun içine kopyalıyoruz
COPY index.html /usr/share/nginx/html/index.html

# 80 portunu dışarı açıyoruz
EXPOSE 80