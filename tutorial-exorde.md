Untuk menjalankan Testnet Exorde ada 2 pilihan yaitu menggunakan conda atau docker. Kekurangan docker adalah perlu mempunyai disk yg cukup besar karena log-nya akan cukup memakan disk
# Tutorial menggunakan Conda
1. Jalankan command ``` wget https://raw.githubusercontent.com/zainantum/checker/main/autoRun.sh && chmod 777 autoRun.sh && bash autoRun.sh ```
2. Setelah command di atas selesai, kalian bisa mengecek worker kalian dengan menggunakan syntax ```screen -ls```
3. Untuk mengecek log dari semua worker cukup jalankan perintah ``` bash log.sh ``` maka log akan tercetak satu persatu
4. Proses instalasi di atas sudah termasuk dengan auto restart. jadi teman-teman tidak perlu melakukan restart manual jika ada error.
5. Jika ada update dari tim dev, silahkan kill semua screen yg sedang dijalankan dengan ```pkill screen``` dengan syarat screen yg sedang berjalan hanya screen exorde. Setelah itu jalankan perintah ``` bash updater.sh ```

# Tutorial menggunakan Docker
1. Jalankan command ``` wget https://raw.githubusercontent.com/zainantum/exorde-auto/main/autoRunDocker.sh && chmod 777 autoRunDocker.sh && ./autoRunDocker.sh ```
2. Setelah command di atas selesai, kalian bisa mengecek worker kalian dengan menggunakan syntax ```docker ps```
3. Untuk mengecek log dari semua worker cukup jalankan perintah ``` bash logDocker.sh ``` maka log akan tercetak satu persatu
4. Proses instalasi di atas sudah termasuk dengan auto restart. jadi teman-teman tidak perlu melakukan restart manual jika ada error.
5. Jika ada update dari tim dev, silahkan jalankan perintah ``` bash updaterDocker.sh ```
