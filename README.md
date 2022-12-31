Konfigurasi VPS
1. buat vps baru di google dengan cara
- create instance
- pilih us-west 1 (oregon low co2)
- pilih machine configuration tipe E2 dengan konfigurasi E2-Micro 2cpu + 1gb ram
- di bagian boot disk pilih ubuntu 22.04 dengan size disk 40gb
- create
2. setelah vps jadi kita lanjut menambahkan user
- di halaman dashboard klik open in browser window https://prnt.sc/ZgDK0WXq-46Z di vps yg telah kita buat
- setelah masuk ke terminal ketik ```sudo su```
- ketik ```adduser namauser``` kemudian isi password dan skip isian yg lain dengan cara enter. namauser diganti dengan nama anda
- ketik ```visudo``` kemudian scroll ke bawah dibagian ```root ALL ALL ALL``` copy script tersebut kemudian pastekan dibawahnya. ubah root dengan namauser yg telah dibuat kemudian ctrl + x kemudian pilih y
- ketik ```nano /etc/ssh/sshd_config``` kemudian scroll ke bawah cari ```PasswordAuthentication=no``` kemudian ubah dari no menjadi yes ```PasswordAuthentication=yes``` kemudian ctrl + x dan simpan
- restart ssh menggunakan ```/etc/init.d/ssh restart```
- silahkan login ke putty menggunakan user yg telah dibuat diatas dan lanjutkan ke langkah instalasi swap dll
3. proses instalasi swap bisa menggunakan script createSwap.sh dengan alokasi disk bisa disesuaikan kebutuhab
4. setelah itu lanjut install dependensi
- ```apt install python3 python3-pip git screen && pip install --upgrade pip``` semua pertanyaan pilih yes
- ```wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh && bash Anaconda3-2022.10-Linux-x86_64.sh && bash``` semua pertanyaan pilih yes
- ```wget https://github.com/exorde-labs/ExordeModuleCLI/archive/refs/heads/main.zip \ --output-document=ExordeModuleCLI.zip \ && unzip ExordeModuleCLI.zip \ && rm ExordeModuleCLI.zip \ && mv ExordeModuleCLI-main exorde```
- ``` cp -r exorde exorde1 ``` sampai exorde10
- ``` cd exorde ```
- ``` conda create --name exorde-env python=3.9 && conda activate exorde-env ``` semua pertanyaan pilih yes
- ``` pip install -r requirements.txt ```
- jika requirements sudah terinstall bisa ```exit``` setelah exit harusnya terminal kembali menggunakan root buat exorde-env. jika sudah kembali ke root bisa lanjut menggunakan createScreen.sh untuk menjalankan worker. setelah itu lanjut download c1.sh dan stuck.sh kemudian setting cronjob seperti settingan di bawah
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

