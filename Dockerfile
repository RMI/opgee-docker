FROM continuumio/miniconda3

# Latest commit as of 2023-06-07
ARG OPGEE_COMMIT=ad978eedf9e0b9a10bce10a643b0ed16819646d5

WORKDIR /usr/src/app

RUN git clone https://github.com/Stanford-EAO/OPGEEv4.git --branch master --single-branch . \
  && git checkout $OPGEE_COMMIT
RUN conda env create -f py3-opgee-linux.yml
RUN conda init bash
RUN bash -c "source /root/.bashrc && conda activate opgee && pip install . && opg config"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
