from robbyjo/r-mkl-bioconductor:3.4.1

MAINTAINER Seung Hoan Choi (schoi@broadinstitute.org)

RUN apt-get update
RUN apt-get -y install git

RUN echo 'install.packages("BiocManager")' > install.R && \
	echo "BiocManager::install(c('SeqArray'), dependencies=TRUE, clean=TRUE, INSTALL_opts='--no-docs --no-demo --byte-compile',version="3.8");" >> install.R && \
	R CMD BATCH install.R && \
	rm install.R

RUN git clone https://github.com/seuchoi/vcf2gds.git && cd ./vcf2gds && git pull origin master
