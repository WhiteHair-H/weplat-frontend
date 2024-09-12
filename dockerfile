# Apache 이미지를 기반으로 사용
FROM httpd:2.4

# 필요한 모듈을 로드하는 설정을 추가
RUN echo "LoadModule proxy_module modules/mod_proxy.so" >> /usr/local/apache2/conf/httpd.conf \
    && echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /usr/local/apache2/conf/httpd.conf

# VirtualHost 설정 추가
RUN echo "<VirtualHost *:80>\n\
  ServerName weplat-ap2-web-alb-1374699592.ap-northeast-1.elb.amazonaws.com\n\
  ProxyPreserveHost On\n\
  ProxyPass / http://weplat-ap2-was-nlb-b2860825aee875fd.elb.ap-northeast-1.amazonaws.com:8080/\n\
  ProxyPassReverse / http://weplat-ap2-was-nlb-b2860825aee875fd.elb.ap-northeast-1.amazonaws.com:8080/\n\
</VirtualHost>" >> /usr/local/apache2/conf/httpd.conf

# 포트 80을 외부로 열어줌
EXPOSE 80

# Apache 서버 실행
CMD ["httpd-foreground"]
