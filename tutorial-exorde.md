Untuk menjalankan Testnet Exorde ada 2 pilihan yaitu menggunakan conda atau docker. Kekurangan docker adalah perlu mempunyai disk yg cukup besar karena log-nya akan cukup memakan disk
# Tutorial menggunakan Conda
1. Jalankan command ``` wget https://raw.githubusercontent.com/zainantum/checker/main/autoRun.sh && chmod 777 autoRun.sh && ./autoRun.sh ```
2. Setelah command di atas selesai, kalian bisa mengecek worker kalian dengan menggunakan syntax ```screen -ls```
3. Untuk mengecek log dari semua worker cukup jalankan perintah ``` bash log.sh ``` maka log akan tercetak satu persatu
4. Proses instalasi di atas sudah termasuk dengan auto restart. jadi teman-teman tidak perlu melakukan restart manual jika ada error.
5. Jika ada update dari tim dev, silahkan kill semua screen yg sedang dijalankan dengan ```pkill screen``` dengan syarat screen yg sedang berjalan hanya screen exorde. Setelah itu jalankan perintah ``` bash updater.sh ```
6. Jika ingin menambah worker baru jalankan ```bash createScreen.sh``` kemudian minimum diisi dengan n+1 dari jumlah worker yg sudah ada dan maksimum worker diisi sesuai keinginan. Misal sudah ada 9 worker dan ingin menambah 1 worker lagi, berarti minimum worker dan maksimum worker sama" diisi dengan 10.

# Tutorial menggunakan Docker
1. Jalankan command ``` wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/autoRunDocker.sh && chmod 777 autoRunDocker.sh && ./autoRunDocker.sh ```
2. Setelah command di atas selesai, kalian bisa mengecek worker kalian dengan menggunakan syntax ```docker ps```
3. Untuk mengecek log dari semua worker cukup jalankan perintah ``` bash logDocker.sh ``` maka log akan tercetak satu persatu
4. Proses instalasi di atas sudah termasuk dengan auto restart. jadi teman-teman tidak perlu melakukan restart manual jika ada error.
5. Jika ada update dari tim dev, silahkan jalankan perintah ``` bash updaterDocker.sh ```
6. Jika ingin menambah worker baru jalankan ```bash createWorkerDocker.sh``` kemudian minimum diisi dengan n+1 dari jumlah worker yg sudah ada dan maksimum worker diisi sesuai keinginan. Misal sudah ada 9 worker dan ingin menambah 1 worker lagi, berarti minimum worker dan maksimum worker sama" diisi dengan 10.


# Tutorial melakukan update script menggunakan conda. Pastikan dalam posisi root
1. lakukan pkill screen menggunakan ```pkill screen``` jika teman-teman hanya ngerun exorde
2. lanjut cek apakah screennya sudah berhasil dikill apa belum dengan ```screen -ls``` jika screennya masih ada silahkan pake command ```reboot``` untuk merestart vps kalian. hal ini karena daemon screennya agak bandel, jadi biar langsung mati
3. setelah vps direstart, cek ulang apakah screennya udah benar-benar dikill dengan ```screen -ls``` jika sudah maka lanjut step berikutnya
4. run command updater kemudian masukkan detail address kalian seperti biasa. done


