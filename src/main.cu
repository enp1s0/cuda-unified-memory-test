#include <iostream>
#include <chrono>
#include <cublas.h>
#include <cublas_v2.h>

constexpr std::size_t N = 1lu << 15;

std::size_t gemm_test() {
	float *da, *db, *dc;
	cudaMalloc(&da, sizeof(float) * N * N);
	cudaMalloc(&db, sizeof(float) * N * N);
	cudaMalloc(&dc, sizeof(float) * N * N);

	float *ha, *hb, *hc;
	cudaMallocHost(&ha, sizeof(float) * N * N);
	cudaMallocHost(&hb, sizeof(float) * N * N);
	cudaMallocHost(&hc, sizeof(float) * N * N);

	// Init
	for (std::size_t i = 0; i < N * N; i++) {
		ha[i] = 1.f;
		hb[i] = 1.f;
		hc[i] = 1.f;
	}

	cublasHandle_t cublas_handle;
	cublasCreate(&cublas_handle);

	const auto start_clock = std::chrono::system_clock::now();
	const float alpha = 1.0f;
	const float beta = 1.0f;

	// Copy to device
	cudaMemcpy(da, ha, sizeof(float) * N * N, cudaMemcpyDefault);
	cudaMemcpy(db, hb, sizeof(float) * N * N, cudaMemcpyDefault);
	cudaMemcpy(dc, hc, sizeof(float) * N * N, cudaMemcpyDefault);

	// Gemm
	cublasSgemm(
			cublas_handle,
			CUBLAS_OP_T, CUBLAS_OP_N,
			N, N, N,
			&alpha,
			da, N,
			db, N,
			&beta,
			dc, N
			);

	cudaDeviceSynchronize();
	const auto end_clock = std::chrono::system_clock::now();

	cudaFreeHost(ha);
	cudaFreeHost(hb);
	cudaFreeHost(hc);

	cudaFree(da);
	cudaFree(db);
	cudaFree(dc);

	return std::chrono::duration_cast<std::chrono::microseconds>(end_clock - start_clock).count();
}

std::size_t gemm_test_umem() {
	float *ua, *ub, *uc;
	cudaMallocManaged(&ua, sizeof(float) * N * N);
	cudaMallocManaged(&ub, sizeof(float) * N * N);
	cudaMallocManaged(&uc, sizeof(float) * N * N);

	// Init
	for (std::size_t i = 0; i < N * N; i++) {
		ua[i] = 1.f;
		ub[i] = 1.f;
		uc[i] = 1.f;
	}

	cublasHandle_t cublas_handle;
	cublasCreate(&cublas_handle);

	const auto start_clock = std::chrono::system_clock::now();
	const float alpha = 1.0f;
	const float beta = 1.0f;

	// Gemm
	cublasSgemm(
			cublas_handle,
			CUBLAS_OP_T, CUBLAS_OP_N,
			N, N, N,
			&alpha,
			ua, N,
			ub, N,
			&beta,
			uc, N
			);

	cudaDeviceSynchronize();
	const auto end_clock = std::chrono::system_clock::now();

	cudaFreeHost(ua);
	cudaFreeHost(ub);
	cudaFreeHost(uc);

	return std::chrono::duration_cast<std::chrono::microseconds>(end_clock - start_clock).count();
}

int main() {
	std::printf("Matrix size : %lu x %lu\n", N, N);

	const auto gemm_mem_time = gemm_test();
	std::printf("[ mem] %luus\n", gemm_mem_time);

	const auto gemm_umem_time = gemm_test_umem();
	std::printf("[umem] %luus\n", gemm_umem_time);
}
