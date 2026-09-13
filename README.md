# 🧭 Doğu Yönelimli İnteraktif Dünya Haritası (East-Oriented World Map)

<div align="center">

[![Live Demo](https://img.shields.io/badge/🌐%20Canlı%20Demo-harita.konstantiniyye.studio-00b4d8?style=for-the-badge&logo=googlechrome&logoColor=white)](https://harita.konstantiniyye.studio)
[![Version](https://img.shields.io/badge/Sürüm-1.2.0-6366f1?style=for-the-badge&logo=semver&logoColor=white)](https://github.com/gitmuhammedalbayrak/dogu-haritasi)
[![Arch](https://img.shields.io/badge/Mimari-linux%2Farm64-f97316?style=for-the-badge&logo=arm&logoColor=white)](https://github.com/gitmuhammedalbayrak/dogu-haritasi)
[![K8s](https://img.shields.io/badge/Orkestrasyon-K3s%20%7C%20Rancher-326ce5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://github.com/gitmuhammedalbayrak/dogu-haritasi)
[![Docker](https://img.shields.io/badge/Konteyner-Non--Root%20(10001)-22c55e?style=for-the-badge&logo=docker&logoColor=white)](https://github.com/gitmuhammedalbayrak/dogu-haritasi)

**Tarihsel Doğu-Yukarı (Orient) Perspektifini Modern Küresel Jeopolitik, Stratejik Boğazlar ve Finans Merkezleriyle Buluşturan Yeni Nesil Vektör Harita Platformu.**

[Canlı Haritayı İncele](https://harita.konstantiniyye.studio) • [Özellikler](#-yeni-nesil-özellikler) • [Mimari](#-sistem-mimarisi) • [Yerel Kurulum](#-yerel-kurulum-ve-çalıştırma)

</div>

---

## 💡 Harita Felsefesi: Neden "Doğu Yukarı"?

Tarih boyunca haritalarda her zaman Kuzey yukarıda değildi:
* **Ortaçağ Avrupa T-O Haritaları:** Cennetin ve güneşin doğuşunun kutsallığı nedeniyle **Doğu (Orient)** daima yukarıda çizilirdi (*"Orientation / Oryantasyon"* kelimesi kökenini buradan alır).
* **Klasik İslam Kartografisi (El-İdrisî):** İslam coğrafyacıları dünyayı **Güney** yukarıda olacak şekilde resmetmişti.
* **Modern Kartografi:** Pusulanın yaygınlaşması ve denizcilikle birlikte Kuzey merkeze alındı.

Bu proje; Doğu yönelimli harita felsefesini nostaljik bir anı olmaktan çıkarıp, **günümüz küresel ticaret yolları, stratejik boğazlar, dünya mega finans merkezleri ve dinamik açılı rotasyon motoruyla** modern dünyanın kullanımına sunar.

---

## ✨ Yeni Nesil Özellikler (v1.2.0)

### 1. 🔄 Dinamik 4 Yönlü Rotasyon Motoru
* **Doğu Yukarı (90°):** Antik ve Ortaçağ Doğu yönelimli dünya perspektifi.
* **Kuzey Yukarı (0°):** Modern küresel standart yönelim.
* **Güney Yukarı (180°):** Güney yarımküre ve İslam kartografisi perspektifi.
* **Batı Yukarı (270°):** Ters okyanus havzası perspektifi.
* **Canlı Pusula:** Harita açısına göre gerçek zamanlı dönen dinamik pusula kadranı.
* **Akıllı Metin Telafisi:** Harita hangi açıda olursa olsun şehir ve boğaz isimleri ters dönmez, daima kullanıcıya doğru dik kalır.

### 2. 🚢 Küresel Deniz Koridorları ve Stratejik Boğazlar (Chokepoints)
* **Darboğazlar ve Kanallar:** Süveyş Kanalı, Malakka Boğazı, Hürmüz Boğazı, Babülmendep, Panama Kanalı, Türk Boğazları (İstanbul & Çanakkale) ve Cebelitarık.
* **Animasyonlu Rotalar:** Asya-Avrupa, Trans-Pasifik, Trans-Atlantik ve Orta Doğu petrol koridorları üzerinde parıldayan kesik çizgi akışları.
* **Tarihi vs Modern Kıyas:** Tarihi İpek Yolu kara kervan ağı ile modern deniz yolları aynı anda karşılaştırılabilir.

### 3. 🏙️ Küresel Finans Hub'ları & Canlı Saatler
* İstanbul, Londra, New York, Tokyo, Şanghay, Singapur, Dubai, Frankfurt, Pekin gibi stratejik merkezler.
* Tıklandığında açılan detay kartında:
  * Koordinatlar ve jeopolitik stratejik rol.
  * Canlı yerel saat hesabı (UTC ofsetiyle otomatik hesaplanır).
  * Nüfus ve ticaret hacmi verileri.

### 4. 🔍 Akıllı Arama ve Odaklanma (Fly-To)
* Şehir veya boğaz adı yazıldığında otomatik tamamlama önerileri.
* Seçilen konuma yumuşak eğrili (cubic-bezier) animasyonla otomatik uçuş ve zoom.

### 5. 🎨 3 Farklı Arayüz Teması
* **Modern Karanlık (Cyber Slate):** Koyu okyanus zemininde neon mavi, amber ve zümrüt rotalar.
* **Minimalist Açık (Clean Vector):** Ferah, modern beyaz/gri harita dokusu.
* **Tarihi Parşömen (Vintage Parchment):** Antika el yazması atlas hissi veren doku ve renkler.

---

## 🏗️ Sistem Mimarisi

| Katman | Teknoloji / Standart | Açıklama |
| :--- | :--- | :--- |
| **Görselleştirme** | D3.js v7 + TopoJSON | Yüksek performanslı SVG vektör projeksiyonu |
| **Ön Yüz Mimarisi** | Vanilla JS + Glassmorphism UI | Bağımlılıksız, ultra hafif (<50 KB) tek sayfa arayüzü |
| **Web Sunucusu** | Nginx Alpine (Rootless) | Port 8080, Gzip sıkıştırma, `/healthz` probe endpointi |
| **Konteyner Güvenliği** | Multi-Stage Dockerfile | `USER 10001`, `readOnlyRootFilesystem: true`, `drop: [ALL]` |
| **Altyapı** | Oracle Cloud (OCI) ARM64 (`aarch64`) | K3s / Rancher Kubernetes Kümesi, Rocky Linux Host |
| **Ingress & TLS** | Traefik Ingress Controller | `harita.konstantiniyye.studio` |

---

## 🚀 Yerel Kurulum ve Çalıştırma

### Docker ile Çalıştırma (Önerilen)
```bash
# 1. Depoyu klonlayın
git clone https://github.com/gitmuhammedalbayrak/dogu-haritasi.git
cd dogu-haritasi

# 2. Çok aşamalı Docker imajını derleyin
docker build -t dogu-haritasi:1.2.0 .

# 3. Non-root konteyneri başlatın
docker run -d --name dogu-web -p 8080:8080 dogu-haritasi:1.2.0

# 4. Tarayıcınızda açın
# http://localhost:8080
```

---

## ☸️ Kubernetes Dağıtımı

Dağıtım, **`harita`** namespace'i altında kurumsal güvenlik standartlarıyla izole edilmiştir:

```bash
# Kümeye uygulamak için:
kubectl apply -f deployment.yaml -n harita

# Dağıtım durumunu doğrulamak için:
kubectl rollout status deployment/dogu-haritasi -n harita
```

---

## 🏷️ Lisans ve Katkı
Bu proje [MIT Lisansı](LICENSE) kapsamında açık kaynak olarak yayınlanmıştır. Katkıda bulunmaktan, hata bildirmekten veya yeni ticaret rotaları önermekten çekinmeyin!
