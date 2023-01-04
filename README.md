Konfigurasi VPS
1. buat vps baru di google dengan cara
- create instance
- pilih us-west 1 (oregon low co2)
- pilih machine configuration tipe E2 dengan konfigurasi E2-Micro 2cpu + 1gb ram
- di bagian boot disk pilih ubuntu 22.04 dengan size disk 50gb
- create
- untuk digital ocean bisa memilih droplet dengan ram 2gb + 1cpu. kalo tidak salah harganya 12$/bulan. silahkan buat sebanyak sisa credit/sisa waktu trial
2. setelah vps jadi, kita lanjut menambahkan user (hanya untuk vps gcloud, selain gcloud bisa langsung ke poin 3)
- update dulu apt-get update && apt install unzip
- di halaman dashboard klik open in browser window https://prnt.sc/ZgDK0WXq-46Z di vps yg telah kita buat
- setelah masuk ke terminal ketik ```sudo su```
- ketik ```adduser namauser``` kemudian isi password dan skip isian yg lain dengan cara enter. namauser diganti dengan nama anda
- ketik ```visudo``` kemudian scroll ke bawah dibagian ```root ALL ALL ALL``` copy script tersebut kemudian pastekan dibawahnya. ubah root dengan namauser yg telah dibuat kemudian ctrl + x kemudian pilih y
- ketik ```nano /etc/ssh/sshd_config``` kemudian scroll ke bawah cari ```PasswordAuthentication no``` kemudian ubah dari no menjadi yes ```PasswordAuthentication yes``` kemudian ctrl + x dan simpan
- restart ssh menggunakan ```/etc/init.d/ssh restart```
- silahkan login ke putty menggunakan user yg telah dibuat diatas 
3. run ```wget https://raw.githubusercontent.com/zainantum/checker/main/autoRun.sh && chmod 777 autoRun.sh && ./autoRun.sh```

install pstree
```apt-get install psmisc```
