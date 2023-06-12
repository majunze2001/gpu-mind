
// The start --> memory mapping
SyS_mmap() -> do_mmap() -> uvm_mmap_entry()



- do_async_page_fault()
  - find_vma()
  - handle_mm_fault()
    - __do_fault()
      - uvm_va_space_cpu_fault() uvm_va_space.c#2133

        // Handle a CPU fault in the given VA space for a managed allocation,
        // performing any operations necessary to establish a coherent CPU mapping
        // (migrations, cache invalidates, etc.).
        
        - uvm_va_block_find_create()
          - uvm_va_block_find_create_in_range()
          - kmem_cache_zalloc()


- uvm_va_space_cpu_fault_managed()
  - uvm_va_space_cpu_fault()
    - uvm_va_block_find_create
      - uvm_va_range_find()
      - uvm_va_block_find_create_in_range()
        - uvm_va_range_block_index() -- finds the index of the block in the va_range
        - uvm_va_range_block_create()
          - uvm_va_block_create()
            - kmem_cache_alloc()
              - __slab_alloc()
              - memcg_kmem_put_cache()
            - nv_kthread_q_item_init() : deferred block_add_eviction_mappings
    - uvm_va_block_cpu_fault()
      - block_cpu_fault_locked()
        - uvm_perf_event_notify()
        - uvm_range_group_address_migratable()
          - uvm_range_tree_find()
        - uvm_va_block_select_residency()
        - uvm_va_block_service_locked()
          - uvm_va_policy_is_read_duplicate() * n
          - uvm_va_block_service_copy()
            - uvm_va_block_make_resident_copy()
              - block_resident_mask_get_alloc
              - uvm_va_block_unmap_mask
              - block_populate_pages
              - block_copy_resident_pages
                - block_copy_resident_pages_mask
                - uvm_tracker_add_tracker_safe
          - uvm_va_block_service_finish()
            - uvm_va_block_make_resident_finish
              - block_copy_set_first_touch_residency()
              - uvm_page_mask_init_from_region()
            - uvm_va_space_can_read_duplicate * n 
            - block_region_authorized_processors * n 
            - block_unmap_cpu
            - uvm_va_block_map
              - block_page_prot_cpu
              - block_page_get.isra.77
              - **vm_insert_page**
              - block_page_get.isra.77 ... * n
            - uvm_va_block_add_mappings_after_migration


- wrapper
- thread_context_remove

L2000