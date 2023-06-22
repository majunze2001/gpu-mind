all:
	nvcc -O0 migrate_ctg.cu -o ctg.o

# nvcc -g -G -O migrate_ctg.cu -o ctg.o
# clang++ add.cpp -o add.o
# nvcc add_1.cu -o add_1.o 
# nvcc add_2.cu -o add_2.o
# nvcc migrate_gtc.cu -o gtc.o
