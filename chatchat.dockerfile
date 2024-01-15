FROM nvidia/cuda:12.3.0-runtime-ubuntu22.04
LABEL MAINTAINER="cgwyx"

COPY ./Langchain-Chatchat /Langchain-Chatchat

WORKDIR /Langchain-Chatchat

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
RUN apt-get update -y && apt-get install python3 python3-pip curl libgl1 libglib2.0-0 -y  && apt-get clean
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py 

WORKDIR /Langchain-Chatchat

RUN pip3 install -r requirements.txt  -i https://pypi.mirrors.ustc.edu.cn/simple/
RUN  pip3 install -r requirements_api.txt  -i https://pypi.mirrors.ustc.edu.cn/simple/
RUN pip3 install -r requirements_webui.txt -i https://pypi.mirrors.ustc.edu.cn/simple/

RUN  python3 copy_config_example.py
#RUN  python3 init_database.py --recreate-vs

CMD ["python3","startup.py", "-a"]
