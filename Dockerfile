FROM continuumio/miniconda3

# Latest commit as of 2023-01-27
ARG OPGEE_COMMIT=07fdca83cbbcc9f0aa22bb6dc8d50ce1e02559e5

WORKDIR /usr/src/app

RUN git clone https://github.com/Stanford-EAO/OPGEEv4.git --branch master --single-branch . \
  && git checkout $OPGEE_COMMIT
RUN conda env create -f py3-opgee-linux.yml
RUN conda init bash
RUN bash -c "source /root/.bashrc && conda activate opgee && pip install --editable . && opg config"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
