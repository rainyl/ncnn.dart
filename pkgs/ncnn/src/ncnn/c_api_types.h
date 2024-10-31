#ifndef NCNN_C_API_TYPES_H
#define NCNN_C_API_TYPES_H

#include "c_api.h"

#ifdef __cplusplus
extern "C" {
#endif

// Function pointers
typedef void* (*ncnn_allocator_fast_malloc)(ncnn_allocator_t allocator, size_t size);
typedef void (*ncnn_allocator_fast_free)(ncnn_allocator_t allocator, void* ptr);

typedef int (*ncnn_datareader_scan)(ncnn_datareader_t dr, const char* format, void* p);
typedef size_t (*ncnn_datareader_read)(ncnn_datareader_t dr, void* buf, size_t size);

typedef ncnn_mat_t (*ncnn_modelbin_load_1d)(const ncnn_modelbin_t mb, int w, int type);
typedef ncnn_mat_t (*ncnn_modelbin_load_2d)(const ncnn_modelbin_t mb, int w, int h, int type);
typedef ncnn_mat_t (*ncnn_modelbin_load_3d)(const ncnn_modelbin_t mb, int w, int h, int c, int type);

typedef int (*ncnn_layer_load_param)(ncnn_layer_t layer, const ncnn_paramdict_t pd);
typedef int (*ncnn_layer_load_model)(ncnn_layer_t layer, const ncnn_modelbin_t mb);
typedef int (*ncnn_layer_create_pipeline)(ncnn_layer_t layer, const ncnn_option_t opt);
typedef int (*ncnn_layer_destroy_pipeline)(ncnn_layer_t layer, const ncnn_option_t opt);
typedef int (*ncnn_layer_forward_1)(const ncnn_layer_t layer, const ncnn_mat_t bottom_blob, ncnn_mat_t* top_blob, const ncnn_option_t opt);
typedef int (*ncnn_layer_forward_n)(const ncnn_layer_t layer, const ncnn_mat_t* bottom_blobs, int n, ncnn_mat_t* top_blobs, int n2, const ncnn_option_t opt);
typedef int (*ncnn_layer_forward_inplace_1)(const ncnn_layer_t layer, ncnn_mat_t bottom_top_blob, const ncnn_option_t opt);
typedef int (*ncnn_layer_forward_inplace_n)(const ncnn_layer_t layer, ncnn_mat_t* bottom_top_blobs, int n, const ncnn_option_t opt);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif // NCNN_C_API_TYPES_H
