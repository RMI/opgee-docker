FROM continuumio/miniconda3

# Latest commit as of 2023-06-20
ARG OPGEE_COMMIT=b7559c49510f2dfe567c638dbe7e6d5002f1e496

WORKDIR /usr/src/app

RUN git clone https://github.com/Stanford-EAO/OPGEEv4.git --branch master --single-branch . \
  && git checkout $OPGEE_COMMIT
RUN conda env create -f py3-opgee-linux.yml
RUN conda init bash
RUN bash -c "source /root/.bashrc && conda activate opgee && pip install . && opg config"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
