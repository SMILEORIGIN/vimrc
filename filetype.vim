au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*,/usr/local/etc/nginx/servers/* if &ft == '' | setfiletype nginx | endif
