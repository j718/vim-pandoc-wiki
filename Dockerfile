FROM python:3.7-buster

RUN apt-get update && apt-get install git -y
RUN apt-get install vim -y

RUN git clone https://github.com/junegunn/vader.vim.git vader.vim
