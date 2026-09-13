# 🗺️ Doğu Haritası (Tarihi İnteraktif Harita Sistemi)

Tarihi Doğu coğrafyası, yerleşimleri ve kültürel rotaları için tasarlanmış; modern, mobil uyumlu, yüksek güvenlik standartlarına sahip interaktif web haritası platformu.

---

## 📌 İçindekiler
1. [Genel Bakış ve Özellikler](#-genel-bakış-ve-özellikler)
2. [Sistem Mimarisi ve Teknoloji Yığını](#-sistem-mimarisi-ve-teknoloji-yığını)
3. [Dizin ve Dosya Yapısı](#-dizin-ve-dosya-yapısı)
4. [Güvenlik ve Konteyner Standartları](#-güvenlik-ve-konteyner-standartları)
5. [Yerel Geliştirme ve Kurulum](#-yerel-geliştirme-ve-kurulum)
6. [Kubernetes Dağıtımı ve Ağ Mimarisi](#-kubernetes-dağıtımı-ve-ağ-mimarisi)
7. [CI/CD Dağıtım Boru Hattı](#-cicd-dağıtım-boru-hattı)
8. [Sürüm Yönetimi (SemVer) ve Commit Kuralları](#-sürüm-yönetimi-semver-ve-commit-kuralları)

---

## 🧭 Genel Bakış ve Özellikler

* **Tarihi Temalı Arayüz:** Doğu Akdeniz, Anadolu, Kafkaslar ve çevre coğrafyaların tarihi dokusuna uygun özel renk paleti ve tipografi.
* **Mobil ve Dokunmatik Desteği:** Akıllı telefon ve tabletlerde kesintisiz çift dokunuş, kaydırma ve parmak hareketleriyle sezgisel gezinme.
* **Gelişmiş Bilgi Panelleri:** Yerleşim yerleri, tarihi olaylar ve rotalar hakkında dinamik bilgi kartları.
* **Ultra Hafif ve Hızlı:** İstemci tarafında optimize edilmiş Leaflet tabanlı yapı, Gzip sıkıştırma ve önbellek desteği.

---

## 🏗️ Sistem Mimarisi ve Teknoloji Yığını

| Katman | Teknoloji / Standart | Açıklama |
| :--- | :--- | :--- |
| **Ön Yüz (Frontend)** | HTML5 / Modern CSS / Vanilla JS / Leaflet | Yüksek performanslı, bağımlılıksız tek sayfa arayüzü |
| **Web Sunucusu** | Nginx Alpine (Non-Root) | Güvenlik başlıkları, gzip ve `/healthz` uç noktası yapılandırılmış |
| **Konteyner** | Docker (Multi-Stage, Multi-Arch) | `linux/arm64` ve `linux/amd64` tam uyumlu |
| **Altyapı** | Oracle Cloud Infrastructure (OCI) ARM64 | K3s / Rancher Kubernetes Kümesi (Rocky Linux Host) |
| **Ingress & Ağ** | Traefik Ingress Controller | `harita.konstantiniyye.studio` |
| **CI / CD** | Gitea Actions & Gitea Container Registry | Multi-arch buildx derlemesi ve otomatik K3s rollout |

---

## 📂 Dizin ve Dosya Yapısı

```text
Dogu/
├── .gitea/
│   └── workflows/
│       └── deploy.yaml         # Gitea Actions CI/CD hattı (Buildx, Multi-arch, K8s Rollout)
├── .vscode/
│   └── settings.json           # VS Code geliştirme tercihleri
├── Dockerfile                  # Multi-stage, non-root (USER 10001) Docker yapılandırması
├── nginx.conf                  # Port 8080, tmp dizinleri ve güvenlik başlıklarına sahip Nginx ayarları
├── deployment.yaml             # Kubernetes Deployment, Service ve Ingress manifestoları
├── index.html                  # Harita arayüzü, Leaflet kütüphanesi ve etkileşim kodları
├── .gitignore                  # Harici alt repoları ve geçici dosyaları filtreleyen yapılandırma
└── README.md                   # Proje oryantasyon ve mimari dokümantasyonu
```

---

## 🔒 Güvenlik ve Konteyner Standartları

Bu proje kurumsal bulut ve Kubernetes güvenlik standartlarına tam uyumlu olarak inşa edilmiştir:

1. **Rootless (Non-Root) Çalışma Zamanı:**
   * Konteyner içerisinde `root` (`UID 0`) kullanıcısı tamamen devre dışı bırakılmıştır.
   * Uygulama, özel olarak ayrılmış `USER 10001` (`appuser`) kimliğiyle çalışır.
   * Standart 80 portu yerine ayrıcalıksız (non-privileged) **`8080`** portu dinlenir.

2. **Salt-Okunur Kök Dosya Sistemi (`readOnlyRootFilesystem: true`):**
   * Konteyner kök dosya sistemi salt-okunur moddadır; dosya enjeksiyonu ve yetkisiz değişiklik engellenir.
   * Nginx'in çalışma anında ihtiyaç duyduğu geçici dizinler (`/tmp`, `/var/cache/nginx`, `/var/log/nginx`) Kubernetes tarafında `emptyDir` birimleriyle sağlanır.

3. **Linux Yeteneklerinin Sıfırlanması:**
   * Container seviyesinde `capabilities.drop: [ALL]` ve `allowPrivilegeEscalation: false` uygulanarak çekirdek seviyesi yetki yükseltmeleri önlenmiştir.

4. **Sağlık Probları (Health Probes):**
   * `startupProbe`, `readinessProbe` ve `livenessProbe` yapılandırmaları Nginx içindeki `/healthz` uç noktasına bağlanmıştır.

---

## 💻 Yerel Geliştirme ve Kurulum

### Yöntem 1: Docker ile Çalıştırma (Önerilen)

```bash
# 1. Konteyner imajını derleyin
docker build -t dogu-haritasi:local .

# 2. Konteyneri başlatın
docker run -d --name dogu-web -p 8080:8080 dogu-haritasi:local

# 3. Tarayıcınızda test edin
# http://localhost:8080
# Sağlık kontrolü: http://localhost:8080/healthz
```

### Yöntem 2: Statik Önizleme
Herhangi bir yerel HTTP sunucusu ile `index.html` dosyasını doğrudan çalıştırabilirsiniz:
```bash
# Python ile hızlı sunucu
python3 -m http.server 8080
```

---

## ☸️ Kubernetes Dağıtımı ve Ağ Mimarisi

Dağıtım, **`harita`** namespace'i altında izole edilmiştir.

### Ağ Akış Şeması
```text
İstemci (Kullanıcı)
       │
       ▼
Traefik Ingress (harita.konstantiniyye.studio)
       │
       ▼
K8s Service: dogu-haritasi-service (Port: 80 -> TargetPort: 8080)
       │
       ▼
K8s Pod: dogu-haritasi (Port: 8080, User: 10001, Multi-stage Nginx)
```

### Manuel Dağıtım Komutu
```bash
kubectl apply -f deployment.yaml -n harita
kubectl rollout status deployment/dogu-haritasi -n harita
```

---

## 🚀 CI/CD Dağıtım Boru Hattı

Gitea Actions iş akışı (`.gitea/workflows/deploy.yaml`), `main` dalına kod gönderildiğinde (`push`) otomatik olarak tetiklenir:

1. **Docker Buildx (Multi-Arch):**
   * OCI ARM64 (`linux/arm64`) ve x86_64 (`linux/amd64`) mimarileri için imaj derlenir.
   * `cache-from: type=gha` ve `cache-to: type=gha,mode=max` ile derleme hızlandırılır.
   * Gitea Container Registry'ye SemVer etiketi (`1.1.0`) ve commit SHA digest'i ile push edilir.

2. **Kubeconfig ve Akıllı Dağıtım:**
   * Secret içerisindeki `KUBE_CONFIG` değişkeninin ham YAML veya Base64 olup olmadığı dinamik algılanır.
   * Küme bağlantısı doğrulandıktan sonra `deployment.yaml` güncellenir ve digest bazlı imaj ile `rollout status` izlenir.

### Gitea Üzerinde Gerekli Secret Tanımları
* `DOCKER_PASSWORD`: Gitea Container Registry erişim şifresi / belirteci.
* `KUBE_CONFIG`: K3s kümesine erişim sağlayan Kubeconfig içeriği (Base64 veya YAML).

---

## 🏷️ Sürüm Yönetimi (SemVer) ve Commit Kuralları

Projeye yapılan tüm katkılarda **Semantic Versioning** (`MAJOR.MINOR.PATCH`) ve **Conventional Commits** standartlarına uyulması zorunludur.

* **Commit Mesaj Dili:** Türkçe
* **Format:**
```text
<tür>(<kapsam>): <kısa ve net başlık>

- **Değişiklik Özeti:** <Yapılan ana değişikliklerin özeti>
- **Teknik Detay:** <Neden, altyapı etkisi veya mimari olarak ne yapıldığı>
- **İlişkili Sürüm:** <SemVer etiketi, örn: 1.1.0>
```
*Türler:* `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`.
