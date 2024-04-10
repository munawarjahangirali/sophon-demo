#!/bin/bash
res=$(which unzip)
if [ $? != 0 ];
then
    echo "Please install unzip on your system!"
    exit
fi
pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
scripts_dir=$(dirname $(readlink -f "$0"))

pushd $scripts_dir
# datasets
if [ ! -d "../datasets" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/BERT/datasets_0918/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "datasets download!"
else
    echo "Datasets folder exist! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/BERT/models_0918/models.zip
    unzip models.zip -d ../
    rm models.zip
    pushd ../models/
    python3 -m dfss --url=open@sophgo.com:sophon-demo/BERT/models_a2_0118/BM1688.zip
    unzip BM1688.zip
    rm -r BM1688.zip
    python3 -m dfss --url=open@sophgo.com:sophon-demo/BERT/models_a2_240410/CV186X.zip
    unzip CV186X.zip
    rm -r CV186X.zip
    popd
    echo "models download!"
else
    echo "Models folder exist! Remove it if you need to update."
fi
popd