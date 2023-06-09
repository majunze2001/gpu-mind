all:
	nvcc add_1.cu -o add_1.o 
	nvcc add_2.cu -o add_2.o
	nvcc migrate_ctg.cu -ctg.o