Konfigurasi VPS
1. buat vps baru di google dengan cara
a. create instance
b. pilih us-west 1 (oregon low co2)
c. pilih machine configuration tipe E2 dengan konfigurasi E2-Micro 2cpu + 1gb ram
d. di bagian boot disk pilih ubuntu 22.04 dengan size disk 40gb
e. create
2. setelah vps jadi kita lanjut menambahkan user
a. di halaman dashboard klik open in browser window https://prnt.sc/ZgDK0WXq-46Z di vps yg telah kita buat
b. setelah masuk ke terminal ketik ```sudo su```
c. ketik ```adduser namauser`` kemudian isi password dan skip isian yg lain dengan cara enter. namauser diganti dengan nama anda
d. ketik ```visudo``` kemudian scroll ke bawah dibagian ```root ALL ALL ALL``` copy script tersebut kemudian pastekan dibawahnya. ubah root dengan namauser yg telah dibuat kemudian ctrl + x kemudian pilih y
e. ketik ```nano /etc/ssh/sshd_config``` kemudian scroll ke bawah cari ```PasswordAuthentication=no``` kemudian ubah dari no menjadi yes ```PasswordAuthentication=yes``` kemudian ctrl + x dan simpan
f. restart ssh menggunakan ```/etc/init.d/ssh restart```
g. silahkan login ke putty menggunakan user yg telah dibuat diatas dan lanjutkan ke langkah instalasi swap dll

# add checker to crontab
``` */1 * * * * /root/c1.sh 2>&1 | logger -t mycmd ```
``` */5 * * * * /root/stuck.sh 2>&1 | logger -t mycmd ```
# check log
``` journalctl -u cron.service ```

# download checker
``` wget https://raw.githubusercontent.com/zainantum/checker/main/c1.sh && chmod 777 c1.sh ```

# download stuck
``` wget https://raw.githubusercontent.com/zainantum/checker/main/stuck.sh && chmod 777 stuck.sh ```

# download updater
``` wget https://raw.githubusercontent.com/zainantum/checker/main/updater.sh && chmod 777 updater.sh ```

