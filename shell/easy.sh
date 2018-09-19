echo "ad-service"
cd /home/easy-park2.0/deployment/ad-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-ad-info-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &


echo "cms-service"
cd /home/easy-park2.0/deployment/cms-sevice
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar cms-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &


echo "end-user-service"
cd /home/easy-park2.0/deployment/end-user-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-ad-info-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "feedback-service"
cd /home/easy-park2.0/deployment/feedback-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-end-user-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "order-service"
cd /home/easy-park2.0/deployment/order-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-order-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "parking-service"
cd /home/easy-park2.0/deployment/parking-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-parking-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &


echo "shop-service"
cd /home/easy-park2.0/deployment/shop-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-shop-info-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "version-service"
cd /home/easy-park2.0/deployment/version-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-version-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "area-service"
cd /home/easy-park2.0/deployment/area-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-area-info-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "coupon-service"
cd /home/easy-park2.0/deployment/coupon-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-coupon-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "equip-communicate-service"
cd /home/easy-park2.0/deployment/equip-communicate-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-equip-communicate-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "message-service"
cd /home/easy-park2.0/deployment/message-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-message-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "park-info-service"
cd /home/easy-park2.0/deployment/park-info-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-park-info-service-1.0-SNAPSHOT >> catalina.out 2>&1 &

echo "park-supplier-service"
cd /home/easy-park2.0/deployment/park-supplier-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-park-supplier-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "token-service"
cd /home/easy-park2.0/deployment/token-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ifox-token-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &

echo "wallet-service"
cd /home/easy-park2.0/deployment/wallet-service
nohup java -Xms512m -Xmx512m -Xmn200m -Xss256k -jar ep-wallet-service-1.0-SNAPSHOT.jar >> catalina.out 2>&1 &


###########################

for alpha in 10000 10001 10003 10004 10005 10006 10007 10008 10009 10010 10011 10012 10013 10014 10015 10016 10017 10018 10019 10020 10021 10030 10028 10031 ;do
    echo "端口="  $alpha
    #根据端口号查询对应的pid
    pid=$(netstat -nlp | grep :$alpha | awk '{print $7}' | awk -F"/" '{ print $1 }');
    echo "pid=" $pid
    #杀掉对应的进程，如果pid不存在，则不执行
    if [  -n  "$pid"  ];  then
      kill  -9  $pid;
    fi

done



